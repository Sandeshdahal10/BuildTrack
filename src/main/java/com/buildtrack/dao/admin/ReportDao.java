package com.buildtrack.dao.admin;

import com.buildtrack.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ReportDAO provides aggregated data queries for admin reports.
 * Returns Maps and Lists rather than model objects,
 * since reports are read-only aggregate views.
 */
public class ReportDao {

    //  Budget Reports

    /** Returns budget vs actual cost for all projects. */
    public List<Map<String, Object>> getBudgetVsActualAll() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.id, p.title, p.status, p.total_budget, " +
                "COALESCE(SUM(mu.total_cost),0) AS actual_cost " +
                "FROM projects p " +
                "LEFT JOIN material_usage mu ON p.id = mu.project_id " +
                "GROUP BY p.id, p.title, p.status, p.total_budget " +
                "ORDER BY p.title";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("projectId", rs.getInt("id"));
                row.put("title", rs.getString("title"));
                row.put("status", rs.getString("status"));
                row.put("budget", rs.getBigDecimal("total_budget"));
                row.put("actualCost", rs.getBigDecimal("actual_cost"));
                BigDecimal budget = rs.getBigDecimal("total_budget");
                BigDecimal actual = rs.getBigDecimal("actual_cost");
                BigDecimal remaining = budget.subtract(actual);
                row.put("remaining", remaining);
                double pct = 0;
                if (budget.compareTo(BigDecimal.ZERO) > 0) {
                    pct = actual.multiply(BigDecimal.valueOf(100))
                            .divide(budget, 1, BigDecimal.ROUND_HALF_UP).doubleValue();
                }
                row.put("usagePercent", pct);
                list.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getBudgetVsActualAll error: " + e.getMessage());
        }
        return list;
    }

    /** Budget vs actual for a single project. */
    public Map<String, Object> getBudgetVsActual(int projectId) {
        String sql = "SELECT p.title, p.status, p.total_budget, " +
                "COALESCE(SUM(mu.total_cost),0) AS actual_cost " +
                "FROM projects p " +
                "LEFT JOIN material_usage mu ON p.id = mu.project_id " +
                "WHERE p.id = ? GROUP BY p.id, p.title, p.status, p.total_budget";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("title", rs.getString("title"));
                row.put("status", rs.getString("status"));
                row.put("budget", rs.getBigDecimal("total_budget"));
                BigDecimal actual = rs.getBigDecimal("actual_cost");
                row.put("actualCost", actual);
                BigDecimal budget = rs.getBigDecimal("total_budget");
                row.put("remaining", budget.subtract(actual));
                double pct = 0;
                if (budget.compareTo(BigDecimal.ZERO) > 0) {
                    pct = actual.multiply(BigDecimal.valueOf(100))
                            .divide(budget, 1, BigDecimal.ROUND_HALF_UP).doubleValue();
                }
                row.put("usagePercent", pct);
                return row;
            }
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getBudgetVsActual error: " + e.getMessage());
        }
        return null;
    }

    // Expense Category Report

    /** Total expense grouped by material for a project. */
    public List<Map<String, Object>> getExpenseByCategory(int projectId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT m.name AS material_name, m.unit, " +
                "SUM(mu.quantity_used) AS total_quantity, " +
                "SUM(mu.total_cost) AS total_cost " +
                "FROM material_usage mu JOIN materials m ON mu.material_id = m.id " +
                "WHERE mu.project_id = ? " +
                "GROUP BY m.id, m.name, m.unit ORDER BY total_cost DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("materialName", rs.getString("material_name"));
                row.put("unit", rs.getString("unit"));
                row.put("totalQuantity", rs.getBigDecimal("total_quantity"));
                row.put("totalCost", rs.getBigDecimal("total_cost"));
                list.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getExpenseByCategory error: " + e.getMessage());
        }
        return list;
    }

    //  Payroll Summary

    /** Total payroll expense by month. */
    public List<Map<String, Object>> getPayrollSummaryByMonth() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT month_year, " +
                "COUNT(*) AS total_workers, " +
                "SUM(CASE WHEN status='PAID' THEN 1 ELSE 0 END) AS paid_count, " +
                "SUM(CASE WHEN status='PENDING' THEN 1 ELSE 0 END) AS pending_count, " +
                "SUM(total_salary) AS total_amount " +
                "FROM payroll GROUP BY month_year ORDER BY month_year DESC LIMIT 12";
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

    //  Dashboard Totals

    /** Grand total of all material costs across all projects. */
    public BigDecimal getTotalMaterialCost() {
        String sql = "SELECT COALESCE(SUM(total_cost),0) FROM material_usage";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getTotalMaterialCost error: " + e.getMessage());
        }
        return BigDecimal.ZERO;
    }

    /** Grand total of all payroll across all months. */
    public BigDecimal getTotalPayrollCost() {
        String sql = "SELECT COALESCE(SUM(total_salary),0) FROM payroll";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[ReportDAO] getTotalPayrollCost error: " + e.getMessage());
        }
        return BigDecimal.ZERO;
    }
}