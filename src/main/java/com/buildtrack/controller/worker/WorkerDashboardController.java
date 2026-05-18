package com.buildtrack.controller.worker;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.buildtrack.model.User;
import com.buildtrack.model.Project;
import com.buildtrack.dao.admin.AttendanceDao;
import com.buildtrack.service.worker.WorkLogService;

@WebServlet("/worker/dashboard")
public class WorkerDashboardController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Prepare services/daos
        WorkLogService workLogService = new WorkLogService();
        AttendanceDao attendanceDao = new AttendanceDao();

        // Current month in YYYY-MM
        String month = LocalDate.now().toString().substring(0, 7);

        // Assigned projects and recent logs
        List<Project> assignedProjects = workLogService.getAssignedProjects(user.getId());
        List<com.buildtrack.model.WorkLog> recentLogs = workLogService.getWorkerLogs(user.getId(), month);

        // Attendance summary (present, half-day)
        int[] attendanceCounts = attendanceDao.getAttendanceCounts(user.getId(), month);
        int present = attendanceCounts.length > 0 ? attendanceCounts[0] : 0;
        int halfDay = attendanceCounts.length > 1 ? attendanceCounts[1] : 0;

        request.setAttribute("assignedProjects", assignedProjects);
        request.setAttribute("recentLogs", recentLogs);
        request.setAttribute("presentCount", present);
        request.setAttribute("halfDayCount", halfDay);
        request.setAttribute("currentMonth", month);

        request.getRequestDispatcher("/WEB-INF/views/worker/dashboard.jsp")
                .forward(request, response);
    }
}
