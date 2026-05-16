package com.buildtrack.controller.client;

import com.buildtrack.model.User;
import com.buildtrack.service.client.ClientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Client profile controller.
 */
@WebServlet("/client/profile")
public class ProfileController extends HttpServlet {

    private final ClientService clientService = new ClientService();

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

        request.getRequestDispatcher("/WEB-INF/views/client/Profile.jsp")
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
