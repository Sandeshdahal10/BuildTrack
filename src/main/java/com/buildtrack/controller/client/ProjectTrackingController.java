package com.buildtrack.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.buildtrack.dao.client.ClientDao;
import com.buildtrack.model.Project;

import java.util.List;

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

		request.getRequestDispatcher("/WEB-INF/views/client/project.jsp")
				.forward(request, response);
	}
}
