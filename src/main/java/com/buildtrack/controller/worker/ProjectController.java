package com.buildtrack.controller.worker;

import com.buildtrack.model.Project;
import com.buildtrack.model.User;
import com.buildtrack.dao.admin.ProjectDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/worker/projects")
public class ProjectController extends HttpServlet {

    private final ProjectDao projectDao = new ProjectDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Project> assignedProjects = projectDao.findAssignedProjectsForWorker(user.getId());
        request.setAttribute("projects", assignedProjects);

        request.getRequestDispatcher("/WEB-INF/views/worker/project.jsp")
                .forward(request, response);
    }
}
