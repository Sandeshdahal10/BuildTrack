package com.buildtrack.controller.admin;

import com.buildtrack.model.Attendance;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.service.admin.ReportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Admin reports — read-only aggregated views.
 *
 * GET  /admin/reports                            → reports overview
 * GET  /admin/reports?action=budget              → budget vs actual for all projects
 * GET  /admin/reports?action=budget&pid=X        → budget vs actual for one project
 * GET  /admin/reports?action=material&pid=X      → material expense breakdown for project
 * GET  /admin/reports?action=attendance&pid=X&my=X → attendance summary for project/month
 * GET  /admin/reports?action=payroll             → payroll summary by month
 */
@WebServlet("/admin/reports")
public class ReportController extends HttpServlet {

    private final ReportService reportService = new ReportService();
    private final com.buildtrack.service.admin.ProjectService projectService
            = new com.buildtrack.service.admin.ProjectService();

    // ==================== GET (all reports are read-only) ====================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // ---------- Reports overview ----------
            request.setAttribute("totalMaterialCost", reportService.getTotalMaterialCost());
            request.setAttribute("totalPayrollCost", reportService.getTotalPayrollCost());
            request.setAttribute("totalExpenses", reportService.getTotalExpenses());
            request.setAttribute("projects", projectService.getAllProjects());
            request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
                    .forward(request, response);
            return;
        }

        switch (action) {

            // ---------- Budget vs Actual — all projects ----------
            case "budget": {
                String pidStr = request.getParameter("pid");

                if (pidStr != null && !pidStr.isEmpty()) {
                    // Single project budget report
                    int projectId = Integer.parseInt(pidStr);
                    Map<String, Object> report = reportService.getBudgetVsActual(projectId);
                    if (report == null) { response.sendError(404, "Project not found"); return; }

                    request.setAttribute("singleReport", report);
                    request.setAttribute("projectId", projectId);
                    request.setAttribute("projectTitle", report.get("title"));

                    // Also get expense breakdown by category
                    List<Map<String, Object>> categories =
                            reportService.getExpenseByCategory(projectId);
                    request.setAttribute("expenseCategories", categories);

                    // Material usage summary
                    List<MaterialUsage> usageSummary =
                            reportService.getMaterialUsageSummary(projectId);
                    request.setAttribute("usageSummary", usageSummary);
                } else {
                    // All projects budget report
                    List<Map<String, Object>> reports = reportService.getBudgetVsActualAll();
                    request.setAttribute("budgetReports", reports);
                }

                request.setAttribute("projects", projectService.getAllProjects());
                request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
                        .forward(request, response);
                break;
            }

            // ---------- Material expense breakdown ----------
            case "material": {
                int projectId = Integer.parseInt(request.getParameter("pid"));
                List<Map<String, Object>> categories =
                        reportService.getExpenseByCategory(projectId);
                List<MaterialUsage> usageSummary =
                        reportService.getMaterialUsageSummary(projectId);

                request.setAttribute("projectId", projectId);
                request.setAttribute("expenseCategories", categories);
                request.setAttribute("usageSummary", usageSummary);
                request.setAttribute("projects", projectService.getAllProjects());
                request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
                        .forward(request, response);
                break;
            }

            // ---------- Attendance summary for project/month ----------
            case "attendance": {
                int projectId = Integer.parseInt(request.getParameter("pid"));
                String monthYear = request.getParameter("my");

                List<Attendance> summary =
                        reportService.getProjectWorkerSummary(projectId, monthYear);

                request.setAttribute("projectId", projectId);
                request.setAttribute("monthYear", monthYear);
                request.setAttribute("attendanceSummary", summary);
                request.setAttribute("projects", projectService.getAllProjects());
                request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
                        .forward(request, response);
                break;
            }

            // ---------- Payroll summary by month ----------
            case "payroll": {
                List<Map<String, Object>> summary = reportService.getPayrollSummaryByMonth();
                request.setAttribute("payrollSummary", summary);
                request.getRequestDispatcher("/WEB-INF/views/admin/reports.jsp")
                        .forward(request, response);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/reports");
        }
    }

    // No POST — reports are read-only
}