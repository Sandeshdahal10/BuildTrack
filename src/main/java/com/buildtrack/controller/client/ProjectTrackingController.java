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

/**
 * Client project tracking controller.
 */
@WebServlet("/client/project")
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
				request.setAttribute("selectedProject", project);
				request.setAttribute("selectedProjectId", selectedProjectId);
				request.setAttribute("materials", materials);
				request.setAttribute("expenses", expenses);
				request.setAttribute("timeProgress", timeProgress);
			} else {
				request.setAttribute("projectNotFound", true);
			}
		}

		request.getRequestDispatcher("/WEB-INF/views/client/project.jsp")
				.forward(request, response);
	}
}
