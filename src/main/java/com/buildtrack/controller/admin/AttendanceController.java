package com.buildtrack.controller.admin;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import com.buildtrack.dao.admin.ProjectDao;
import com.buildtrack.model.Attendance;
import com.buildtrack.model.Project;
import com.buildtrack.service.admin.AttendanceService;
import com.buildtrack.service.admin.ProjectService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Admin attendance management — view and mark attendance for workers.
 *
 * GET /admin/attendance → show attendance form (pick date/project)
 * GET /admin/attendance?action=view&date=X → view all attendance for a date
 * GET /admin/attendance?action=view&pid=X&date=X → view attendance for
 * project+date
 * GET /admin/attendance?action=worker&id=X&my=X → view worker attendance
 * history
 * POST /admin/attendance?action=mark → mark attendance for one worker
 * POST /admin/attendance?action=batch-mark → batch mark for multiple workers
 */
@WebServlet("/admin/attendance")
public class AttendanceController extends HttpServlet {

    private final AttendanceService attendanceService = new AttendanceService();
    private final ProjectService projectService = new ProjectService();

    // ==================== GET ====================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // ---------- Show today's attendance by default ----------
            String today = LocalDate.now().toString();
            request.setAttribute("attendanceDate", today);
            request.setAttribute("records", attendanceService.getAttendanceByDate(today));
            List<Project> activeProjects = projectService.getProjectsByStatus("IN_PROGRESS");
            request.setAttribute("projects", activeProjects);
            transferFlashMessages(request);
            request.getRequestDispatcher("/WEB-INF/views/admin/attendance.jsp")
                    .forward(request, response);
            return;
        }

        switch (action) {

            // ---------- View attendance for a specific date (all projects) ----------
            case "view" -> {
                String dateStr = request.getParameter("date");
                String pidStr = request.getParameter("pid");
                if (dateStr == null || dateStr.isBlank()) {
                    dateStr = LocalDate.now().toString();
                }

                List<Attendance> records;

                if (pidStr != null && !pidStr.isEmpty()) {
                    // Filter by project
                    int projectId = Integer.parseInt(pidStr);
                    records = attendanceService.getAttendanceByProjectAndDate(projectId, dateStr);
                    request.setAttribute("projectId", projectId);
                    Project p = projectService.getProjectById(projectId);
                    if (p != null)
                        request.setAttribute("projectName", p.getTitle());
                } else {
                    // All projects for that date
                    records = attendanceService.getAttendanceByDate(dateStr);
                }

                request.setAttribute("attendanceDate", dateStr);
                request.setAttribute("records", records);
                request.setAttribute("projects", projectService.getProjectsByStatus("IN_PROGRESS"));
                transferFlashMessages(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/attendance.jsp")
                        .forward(request, response);
            }

            // ---------- View a specific worker's attendance history ----------
            case "worker" -> {
                int workerId = Integer.parseInt(request.getParameter("id"));
                String monthYear = request.getParameter("my"); // YYYY-MM

                List<Attendance> history = attendanceService.getWorkerHistory(workerId, monthYear);
                request.setAttribute("workerId", workerId);
                request.setAttribute("monthYear", monthYear);
                request.setAttribute("history", history);
                request.setAttribute("projects", projectService.getProjectsByStatus("IN_PROGRESS"));
                transferFlashMessages(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/attendance.jsp")
                        .forward(request, response);
            }

            // ---------- Show mark attendance form for a project ----------
            case "mark" -> {
                int projectId = Integer.parseInt(request.getParameter("pid"));
                String dateStr = request.getParameter("date");
                if (dateStr == null || dateStr.isBlank()) {
                    dateStr = LocalDate.now().toString();
                }
                Project p = projectService.getProjectById(projectId);

                if (p == null) {
                    response.sendError(404, "Project not found");
                    return;
                }

                // Get workers assigned to this project
                List<ProjectDao.AssignedWorker> workers = projectService.getAssignedWorkers(projectId);

                // Get existing attendance for this project+date
                List<Attendance> existing = attendanceService.getAttendanceByProjectAndDate(
                        projectId, dateStr);

                request.setAttribute("project", p);
                request.setAttribute("date", dateStr);
                request.setAttribute("attendanceDate", dateStr);
                request.setAttribute("assignedWorkers", workers);
                request.setAttribute("existingAttendance", existing);
                request.setAttribute("projects", projectService.getProjectsByStatus("IN_PROGRESS"));
                transferFlashMessages(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/attendance.jsp")
                        .forward(request, response);
            }

            default -> response.sendRedirect(request.getContextPath() + "/admin/attendance");
        }
    }

    private void transferFlashMessages(HttpServletRequest request) {
        Object errors = request.getSession().getAttribute("errors");
        if (errors != null) {
            request.setAttribute("errors", errors);
            request.getSession().removeAttribute("errors");
        }
        Object success = request.getSession().getAttribute("success");
        if (success != null) {
            request.setAttribute("success", success);
            request.getSession().removeAttribute("success");
        }
    }

    // ==================== POST ====================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/attendance");
            return;
        }

        int adminId = (int) request.getSession().getAttribute("userId");

        switch (action) {

            // ---------- Mark attendance for a single worker ----------
            case "mark" -> {
                int workerId = Integer.parseInt(request.getParameter("workerId"));
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                String dateStr = request.getParameter("date");
                String status = request.getParameter("status");
                String notes = request.getParameter("notes");

                List<String> errors = attendanceService.markAttendance(
                        workerId, projectId, dateStr, status, notes, adminId);

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                }

                // Redirect back to mark form
                response.sendRedirect(request.getContextPath()
                        + "/admin/attendance?action=mark&pid=" + projectId
                        + "&date=" + dateStr);
            }

            // ---------- Batch mark attendance (all selected workers same status)
            // ----------
            case "batch-mark" -> {
                int projectId = Integer.parseInt(request.getParameter("projectId"));
                String dateStr = request.getParameter("date");
                String status = request.getParameter("status");
                String[] workerIdStrs = request.getParameterValues("workerIds");

                List<String> errors;
                int selectedCount = 0;

                if (workerIdStrs == null || workerIdStrs.length == 0) {
                    errors = List.of("No workers selected.");
                } else {
                    selectedCount = workerIdStrs.length;
                    int[] workerIds = new int[workerIdStrs.length];
                    for (int i = 0; i < workerIdStrs.length; i++) {
                        workerIds[i] = Integer.parseInt(workerIdStrs[i]);
                    }
                    errors = attendanceService.batchMarkAttendance(
                            projectId, dateStr, status, workerIds, adminId);
                }

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "Attendance marked for " + selectedCount + " worker(s).");
                }

                response.sendRedirect(request.getContextPath()
                        + "/admin/attendance?action=mark&pid=" + projectId
                        + "&date=" + dateStr);
            }

            default -> response.sendRedirect(request.getContextPath() + "/admin/attendance");
        }
    }
}