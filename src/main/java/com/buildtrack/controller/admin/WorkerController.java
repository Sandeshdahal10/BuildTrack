package com.buildtrack.controller.admin;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "workerController", value = { "/admin/workers", "/admin/workers/*" })
public class WorkerController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "workers");
        String pathInfo = req.getPathInfo();
        String view = req.getParameter("view");

        if ("/form".equals(pathInfo) || "/form/".equals(pathInfo) || "form".equalsIgnoreCase(view)) {
            req.getRequestDispatcher("/WEB-INF/views/form/workerForm.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/workers.jsp").forward(req, resp);
    }
}
