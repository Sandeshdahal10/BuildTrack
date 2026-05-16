package com.buildtrack.util;

import com.buildtrack.model.Role;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 * Utility class for input validation across the application.
 * Returns lists of error messages for clean error display.
 */
public class ValidationUtil {

    // Pre-compiled regex patterns for performance
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9+\\-\\s()]{7,20}$");
    private static final Pattern NAME_PATTERN =
            Pattern.compile("^[A-Za-z\\s.'-]{2,100}$");

    /**
     * Validates all registration fields and returns a list of error messages.
     * Returns an empty list if all fields are valid.
     */
    public static List<String> validateRegistration(
            String fullName, String email, String phone,
            String password, String confirmPassword, String role) {

        List<String> errors = new ArrayList<>();

        // Full Name validation
        if (isEmpty(fullName)) {
            errors.add("Full name is required.");
        } else if (!NAME_PATTERN.matcher(fullName).matches()) {
            errors.add("Full name must contain only letters, spaces, hyphens, or dots (2-100 characters).");
        }

        // Email validation
        if (isEmpty(email)) {
            errors.add("Email address is required.");
        } else if (!EMAIL_PATTERN.matcher(email).matches()) {
            errors.add("Please enter a valid email address.");
        }

        // Phone validation
        if (isEmpty(phone)) {
            errors.add("Phone number is required.");
        } else if (!PHONE_PATTERN.matcher(phone).matches()) {
            errors.add("Phone number must be 7-20 digits and may include +, -, spaces, or parentheses.");
        }

        // Password validation
        if (isEmpty(password)) {
            errors.add("Password is required.");
        } else if (password.length() < 8) {
            errors.add("Password must be at least 8 characters long.");
        }

        // Confirm Password validation
        if (isEmpty(confirmPassword)) {
            errors.add("Please confirm your password.");
        } else if (!password.equals(confirmPassword)) {
            errors.add("Password and confirm password do not match.");
        }

        // Role validation: public registration is client/worker-only
        if (isEmpty(role)) {
            errors.add("Please select a role.");
        } else {
            Role parsedRole = Role.fromString(role);
            if (parsedRole == null) {
                errors.add("Invalid role selected.");
            } else if (parsedRole == Role.ADMIN) {
                errors.add("Only client or worker registration is allowed through this form.");
            }
        }

        return errors;
    }

    /**
     * Validates login fields and returns a list of error messages.
     */
    public static List<String> validateLogin(String email, String password) {
        List<String> errors = new ArrayList<>();

        if (isEmpty(email)) {
            errors.add("Email address is required.");
        } else if (!EMAIL_PATTERN.matcher(email).matches()) {
            errors.add("Please enter a valid email address.");
        }

        if (isEmpty(password)) {
            errors.add("Password is required.");
        }

        return errors;
    }

    /**
     * Validates forgot-password fields.
     */
    public static List<String> validateForgotPassword(String email) {
        List<String> errors = new ArrayList<>();

        if (isEmpty(email)) {
            errors.add("Email address is required.");
        } else if (!EMAIL_PATTERN.matcher(email).matches()) {
            errors.add("Please enter a valid email address.");
        }

        return errors;
    }

    /**
     * Validates reset-password fields.
     */
    public static List<String> validateResetPassword(
            String newPassword, String confirmPassword) {
        List<String> errors = new ArrayList<>();

        if (isEmpty(newPassword)) {
            errors.add("New password is required.");
        } else if (newPassword.length() < 8) {
            errors.add("Password must be at least 8 characters long.");
        }

        if (isEmpty(confirmPassword)) {
            errors.add("Please confirm your new password.");
        } else if (!newPassword.equals(confirmPassword)) {
            errors.add("Password and confirm password do not match.");
        }

        return errors;
    }

    /**
     * Validates client profile update fields.
     */
    public static List<String> validateProfileUpdate(String fullName, String phone) {
        List<String> errors = new ArrayList<>();

        if (isEmpty(fullName)) {
            errors.add("Full name is required.");
        } else if (!NAME_PATTERN.matcher(fullName).matches()) {
            errors.add("Full name must contain only letters, spaces, hyphens, or dots (2-100 characters).");
        }

        if (isEmpty(phone)) {
            errors.add("Phone is required.");
        } else if (!PHONE_PATTERN.matcher(phone).matches()) {
            errors.add("Phone number must be 7-20 digits and may include +, -, spaces, or parentheses.");
        }

        return errors;
    }

    /**
     * Checks if a string is null or empty/whitespace.
     */
    public static boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Sanitizes a string by trimming whitespace.
     * Returns empty string if null.
     */
    public static String sanitize(String value) {
        return value == null ? "" : value.trim();
    }
}