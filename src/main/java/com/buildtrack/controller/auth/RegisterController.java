package com.buildtrack.controller.auth;

import com.buildtrack.service.auth.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Handles user registration.
 *
 * GET  /register  → Shows the registration form
 * POST /register  → Processes registration data
 *
 * New users are created with status PENDING and must be
 * approved by an administrator before they can log in.
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, redirect to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Forward to registration form
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String fullName        = request.getParameter("fullName");
        String email           = request.getParameter("email");
        String phone           = request.getParameter("phone");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role            = request.getParameter("role");

        // Register via service
        List<String> errors = authService.register(
                fullName, email, phone, password, confirmPassword, role);

        if (!errors.isEmpty()) {
            // Registration failed — forward back with errors and preserved input
            request.setAttribute("errors", errors);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("role", role);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp")
                    .forward(request, response);
            return;
        }

        // Registration successful — redirect to login with success message
        response.sendRedirect(request.getContextPath()
                + "/login?registered=true");
    }
}