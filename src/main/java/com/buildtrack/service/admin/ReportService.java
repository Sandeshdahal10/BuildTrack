package com.buildtrack.service.admin;

import com.buildtrack.dao.admin.ReportDao;
import com.buildtrack.model.MaterialUsage;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public class ReportService {

    private final ReportDao reportDAO = new ReportDao();
    private final com.buildtrack.service.admin.MaterialService materialService
            = new com.buildtrack.service.admin.MaterialService();
    private final com.buildtrack.service.admin.AttendanceService attendanceService
            = new com.buildtrack.service.admin.AttendanceService();

    //Budget Reports

    public List<Map<String, Object>> getBudgetVsActualAll() {
        return reportDAO.getBudgetVsActualAll();
    }

    public Map<String, Object> getBudgetVsActual(int projectId) {
        return reportDAO.getBudgetVsActual(projectId);
    }

    //Material Reports

    public List<Map<String, Object>> getExpenseByCategory(int projectId) {
        return reportDAO.getExpenseByCategory(projectId);
    }

    public List<MaterialUsage> getMaterialUsageSummary(int projectId) {
        return materialService.getUsageSummaryByProject(projectId);
    }

    // Attendance Reports

    public List<com.buildtrack.model.Attendance> getProjectWorkerSummary(int projectId, String monthYear) {
        return attendanceService.getProjectWorkerSummary(projectId, monthYear);
    }

    // Payroll Reports

    public List<Map<String, Object>> getPayrollSummaryByMonth() {
        return reportDAO.getPayrollSummaryByMonth();
    }

    //Overall Totals

    public BigDecimal getTotalMaterialCost() { return reportDAO.getTotalMaterialCost(); }
    public BigDecimal getTotalPayrollCost() { return reportDAO.getTotalPayrollCost(); }

    public BigDecimal getTotalExpenses() {
        return reportDAO.getTotalMaterialCost().add(reportDAO.getTotalPayrollCost());
    }
}