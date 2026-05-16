package com.buildtrack.dao.client;

import com.buildtrack.model.Project;
import com.buildtrack.model.User;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for client related database operations.
 * Provides methods to fetch client profile and projects belonging to a client.
 */
public class ClientDao {

	/**
	 * Find client (user) by id. Returns null if not found.
	 */
	public User findById(int id) {
		String sql = "SELECT id,full_name,email,phone,password,role,status,daily_wage,reset_token,reset_token_expiry,created_at,updated_at "
				+
				"FROM users WHERE id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return mapRowToUser(rs);
		} catch (SQLException e) {
			System.err.println("[ClientDAO] findById error: " + e.getMessage());
		}
		return null;
	}

	/**
	 * Update client's profile (full name and phone).
	 */
	public boolean updateProfile(int id, String fullName, String phone) {
		String sql = "UPDATE users SET full_name = ?, phone = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, fullName);
			ps.setString(2, phone);
			ps.setInt(3, id);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("[ClientDAO] updateProfile error: " + e.getMessage());
		}
		return false;
	}

	/**
	 * Returns list of projects that belong to the given client id.
	 */
	public List<Project> findProjectsByClientId(int clientId) {
		List<Project> list = new ArrayList<>();
		String sql = "SELECT p.*, u.full_name AS client_name " +
				"FROM projects p LEFT JOIN users u ON p.client_id = u.id " +
				"WHERE p.client_id = ? ORDER BY p.created_at DESC";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, clientId);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
				list.add(mapRowToProject(rs, true));
		} catch (SQLException e) {
			System.err.println("[ClientDAO] findProjectsByClientId error: " + e.getMessage());
		}
		return list;
	}

	/**
	 * Count projects for a client.
	 */
	public int countProjects(int clientId) {
		String sql = "SELECT COUNT(*) FROM projects WHERE client_id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, clientId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getInt(1);
		} catch (SQLException e) {
			System.err.println("[ClientDAO] countProjects error: " + e.getMessage());
		}
		return 0;
	}

	/**
	 * Returns total budget sum of all projects for a client.
	 */
	public java.math.BigDecimal totalBudgetForClient(int clientId) {
		String sql = "SELECT COALESCE(SUM(total_budget),0) FROM projects WHERE client_id = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, clientId);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				return rs.getBigDecimal(1);
		} catch (SQLException e) {
			System.err.println("[ClientDAO] totalBudgetForClient error: " + e.getMessage());
		}
		return java.math.BigDecimal.ZERO;
	}

	// ----------------- Helpers -----------------
	/**
	 * Maps a result set row to a User.
	 *
	 * @param rs result set positioned on a row
	 * @return mapped user
	 * @throws SQLException if column access fails
	 */
	private User mapRowToUser(ResultSet rs) throws SQLException {
		User u = new User();
		u.setId(rs.getInt("id"));
		u.setFullName(rs.getString("full_name"));
		u.setEmail(rs.getString("email"));
		u.setPhone(rs.getString("phone"));
		u.setPassword(rs.getString("password"));
		try {
			u.setRole(com.buildtrack.model.Role.fromString(rs.getString("role")));
		} catch (Exception ignored) {
		}
		u.setStatus(rs.getString("status"));
		u.setDailyWage(rs.getBigDecimal("daily_wage"));
		try {
			u.setResetToken(rs.getString("reset_token"));
		} catch (Exception ignored) {
		}
		try {
			u.setResetTokenExpiry(rs.getTimestamp("reset_token_expiry"));
		} catch (Exception ignored) {
		}
		try {
			u.setCreatedAt(rs.getTimestamp("created_at"));
		} catch (Exception ignored) {
		}
		try {
			u.setUpdatedAt(rs.getTimestamp("updated_at"));
		} catch (Exception ignored) {
		}
		return u;
	}

	/**
	 * Maps a result set row to a Project.
	 *
	 * @param rs         result set positioned on a row
	 * @param withClient whether to populate client name
	 * @return mapped project
	 * @throws SQLException if column access fails
	 */
	private Project mapRowToProject(ResultSet rs, boolean withClient) throws SQLException {
		Project p = new Project();
		p.setId(rs.getInt("id"));
		p.setTitle(rs.getString("title"));
		p.setDescription(rs.getString("description"));
		int cid = rs.getInt("client_id");
		p.setClientId(rs.wasNull() ? null : cid);
		p.setStartDate(rs.getDate("start_date"));
		p.setEndDate(rs.getDate("end_date"));
		p.setTotalBudget(rs.getBigDecimal("total_budget"));
		p.setStatus(rs.getString("status"));
		p.setCreatedAt(rs.getTimestamp("created_at"));
		p.setUpdatedAt(rs.getTimestamp("updated_at"));
		if (withClient)
			p.setClientName(rs.getString("client_name"));
		return p;
	}
}
