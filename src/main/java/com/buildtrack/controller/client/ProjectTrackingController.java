package com.buildtrack.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.buildtrack.dao.client.ClientDao;
import com.buildtrack.dao.client.ProjectTrackingDao;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.model.Project;

import java.util.List;
import java.util.Map;

import java.io.IOException;

@WebServlet("/client/project")
public class ProjectTrackingController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
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
		ClientDao dao = new ClientDao();
		List<Project> projects = dao.findProjectsByClientId(userId);
		request.setAttribute("projects", projects);

		// If a project id is provided, fetch detailed tracking data for that project
		String pidStr = request.getParameter("id");
		if (pidStr != null && !pidStr.trim().isEmpty()) {
			try {
				int pid = Integer.parseInt(pidStr);
				ProjectTrackingDao ptDao = new ProjectTrackingDao();
				Project project = ptDao.findProjectForClient(pid, userId);
				if (project != null) {
					List<MaterialUsage> materials = ptDao.findMaterialUsageForProject(pid);
					List<Map<String, Object>> expenses = ptDao.findExpensesForProject(pid);
					int timeProgress = ptDao.getTimeProgressPercent(pid);
					request.setAttribute("selectedProject", project);
					request.setAttribute("materials", materials);
					request.setAttribute("expenses", expenses);
					request.setAttribute("timeProgress", timeProgress);
				} else {
					request.setAttribute("projectNotFound", true);
				}
			} catch (NumberFormatException ignored) {}
		}

		request.getRequestDispatcher("/WEB-INF/views/client/project.jsp")
				.forward(request, response);
	}
}
