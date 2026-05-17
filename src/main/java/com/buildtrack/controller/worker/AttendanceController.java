package com.buildtrack.controller.worker;

import com.buildtrack.dao.admin.AttendanceDao;
import com.buildtrack.model.Attendance;
import com.buildtrack.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

/**
 * Worker attendance controller: renders monthly history and allows worker
 * to mark their own attendance for assigned projects.
 */
@WebServlet("/worker/attendance")
public class AttendanceController extends HttpServlet {

    private final AttendanceDao attendanceDao = new AttendanceDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // month parameter format: YYYY-MM
        String month = request.getParameter("month");
        if (month == null || month.isBlank()) {
            month = LocalDate.now().toString().substring(0, 7); // yyyy-MM
        }

        // Load worker's attendance for the month
        List<Attendance> records = attendanceDao.findByWorker(user.getId(), month);
        int[] counts = attendanceDao.getAttendanceCounts(user.getId(), month);
        int present = counts.length > 0 ? counts[0] : 0;
        int halfDay = counts.length > 1 ? counts[1] : 0;
        // Absent count = total recorded - present - halfDay
        int totalRecorded = records != null ? records.size() : 0;
        int absent = Math.max(0, totalRecorded - present - halfDay);

        // Fetch projects assigned to this worker
        List<com.buildtrack.model.Project> assignedProjects = new com.buildtrack.dao.worker.WorkLogDao().findAssignedProjects(user.getId());

        request.setAttribute("records", records);
        request.setAttribute("totalDays", totalRecorded);
        request.setAttribute("presentCount", present);
        request.setAttribute("absentCount", absent);
        request.setAttribute("halfDayCount", halfDay);
        request.setAttribute("currentMonth", month);
        request.setAttribute("assignedProjects", assignedProjects);

        request.getRequestDispatcher("/WEB-INF/views/worker/attendance.jsp")
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

        String projectIdStr = request.getParameter("projectId");
        String dateStr = request.getParameter("date");
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");

        // Basic validation
        if (projectIdStr == null || projectIdStr.isEmpty() || status == null || status.isEmpty()) {
            request.setAttribute("error", "Project and status are required to mark attendance.");
            doGet(request, response);
            return;
        }

        int projectId;
        try {
            projectId = Integer.parseInt(projectIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid project selected.");
            doGet(request, response);
            return;
        }

        LocalDate ld = (dateStr == null || dateStr.isBlank()) ? LocalDate.now() : LocalDate.parse(dateStr);
        Date sqlDate = Date.valueOf(ld);

        Attendance a = new Attendance();
        a.setWorkerId(user.getId());
        a.setProjectId(projectId);
        a.setAttendanceDate(sqlDate);
        a.setStatus(status);
        a.setNotes(notes);
        // For self-marking, record who marked it (self)
        a.setMarkedBy(user.getId());

        boolean ok = attendanceDao.insert(a);
        if (ok) {
            request.setAttribute("success", "Attendance marked successfully.");
        } else {
            request.setAttribute("error", "Failed to save attendance. Try again.");
        }

        // Reload view (PRG could be used, but keeping simple to show status)
        doGet(request, response);
    }
}
