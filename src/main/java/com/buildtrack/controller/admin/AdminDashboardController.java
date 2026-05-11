package com.buildtrack.controller.admin;

import com.buildtrack.service.admin.MaterialService;
import com.buildtrack.service.admin.ProjectService;
import com.buildtrack.service.admin.ReportService;
import com.buildtrack.service.admin.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * Admin Dashboard — displays overview statistics.
 * GET /admin/dashboard
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private final ProjectService projectService = new ProjectService();
    private final UserService userService = new UserService();
    private final MaterialService materialService = new MaterialService();
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // =========================
            // Project stats
            // =========================
            Map<String, Integer> projectStats = projectService.getStatusCounts();

            if (projectStats == null) {
                projectStats = Collections.emptyMap();
            }

            request.setAttribute("projectStats", projectStats);

            // =========================
            // User stats
            // =========================
            Map<String, Integer> userStats = userService.getUserStats();

            if (userStats == null) {
                userStats = Collections.emptyMap();
            }

            request.setAttribute("userStats", userStats);

            // =========================
            // Material stats
            // =========================
            Map<String, Integer> materialStats = materialService.getMaterialStats();

            if (materialStats == null) {
                materialStats = Collections.emptyMap();
            }

            request.setAttribute("materialStats", materialStats);

            // =========================
            // Financial overview
            // =========================
            request.setAttribute(
                    "totalMaterialCost",
                    reportService.getTotalMaterialCost()
            );

            request.setAttribute(
                    "totalPayrollCost",
                    reportService.getTotalPayrollCost()
            );

            request.setAttribute(
                    "totalExpenses",
                    reportService.getGrandTotalExpenses()
            );

            // =========================
            // Budget vs Actual
            // =========================
            List<Map<String, Object>> budgetVsActual =
                    reportService.getBudgetVsActualAll();

            if (budgetVsActual == null) {
                budgetVsActual = Collections.emptyList();
            }

            request.setAttribute("budgetVsActual", budgetVsActual);

            // =========================
            // Global totals
            // =========================
            BigDecimal totalBudget = BigDecimal.ZERO;
            BigDecimal totalUtilized = BigDecimal.ZERO;

            for (Map<String, Object> row : budgetVsActual) {

                if (row == null) {
                    continue;
                }

                Object budgetObj = row.get("budget");
                Object actualObj = row.get("actualCost");

                BigDecimal budget = BigDecimal.ZERO;
                BigDecimal actual = BigDecimal.ZERO;

                try {
                    if (budgetObj != null) {
                        budget = new BigDecimal(budgetObj.toString());
                    }
                } catch (Exception e) {
                    System.out.println("Invalid budget value: " + budgetObj);
                }

                try {
                    if (actualObj != null) {
                        actual = new BigDecimal(actualObj.toString());
                    }
                } catch (Exception e) {
                    System.out.println("Invalid actualCost value: " + actualObj);
                }

                totalBudget = totalBudget.add(budget);
                totalUtilized = totalUtilized.add(actual);
            }

            request.setAttribute("globalTotalBudget", totalBudget);
            request.setAttribute("globalTotalUtilized", totalUtilized);

            // =========================
            // Recent projects
            // =========================
            List<?> recentProjects = projectService.getAllProjects();

            if (recentProjects == null) {
                recentProjects = Collections.emptyList();
            }

            request.setAttribute(
                    "recentProjects",
                    recentProjects.stream().limit(5).toList()
            );

            // =========================
            // Pending approvals
            // =========================
            List<?> pendingUsers = userService.getPendingUsers();

            if (pendingUsers == null) {
                pendingUsers = Collections.emptyList();
            }

            request.setAttribute("pendingUsers", pendingUsers);

            // =========================
            // Low stock alerts
            // =========================
            List<?> lowStockMaterials = materialService.getLowStockMaterials();

            if (lowStockMaterials == null) {
                lowStockMaterials = Collections.emptyList();
            }

            request.setAttribute("lowStockMaterials", lowStockMaterials);

            // =========================
            // Forward to JSP
            // =========================
            request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            // Print exact error in console
            e.printStackTrace();

            // Send error message to JSP
            request.setAttribute("errorMessage", e.getMessage());

            response.setContentType("text/html");
            response.getWriter().println("<h2>Dashboard Error</h2>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
        }
    }
}