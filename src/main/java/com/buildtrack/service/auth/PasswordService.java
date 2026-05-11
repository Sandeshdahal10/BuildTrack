package com.buildtrack.service.auth;

import com.buildtrack.dao.auth.AuthDao;
import com.buildtrack.model.User;
import com.buildtrack.util.EmailUtil;
import com.buildtrack.util.PasswordUtil;
import com.buildtrack.util.ValidationUtil;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Service layer for password reset operations.
 * Handles forgot-password and reset-password business logic.
 */
public class PasswordService {

    private final AuthDao authDAO;

    /** Token expiry time in milliseconds (30 minutes). */
    private static final long TOKEN_EXPIRY_MS = 30 * 60 * 1000;

    /**
     * Creates a PasswordService with a default AuthDao.
     */
    public PasswordService() {
        this.authDAO = new AuthDao();
    }

    /**
     * Initiates the password reset process for a given email.
     * Generates a token, saves it to the database, and sends an email.
     *
     * IMPORTANT: For security, this method always returns true
     * to avoid revealing whether an email exists in the system.
     *
     * @param email   the user's email address
     * @param baseUrl the base URL of the application (e.g.,
     *                http://localhost:8080/BuildTrack)
     * @return always true (even if email doesn't exist), for security
     */
    public boolean initiatePasswordReset(String email, String baseUrl) {
        // Validate email format
        List<String> errors = ValidationUtil.validateForgotPassword(email);
        if (!errors.isEmpty()) {
            return true; // Don't reveal validation errors to prevent email enumeration
        }

        // Find user by email
        User user = authDAO.findByEmail(email.trim().toLowerCase());

        // If user doesn't exist, still return true (security measure)
        if (user == null) {
            return true;
        }

        // Generate reset token
        String token = PasswordUtil.generateResetToken();
        Timestamp expiry = new Timestamp(System.currentTimeMillis() + TOKEN_EXPIRY_MS);

        // Save token to database
        boolean saved = authDAO.saveResetToken(user.getEmail(), token, expiry);
        if (!saved) {
            System.err.println("[PasswordService] Failed to save reset token for: " + email);
            return true; // Still return true for security
        }

        // Build the reset link
        String resetLink = baseUrl + "/reset-password?token=" + token;

        // Send email (non-blocking — failures are logged, not exposed to user)
        EmailUtil.sendPasswordResetEmail(user.getEmail(), resetLink);

        return true;
    }

    /**
     * Validates a reset token and returns the associated user if valid.
     *
     * @param token the reset token from the URL
     * @return the User if token is valid, null if invalid/expired
     */
    public User validateResetToken(String token) {
        if (token == null || token.trim().isEmpty()) {
            return null;
        }

        User user = authDAO.findByResetToken(token.trim());
        if (user == null) {
            return null;
        }

        // Check if token is not expired
        if (!user.isResetTokenValid()) {
            return null;
        }

        return user;
    }

    /**
     * Resets the user's password after validating the token and new password.
     *
     * @param token           the reset token
     * @param newPassword     the new plain-text password
     * @param confirmPassword the password confirmation
     * @return a list of error messages; empty if reset succeeds
     */
    public List<String> resetPassword(String token, String newPassword,
            String confirmPassword) {

        List<String> errors = new ArrayList<>();

        // Step 1: Validate new password fields
        List<String> validationErrors = ValidationUtil.validateResetPassword(
                newPassword, confirmPassword);
        errors.addAll(validationErrors);

        if (!errors.isEmpty()) {
            return errors;
        }

        // Step 2: Validate the reset token
        User user = validateResetToken(token);
        if (user == null) {
            errors.add("Invalid or expired reset token. "
                    + "Please request a new password reset link.");
            return errors;
        }

        // Step 3: Hash the new password
        String hashedPassword = PasswordUtil.hashedPassword(newPassword);

        // Step 4: Update password in database
        boolean updated = authDAO.updatePassword(user.getId(), hashedPassword);
        if (!updated) {
            errors.add("Failed to update password. Please try again.");
            return errors;
        }

        // Step 5: Clear the reset token
        authDAO.clearResetToken(user.getId());

        return errors; // Empty list means success
    }
}