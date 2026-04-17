package com.buildtrack.dao.admin;

import com.buildtrack.model.Attendance;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDao {

    //  Insert / Update

    /** Insert attendance. Returns true if successful. */
    public boolean insert(Attendance a) {
        String sql = "INSERT INTO attendance (worker_id,project_id,attendance_date,status,notes,marked_by) " +
                "VALUES (?,?,?,?,?,?) " +
                "ON DUPLICATE KEY UPDATE status=VALUES(status), notes=VALUES(notes), marked_by=VALUES(marked_by)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, a.getWorkerId());
            ps.setInt(2, a.getProjectId());
            ps.setDate(3, a.getAttendanceDate());
            ps.setString(4, a.getStatus());
            ps.setString(5, a.getNotes());
            if (a.getMarkedBy() != null) ps.setInt(6, a.getMarkedBy());
            else ps.setNull(6, Types.INTEGER);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[AttendanceDAO] insert error: " + e.getMessage());
        }
        return false;
    }

    // Queries

    /** Get attendance for all workers on a specific date. */
    public List<Attendance> findByDate(Date date) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT a.*, u.full_name AS worker_name, p.title AS project_name, " +
                "m.full_name AS marked_by_name " +
                "FROM attendance a " +
                "JOIN users u ON a.worker_id = u.id " +
                "JOIN projects p ON a.project_id = p.id " +
                "LEFT JOIN users m ON a.marked_by = m.id " +
                "WHERE a.attendance_date = ? ORDER BY p.title, u.full_name";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, date);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[AttendanceDAO] findByDate error: " + e.getMessage());
        }
        return list;
    }

    /** Get attendance for a specific project on a date. */
    public List<Attendance> findByProjectAndDate(int projectId, Date date) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT a.*, u.full_name AS worker_name, p.title AS project_name, " +
                "m.full_name AS marked_by_name " +
                "FROM attendance a " +
                "JOIN users u ON a.worker_id = u.id " +
                "JOIN projects p ON a.project_id = p.id " +
                "LEFT JOIN users m ON a.marked_by = m.id " +
                "WHERE a.project_id = ? AND a.attendance_date = ? ORDER BY u.full_name";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setDate(2, date);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[AttendanceDAO] findByProjectAndDate error: " + e.getMessage());
        }
        return list;
    }

    /** Get attendance history for a specific worker. */
    public List<Attendance> findByWorker(int workerId, String monthYear) {
        List<Attendance> list = new ArrayList<>();
        String sql;
        if (monthYear != null && monthYear.matches("\\d{4}-\\d{2}")) {
            sql = "SELECT a.*, u.full_name AS worker_name, p.title AS project_name, " +
                    "m.full_name AS marked_by_name " +
                    "FROM attendance a JOIN users u ON a.worker_id = u.id " +
                    "JOIN projects p ON a.project_id = p.id " +
                    "LEFT JOIN users m ON a.marked_by = m.id " +
                    "WHERE a.worker_id = ? AND DATE_FORMAT(a.attendance_date,'%Y-%m') = ? " +
                    "ORDER BY a.attendance_date DESC";
        } else {
            sql = "SELECT a.*, u.full_name AS worker_name, p.title AS project_name, " +
                    "m.full_name AS marked_by_name " +
                    "FROM attendance a JOIN users u ON a.worker_id = u.id " +
                    "JOIN projects p ON a.project_id = p.id " +
                    "LEFT JOIN users m ON a.marked_by = m.id " +
                    "WHERE a.worker_id = ? ORDER BY a.attendance_date DESC";
        }
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            if (monthYear != null && monthYear.matches("\\d{4}-\\d{2}")) {
                ps.setString(2, monthYear);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            System.err.println("[AttendanceDAO] findByWorker error: " + e.getMessage());
        }
        return list;
    }

    //  Payroll Calculation

    /**
     * Returns [totalPresentDays, totalHalfDays] for a worker in a given month.
     * Index 0 = PRESENT count, Index 1 = HALF_DAY count.
     */
    public int[] getAttendanceCounts(int workerId, String monthYear) {
        String sql = "SELECT status, COUNT(*) AS cnt FROM attendance " +
                "WHERE worker_id = ? AND DATE_FORMAT(attendance_date,'%Y-%m') = ? " +
                "AND status IN ('PRESENT','HALF_DAY') GROUP BY status";
        int present = 0, halfDay = 0;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            ps.setString(2, monthYear);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String s = rs.getString("status");
                int cnt = rs.getInt("cnt");
                if ("PRESENT".equals(s)) present = cnt;
                else if ("HALF_DAY".equals(s)) halfDay = cnt;
            }
        } catch (SQLException e) {
            System.err.println("[AttendanceDAO] getAttendanceCounts error: " + e.getMessage());
        }
        return new int[]{present, halfDay};
    }

    /** Check if attendance already exists for a worker on a date/project. */
    public boolean exists(int workerId, int projectId, Date date) {
        String sql = "SELECT COUNT(*) FROM attendance WHERE worker_id=? AND project_id=? AND attendance_date=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            ps.setInt(2, projectId);
            ps.setDate(3, date);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.err.println("[AttendanceDAO] exists error: " + e.getMessage());
        }
        return false;
    }

    /** Attendance summary per worker for a project in a month (for reports). */
    public List<Attendance> getProjectWorkerSummary(int projectId, String monthYear) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT a.worker_id, u.full_name AS worker_name, " +
                "SUM(CASE WHEN a.status='PRESENT' THEN 1 ELSE 0 END) AS present_days, " +
                "SUM(CASE WHEN a.status='HALF_DAY' THEN 1 ELSE 0 END) AS half_days, " +
                "SUM(CASE WHEN a.status='ABSENT' THEN 1 ELSE 0 END) AS absent_days " +
                "FROM attendance a JOIN users u ON a.worker_id = u.id " +
                "WHERE a.project_id = ? AND DATE_FORMAT(a.attendance_date,'%Y-%m') = ? " +
                "GROUP BY a.worker_id, u.full_name ORDER BY u.full_name";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setString(2, monthYear);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Attendance a = new Attendance();
                a.setWorkerId(rs.getInt("worker_id"));
                a.setWorkerName(rs.getString("worker_name"));
                // Store counts in notes field temporarily for the report
                a.setNotes(rs.getInt("present_days") + "P/" + rs.getInt("half_days") + "H/" + rs.getInt("absent_days") + "A");
                list.add(a);
            }
        } catch (SQLException e) {
            System.err.println("[AttendanceDAO] getProjectWorkerSummary error: " + e.getMessage());
        }
        return list;
    }



    private Attendance mapRow(ResultSet rs) throws SQLException {
        Attendance a = new Attendance();
        a.setId(rs.getInt("id"));
        a.setWorkerId(rs.getInt("worker_id"));
        a.setProjectId(rs.getInt("project_id"));
        a.setAttendanceDate(rs.getDate("attendance_date"));
        a.setStatus(rs.getString("status"));
        a.setNotes(rs.getString("notes"));
        int mb = rs.getInt("marked_by");
        a.setMarkedBy(rs.wasNull() ? null : mb);
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setWorkerName(rs.getString("worker_name"));
        a.setProjectName(rs.getString("project_name"));
        a.setMarkedByName(rs.getString("marked_by_name"));
        return a;
    }
}