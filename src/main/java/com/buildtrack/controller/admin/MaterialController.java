package com.buildtrack.controller.admin;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "materialController", value = { "/admin/materials", "/admin/materials/*" })
public class MaterialController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "materials");
        String pathInfo = req.getPathInfo();
        String view = req.getParameter("view");

        if ("/form".equals(pathInfo) || "/form/".equals(pathInfo) || "form".equalsIgnoreCase(view)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/materialForm.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/materials.jsp").forward(req, resp);
    }
}
