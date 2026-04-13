package com.buildtrack.controller.auth;

import com.buildtrack.model.User;
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
 * Handles user login.
 *
 * GET  /login  → Shows the login form
 * POST /login  → Processes login credentials
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, redirect to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            response.sendRedirect(request.getContextPath()
                    + user.getRole().getDashboardPath());
            return;
        }

        // Forward to login form
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        // Authenticate via service
        AuthService.LoginResult result = authService.login(email, password);

        if (result.hasErrors()) {
            // Login failed — forward back to login form with errors
            request.setAttribute("errors", result.getErrors());
            request.setAttribute("email", email); // preserve email input
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        // Login successful — create session
        HttpSession session = request.getSession(true);
        User user = result.getUser();

        // Store minimal user info in session (not the password hash!)
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole().name());
        session.setAttribute("userName", user.getFullName());

        // Handle "Remember Me" — extend session timeout to 7 days
        if ("on".equals(rememberMe)) {
            session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
        }

        // Clear any previous warnings
        session.removeAttribute("authWarning");

        System.out.println("[Login] User logged in: " + user.getEmail()
                + " (" + user.getRole() + ")");

        // Redirect to role-specific dashboard (PRG pattern)
        response.sendRedirect(request.getContextPath()
                + user.getRole().getDashboardPath());
    }
}