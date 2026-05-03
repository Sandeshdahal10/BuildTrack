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
		List<Project> projects = clientService.getProjectsByClientId(userId);
		request.setAttribute("projects", projects);
		request.setAttribute("summary", clientService.getDashboardSummary(userId));

		// If a project id is provided, fetch detailed tracking data for that project
		String pidStr = request.getParameter("id");
		if (pidStr != null && !pidStr.trim().isEmpty()) {
			try {
				int pid = Integer.parseInt(pidStr);
				Project project = projectTrackingService.getProjectOverviewForClient(pid, userId);
				if (project != null) {
					List<MaterialUsage> materials = projectTrackingService.getMaterialUsageForProject(pid);
					List<Map<String, Object>> expenses = projectTrackingService.getExpensesForProject(pid);
					int timeProgress = projectTrackingService.getTimeProgressPercent(pid);
					request.setAttribute("selectedProject", project);
					request.setAttribute("materials", materials);
					request.setAttribute("expenses", expenses);
					request.setAttribute("timeProgress", timeProgress);
				} else {
					request.setAttribute("projectNotFound", true);
				}
			} catch (NumberFormatException ignored) {
			}
		}

		request.getRequestDispatcher("/WEB-INF/views/client/project.jsp")
				.forward(request, response);
	}
}
