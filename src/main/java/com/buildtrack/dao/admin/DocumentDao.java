package com.buildtrack.dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.buildtrack.model.Document;
import com.buildtrack.util.DBUtil;

public class DocumentDao {

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