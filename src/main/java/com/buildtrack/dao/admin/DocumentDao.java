package com.buildtrack.dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.buildtrack.model.Document;
import com.buildtrack.util.DBUtil;

/**
 * DAO for retrieving document metadata for admin reporting.
 */
public class DocumentDao {

    /**
     * Returns all documents with client and project display fields.
     * 
     * @return a list of all documents
     */
    public List<Document> getAllDocuments() {
        List<Document> documents = new ArrayList<>();
        String sql = "SELECT d.*, u.full_name as client_name, p.title as project_title " +
                "FROM documents d " +
                "JOIN users u ON d.client_id = u.id " +
                "JOIN projects p ON d.project_id = p.id " +
                "ORDER BY d.uploaded_at DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                documents.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documents;
    }

    /**
     * Inserts a new document record.
     *
     * @param doc the Document to insert
     * @return true if inserted successfully
     */
    public boolean insertDocument(Document doc) {
        String sql = "INSERT INTO documents (project_id, client_id, file_name, file_path) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, doc.getProjectId());
            ps.setInt(2, doc.getClientId());
            ps.setString(3, doc.getFileName());
            ps.setString(4, doc.getFilePath());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Returns documents for a specific client.
     *
     * @param clientId the ID of the client
     * @return list of documents
     */
    public List<Document> getDocumentsByClientId(int clientId) {
        List<Document> documents = new ArrayList<>();
        String sql = "SELECT d.*, u.full_name as client_name, p.title as project_title " +
                "FROM documents d " +
                "JOIN users u ON d.client_id = u.id " +
                "JOIN projects p ON d.project_id = p.id " +
                "WHERE d.client_id = ? " +
                "ORDER BY d.uploaded_at DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, clientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    documents.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return documents;
    }

    /**
     * Maps a result set row to a Document.
     *
     * @param rs result set positioned on a row
     * @return mapped document
     * @throws SQLException if column access fails
     */
    private Document mapRow(ResultSet rs) throws SQLException {
        Document d = new Document();
        d.setId(rs.getInt("id"));
        d.setProjectId(rs.getInt("project_id"));
        d.setClientId(rs.getInt("client_id"));
        d.setFileName(rs.getString("file_name"));
        d.setFilePath(rs.getString("file_path"));
        d.setUploadedAt(rs.getTimestamp("uploaded_at"));

        d.setClientName(rs.getString("client_name"));
        d.setProjectTitle(rs.getString("project_title"));
        return d;
    }
}