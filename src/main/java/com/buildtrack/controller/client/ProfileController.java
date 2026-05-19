package com.buildtrack.controller.client;

import com.buildtrack.dao.auth.AuthDao;
import com.buildtrack.model.User;
import com.buildtrack.service.client.ClientService;
import com.buildtrack.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Client profile controller.
 */
@WebServlet("/client/profile")
public class ProfileController extends HttpServlet {

    private final ClientService clientService = new ClientService();
    private final AuthDao authDao = new AuthDao();

    /**
     * Renders the client profile view.
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Integer userIdObj = (Integer) session.getAttribute("userId");
        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int userId = userIdObj;
        User client = clientService.getClientById(userId);
        request.setAttribute("client", client);

        Object successMessage = session.getAttribute("profileSuccess");
        if (successMessage != null) {
            request.setAttribute("success", successMessage);
            session.removeAttribute("profileSuccess");
        }

        Object errorMessages = session.getAttribute("profileErrors");
        if (errorMessages != null) {
            request.setAttribute("errors", errorMessages);
            session.removeAttribute("profileErrors");
        }

        request.getRequestDispatcher("/WEB-INF/views/common/profile.jsp")
                .forward(request, response);
    }

    /**
     * Handles client profile updates.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer userIdObj = (Integer) session.getAttribute("userId");
        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = userIdObj;
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        boolean hasPasswordChange = currentPassword != null || newPassword != null || confirmPassword != null;
        if (hasPasswordChange) {
            List<String> passwordErrors = new ArrayList<>();
            if (currentPassword == null || currentPassword.trim().isEmpty()
                    || newPassword == null || newPassword.trim().isEmpty()
                    || confirmPassword == null || confirmPassword.trim().isEmpty()) {
                passwordErrors.add("All password fields are required.");
            }
            if (passwordErrors.isEmpty() && !newPassword.equals(confirmPassword)) {
                passwordErrors.add("New password and confirmation do not match.");
            }
            if (passwordErrors.isEmpty() && newPassword.length() < 6) {
                passwordErrors.add("New password must be at least 6 characters.");
            }

            User dbUser = authDao.findById(userId);
            if (passwordErrors.isEmpty() && dbUser == null) {
                passwordErrors.add("User not found. Please log in again.");
            }
            if (passwordErrors.isEmpty() && !PasswordUtil.verifyPassword(currentPassword, dbUser.getPassword())) {
                passwordErrors.add("Current password is incorrect.");
            }

            if (!passwordErrors.isEmpty()) {
                session.setAttribute("profileErrors", passwordErrors);
                response.sendRedirect(request.getContextPath() + "/client/profile");
                return;
            }

            String hashedNewPassword = PasswordUtil.hashedPassword(newPassword);
            boolean updated = authDao.updatePassword(userId, hashedNewPassword);
            if (updated) {
                session.setAttribute("profileSuccess", "Password updated successfully.");
            } else {
                List<String> updateErrors = new ArrayList<>();
                updateErrors.add("Failed to update password. Please try again.");
                session.setAttribute("profileErrors", updateErrors);
            }
            response.sendRedirect(request.getContextPath() + "/client/profile");
            return;
        }

        List<String> errors = clientService.updateProfile(userId, fullName, phone);
        if (!errors.isEmpty()) {
            session.setAttribute("profileErrors", errors);
            response.sendRedirect(request.getContextPath() + "/client/profile");
            return;
        }

        User refreshedClient = clientService.getClientById(userId);
        if (refreshedClient != null) {
            session.setAttribute("user", refreshedClient);
            session.setAttribute("userName", refreshedClient.getFullName());
        }

        session.setAttribute("profileSuccess", "Profile updated successfully.");
        response.sendRedirect(request.getContextPath() + "/client/profile");
    }
}
