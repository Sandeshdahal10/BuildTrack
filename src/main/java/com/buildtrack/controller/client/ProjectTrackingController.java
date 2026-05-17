package com.buildtrack.controller.client;

import com.buildtrack.model.MaterialUsage;
import com.buildtrack.model.Project;
import com.buildtrack.service.client.ClientService;
import com.buildtrack.service.client.ProjectTrackingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;

import java.io.IOException;

import com.buildtrack.dao.admin.ProjectDao;
import java.math.BigDecimal;
import java.sql.Date;

/**
 * Client project tracking controller.
 */
@WebServlet({"/client/project", "/client/project/update"})
public class ProjectTrackingController extends HttpServlet {

	private final ClientService clientService = new ClientService();
	private final ProjectTrackingService projectTrackingService = new ProjectTrackingService();

	/**
	 * Renders project tracking data for the logged-in client.
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		Integer userIdObj = (Integer) session.getAttribute("userId");
		if (userIdObj == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		int userId = userIdObj;
		Map<String, Object> summary = clientService.getDashboardSummary(userId);
		@SuppressWarnings("unchecked")
		List<Project> projects = (List<Project>) summary.getOrDefault("projects", List.of());
		request.setAttribute("projects", projects);
		request.setAttribute("summary", summary);

		String pidStr = request.getParameter("id");
		boolean projectRequested = pidStr != null && !pidStr.trim().isEmpty();
		Integer selectedProjectId = null;
		if (projectRequested) {
			try {
				selectedProjectId = Integer.parseInt(pidStr);
			} catch (NumberFormatException ignored) {
				request.setAttribute("projectNotFound", true);
			}
		}

		if (!projectRequested && selectedProjectId == null && !projects.isEmpty()) {
			selectedProjectId = projects.get(0).getId();
		}

		if (selectedProjectId != null) {
			Project project = projectTrackingService.getProjectOverviewForClient(selectedProjectId, userId);
			if (project != null) {
				List<MaterialUsage> materials = projectTrackingService.getMaterialUsageForProject(selectedProjectId);
				List<Map<String, Object>> expenses = projectTrackingService.getExpensesForProject(selectedProjectId);
				int timeProgress = projectTrackingService.getTimeProgressPercent(selectedProjectId);
				List<com.buildtrack.model.ProjectDocument> projectDocuments = new com.buildtrack.service.admin.ProjectService().getDocumentsByProjectId(selectedProjectId);

				request.setAttribute("selectedProject", project);
				request.setAttribute("selectedProjectId", selectedProjectId);
				request.setAttribute("materials", materials);
				request.setAttribute("expenses", expenses);
				request.setAttribute("timeProgress", timeProgress);
				request.setAttribute("projectDocuments", projectDocuments);
			} else {
				request.setAttribute("projectNotFound", true);
			}
		}

		request.getRequestDispatcher("/WEB-INF/views/client/project.jsp")
				.forward(request, response);
	}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("actionType");
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/client/project");
            return;
        }

        int projectId = Integer.parseInt(idStr);
        ProjectDao projectDao = new ProjectDao();
        Project project = projectDao.findById(projectId);
        
        if (project == null || !project.getClientId().equals(session.getAttribute("userId"))) {
            response.sendRedirect(request.getContextPath() + "/client/project");
            return;
        }

        if ("delete".equals(action)) {
            project.setTitle("[DELETE REQUESTED] " + project.getTitle());
            project.setStatus("PLANNED");
            projectDao.update(project);
            session.setAttribute("successMessage", "Project deletion requested. Waiting for admin approval.");
        } else if ("update".equals(action)) {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String budgetStr = request.getParameter("totalBudget");

            if (startDateStr != null && !startDateStr.isEmpty() && project.getStatus().equals("PLANNED")) {
                project.setStartDate(Date.valueOf(startDateStr));
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                project.setEndDate(Date.valueOf(endDateStr));
            }
            if (budgetStr != null && !budgetStr.isEmpty()) {
                project.setTotalBudget(new BigDecimal(budgetStr));
            }
            
            project.setStatus("PLANNED"); // Revert status for admin approval
            projectDao.update(project);
            session.setAttribute("successMessage", "Project updated successfully and requires Admin approval.");
        }

        response.sendRedirect(request.getContextPath() + "/client/project");
    }
}
