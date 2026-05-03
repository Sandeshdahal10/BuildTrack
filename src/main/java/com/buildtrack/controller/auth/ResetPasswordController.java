package com.buildtrack.controller.auth;

import com.buildtrack.model.User;
import com.buildtrack.service.auth.PasswordService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Handles the password reset flow.
 *
 * GET /reset-password?token=xxx → Validates token, shows reset form
 * POST /reset-password → Processes new password
 */
@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

        private final PasswordService passwordService = new PasswordService();

        /**
         * Validates token and renders reset password form.
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

                String token = request.getParameter("token");

                // Validate the token
                User user = passwordService.validateResetToken(token);

                if (user == null) {
                        // Token is invalid or expired
                        request.setAttribute("tokenError",
                                        "This password reset link is invalid or has expired. "
                                                        + "Please request a new one.");
                        request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp")
                                        .forward(request, response);
                        return;
                }

                // Token is valid — store in request for the form
                request.setAttribute("validToken", token);
                request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp")
                                .forward(request, response);
        }

        /**
         * Processes password reset submissions.
         */
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                String token = request.getParameter("token");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");

                // Process password reset
                List<String> errors = passwordService.resetPassword(
                                token, newPassword, confirmPassword);

                if (!errors.isEmpty()) {
                        // Reset failed — forward back with errors
                        request.setAttribute("errors", errors);
                        request.setAttribute("validToken", token);
                        request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp")
                                        .forward(request, response);
                        return;
                }

                // Password reset successful — redirect to login
                response.sendRedirect(request.getContextPath()
                                + "/login?resetSuccess=true");
        }
}