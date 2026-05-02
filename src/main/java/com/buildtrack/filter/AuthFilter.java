package com.buildtrack.filter;

import com.buildtrack.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication filter that checks if a user is logged in
 * before allowing access to protected routes (/admin/*, /worker/*, /client/*).
 *
 * If the user is not authenticated, they are redirected to the login page
 * with a warning message.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/admin/*", "/worker/*", "/client/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[AuthFilter] Initialized.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Check if user is logged in
        boolean isAuthenticated = false;
        if (session != null && session.getAttribute("user") != null) {
            Object userObj = session.getAttribute("user");
            if (userObj instanceof User) {
                isAuthenticated = true;
            }
        }

        if (isAuthenticated) {
            // User is authenticated — proceed to next filter/servlet
            chain.doFilter(request, response);
        } else {
            // User is NOT authenticated — redirect to login
            session = httpRequest.getSession(true);
            session.setAttribute("authWarning",
                    "Please log in to access that page.");

            httpResponse.sendRedirect(
                    httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        System.out.println("[AuthFilter] Destroyed.");
    }
}