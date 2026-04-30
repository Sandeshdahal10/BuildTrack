package com.buildtrack.controller.worker;

import com.buildtrack.dao.auth.AuthDao;
import com.buildtrack.model.User;
import com.buildtrack.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/worker/profile")
public class ProfileController extends HttpServlet {

    private final AuthDao authDao = new AuthDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward request to the JSP view
        request.getRequestDispatcher("/WEB-INF/views/worker/profile.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate inputs
        if (currentPassword == null || currentPassword.trim().isEmpty()
                || newPassword == null || newPassword.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "All password fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/worker/profile.jsp")
                    .forward(request, response);
            return;
        }

        // Check new password matches confirmation
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New password and confirmation do not match.");
            request.getRequestDispatcher("/WEB-INF/views/worker/profile.jsp")
                    .forward(request, response);
            return;
        }

        // Check minimum password length
        if (newPassword.length() < 6) {
            request.setAttribute("error", "New password must be at least 6 characters.");
            request.getRequestDispatcher("/WEB-INF/views/worker/profile.jsp")
                    .forward(request, response);
            return;
        }

        // Reload user from DB to get current hashed password
        User dbUser = authDao.findById(user.getId());
        if (dbUser == null) {
            request.setAttribute("error", "User not found. Please log in again.");
            request.getRequestDispatcher("/WEB-INF/views/worker/profile.jsp")
                    .forward(request, response);
            return;
        }

        // Verify current password
        if (!PasswordUtil.verifyPassword(currentPassword, dbUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect.");
            request.getRequestDispatcher("/WEB-INF/views/worker/profile.jsp")
                    .forward(request, response);
            return;
        }

        // Hash and update new password
        String hashedNewPassword = PasswordUtil.hashedPassword(newPassword);
        boolean updated = authDao.updatePassword(user.getId(), hashedNewPassword);

        if (updated) {
            request.setAttribute("success", "Password updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update password. Please try again.");
        }

        request.getRequestDispatcher("/WEB-INF/views/worker/profile.jsp")
                .forward(request, response);
    }
}
