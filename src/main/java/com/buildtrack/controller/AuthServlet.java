package com.buildtrack.controller;

import com.buildtrack.model.User;
import com.buildtrack.service.ClientService;
import com.buildtrack.service.UserService;
import com.buildtrack.service.WorkerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AuthServlet")
public class AuthServlet extends HttpServlet {
    private final UserService userService = new UserService();
    private final WorkerService workerService = new WorkerService();
    private final ClientService clientService = new ClientService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        String action = req.getParameter("action");
        if("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if(session!=null) session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
        }else{
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
    private void dologin(HttpServletRequest req,HttpServletResponse resp)
        throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        List<String> errors = new ArrayList<>();
        if (email == null || email.trim().isEmpty()) errors.add("Email is required!");
        else if (!validationUtil.isValidEmail(email)) errors.add("Please enter a valid Email Address");
        if (password == null || password.trim().isEmpty()) errors.add("Password is required!");

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("loginEmail", email);
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        User user = userService.authenticate(email, password);

        if (user == null) {
            req.setAttribute("error", "Invalid email or password");
            req.setAttribute("loginEmail", email);
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }
        if (user.isPending()) {
            resp.sendRedirect(req.getContextPath() + "/pending");
            return;
        }
        if ("Deactivated".equals(user.getStatus())) {
            req.setAttribute("error", "Your account has been deactivated. Contact to admin");
            req.getRequestDispatcher("WEB=INF/views/login.jsp").forward(req, resp);
            return;
        }
        HttpSession session = req.getSession();
        session.setAttribute("userId", user.getId());
        session.setAttribute("userName", user.getFullName());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("role", user.getRole());

        switch (user.getRole()) {
            case "Admin":
                resp.sendRedirect(req.getContextPath() + "admin/dashboard");
                break;
            case "Worker":
                resp.sendRedirect(req.getContextPath() + "worker/dashboard");
                break;
            case "Client":
                resp.sendRedirect(req.getContextPath() + "client/dashborad");
                break;
            default:
                session.invalidate();
                req.setAttribute("error", "Unknown user role.");
                req.getRequestDispatcher("WB-INF/vies/login.jsp").forward(req, resp);
        }
    }
    }
}
