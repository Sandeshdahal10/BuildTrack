package com.buildtrack.dao;

import com.buildtrack.model.Notification;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for application notifications stored in the notifications table.
 * It creates the table if needed and handles insert, fetch, unread count,
 * and mark-read database operations.
 */
public class NotificationDao {

    /**
     * Creates the notifications table if it does not already exist.
     */
    public NotificationDao() {
        createTableIfNotExists();
    }

    /**
     * Creates the notifications table if it does not already exist.
     */
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

    /**
     * Adds a notification for a user.
     *
     * @param userId the target user id
     * @param message the notification message
     * @return true if the insert succeeds, false otherwise
     */
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

    /**
     * Returns the most recent notifications for a user.
     *
     * @param userId the target user id
     * @return the notifications ordered from newest to oldest
     */
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

    /**
     * Returns the number of unread notifications for a user.
     *
     * @param userId the target user id
     * @return the unread notification count
     */
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

    /**
     * Marks all notifications for a user as read.
     *
     * @param userId the target user id
     * @return true if at least one row was updated, false otherwise
     */
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
