package com.buildtrack.controller.auth;

import com.buildtrack.service.auth.PasswordService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Handles the "Forgot Password" flow.
 *
 * GET /forgot-password → Shows the forgot-password form
 * POST /forgot-password → Processes the email and sends a reset link
 *
 * Security note: Always shows a success message regardless of whether
 * the email exists, to prevent email enumeration attacks.
 */
@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

        private final PasswordService passwordService = new PasswordService();

        /**
         * Renders the forgot-password form.
         */
        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                // If already logged in, redirect to dashboard
                HttpSession session = request.getSession(false);
                if (session != null && session.getAttribute("user") != null) {
                        response.sendRedirect(request.getContextPath() + "/index.jsp");
                        return;
                }

                request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp")
                                .forward(request, response);
        }

        /**
         * Processes a forgot-password request and sends a reset email.
         */
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                String email = request.getParameter("email");

                // Build the base URL for the reset link
                String baseUrl = request.getScheme() + "://"
                                + request.getServerName()
                                + ":" + request.getServerPort()
                                + request.getContextPath();

                // Process the request (always returns true for security)
                passwordService.initiatePasswordReset(email, baseUrl);

                // Always show success message
                request.setAttribute("success",
                                "If an account exists with that email, a password reset link "
                                                + "has been sent. Please check your inbox (and spam folder).");

                request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp")
                                .forward(request, response);
        }
}