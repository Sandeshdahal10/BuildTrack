package com.buildtrack.util;

import org.mindrot.jbcrypt.BCrypt;
/**
 * Utility class for password hashing and verification using BCrypt.
 * BCrypt automatically handles salting — no manual salt management needed.
 */
public class PasswordUtil {
    /**
     * Hashes a plain-text password using BCrypt.
     *
     * @param plainPassword the raw password from the user
     * @return the BCrypt hashed password (60 characters)
     */
    public static String hashedPassword(String plainPassword){
        if (plainPassword==null || plainPassword.isEmpty()){
            throw new IllegalArgumentException("Password cannot be empty or null.");
        }
        return BCrypt.hashpw(plainPassword,BCrypt.gensalt(10));
    }    /**
     * Verifies a plain-text password against a BCrypt hash.
     *
     * @param plainPassword  the raw password from the user
     * @param hashedPassword the stored BCrypt hash from the database
     * @return true if the password matches, false otherwise
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            System.err.println("[PasswordUtil] Verification error: " + e.getMessage());
            return false;
        }
    }
    /**
     * Generates a cryptographically secure random token
     * for password reset (UUID v4 format, 36 characters).
     *
     * @return a random token string
     */
    public static String generateResetToken() {
        return java.util.UUID.randomUUID().toString();
    }
}
