package com.buildtrack.dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.buildtrack.model.Inquiry;
import com.buildtrack.util.DBUtil;

public class InquiryDao {

    public List<Inquiry> getAllInquiries() {
        List<Inquiry> inquiries = new ArrayList<>();
        String sql = "SELECT i.*, u.full_name as client_name, p.title as project_title " +
                     "FROM inquiries i " +
                     "JOIN users u ON i.client_id = u.id " +
                     "JOIN projects p ON i.project_id = p.id " +
                     "ORDER BY i.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                inquiries.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inquiries;
    }

    public boolean updateInquiryReplyAndStatus(int inquiryId, String reply, String status) {
        String sql = "UPDATE inquiries SET status = ? WHERE id = ?"; // simplified for status update demo
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, inquiryId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Inquiry mapRow(ResultSet rs) throws SQLException {
        Inquiry i = new Inquiry();
        i.setId(rs.getInt("id"));
        i.setClientId(rs.getInt("client_id"));
        i.setProjectId(rs.getInt("project_id"));
        i.setSubject(rs.getString("subject"));
        i.setMessage(rs.getString("message"));
        i.setAdminReply(rs.getString("admin_reply"));
        i.setStatus(rs.getString("status"));
        i.setCreatedAt(rs.getTimestamp("created_at"));
        i.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        i.setClientName(rs.getString("client_name"));
        i.setProjectTitle(rs.getString("project_title"));
        return i;
    }
}