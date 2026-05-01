package com.buildtrack.service.admin;

import com.buildtrack.dao.admin.ReportDao;
import com.buildtrack.model.Attendance;
import com.buildtrack.model.MaterialUsage;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * ReportService — UPDATED to include manual expenses.
 *
 * Cost structure:
 *   Project Cost   = Material Usage + Manual Expenses
 *   Grand Total     = Material + Payroll + Manual Expenses
 */
public class ReportService {

    private final ReportDao reportDAO = new ReportDao();
    private final com.buildtrack.service.admin.MaterialService materialService
            = new com.buildtrack.service.admin.MaterialService();
    private final com.buildtrack.service.admin.AttendanceService attendanceService
            = new com.buildtrack.service.admin.AttendanceService();

    // ==================== Budget Reports (UPDATED) ====================

    public List<Map<String, Object>> getBudgetVsActualAll() {
        return reportDAO.getBudgetVsActualAll();
    }

    public Map<String, Object> getBudgetVsActual(int projectId) {
        return reportDAO.getBudgetVsActual(projectId);
    }

    // ==================== Expense Breakdown (UPDATED) ====================

    /** Material-only breakdown (for backward compatibility). */
    public List<Map<String, Object>> getMaterialExpenseByCategory(int projectId) {
        return reportDAO.getMaterialExpenseByCategory(projectId);
    }

    /** NEW: Manual expense breakdown. */
    public List<Map<String, Object>> getManualExpenseByCategory(int projectId) {
        return reportDAO.getManualExpenseByCategory(projectId);
    }

    /** UPDATED: Combined material + manual expense breakdown. */
    public List<Map<String, Object>> getCombinedExpenseBreakdown(int projectId) {
        return reportDAO.getCombinedExpenseBreakdown(projectId);
    }

    /** Material usage summary (unchanged). */
    public List<MaterialUsage> getMaterialUsageSummary(int projectId) {
        return materialService.getUsageSummaryByProject(projectId);
    }

    // ==================== Attendance Reports (unchanged) ====================

    public List<Attendance> getProjectWorkerSummary(int projectId, String monthYear) {
        return attendanceService.getProjectWorkerSummary(projectId, monthYear);
    }

    // ==================== Payroll Reports (unchanged) ====================

    public List<Map<String, Object>> getPayrollSummaryByMonth() {
        return reportDAO.getPayrollSummaryByMonth();
    }

    // ==================== Grand Totals (UPDATED) ====================

    public BigDecimal getTotalMaterialCost() {
        return reportDAO.getTotalMaterialCost();
    }

    public BigDecimal getTotalPayrollCost() {
        return reportDAO.getTotalPayrollCost();
    }

    /** NEW: Total manual expenses. */
    public BigDecimal getTotalManualExpenseCost() {
        return reportDAO.getTotalManualExpenseCost();
    }

    /** UPDATED: Grand total of everything. */
    public BigDecimal getGrandTotalExpenses() {
        return reportDAO.getGrandTotalExpenses();
    }

    /** NEW: Total cost (material + manual) for a single project. */
    public BigDecimal getProjectTotalCost(int projectId) {
        return reportDAO.getProjectTotalCost(projectId);
    }
}