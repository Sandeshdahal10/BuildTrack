package com.buildtrack.dao;

import com.buildtrack.model.Notification;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDao {

    public NotificationDao() {
        createTableIfNotExists();
    }

    private void createTableIfNotExists() {
        String sql = "CREATE TABLE IF NOT EXISTS `notifications` (" +
                "  `id` INT AUTO_INCREMENT PRIMARY KEY," +
                "  `user_id` INT NOT NULL," +
                "  `message` VARCHAR(255) NOT NULL," +
                "  `is_read` TINYINT(1) DEFAULT 0," +
                "  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                "  FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("[NotificationDao] Error creating notifications table: " + e.getMessage());
        }
    }

    public boolean addNotification(int userId, String message) {
        String sql = "INSERT INTO `notifications` (`user_id`, `message`) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, message);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[NotificationDao] Error adding notification: " + e.getMessage());
            return false;
        }
    }

    public List<Notification> getNotificationsByUserId(int userId) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM `notifications` WHERE `user_id` = ? ORDER BY `created_at` DESC LIMIT 20";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Notification(
                            rs.getInt("id"),
                            rs.getInt("user_id"),
                            rs.getString("message"),
                            rs.getBoolean("is_read"),
                            rs.getTimestamp("created_at")
                    ));
                }
            }
        } catch (SQLException e) {
            System.err.println("[NotificationDao] Error fetching notifications: " + e.getMessage());
        }
        return list;
    }

    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM `notifications` WHERE `user_id` = ? AND `is_read` = 0";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("[NotificationDao] Error fetching unread count: " + e.getMessage());
        }
        return 0;
    }

    public boolean markAllAsRead(int userId) {
        String sql = "UPDATE `notifications` SET `is_read` = 1 WHERE `user_id` = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[NotificationDao] Error marking notifications as read: " + e.getMessage());
            return false;
        }
    }
}
