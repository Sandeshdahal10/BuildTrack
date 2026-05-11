package com.buildtrack.filter;

import com.buildtrack.model.Role;
import com.buildtrack.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Role-based authorization filter.
 * Checks if the authenticated user has the required role
 * for the requested URL path.
 *
 * URL → Role mapping:
 * /admin/* → ADMIN
 * /worker/* → WORKER
 * /client/* → CLIENT
 *
 * If the role doesn't match, the user is redirected to their
 * own dashboard with an unauthorized access message.
 */
@WebFilter(filterName = "RoleFilter", urlPatterns = { "/admin/*", "/worker/*", "/client/*" })
public class RoleFilter implements Filter {

    /**
     * Initializes the role-based authorization filter.
     *
     * @param filterConfig filter configuration
     * @throws ServletException if initialization fails
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[RoleFilter] Initialized.");
    }

    /**
     * Enforces role-based access for protected routes.
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

        // Get the user from session
        User user = null;
        if (session != null) {
            Object userObj = session.getAttribute("user");
            if (userObj instanceof User) {
                user = (User) userObj;
            }
        }

        // Safety check: if no user, let AuthFilter handle it
        if (user == null || user.getRole() == null) {
            chain.doFilter(request, response);
            return;
        }

        // Determine the required role from the URL path
        String path = httpRequest.getServletPath();
        Role requiredRole = getRequiredRole(path);

        if (requiredRole == null) {
            // No specific role required — proceed
            chain.doFilter(request, response);
            return;
        }

        // Check if the user has the required role
        if (user.getRole() == requiredRole) {
            // Role matches — proceed
            chain.doFilter(request, response);
        } else {
            // Role mismatch — redirect to user's own dashboard
            session.setAttribute("roleError",
                    "You do not have permission to access that page.");
            httpResponse.sendRedirect(
                    httpRequest.getContextPath() + user.getRole().getDashboardPath());
        }
    }

    /**
     * Cleans up filter resources on shutdown.
     */
    @Override
    public void destroy() {
        System.out.println("[RoleFilter] Destroyed.");
    }

    /**
     * Determines the required role based on the URL path prefix.
     *
     * @param path servlet path
     * @return required role, or null if no role is required
     */
    private Role getRequiredRole(String path) {
        if (path == null)
            return null;

        if (path.startsWith("/admin/")) {
            return Role.ADMIN;
        } else if (path.startsWith("/worker/")) {
            return Role.WORKER;
        } else if (path.startsWith("/client/")) {
            return Role.CLIENT;
        }

        return null;
    }
}