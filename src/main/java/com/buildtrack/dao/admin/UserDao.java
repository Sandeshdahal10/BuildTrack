package com.buildtrack.dao.admin;

import com.buildtrack.model.Role;
import com.buildtrack.model.User;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {

    // CRUD for user

    public List<User> findByRole(String role) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id,full_name,email,phone,role,status,daily_wage,created_at " +
                "FROM users WHERE role = ? ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRowBasic(rs));
        } catch (SQLException e) {
            System.err.println("[UserDAO] findByRole error: " + e.getMessage());
        }
        return list;
    }

    public List<User> findByRoleAndStatus(String role, String status) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id,full_name,email,phone,role,status,daily_wage,created_at " +
                "FROM users WHERE role = ? AND status = ? ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRowBasic(rs));
        } catch (SQLException e) {
            System.err.println("[UserDAO] findByRoleAndStatus error: " + e.getMessage());
        }
        return list;
    }

    public List<User> findByStatus(String status) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id,full_name,email,phone,role,status,daily_wage,created_at " +
                "FROM users WHERE status = ? ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRowBasic(rs));
        } catch (SQLException e) {
            System.err.println("[UserDAO] findByStatus error: " + e.getMessage());
        }
        return list;
    }

    public List<User> findAllNonAdmin() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id,full_name,email,phone,role,status,daily_wage,created_at " +
                "FROM users WHERE role != 'ADMIN' ORDER BY role, created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRowBasic(rs));
        } catch (SQLException e) {
            System.err.println("[UserDAO] findAllNonAdmin error: " + e.getMessage());
        }
        return list;
    }

    public User findById(int id) {
        String sql = "SELECT id,full_name,email,phone,role,status,daily_wage,created_at,updated_at " +
                "FROM users WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRowBasic(rs);
        } catch (SQLException e) {
            System.err.println("[UserDAO] findById error: " + e.getMessage());
        }
        return null;
    }

    /** Search users by name or email (for assign-worker dropdown). */
    public List<User> searchWorkers(String query) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id,full_name,email,phone,role,status,daily_wage " +
                "FROM users WHERE role='WORKER' AND status='APPROVED' " +
                "AND (full_name LIKE ? OR email LIKE ?) ORDER BY full_name LIMIT 20";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String pattern = "%" + query + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRowBasic(rs));
        } catch (SQLException e) {
            System.err.println("[UserDAO] searchWorkers error: " + e.getMessage());
        }
        return list;
    }

    // Updating Status

    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[UserDAO] updateStatus error: " + e.getMessage());
        }
        return false;
    }

    public boolean updateDailyWage(int id, java.math.BigDecimal wage) {
        String sql = "UPDATE users SET daily_wage = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, wage);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[UserDAO] updateDailyWage error: " + e.getMessage());
        }
        return false;
    }

    public boolean updateProfile(int id, String fullName, String phone) {
        String sql = "UPDATE users SET full_name = ?, phone = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[UserDAO] updateProfile error: " + e.getMessage());
        }
        return false;
    }

    // Added logic for counts

    public int countByRoleAndStatus(String role, String status) {
        String sql = "SELECT COUNT(*) FROM users WHERE role = ? AND status = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[UserDAO] countByRoleAndStatus error: " + e.getMessage());
        }
        return 0;
    }

    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM users WHERE status = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[UserDAO] countByStatus error: " + e.getMessage());
        }
        return 0;
    }



    private User mapRowBasic(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRole(Role.fromString(rs.getString("role")));
        u.setStatus(rs.getString("status"));
        u.setDailyWage(rs.getBigDecimal("daily_wage"));
        try { u.setCreatedAt(rs.getTimestamp("created_at")); }
        catch (Exception ignored)
        {}
        try { u.setUpdatedAt(rs.getTimestamp("updated_at"));
        } catch
        (Exception ignored) {}
        return u;
    }
}