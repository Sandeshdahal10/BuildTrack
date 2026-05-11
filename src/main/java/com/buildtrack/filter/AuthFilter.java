package com.buildtrack.filter;

import java.io.IOException;

import com.buildtrack.model.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Authentication filter that checks if a user is logged in
 * before allowing access to protected routes (/admin/*, /worker/*, /client/*).
 *
 * If the user is not authenticated, they are redirected to the login page
 * with a warning message.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = { "/admin/*", "/worker/*", "/client/*" })
public class AuthFilter implements Filter {

    /**
     * Initializes the authentication filter.
     *
     * @param filterConfig filter configuration
     * @throws ServletException if initialization fails
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[AuthFilter] Initialized.");
    }

    /**
     * Ensures the request has an authenticated user before proceeding.
     *
     * @param request  servlet request
     * @param response servlet response
     * @param chain    filter chain
     * @throws IOException      if redirect fails
     * @throws ServletException if downstream filter/servlet fails
     */
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

    /**
     * Cleans up filter resources on shutdown.
     */
    @Override
    public void destroy() {
        System.out.println("[AuthFilter] Destroyed.");
    }
}