package com.buildtrack.dao.admin;

import com.buildtrack.model.Payroll;
import com.buildtrack.model.Payslip;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PayrollDao {

    //  Insert / Update

    public int insert(Payroll p) {
        String sql = "INSERT INTO payroll (worker_id,month_year,total_days,half_days,daily_wage,generated_by) " +
                "VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getWorkerId());
            ps.setString(2, p.getMonthYear());
            ps.setInt(3, p.getTotalDays());
            ps.setInt(4, p.getHalfDays());
            ps.setBigDecimal(5, p.getDailyWage());
            ps.setInt(6, p.getGeneratedBy());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                System.err.println("[PayrollDAO] Payroll already exists for worker/month.");
            } else {
                System.err.println("[PayrollDAO] insert error: " + e.getMessage());
            }
        }
        return -1;
    }

    /** Insert payroll using external connection (for batch transactions). */
    public int insert(Connection conn, Payroll p) throws SQLException {
        String sql = "INSERT INTO payroll (worker_id,month_year,total_days,half_days,daily_wage,generated_by) " +
                "VALUES (?,?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getWorkerId());
            ps.setString(2, p.getMonthYear());
            ps.setInt(3, p.getTotalDays());
            ps.setInt(4, p.getHalfDays());
            ps.setBigDecimal(5, p.getDailyWage());
            ps.setInt(6, p.getGeneratedBy());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        }
        return -1;
    }

    public boolean markAsPaid(int id) {
        String sql = "UPDATE payroll SET status='PAID', paid_at=NOW() WHERE id=? AND status='PENDING'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[PayrollDAO] markAsPaid error: " + e.getMessage());
        }
        return false;
    }

    // ==================== Queries ====================

    public List<Payroll> findByMonth(String monthYear) {
        List<Payroll> list = new ArrayList<>();
        String sql = "SELECT pr.*, u.full_name AS worker_name, u.email AS worker_email " +
                "FROM payroll pr JOIN users u ON pr.worker_id = u.id " +
                "WHERE pr.month_year = ? ORDER BY u.full_name";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, monthYear);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[PayrollDAO] findByMonth error: " + e.getMessage());
        }
        return list;
    }

    public Payroll findById(int id) {
        String sql = "SELECT pr.*, u.full_name AS worker_name, u.email AS worker_email " +
                "FROM payroll pr JOIN users u ON pr.worker_id = u.id WHERE pr.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("[PayrollDAO] findById error: " + e.getMessage());
        }
        return null;
    }

    public Payroll findByWorkerAndMonth(int workerId, String monthYear) {
        String sql = "SELECT pr.*, u.full_name AS worker_name, u.email AS worker_email " +
                "FROM payroll pr JOIN users u ON pr.worker_id = u.id " +
                "WHERE pr.worker_id = ? AND pr.month_year = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            ps.setString(2, monthYear);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            System.err.println("[PayrollDAO] findByWorkerAndMonth error: " + e.getMessage());
        }
        return null;
    }

    /** Build a full Payslip DTO from payroll ID. */
    public Payslip findPayslipById(int id) {
        String sql = "SELECT pr.*, u.full_name AS worker_name, u.email AS worker_email, " +
                "u.phone AS worker_phone, a.full_name AS admin_name " +
                "FROM payroll pr " +
                "JOIN users u ON pr.worker_id = u.id " +
                "JOIN users a ON pr.generated_by = a.id " +
                "WHERE pr.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapPayslip(rs);
        } catch (SQLException e) {
            System.err.println("[PayrollDAO] findPayslipById error: " + e.getMessage());
        }
        return null;
    }

    public boolean exists(int workerId, String monthYear) {
        String sql = "SELECT COUNT(*) FROM payroll WHERE worker_id=? AND month_year=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            ps.setString(2, monthYear);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.err.println("[PayrollDAO] exists error: " + e.getMessage());
        }
        return false;
    }

    /** Get total salary paid in a month. */
    public java.math.BigDecimal getTotalSalaryByMonth(String monthYear, String status) {
        String sql;
        if (status != null) {
            sql = "SELECT COALESCE(SUM(total_salary),0) FROM payroll WHERE month_year=? AND status=?";
        } else {
            sql = "SELECT COALESCE(SUM(total_salary),0) FROM payroll WHERE month_year=?";
        }
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, monthYear);
            if (status != null) ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[PayrollDAO] getTotalSalaryByMonth error: " + e.getMessage());
        }
        return java.math.BigDecimal.ZERO;
    }



    private Payroll mapRow(ResultSet rs) throws SQLException {
        Payroll p = new Payroll();
        p.setId(rs.getInt("id"));
        p.setWorkerId(rs.getInt("worker_id"));
        p.setMonthYear(rs.getString("month_year"));
        p.setTotalDays(rs.getInt("total_days"));
        p.setHalfDays(rs.getInt("half_days"));
        p.setDailyWage(rs.getBigDecimal("daily_wage"));
        p.setTotalSalary(rs.getBigDecimal("total_salary"));
        p.setStatus(rs.getString("status"));
        p.setGeneratedBy(rs.getInt("generated_by"));
        p.setGeneratedAt(rs.getTimestamp("generated_at"));
        p.setPaidAt(rs.getTimestamp("paid_at"));
        p.setWorkerName(rs.getString("worker_name"));
        p.setWorkerEmail(rs.getString("worker_email"));
        return p;
    }

    private Payslip mapPayslip(ResultSet rs) throws SQLException {
        Payslip ps = new Payslip();
        ps.setPayrollId(rs.getInt("id"));
        ps.setWorkerName(rs.getString("worker_name"));
        ps.setWorkerEmail(rs.getString("worker_email"));
        ps.setWorkerPhone(rs.getString("worker_phone"));
        ps.setMonthYear(rs.getString("month_year"));
        ps.setTotalDays(rs.getInt("total_days"));
        ps.setHalfDays(rs.getInt("half_days"));
        ps.setEffectiveDays(rs.getInt("total_days") + rs.getInt("half_days") * 0.5);
        ps.setDailyWage(rs.getBigDecimal("daily_wage"));
        ps.setTotalSalary(rs.getBigDecimal("total_salary"));
        ps.setStatus(rs.getString("status"));
        ps.setGeneratedByName(rs.getString("admin_name"));
        Timestamp ga = rs.getTimestamp("generated_at");
        ps.setGeneratedAt(ga != null ? ga.toString() : "");
        Timestamp pa = rs.getTimestamp("paid_at");
        ps.setPaidAt(pa != null ? pa.toString() : "");
        // Format month display
        String my = rs.getString("month_year");
        if (my != null && my.length() == 7) {
            String[] parts = my.split("-");
            String[] months = {"January","February","March","April","May","June",
                    "July","August","September","October","November","December"};
            ps.setMonthYearDisplay(months[Integer.parseInt(parts[1])-1] + " " + parts[0]);
        }
        return ps;
    }
}