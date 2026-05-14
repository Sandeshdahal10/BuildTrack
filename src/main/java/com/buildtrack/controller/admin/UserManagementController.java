package com.buildtrack.controller.admin;

import com.buildtrack.model.User;
import com.buildtrack.service.admin.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * User management for admin — handles viewing, approving, deactivating,
 * reactivating user accounts, and setting worker daily wages.
 *
 * GET  /admin/users                        → list all non-admin users
 * GET  /admin/users?role=WORKER            → filter by worker role
 * GET  /admin/users?role=CLIENT            → filter by client role
 * GET  /admin/users?status=PENDING         → filter by pending status
 * GET  /admin/users?status=APPROVED        → filter by approved status
 * GET  /admin/users?status=DEACTIVATED     → filter by deactivated status
 * GET  /admin/users?action=view&id=X       → view single user detail
 * POST /admin/users?action=approve&id=X    → approve pending user
 * POST /admin/users?action=deactivate&id=X → deactivate user
 * POST /admin/users?action=activate&id=X   → reactivate user
 * POST /admin/users?action=set-wage        → set daily wage for a worker
 * POST /admin/users?action=update-profile  → update user name/phone
 */
@WebServlet("/admin/users")
public class UserManagementController extends HttpServlet {

    private final UserService userService = new UserService();

    // ==================== GET ====================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        // ---------- View single user ----------
        if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userService.getUserById(id);
            if (user == null) {
                response.sendError(404, "User not found");
                return;
            }
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp")
                    .forward(request, response);
            return;
        }

        // ---------- List users with optional filters ----------
        List<User> users;

        if ("PENDING".equals(status)) {
            users = userService.getPendingUsers();
            request.setAttribute("filterLabel", "Pending Approvals");
        } else if (role != null) {
            if ("WORKER".equals(role)) {
                users = userService.getWorkers();
                request.setAttribute("filterLabel", "Workers");
            } else if ("CLIENT".equals(role)) {
                users = userService.getClients();
                request.setAttribute("filterLabel", "Clients");
            } else {
                users = userService.getAllNonAdmin();
                request.setAttribute("filterLabel", "All Users");
            }
        } else if (status != null) {
            if ("DEACTIVATED".equals(status)) {
                users = userService.getAllNonAdmin().stream()
                        .filter(u -> "DEACTIVATED".equals(u.getStatus()))
                        .toList();
                request.setAttribute("filterLabel", "Deactivated Users");
            } else {
                users = userService.getAllNonAdmin();
                request.setAttribute("filterLabel", "All Users");
            }
        } else {
            users = userService.getAllNonAdmin();
            request.setAttribute("filterLabel", "All Users");
        }

        request.setAttribute("users", users);
        request.setAttribute("userStats", userService.getUserStats());
        request.setAttribute("currentRole", role);
        request.setAttribute("currentStatus", status);

        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp")
                .forward(request, response);
    }

    // ==================== POST ====================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        switch (action) {

            // ---------- Approve a pending user ----------
            case "approve": {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = userService.approveUser(id);
                if (success) {
                    request.getSession().setAttribute("success",
                            "User approved successfully.");
                } else {
                    request.getSession().setAttribute("errors",
                            List.of("Failed to approve user."));
                }
                String from = request.getParameter("from");
                if ("pending".equals(from)) {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/users?status=PENDING");
                } else if ("clients".equals(from)) {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/clients");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/users?action=view&id=" + id);
                }
                break;
            }

            // ---------- Deactivate a user ----------
            case "deactivate": {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = userService.deactivateUser(id);
                if (success) {
                    request.getSession().setAttribute("success",
                            "User deactivated successfully.");
                } else {
                    request.getSession().setAttribute("errors",
                            List.of("Failed to deactivate user."));
                }
                String from = request.getParameter("from");
                if ("clients".equals(from)) {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/clients");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/users?action=view&id=" + id);
                }
                break;
            }

            // ---------- Reactivate a deactivated user ----------
            case "activate": {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = userService.activateUser(id);
                if (success) {
                    request.getSession().setAttribute("success",
                            "User reactivated successfully.");
                } else {
                    request.getSession().setAttribute("errors",
                            List.of("Failed to reactivate user."));
                }
                String from = request.getParameter("from");
                if ("clients".equals(from)) {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/clients");
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/users?action=view&id=" + id);
                }
                break;
            }

            // ---------- Set daily wage for a worker ----------
            case "set-wage": {
                int id = Integer.parseInt(request.getParameter("id"));
                String wageStr = request.getParameter("dailyWage");

                List<String> errors = userService.setDailyWage(id, wageStr);

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "Daily wage updated successfully.");
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?action=view&id=" + id);
                break;
            }

            // ---------- Update user profile (name, phone) ----------
            case "update-profile": {
                int id = Integer.parseInt(request.getParameter("id"));
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");

                List<String> errors = userService.updateProfile(id, fullName, phone);

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "User profile updated successfully.");
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/users?action=view&id=" + id);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}