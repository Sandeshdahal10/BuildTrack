package com.buildtrack.controller.worker;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/worker/dashboard")
public class WorkerDashboardController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward request to the JSP view
        request.getRequestDispatcher("/WEB-INF/views/worker/dashboard.jsp")
                .forward(request, response);
    }
}
