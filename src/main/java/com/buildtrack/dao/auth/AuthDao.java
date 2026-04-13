package com.buildtrack.dao.auth;

import com.buildtrack.model.Role;
import com.buildtrack.model.User;
import com.buildtrack.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;

/**
 * Data Access Object for all authentication-related database operations.
 * Handles user CRUD, password reset token management, and email lookups.
 */
public class AuthDao {

    // ---------- INSERT ----------

    /**
     * Inserts a new user into the database.
     * Password must already be hashed before calling this method.
     *
     * @param user the User object to insert
     * @return true if insertion was successful, false otherwise
     */
    public boolean insertUser(User user) {
        String sql = "INSERT INTO users (full_name, email, phone, password, role, status, daily_wage) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getRole().name());
            pstmt.setString(6, user.getStatus());

            if (user.getDailyWage() != null) {
                pstmt.setBigDecimal(7, user.getDailyWage());
            } else {
                pstmt.setNull(7, Types.DECIMAL);
            }

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            // Check for duplicate email (error code 1062 in MySQL)
            if (e.getErrorCode() == 1062) {
                System.err.println("[AuthDAO] Duplicate email: " + user.getEmail());
            } else {
                System.err.println("[AuthDAO] Insert error: " + e.getMessage());
            }
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    // ---------- FIND ----------

    /**
     * Finds a user by their email address.
     *
     * @param email the email to search for
     * @return the User object if found, null otherwise
     */
    public User findByEmail(String email) {
        String sql = "SELECT id, full_name, email, phone, password, role, status, "
                + "daily_wage, reset_token, reset_token_expiry, created_at, updated_at "
                + "FROM users WHERE email = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapRowToUser(rs);
            }
            return null;

        } catch (SQLException e) {
            System.err.println("[AuthDAO] findByEmail error: " + e.getMessage());
            return null;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /**
     * Finds a user by their ID.
     *
     * @param id the user ID to search for
     * @return the User object if found, null otherwise
     */
    public User findById(int id) {
        String sql = "SELECT id, full_name, email, phone, password, role, status, "
                + "daily_wage, reset_token, reset_token_expiry, created_at, updated_at "
                + "FROM users WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapRowToUser(rs);
            }
            return null;

        } catch (SQLException e) {
            System.err.println("[AuthDAO] findById error: " + e.getMessage());
            return null;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /**
     * Finds a user by their password reset token.
     *
     * @param token the reset token to search for
     * @return the User object if found, null otherwise
     */
    public User findByResetToken(String token) {
        String sql = "SELECT id, full_name, email, phone, password, role, status, "
                + "daily_wage, reset_token, reset_token_expiry, created_at, updated_at "
                + "FROM users WHERE reset_token = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, token);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapRowToUser(rs);
            }
            return null;

        } catch (SQLException e) {
            System.err.println("[AuthDAO] findByResetToken error: " + e.getMessage());
            return null;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    // ---------- EXISTS ----------

    /**
     * Checks if a user with the given email already exists.
     *
     * @param email the email to check
     * @return true if the email exists, false otherwise
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;

        } catch (SQLException e) {
            System.err.println("[AuthDAO] emailExists error: " + e.getMessage());
            return false;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    // ---------- UPDATE ----------

    /**
     * Updates the hashed password for a given user ID.
     *
     * @param userId       the user ID
     * @param hashedPassword the new BCrypt-hashed password
     * @return true if update was successful, false otherwise
     */
    public boolean updatePassword(int userId, String hashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hashedPassword);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[AuthDAO] updatePassword error: " + e.getMessage());
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * Saves or updates the password reset token for a user.
     *
     * @param email  the user's email
     * @param token  the new reset token
     * @param expiry the token expiry timestamp
     * @return true if update was successful, false otherwise
     */
    public boolean saveResetToken(String email, String token, Timestamp expiry) {
        String sql = "UPDATE users SET reset_token = ?, reset_token_expiry = ? WHERE email = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, token);
            pstmt.setTimestamp(2, expiry);
            pstmt.setString(3, email);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[AuthDAO] saveResetToken error: " + e.getMessage());
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * Clears the password reset token for a given user ID.
     * Called after a successful password reset.
     *
     * @param userId the user ID
     * @return true if cleared successfully, false otherwise
     */
    public boolean clearResetToken(int userId) {
        String sql = "UPDATE users SET reset_token = NULL, reset_token_expiry = NULL WHERE id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[AuthDAO] clearResetToken error: " + e.getMessage());
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    // ---------- HELPER ----------

    /**
     * Maps a ResultSet row to a User object.
     * Centralizes the mapping logic to avoid duplication.
     */
    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPassword(rs.getString("password"));
        user.setRole(Role.fromString(rs.getString("role")));
        user.setStatus(rs.getString("status"));
        user.setDailyWage(rs.getBigDecimal("daily_wage"));
        user.setResetToken(rs.getString("reset_token"));
        user.setResetTokenExpiry(rs.getTimestamp("reset_token_expiry"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }
}