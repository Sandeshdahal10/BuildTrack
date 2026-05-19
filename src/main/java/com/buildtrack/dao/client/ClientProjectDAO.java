package com.buildtrack.dao.client;

import com.buildtrack.model.Project;
import com.buildtrack.model.ProjectDocument;
import com.buildtrack.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * DAO for client-owned project creation and document uploads.
 * Uses the database to persist new projects, store uploaded files,
 * and verify project ownership before client actions.
 */
public class ClientProjectDAO {

    /**
     * Creates a new project in the database.
     * Returns the generated project id, or -1 if insertion fails.
     *
     * @param project project object with all required fields
     * @return generated project id or -1 on failure
     */
    public int createProject(Project project) {
        String sql = "INSERT INTO projects (title, description, client_id, start_date, end_date, " +
                "total_budget, status, created_at, updated_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, project.getTitle());
            ps.setString(2, project.getDescription());
            ps.setInt(3, project.getClientId());
            ps.setDate(4, project.getStartDate());
            ps.setDate(5, project.getEndDate());
            ps.setBigDecimal(6, project.getTotalBudget());
            ps.setString(7, project.getStatus());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[ClientProjectDAO] createProject error: " + e.getMessage());
        }
        return -1;
    }

    /**
     * Saves a project document record to the database.
     * Returns the generated document id, or -1 if insertion fails.
     *
     * @param document project document object with all required fields
     * @return generated document id or -1 on failure
     */
    public int saveProjectDocument(ProjectDocument document) {
        String sql = "INSERT INTO project_documents (project_id, client_id, file_name, " +
                "file_path, file_type, file_size, uploaded_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, NOW())";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, document.getProjectId());
            ps.setInt(2, document.getClientId());
            ps.setString(3, document.getFileName());
            ps.setString(4, document.getFilePath());
            ps.setString(5, document.getFileType());
            ps.setLong(6, document.getFileSize());

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[ClientProjectDAO] saveProjectDocument error: " + e.getMessage());
        }
        return -1;
    }

    /**
     * Checks if a project exists and belongs to the given client.
     *
     * @param projectId project identifier
     * @param clientId  client identifier
      * @return true if the project exists and belongs to the client, false otherwise
     */
    public boolean projectBelongsToClient(int projectId, int clientId) {
        String sql = "SELECT 1 FROM projects WHERE id = ? AND client_id = ? LIMIT 1";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, projectId);
            ps.setInt(2, clientId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.err.println("[ClientProjectDAO] projectBelongsToClient error: " + e.getMessage());
        }
        return false;
    }
}
