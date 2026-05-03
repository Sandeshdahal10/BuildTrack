package com.buildtrack.dao.admin;

import com.buildtrack.util.DBUtil;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ReportDAO — aggregated read-only queries for admin reports.
 * UPDATED: Now includes manual expenses in all calculations.
 * Total Project Cost = Material Usage + Manual Expenses
 * Grand Total Expenses = Material + Payroll + Manual Expenses
 */
public class ReportDao {

    // ==================== Budget vs Actual (UPDATED) ====================

    /**
     * Budget vs Actual for ALL projects.
     * NOW includes manual expenses in actual cost.
     *
     * actual_cost = SUM(material_usage.total_cost) + SUM(expenses.amount)
     */
    public List<Map<String, Object>> getBudgetVsActualAll() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.id, p.title, p.status, " +
                "       COALESCE(p.total_budget, 0) AS total_budget, " +
                "       COALESCE((SELECT SUM(mu.total_cost) " +
                "               FROM material_usage mu WHERE mu.project_id = p.id), 0) " +
                "       + COALESCE((SELECT SUM(e.amount) " +
                "               FROM expenses e WHERE e.project_id = p.id), 0) " +
                "       AS actual_cost " +
                "FROM projects p " +
                "ORDER BY p.title";

        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = buildBudgetRow(rs);
                list.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getBudgetVsActualAll error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Budget vs Actual for a SINGLE project.
     * NOW includes manual expenses.
     */
    public Map<String, Object> getBudgetVsActual(int projectId) {
        String sql = "SELECT p.id, p.title, p.status, " +
                "       COALESCE(p.total_budget, 0) AS total_budget, " +
                "       COALESCE((SELECT SUM(mu.total_cost) " +
                "               FROM material_usage mu WHERE mu.project_id = p.id), 0) " +
                "       + COALESCE((SELECT SUM(e.amount) " +
                "               FROM expenses e WHERE e.project_id = p.id), 0) " +
                "       AS actual_cost " +
                "FROM projects p WHERE p.id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return buildBudgetRow(rs);
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getBudgetVsActual error: " + e.getMessage());
        }
        return null;
    }

    // ==================== Expense Category Breakdown (UPDATED)
    // ====================

    /**
     * Material expense categories for a project (unchanged).
     */
    public List<Map<String, Object>> getMaterialExpenseByCategory(int projectId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT m.name AS material_name, m.unit, " +
                "       SUM(mu.quantity_used) AS total_quantity, " +
                "       SUM(mu.total_cost) AS total_cost " +
                "FROM material_usage mu " +
                "JOIN materials m ON mu.material_id = m.id " +
                "WHERE mu.project_id = ? " +
                "GROUP BY m.id, m.name, m.unit " +
                "ORDER BY total_cost DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("name", rs.getString("material_name"));
                row.put("unit", rs.getString("unit"));
                row.put("totalQuantity", rs.getBigDecimal("total_quantity"));
                row.put("totalCost", rs.getBigDecimal("total_cost"));
                row.put("type", "Material");
                list.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getMaterialExpenseByCategory error: " + e.getMessage());
        }
        return list;
    }

    /**
     * NEW: Manual expense categories for a project.
     */
    public List<Map<String, Object>> getManualExpenseByCategory(int projectId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT category, COUNT(*) AS entry_count, " +
                "       SUM(amount) AS total_cost " +
                "FROM expenses WHERE project_id = ? " +
                "GROUP BY category ORDER BY total_cost DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("name", rs.getString("category"));
                row.put("unit", "entries");
                row.put("totalQuantity", rs.getInt("entry_count"));
                row.put("totalCost", rs.getBigDecimal("total_cost"));
                row.put("type", "Manual");
                list.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getManualExpenseByCategory error: " + e.getMessage());
        }
        return list;
    }

    /**
     * UPDATED: Combined expense breakdown (material + manual) for a project.
     */
    public List<Map<String, Object>> getCombinedExpenseBreakdown(int projectId) {
        List<Map<String, Object>> list = new ArrayList<>();
        list.addAll(getMaterialExpenseByCategory(projectId));
        list.addAll(getManualExpenseByCategory(projectId));
        // Sort by total cost descending
        list.sort((a, b) -> ((BigDecimal) b.get("totalCost"))
                .compareTo((BigDecimal) a.get("totalCost")));
        return list;
    }

    // ==================== Payroll Summary (unchanged) ====================

    /**
     * Returns payroll summary aggregated by month.
     */
    public List<Map<String, Object>> getPayrollSummaryByMonth() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT month_year, " +
                "       COUNT(*) AS total_workers, " +
                "       SUM(CASE WHEN status='PAID' THEN 1 ELSE 0 END) AS paid_count, " +
                "       SUM(CASE WHEN status='PENDING' THEN 1 ELSE 0 END) AS pending_count, " +
                "       SUM(total_salary) AS total_amount " +
                "FROM payroll " +
                "GROUP BY month_year ORDER BY month_year DESC LIMIT 12";

        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("monthYear", rs.getString("month_year"));
                row.put("totalWorkers", rs.getInt("total_workers"));
                row.put("paidCount", rs.getInt("paid_count"));
                row.put("pendingCount", rs.getInt("pending_count"));
                row.put("totalAmount", rs.getBigDecimal("total_amount"));
                list.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getPayrollSummaryByMonth error: " + e.getMessage());
        }
        return list;
    }

    // ==================== Grand Totals (UPDATED) ====================

    /** Total material cost across all projects. */
    public BigDecimal getTotalMaterialCost() {
        String sql = "SELECT COALESCE(SUM(total_cost), 0) FROM material_usage";
        return runSumQuery(sql);
    }

    /** Total payroll cost across all months. */
    public BigDecimal getTotalPayrollCost() {
        String sql = "SELECT COALESCE(SUM(total_salary), 0) FROM payroll";
        return runSumQuery(sql);
    }

    /** NEW: Total manual expense cost across all projects. */
    public BigDecimal getTotalManualExpenseCost() {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM expenses";
        return runSumQuery(sql);
    }

    /** UPDATED: Grand total = material + payroll + manual expenses. */
    public BigDecimal getGrandTotalExpenses() {
        String sql = "SELECT " +
                "  COALESCE((SELECT SUM(total_cost) FROM material_usage), 0) + " +
                "  COALESCE((SELECT SUM(total_salary) FROM payroll), 0) + " +
                "  COALESCE((SELECT SUM(amount) FROM expenses), 0) " +
                "AS grand_total";

        return runSumQuery(sql);
    }

    /** NEW: Get material + manual cost for a single project. */
    public BigDecimal getProjectTotalCost(int projectId) {
        String sql = "SELECT " +
                "  COALESCE((SELECT SUM(total_cost) FROM material_usage WHERE project_id = ?), 0) + " +
                "  COALESCE((SELECT SUM(amount) FROM expenses WHERE project_id = ?), 0) " +
                "AS project_total";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setInt(2, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getProjectTotalCost error: " + e.getMessage());
        }
        return BigDecimal.ZERO;
    }

    // ==================== Helpers ====================

    /**
     * Runs a sum query that returns a single BigDecimal.
     */
    private BigDecimal runSumQuery(String sql) {
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[ReportDAO] runSumQuery error: " + e.getMessage());
        }
        return BigDecimal.ZERO;
    }

    /**
     * Builds a budget comparison row with computed fields.
     */
    private Map<String, Object> buildBudgetRow(ResultSet rs) throws SQLException {
        Map<String, Object> row = new HashMap<>();
        BigDecimal budget = rs.getBigDecimal("total_budget");
        BigDecimal actual = rs.getBigDecimal("actual_cost");
        BigDecimal remaining = budget.subtract(actual);

        double pct = 0;
        if (budget.compareTo(BigDecimal.ZERO) > 0) {
            pct = actual.multiply(BigDecimal.valueOf(100))
                    .divide(budget, 1, RoundingMode.HALF_UP).doubleValue();
        }

        row.put("projectId", rs.getInt("id"));
        row.put("title", rs.getString("title"));
        row.put("status", rs.getString("status"));
        row.put("budget", budget);
        row.put("actualCost", actual);
        row.put("remaining", remaining);
        row.put("usagePercent", pct);
        return row;
    }
}