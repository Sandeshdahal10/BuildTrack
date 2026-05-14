package com.buildtrack.controller.worker;

import com.buildtrack.model.User;
import com.buildtrack.service.worker.WorkLogService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/worker/worklog")
public class WorkLogController extends HttpServlet {

    private final WorkLogService workLogService = new WorkLogService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String month = request.getParameter("month");
        if (month == null || month.isBlank()) {
            month = LocalDate.now().toString().substring(0, 7);
        }

        request.setAttribute("assignedProjects", workLogService.getAssignedProjects(user.getId()));
        request.setAttribute("workLogs", workLogService.getWorkerLogs(user.getId(), month));
        request.setAttribute("currentMonth", month);

        request.getRequestDispatcher("/WEB-INF/views/worker/worklog.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        java.util.List<String> errors = workLogService.createWorkLog(
                user.getId(),
                request.getParameter("projectId"),
                request.getParameter("date"),
                request.getParameter("description"));

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            doGet(request, response);
            return;
        }

        request.getSession().setAttribute("success", "Work log submitted successfully.");
        response.sendRedirect(request.getContextPath() + "/worker/worklog?submitted=true");
    }
}
