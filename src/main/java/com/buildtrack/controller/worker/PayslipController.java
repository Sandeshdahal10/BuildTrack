package com.buildtrack.controller.worker;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Worker payslip view controller.
 */
@WebServlet("/worker/payslip")
public class PayslipController extends HttpServlet {

    /**
     * Renders the worker payslip view.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward request to the JSP view
        request.getRequestDispatcher("/WEB-INF/views/worker/payslip.jsp")
                .forward(request, response);
    }
}