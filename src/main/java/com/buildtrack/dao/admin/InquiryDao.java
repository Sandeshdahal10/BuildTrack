package com.buildtrack.dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.buildtrack.model.Inquiry;
import com.buildtrack.util.DBUtil;

/**
 * DAO for retrieving and updating client inquiries.
 */
public class InquiryDao {

    /**
     * Returns all inquiries with client and project display fields.
     *
     * @return a list of all inquiries
     */
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

    /**
     * Updates the reply and status for an inquiry.
     *
     * @param inquiryId inquiry id
     * @param reply     admin reply text
     * @param status    new status value
     * @return true if update succeeded
     */
    public boolean updateInquiryReplyAndStatus(int inquiryId, String reply, String status) {
        String sql = "UPDATE inquiries SET status = ?, admin_reply = ? WHERE id = ?"; // changed to also update admin_reply
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, reply);
            ps.setInt(3, inquiryId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Inserts a new inquiry.
     *
     * @param inquiry the Inquiry to insert
     * @return true if inserted successfully
     */
    public boolean insertInquiry(Inquiry inquiry) {
        String sql = "INSERT INTO inquiries (client_id, project_id, subject, message, status) VALUES (?, ?, ?, ?, 'PENDING')";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, inquiry.getClientId());
            ps.setInt(2, inquiry.getProjectId());
            ps.setString(3, inquiry.getSubject());
            ps.setString(4, inquiry.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Returns inquiries for a specific client.
     *
     * @param clientId the client's ID
     * @return a list of inquiries
     */
    public List<Inquiry> getInquiriesByClientId(int clientId) {
        List<Inquiry> inquiries = new ArrayList<>();
        String sql = "SELECT i.*, u.full_name as client_name, p.title as project_title " +
                "FROM inquiries i " +
                "JOIN users u ON i.client_id = u.id " +
                "JOIN projects p ON i.project_id = p.id " +
                "WHERE i.client_id = ? " +
                "ORDER BY i.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, clientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    inquiries.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inquiries;
    }

    /**
     * Maps a result set row to an Inquiry.
     *
     * @param rs result set positioned on a row
     * @return mapped inquiry
     * @throws SQLException if column access fails
     */
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