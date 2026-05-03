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

        request.getRequestDispatcher("/WEB-INF/views/client/Profile.jsp")
                .forward(request, response);
    }
}
