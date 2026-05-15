package com.buildtrack.dao.client;

import com.buildtrack.model.MaterialUsage;
import com.buildtrack.model.Project;
import com.buildtrack.util.DBUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * DAO containing read-only queries used by client-side project tracking views.
 */
public class ProjectTrackingDao {

	/**
	 * Returns project overview for a given project if it belongs to the client.
	 * Populates assignedWorkerCount and actualCost on the Project object.
	 */
	public Project findProjectForClient(int projectId, int clientId) {
		String sql = "SELECT p.*, u.full_name AS client_name, " +
				"COALESCE((SELECT SUM(mu.total_cost) FROM material_usage mu WHERE mu.project_id = p.id),0) " +
				"+ COALESCE((SELECT SUM(e.amount) FROM expenses e WHERE e.project_id = p.id),0) AS actual_cost, " +
				"COALESCE((SELECT COUNT(*) FROM project_workers pw WHERE pw.project_id = p.id AND pw.is_active = 1),0) AS assigned_count " +
				"FROM projects p LEFT JOIN users u ON p.client_id = u.id " +
				"WHERE p.id = ? AND p.client_id = ?";

		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, projectId);
			ps.setInt(2, clientId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
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
				p.setClientName(rs.getString("client_name"));
				p.setAssignedWorkerCount(rs.getInt("assigned_count"));
				BigDecimal actual = rs.getBigDecimal("actual_cost");
				p.setActualCost(actual == null ? BigDecimal.ZERO : actual);
				return p;
			}
		} catch (SQLException e) {
			System.err.println("[ProjectTrackingDao] findProjectForClient error: " + e.getMessage());
		}
		return null;
	}

	/**
	 * Returns list of material usages for a project, newest first.
	 */
	public List<MaterialUsage> findMaterialUsageForProject(int projectId) {
		List<MaterialUsage> list = new ArrayList<>();
		String sql = "SELECT mu.*, m.name AS material_name, m.unit AS material_unit, " +
				"p.title AS project_name, u.full_name AS recorded_by_name " +
				"FROM material_usage mu " +
				"JOIN materials m ON mu.material_id = m.id " +
				"LEFT JOIN projects p ON mu.project_id = p.id " +
				"LEFT JOIN users u ON mu.recorded_by = u.id " +
				"WHERE mu.project_id = ? ORDER BY mu.usage_date DESC";

		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, projectId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				MaterialUsage mu = new MaterialUsage();
				mu.setId(rs.getInt("id"));
				mu.setMaterialId(rs.getInt("material_id"));
				mu.setProjectId(rs.getInt("project_id"));
				mu.setQuantityUsed(rs.getBigDecimal("quantity_used"));
				mu.setUnitCost(rs.getBigDecimal("unit_cost"));
				mu.setTotalCost(rs.getBigDecimal("total_cost"));
				mu.setUsageDate(rs.getDate("usage_date"));
				mu.setRecordedBy(rs.getInt("recorded_by"));
				mu.setNotes(rs.getString("notes"));
				mu.setCreatedAt(rs.getTimestamp("created_at"));
				mu.setMaterialName(rs.getString("material_name"));
				mu.setMaterialUnit(rs.getString("material_unit"));
				mu.setProjectName(rs.getString("project_name"));
				mu.setRecordedByName(rs.getString("recorded_by_name"));
				list.add(mu);
			}
		} catch (SQLException e) {
			System.err.println("[ProjectTrackingDao] findMaterialUsageForProject error: " + e.getMessage());
		}
		return list;
	}

	/**
	 * Returns a simple expense list (manual expenses) for a project.
	 * Each map contains id, category, amount, notes, recordedBy, createdAt.
	 */
	public List<Map<String, Object>> findExpensesForProject(int projectId) {
		List<Map<String, Object>> list = new ArrayList<>();
		String sql = "SELECT e.id, e.category, e.amount, e.notes, e.recorded_by, e.created_at, " +
				"u.full_name AS recorded_by_name " +
				"FROM expenses e LEFT JOIN users u ON e.recorded_by = u.id " +
				"WHERE e.project_id = ? ORDER BY e.created_at DESC";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, projectId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Map<String, Object> row = new HashMap<>();
				row.put("id", rs.getInt("id"));
				row.put("category", rs.getString("category"));
				row.put("amount", rs.getBigDecimal("amount"));
				row.put("notes", rs.getString("notes"));
				row.put("recordedBy", rs.getInt("recorded_by"));
				row.put("recordedByName", rs.getString("recorded_by_name"));
				row.put("createdAt", rs.getTimestamp("created_at"));
				list.add(row);
			}
		} catch (SQLException e) {
			System.err.println("[ProjectTrackingDao] findExpensesForProject error: " + e.getMessage());
		}
		return list;
	}

	/**
	 * Returns approximate time progress percentage (0-100) based on start/end dates.
	 * If dates are missing, returns 0.
	 */
	public int getTimeProgressPercent(int projectId) {
		String sql = "SELECT start_date, end_date FROM projects WHERE id = ?";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, projectId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				java.sql.Date start = rs.getDate("start_date");
				java.sql.Date end = rs.getDate("end_date");
				if (start == null || end == null) return 0;
				long total = end.getTime() - start.getTime();
				long elapsed = System.currentTimeMillis() - start.getTime();
				if (total <= 0) return 0;
				double pct = (double) elapsed / (double) total * 100.0;
				if (pct < 0) pct = 0; if (pct > 100) pct = 100;
				return (int) Math.round(pct);
			}
		} catch (SQLException e) {
			System.err.println("[ProjectTrackingDao] getTimeProgressPercent error: " + e.getMessage());
		}
		return 0;
	}
}
