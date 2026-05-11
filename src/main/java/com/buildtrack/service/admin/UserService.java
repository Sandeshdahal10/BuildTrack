package com.buildtrack.service.admin;

import com.buildtrack.dao.admin.UserDao;
import com.buildtrack.model.User;
import com.buildtrack.util.ValidationUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Service layer for admin user management.
 */
public class UserService {

    private final UserDao userDAO = new UserDao();

    // List

    /**
     * Returns all workers.
     */
    public List<User> getWorkers() {
        return userDAO.findByRole("WORKER");
    }

    /**
     * Returns all clients.
     */
    public List<User> getClients() {
        return userDAO.findByRole("CLIENT");
    }

    /**
     * Returns users pending approval.
     */
    public List<User> getPendingUsers() {
        return userDAO.findByStatus("PENDING");
    }

    /**
     * Returns all non-admin users.
     */
    public List<User> getAllNonAdmin() {
        return userDAO.findAllNonAdmin();
    }

    /**
     * Returns workers filtered by status.
     */
    public List<User> getWorkersByStatus(String status) {
        return userDAO.findByRoleAndStatus("WORKER", status);
    }

    /**
     * Searches approved workers by name or email.
     */
    public List<User> searchWorkers(String query) {
        if (ValidationUtil.isEmpty(query))
            return new ArrayList<>();
        return userDAO.searchWorkers(query);
    }

    /**
     * Returns a user by id.
     */
    public User getUserById(int id) {
        return userDAO.findById(id);
    }

    // Status Management

    /**
     * Approves a user.
     */
    public boolean approveUser(int id) {
        return userDAO.updateStatus(id, "APPROVED");
    }

    /**
     * Deactivates a user.
     */
    public boolean deactivateUser(int id) {
        return userDAO.updateStatus(id, "DEACTIVATED");
    }

    /**
     * Activates a user.
     */
    public boolean activateUser(int id) {
        return userDAO.updateStatus(id, "APPROVED");
    }

    /**
     * Updates a user status.
     */
    public boolean updateStatus(int id, String status) {
        return userDAO.updateStatus(id, status);
    }

    // Wage Management

    /**
     * Sets daily wage for a user with validation.
     */
    public List<String> setDailyWage(int userId, String wageStr) {
        List<String> errors = new ArrayList<>();
        if (ValidationUtil.isEmpty(wageStr)) {
            errors.add("Daily wage is required.");
            return errors;
        }
        BigDecimal wage;
        try {
            wage = new BigDecimal(wageStr);
        } catch (NumberFormatException e) {
            errors.add("Invalid wage amount.");
            return errors;
        }
        if (wage.compareTo(BigDecimal.ZERO) < 0)
            errors.add("Wage cannot be negative.");
        if (!errors.isEmpty())
            return errors;
        if (!userDAO.updateDailyWage(userId, wage))
            errors.add("Failed to update wage.");
        return errors;
    }

    // Profile Update

    /**
     * Updates a user's profile.
     */
    public List<String> updateProfile(int id, String fullName, String phone) {
        List<String> errors = new ArrayList<>();
        if (ValidationUtil.isEmpty(fullName))
            errors.add("Full name is required.");
        if (ValidationUtil.isEmpty(phone))
            errors.add("Phone is required.");
        if (!errors.isEmpty())
            return errors;
        if (!userDAO.updateProfile(id, fullName.trim(), phone.trim()))
            errors.add("Failed to update profile.");
        return errors;
    }

    // Stats

    /**
     * Returns dashboard user statistics.
     */
    public Map<String, Integer> getUserStats() {
        Map<String, Integer> stats = new java.util.LinkedHashMap<>();
        stats.put("totalWorkers", userDAO.countByRoleAndStatus("WORKER", "APPROVED"));
        stats.put("totalClients", userDAO.countByRoleAndStatus("CLIENT", "APPROVED"));
        stats.put("pendingApprovals", userDAO.countByStatus("PENDING"));
        return stats;
    }
}