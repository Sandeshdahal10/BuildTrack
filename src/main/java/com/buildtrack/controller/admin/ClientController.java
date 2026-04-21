package com.buildtrack.controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.buildtrack.model.User;
import com.buildtrack.service.admin.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "clientController", value = { "/admin/clients", "/admin/clients/*" })
public class ClientController extends HttpServlet {
    private final UserService userService = new UserService();

    private static final Pattern EDIT_PATH_PATTERN = Pattern.compile("^/([0-9]+)/edit/?$");
    private static final Pattern VIEW_PATH_PATTERN = Pattern.compile("^/([0-9]+)/?$");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("activePage", "clients");
        String pathInfo = req.getPathInfo();
        String view = req.getParameter("view");
        String mode = req.getParameter("mode");

        if (pathInfo == null || pathInfo.isEmpty() || "/".equals(pathInfo)) {
            req.setAttribute("clients", userService.getClients());
            req.setAttribute("userStats", userService.getUserStats());
            req.getRequestDispatcher("/WEB-INF/views/admin/clients.jsp").forward(req, resp);
            return;
        }

        Matcher viewMatcher = VIEW_PATH_PATTERN.matcher(pathInfo);
        if (viewMatcher.matches()) {
            int clientId = Integer.parseInt(viewMatcher.group(1));
            User client = userService.getUserById(clientId);
            if (client == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Client not found");
                return;
            }
            req.setAttribute("formMode", "view");
            req.setAttribute("clientId", String.valueOf(client.getId()));
            req.setAttribute("client", client);
            req.getRequestDispatcher("/WEB-INF/views/form/clientForm.jsp").forward(req, resp);
            return;
        }

        Matcher editMatcher = EDIT_PATH_PATTERN.matcher(pathInfo);
        if (editMatcher.matches()) {
            int clientId = Integer.parseInt(editMatcher.group(1));
            User client = userService.getUserById(clientId);
            if (client == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Client not found");
                return;
            }
            req.setAttribute("formMode", "edit");
            req.setAttribute("clientId", String.valueOf(client.getId()));
            req.setAttribute("client", client);
            req.getRequestDispatcher("/WEB-INF/views/form/clientForm.jsp").forward(req, resp);
            return;
        }

        if ("/form".equals(pathInfo) || "/form/".equals(pathInfo) || "form".equalsIgnoreCase(view)) {
            String normalizedMode = "edit".equalsIgnoreCase(mode) ? "edit"
                    : ("view".equalsIgnoreCase(mode) ? "view" : "create");
            req.setAttribute("formMode", normalizedMode);

            String clientIdParam = req.getParameter("id");
            req.setAttribute("clientId", clientIdParam);
            if (clientIdParam != null && !clientIdParam.isBlank()) {
                try {
                    User client = userService.getUserById(Integer.parseInt(clientIdParam));
                    req.setAttribute("client", client);
                } catch (NumberFormatException ignored) {
                    // Keep form in create mode when id is invalid.
                    req.setAttribute("formMode", "create");
                }
            }
            req.getRequestDispatcher("/WEB-INF/views/form/clientForm.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("clients", userService.getClients());
        req.setAttribute("userStats", userService.getUserStats());
        req.getRequestDispatcher("/WEB-INF/views/admin/clients.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String mode = req.getParameter("mode");
        String idParam = req.getParameter("id");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");

        if ("edit".equalsIgnoreCase(mode) && idParam != null && !idParam.isBlank()) {
            try {
                int id = Integer.parseInt(idParam);
                List<String> errors = userService.updateProfile(id, fullName, phone);
                if (!errors.isEmpty()) {
                    req.getSession().setAttribute("errors", errors);
                    resp.sendRedirect(req.getContextPath() + "/admin/clients/" + id + "/edit");
                    return;
                }
                req.getSession().setAttribute("success", "Client profile updated successfully.");
                resp.sendRedirect(req.getContextPath() + "/admin/clients");
                return;
            } catch (NumberFormatException ignored) {
                req.getSession().setAttribute("errors", List.of("Invalid client id."));
                resp.sendRedirect(req.getContextPath() + "/admin/clients");
                return;
            }
        }

        req.getSession().setAttribute("errors",
                List.of("Client creation is not available yet. Please use an existing client record."));
        resp.sendRedirect(req.getContextPath() + "/admin/clients");
    }
}
