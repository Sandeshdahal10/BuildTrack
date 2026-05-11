package com.buildtrack.controller.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Public About page.
 *
 * GET /about -> renders About Us content.
 */
@WebServlet("/about")
public class AboutController extends HttpServlet {

    /**
     * Handles GET requests for the About page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/common/about.jsp")
                .forward(request, response);
    }
}
