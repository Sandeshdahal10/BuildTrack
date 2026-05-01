package com.buildtrack.dao.admin;

import com.buildtrack.model.Expense;
import com.buildtrack.util.DBUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * ExpenseDAO — handles all CRUD and aggregate queries
 * for the expenses table.
 */
public class ExpenseDao {

    // ==================== CRUD ====================

    public int insert(Expense expense) {
        String sql = "INSERT INTO expenses (project_id, category, description, " +
                "amount, expense_date, recorded_by) VALUES (?,?,?,?,?,?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, expense.getProjectId());
            ps.setString(2, expense.getCategory());
            ps.setString(3, expense.getDescription());
            ps.setBigDecimal(4, expense.getAmount());
            ps.setDate(5, expense.getExpenseDate());
            ps.setInt(6, expense.getRecordedBy());

            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] insert error: " + e.getMessage());
        }
        return -1;
    }

    public boolean update(Expense expense) {
        String sql = "UPDATE expenses SET project_id=?, category=?, description=?, " +
                "amount=?, expense_date=? WHERE id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, expense.getProjectId());
            ps.setString(2, expense.getCategory());
            ps.setString(3, expense.getDescription());
            ps.setBigDecimal(4, expense.getAmount());
            ps.setDate(5, expense.getExpenseDate());
            ps.setInt(6, expense.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] update error: " + e.getMessage());
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM expenses WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] delete error: " + e.getMessage());
        }
        return false;
    }

    public Expense findById(int id) {
        String sql = "SELECT e.*, p.title AS project_name, " +
                "u.full_name AS recorded_by_name " +
                "FROM expenses e " +
                "JOIN projects p ON e.project_id = p.id " +
                "LEFT JOIN users u ON e.recorded_by = u.id " +
                "WHERE e.id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] findById error: " + e.getMessage());
        }
        return null;
    }

    // ==================== List Queries ====================

    /** All expenses across all projects, newest first. */
    public List<Expense> findAll() {
        String sql = "SELECT e.*, p.title AS project_name, " +
                "u.full_name AS recorded_by_name " +
                "FROM expenses e " +
                "JOIN projects p ON e.project_id = p.id " +
                "LEFT JOIN users u ON e.recorded_by = u.id " +
                "ORDER BY e.expense_date DESC, e.created_at DESC";

        List<Expense> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] findAll error: " + e.getMessage());
        }
        return list;
    }

    /** Expenses for a specific project. */
    public List<Expense> findByProject(int projectId) {
        String sql = "SELECT e.*, p.title AS project_name, " +
                "u.full_name AS recorded_by_name " +
                "FROM expenses e " +
                "JOIN projects p ON e.project_id = p.id " +
                "LEFT JOIN users u ON e.recorded_by = u.id " +
                "WHERE e.project_id = ? " +
                "ORDER BY e.expense_date DESC, e.created_at DESC";

        List<Expense> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] findByProject error: " + e.getMessage());
        }
        return list;
    }

    /** Expenses filtered by project and date range. */
    public List<Expense> findByProjectAndDateRange(int projectId,
                                                   String dateFrom, String dateTo) {
        StringBuilder sql = new StringBuilder(
                "SELECT e.*, p.title AS project_name, " +
                        "u.full_name AS recorded_by_name " +
                        "FROM expenses e " +
                        "JOIN projects p ON e.project_id = p.id " +
                        "LEFT JOIN users u ON e.recorded_by = u.id " +
                        "WHERE e.project_id = ? ");

        if (dateFrom != null && !dateFrom.isEmpty()) sql.append("AND e.expense_date >= ? ");
        if (dateTo != null && !dateTo.isEmpty()) sql.append("AND e.expense_date <= ? ");
        sql.append("ORDER BY e.expense_date DESC, e.created_at DESC");

        List<Expense> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            ps.setInt(idx++, projectId);
            if (dateFrom != null && !dateFrom.isEmpty()) ps.setDate(idx++, Date.valueOf(dateFrom));
            if (dateTo != null && !dateTo.isEmpty()) ps.setDate(idx++, Date.valueOf(dateTo));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] findByProjectAndDateRange error: " + e.getMessage());
        }
        return list;
    }

    /** Recent N expenses across all projects. */
    public List<Expense> findRecent(int limit) {
        String sql = "SELECT e.*, p.title AS project_name, " +
                "u.full_name AS recorded_by_name " +
                "FROM expenses e " +
                "JOIN projects p ON e.project_id = p.id " +
                "LEFT JOIN users u ON e.recorded_by = u.id " +
                "ORDER BY e.expense_date DESC, e.created_at DESC " +
                "LIMIT ?";

        List<Expense> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] findRecent error: " + e.getMessage());
        }
        return list;
    }

    // ==================== Aggregate Queries ====================

    /** Total manual expense for a single project. */
    public BigDecimal getTotalByProject(int projectId) {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM expenses WHERE project_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getBigDecimal(1);

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] getTotalByProject error: " + e.getMessage());
        }
        return BigDecimal.ZERO;
    }

    /** Grand total of ALL manual expenses. */
    public BigDecimal getGrandTotal() {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM expenses";

        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] getGrandTotal error: " + e.getMessage());
        }
        return BigDecimal.ZERO;
    }

    /** Expense breakdown by category for a project. */
    public List<Map<String, Object>> getCategoryBreakdown(int projectId) {
        String sql = "SELECT category, COUNT(*) AS entry_count, " +
                "SUM(amount) AS total_amount " +
                "FROM expenses WHERE project_id = ? " +
                "GROUP BY category ORDER BY total_amount DESC";

        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("category", rs.getString("category"));
                row.put("entryCount", rs.getInt("entry_count"));
                row.put("totalAmount", rs.getBigDecimal("total_amount"));
                list.add(row);
            }

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] getCategoryBreakdown error: " + e.getMessage());
        }
        return list;
    }

    /** Per-project expense summary (for overview table). */
    public List<Map<String, Object>> getProjectExpenseSummary() {
        String sql = "SELECT e.project_id, p.title AS project_name, " +
                "COUNT(*) AS entry_count, " +
                "SUM(e.amount) AS total_expense " +
                "FROM expenses e " +
                "JOIN projects p ON e.project_id = p.id " +
                "GROUP BY e.project_id, p.title " +
                "ORDER BY total_expense DESC";

        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("projectId", rs.getInt("project_id"));
                row.put("projectName", rs.getString("project_name"));
                row.put("entryCount", rs.getInt("entry_count"));
                row.put("totalExpense", rs.getBigDecimal("total_expense"));
                list.add(row);
            }
        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] getProjectExpenseSummary error: " + e.getMessage());
        }
        return list;
    }

    /** Total expense for a project in a specific month (YYYY-MM). */
    public BigDecimal getTotalByProjectAndMonth(int projectId, String monthYear) {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM expenses " +
                "WHERE project_id = ? AND DATE_FORMAT(expense_date, '%Y-%m') = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, projectId);
            ps.setString(2, monthYear);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getBigDecimal(1);

        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] getTotalByProjectAndMonth error: " + e.getMessage());
        }
        return BigDecimal.ZERO;
    }

    /** Count all expense records. */
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM expenses";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[ExpenseDAO] countAll error: " + e.getMessage());
        }
        return 0;
    }

    // ==================== Helper ====================

    private Expense mapRow(ResultSet rs) throws SQLException {
        Expense e = new Expense();
        e.setId(rs.getInt("id"));
        e.setProjectId(rs.getInt("project_id"));
        e.setCategory(rs.getString("category"));
        e.setDescription(rs.getString("description"));
        e.setAmount(rs.getBigDecimal("amount"));
        e.setExpenseDate(rs.getDate("expense_date"));
        e.setRecordedBy(rs.getInt("recorded_by"));
        e.setCreatedAt(rs.getTimestamp("created_at"));
        e.setUpdatedAt(rs.getTimestamp("updated_at"));
        e.setProjectName(rs.getString("project_name"));
        e.setRecordedByName(rs.getString("recorded_by_name"));
        return e;
    }
}