package com.buildtrack.dao.worker;

import com.buildtrack.model.Project;
import com.buildtrack.model.WorkLog;
import com.buildtrack.util.DBUtil;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for worker work log persistence operations.
 */
public class WorkLogDao {

	/**
	 * Inserts a work log record.
	 *
	 * @param workLog the work log object to insert
	 * @return true if successful, false otherwise
	 */
	public boolean insert(WorkLog workLog) {
		String sql = "INSERT INTO work_logs (worker_id, project_id, log_date, description, created_at) "
				+ "VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, workLog.getWorkerId());
			ps.setInt(2, workLog.getProjectId());
			ps.setDate(3, workLog.getLogDate());
			ps.setString(4, workLog.getDescription());
			ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			System.err.println("[WorkLogDAO] insert error: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Gets work logs for one worker in a month.
	 *
	 * @param workerId the worker id
	 * @param monthYear the month in YYYY-MM format
	 * @return the matching work log records
	 */
	public List<WorkLog> findByWorker(int workerId, String monthYear) {
		List<WorkLog> list = new ArrayList<>();
		String sql = "SELECT wl.*, p.title AS project_name, u.full_name AS worker_name "
				+ "FROM work_logs wl "
				+ "JOIN projects p ON wl.project_id = p.id "
				+ "JOIN users u ON wl.worker_id = u.id "
				+ "WHERE wl.worker_id = ? AND DATE_FORMAT(wl.log_date, '%Y-%m') = ? "
				+ "ORDER BY wl.log_date DESC, wl.id DESC";

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, workerId);
			ps.setString(2, monthYear);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					list.add(mapRow(rs));
				}
			}
		} catch (SQLException e) {
			System.err.println("[WorkLogDAO] findByWorker error: " + e.getMessage());
		}
		return list;
	}

	/**
	 * Gets the active projects assigned to a worker.
	 *
	 * @param workerId the worker id
	 * @return the assigned projects
	 */
	public List<Project> findAssignedProjects(int workerId) {
		List<Project> projects = new ArrayList<>();
		String sql = "SELECT DISTINCT p.* "
				+ "FROM project_workers pw "
				+ "JOIN projects p ON pw.project_id = p.id "
				+ "WHERE pw.worker_id = ? AND pw.is_active = 1 "
				+ "ORDER BY p.created_at DESC";

		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, workerId);
			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Project project = new Project();
					project.setId(rs.getInt("id"));
					project.setTitle(rs.getString("title"));
					project.setStatus(rs.getString("status"));
					project.setStartDate(rs.getDate("start_date"));
					project.setEndDate(rs.getDate("end_date"));
					projects.add(project);
				}
			}
		} catch (SQLException e) {
			System.err.println("[WorkLogDAO] findAssignedProjects error: " + e.getMessage());
		}
		return projects;
	}

	/**
	 * Maps a result set row to a work log.
	 *
	 * @param rs result set positioned on a row
	 * @return mapped work log record
	 * @throws SQLException if column access fails
	 */
	private WorkLog mapRow(ResultSet rs) throws SQLException {
		WorkLog workLog = new WorkLog();
		workLog.setId(rs.getInt("id"));
		workLog.setWorkerId(rs.getInt("worker_id"));
		workLog.setProjectId(rs.getInt("project_id"));
		workLog.setLogDate(rs.getDate("log_date"));
		workLog.setDescription(rs.getString("description"));
		workLog.setCreatedAt(rs.getTimestamp("created_at"));
		workLog.setWorkerName(rs.getString("worker_name"));
		workLog.setProjectName(rs.getString("project_name"));
		return workLog;
	}
}
