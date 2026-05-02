package com.buildtrack.controller.admin;

import com.buildtrack.service.admin.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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

        // Project stats
        Map<String, Integer> projectStats = projectService.getStatusCounts();
        request.setAttribute("projectStats", projectStats);

        // User stats
        Map<String, Integer> userStats = userService.getUserStats();
        request.setAttribute("userStats", userStats);

        // Material stats
        Map<String, Integer> materialStats = materialService.getMaterialStats();
        request.setAttribute("materialStats", materialStats);

        // Financial overview
        request.setAttribute("totalMaterialCost", reportService.getTotalMaterialCost());
        request.setAttribute("totalPayrollCost", reportService.getTotalPayrollCost());
        request.setAttribute("totalExpenses", reportService.getGrandTotalExpenses());
        
        List<Map<String, Object>> budgetVsActual = reportService.getBudgetVsActualAll();
        request.setAttribute("budgetVsActual", budgetVsActual);
        
        // Calculate Total Budget and Utilized dynamically for the whole system
        java.math.BigDecimal totalBudget = java.math.BigDecimal.ZERO;
        java.math.BigDecimal totalUtilized = java.math.BigDecimal.ZERO;
        for (Map<String, Object> row : budgetVsActual) {
            totalBudget = totalBudget.add((java.math.BigDecimal) row.get("budget"));
            totalUtilized = totalUtilized.add((java.math.BigDecimal) row.get("actualCost"));
        }
        request.setAttribute("globalTotalBudget", totalBudget);
        request.setAttribute("globalTotalUtilized", totalUtilized);

        // Recent projects (top 5)
        request.setAttribute("recentProjects",
                projectService.getAllProjects().stream().limit(5).toList());

        // Pending approvals
        request.setAttribute("pendingUsers", userService.getPendingUsers());

        // Low stock alerts
        request.setAttribute("lowStockMaterials", materialService.getLowStockMaterials());

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp")
                .forward(request, response);
    }
}