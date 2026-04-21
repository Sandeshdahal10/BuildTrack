package com.buildtrack.controller.admin;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "clientController", value = { "/admin/clients", "/admin/clients/*" })
public class ClientController extends HttpServlet {
    private static final Pattern EDIT_PATH_PATTERN = Pattern.compile("^/([0-9]+)/edit/?$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "clients");
        String pathInfo = req.getPathInfo();
        String view = req.getParameter("view");
        String mode = req.getParameter("mode");

        if (pathInfo == null || pathInfo.isEmpty() || "/".equals(pathInfo)) {
            req.getRequestDispatcher("/WEB-INF/views/admin/clients.jsp").forward(req, resp);
            return;
        }

        Matcher editMatcher = EDIT_PATH_PATTERN.matcher(pathInfo);
        if (editMatcher.matches()) {
            req.setAttribute("formMode", "edit");
            req.setAttribute("clientId", editMatcher.group(1));
            req.getRequestDispatcher("/WEB-INF/views/form/clientForm.jsp").forward(req, resp);
            return;
        }

        if ("/form".equals(pathInfo) || "/form/".equals(pathInfo) || "form".equalsIgnoreCase(view)) {
            req.setAttribute("formMode", "edit".equalsIgnoreCase(mode) ? "edit" : "create");
            req.setAttribute("clientId", req.getParameter("id"));
            req.getRequestDispatcher("/WEB-INF/views/form/clientForm.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/admin/clients.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Placeholder submit handling until DAO/service wiring is connected.
        resp.sendRedirect(req.getContextPath() + "/admin/clients");
    }
}
