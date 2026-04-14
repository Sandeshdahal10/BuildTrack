package com.buildtrack.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "projectController", value = { "/admin/projects", "/admin/projects/*" })
public class ProjectController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "projects");
        String pathInfo = req.getPathInfo();
        String view = req.getParameter("view");

        if ("/form".equals(pathInfo) || "/form/".equals(pathInfo) || "form".equalsIgnoreCase(view)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/projectForm.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/projects.jsp").forward(req, resp);
    }
}
