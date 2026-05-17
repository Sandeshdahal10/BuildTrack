package com.buildtrack.controller.admin;

import java.io.IOException;
import java.util.List;

import com.buildtrack.model.User;
import com.buildtrack.service.admin.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "workerController", value = { "/admin/workers", "/admin/workers/*" })
public class WorkerController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "workers");

        String action = req.getParameter("action");
        if ("deactivate".equalsIgnoreCase(action) || "activate".equalsIgnoreCase(action)) {
            String idParam = req.getParameter("id");
            if (idParam != null && !idParam.isBlank()) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean success = "deactivate".equalsIgnoreCase(action)
                            ? userService.deactivateUser(id)
                            : userService.activateUser(id);

                    if (success) {
                        req.getSession().setAttribute("success",
                                "deactivate".equalsIgnoreCase(action)
                                        ? "Worker deactivated successfully."
                                        : "Worker activated successfully.");
                    } else {
                        req.getSession().setAttribute("errors", List.of("Failed to update worker status."));
                    }
                } catch (NumberFormatException ignored) {
                    req.getSession().setAttribute("errors", List.of("Invalid worker id."));
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/workers");
            return;
        }

        String pathInfo = req.getPathInfo();
        String view = req.getParameter("view");
        String mode = req.getParameter("mode");
        String idParam = req.getParameter("id");

        if ("/form".equals(pathInfo) || "/form/".equals(pathInfo) || "form".equalsIgnoreCase(view)) {
            if (idParam != null && !idParam.isBlank()) {
                try {
                    int id = Integer.parseInt(idParam);
                    User worker = userService.getUserById(id);
                    req.setAttribute("worker", worker);
                    
                    List<com.buildtrack.model.Project> assignedProjects = new com.buildtrack.dao.worker.WorkLogDao().findAssignedProjects(id);
                    if (assignedProjects != null && !assignedProjects.isEmpty()) {
                        req.setAttribute("assignedProjectId", assignedProjects.get(0).getId());
                    }
                } catch (NumberFormatException ignored) {
                    // Render empty form when id is invalid.
                }
            }
            req.setAttribute("projects", new com.buildtrack.service.admin.ProjectService().getAllProjects());
            req.setAttribute("formMode", mode);
            req.getRequestDispatcher("/WEB-INF/views/form/workerForm.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("workers", userService.getWorkers());
        req.setAttribute("userStats", userService.getUserStats());
        req.getRequestDispatcher("/WEB-INF/views/admin/workers.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String mode = req.getParameter("mode");
        String idParam = req.getParameter("id");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");

        if ("edit".equalsIgnoreCase(mode) && idParam != null && !idParam.isBlank()) {
            try {
                int id = Integer.parseInt(idParam);
                List<String> errors = userService.updateProfile(id, fullName, phone);
                if (!errors.isEmpty()) {
                    req.getSession().setAttribute("errors", errors);
                    resp.sendRedirect(req.getContextPath() + "/admin/workers/form?mode=edit&id=" + id);
                    return;
                }
                
                String status = req.getParameter("status");
                if (status != null && !status.trim().isEmpty()) {
                    if ("Active".equalsIgnoreCase(status)) {
                        userService.updateStatus(id, "APPROVED");
                    } else if ("Deactivated".equalsIgnoreCase(status)) {
                        userService.updateStatus(id, "DEACTIVATED");
                    } else if ("Pending".equalsIgnoreCase(status)) {
                        userService.updateStatus(id, "PENDING");
                    }
                }
                
                String dailyWageStr = req.getParameter("dailyWage");
                if (dailyWageStr != null && !dailyWageStr.trim().isEmpty()) {
                    List<String> wageErrors = userService.setDailyWage(id, dailyWageStr);
                    if (!wageErrors.isEmpty()) {
                        req.getSession().setAttribute("errors", wageErrors);
                        resp.sendRedirect(req.getContextPath() + "/admin/workers/form?mode=edit&id=" + id);
                        return;
                    }
                }
                
                String projectIdStr = req.getParameter("projectId");
                if (projectIdStr != null && !projectIdStr.trim().isEmpty()) {
                    try {
                        int projectId = Integer.parseInt(projectIdStr);
                        // Delete previous assignments if needed? Or just assign. 
                        // The ProjectService.assignWorker ignores if already assigned.
                        new com.buildtrack.service.admin.ProjectService().assignWorker(projectId, id, "Worker");
                    } catch (NumberFormatException ignored) {}
                }
                
                req.getSession().setAttribute("success", "Worker profile updated successfully.");
                resp.sendRedirect(req.getContextPath() + "/admin/workers");
                return;
            } catch (NumberFormatException ignored) {
                req.getSession().setAttribute("errors", List.of("Invalid worker id."));
                resp.sendRedirect(req.getContextPath() + "/admin/workers");
                return;
            }
        }

        req.getSession().setAttribute("errors",
                List.of("Worker creation is not available yet. Please edit an existing worker."));
        resp.sendRedirect(req.getContextPath() + "/admin/workers");
    }
}
