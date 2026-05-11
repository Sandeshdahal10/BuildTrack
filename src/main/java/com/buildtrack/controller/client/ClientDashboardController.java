package com.buildtrack.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Client dashboard controller.
 */
@WebServlet("/client/dashboard")
public class ClientDashboardController extends HttpServlet {

    /**
     * Renders the client dashboard view.
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/client/dashboard.jsp")
                .forward(request, response);
    }
}
