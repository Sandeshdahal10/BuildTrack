package com.buildtrack.controller.admin;

import java.io.IOException;
import java.util.List;

import com.buildtrack.model.Project;
import com.buildtrack.service.admin.ProjectService;
import com.buildtrack.service.admin.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Full CRUD for projects + worker assignment.
 *
 * GET /admin/projects → list all
 * GET /admin/projects?action=new → new form
 * GET /admin/projects?action=edit&id=X → edit form
 * GET /admin/projects?action=view&id=X → detail view
 * POST /admin/projects?action=create → create
 * POST /admin/projects?action=update → update
 * POST /admin/projects?action=delete&id=X → delete
 * POST /admin/projects?action=assign-worker → assign worker
 * POST /admin/projects?action=remove-worker → remove worker
 */
@WebServlet("/admin/projects")
public class ProjectController extends HttpServlet {

    private final ProjectService projectService = new ProjectService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // List all projects with status counts
            request.setAttribute("projects", projectService.getAllProjects());
            request.setAttribute("statusCounts", projectService.getStatusCounts());
            request.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "new":
                // Pass clients for dropdown
                request.setAttribute("clients", userService.getClients());
                request.setAttribute("formMode", "create");
                request.getRequestDispatcher("/WEB-INF/views/form/projectForm.jsp")
                        .forward(request, response);
                break;

            case "edit": {
                int id = Integer.parseInt(request.getParameter("id"));
                Project p = projectService.getProjectById(id);
                if (p == null) {
                    response.sendError(404, "Project not found");
                    return;
                }
                request.setAttribute("project", p);
                request.setAttribute("clients", userService.getClients());
                request.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp")
                        .forward(request, response);
                break;
            }

            case "view": {
                int id = Integer.parseInt(request.getParameter("id"));
                Project p = projectService.getProjectById(id);
                if (p == null) {
                    response.sendError(404, "Project not found");
                    return;
                }
                request.setAttribute("project", p);
                request.setAttribute("assignedWorkers", projectService.getAssignedWorkers(id));
                request.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp")
                        .forward(request, response);
                break;
            }

            case "assign": {
                // Show assign-worker form
                int id = Integer.parseInt(request.getParameter("id"));
                Project p = projectService.getProjectById(id);
                if (p == null) {
                    response.sendError(404);
                    return;
                }
                request.setAttribute("project", p);
                request.setAttribute("assignedWorkers", projectService.getAssignedWorkers(id));
                // Search query param
                String q = request.getParameter("q");
                if (q != null && !q.trim().isEmpty()) {
                    request.setAttribute("searchResults", userService.searchWorkers(q.trim()));
                }
                request.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp")
                        .forward(request, response);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/projects");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/projects");
            return;
        }

        switch (action) {
            case "create": {
                List<String> errors = projectService.createProject(
                        request.getParameter("title"),
                        request.getParameter("description"),
                        request.getParameter("clientId"),
                        request.getParameter("startDate"),
                        request.getParameter("endDate"),
                        request.getParameter("totalBudget"),
                        request.getParameter("status"));
                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    request.setAttribute("clients", userService.getClients());
                    // Preserve form input
                    preserveProjectForm(request);
                    request.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp")
                            .forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/projects?created=true");
                }
                break;
            }

            case "update": {
                int id = Integer.parseInt(request.getParameter("id"));
                List<String> errors = projectService.updateProject(
                        id,
                        request.getParameter("title"),
                        request.getParameter("description"),
                        request.getParameter("clientId"),
                        request.getParameter("startDate"),
                        request.getParameter("endDate"),
                        request.getParameter("totalBudget"),
                        request.getParameter("status"));
                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    request.setAttribute("project", projectService.getProjectById(id));
                    request.setAttribute("clients", userService.getClients());
                    request.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp")
                            .forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/projects?updated=true");
                }
                break;
            }

            case "delete": {
                int id = Integer.parseInt(request.getParameter("id"));
                List<String> errors = projectService.deleteProject(id);
                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/projects?deleted=true");
                break;
            }

            case "assign-worker": {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                int workerId = Integer.parseInt(request.getParameter("workerId"));
                String assignedRole = request.getParameter("assignedRole");
                List<String> errors = projectService.assignWorker(projectId, workerId, assignedRole);
                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/projects?action=assign&id=" + projectId);
                break;
            }

            case "remove-worker": {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                int workerId = Integer.parseInt(request.getParameter("workerId"));
                List<String> errors = projectService.removeWorker(projectId, workerId);
                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/projects?action=view&id=" + projectId);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/projects");
        }
    }

    private void preserveProjectForm(HttpServletRequest request) {
        request.setAttribute("title", request.getParameter("title"));
        request.setAttribute("description", request.getParameter("description"));
        request.setAttribute("clientId", request.getParameter("clientId"));
        request.setAttribute("startDate", request.getParameter("startDate"));
        request.setAttribute("endDate", request.getParameter("endDate"));
        request.setAttribute("totalBudget", request.getParameter("totalBudget"));
        request.setAttribute("status", request.getParameter("status"));
    }
}