package com.buildtrack.service.auth;

import com.buildtrack.dao.auth.AuthDao;
import com.buildtrack.model.User;
import com.buildtrack.model.Role;
import com.buildtrack.util.PasswordUtil;
import com.buildtrack.util.ValidationUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Service layer for authentication operations.
 * Handles business logic for login and registration,
 * separating it from controllers and DAOs.
 */
public class AuthService {

    private final AuthDao authDAO;

    /**
     * Creates an AuthService with a default AuthDao.
     */
    public AuthService() {
        this.authDAO = new AuthDao();
    }

    /**
     * Registers a new user after validation.
     *
     * @param fullName        the user's full name
     * @param email           the user's email
     * @param phone           the user's phone number
     * @param password        the plain-text password (will be hashed)
     * @param confirmPassword the password confirmation
     * @param roleStr         the role string (client-only public signup)
     * @return a list of error messages; empty if registration succeeds
     */
    public List<String> register(String fullName, String email, String phone,
            String password, String confirmPassword,
            String roleStr) {

        List<String> errors = new ArrayList<>();

        // Step 1: Validate input fields
        List<String> validationErrors = ValidationUtil.validateRegistration(
                fullName, email, phone, password, confirmPassword, roleStr);
        errors.addAll(validationErrors);

        // If basic validation failed, return early (no DB checks needed)
        if (!errors.isEmpty()) {
            return errors;
        }

        // Step 2: Check if email already exists
        if (authDAO.emailExists(email.trim())) {
            errors.add("An account with this email already exists.");
            return errors;
        }

        // Step 3: Parse role (public signup is client-only)
        Role role = Role.fromString(roleStr);
        if (role != Role.CLIENT) {
            errors.add("Only client registration is allowed through this form.");
            return errors;
        }

        // Step 4: Hash the password
        String hashedPassword = PasswordUtil.hashedPassword(password);

        // Step 5: Build the User object
        User user = new User(
                fullName.trim(),
                email.trim().toLowerCase(),
                phone.trim(),
                hashedPassword,
                Role.CLIENT,
                BigDecimal.ZERO // daily wage set by admin later
        );

        // Step 6: Save to database
        boolean saved = authDAO.insertUser(user);
        if (!saved) {
            errors.add("Registration failed due to a database error. Please try again.");
        }

        return errors;
    }

    /**
     * Authenticates a user with email and password.
     *
     * @param email    the user's email
     * @param password the plain-text password
     * @return a LoginResult object containing either the user or error messages
     */
    public LoginResult login(String email, String password) {
        LoginResult result = new LoginResult();

        // Step 1: Validate input
        List<String> validationErrors = ValidationUtil.validateLogin(email, password);
        if (!validationErrors.isEmpty()) {
            result.setErrors(validationErrors);
            return result;
        }

        // Step 2: Find user by email
        User user = authDAO.findByEmail(email.trim().toLowerCase());

        if (user == null) {
            result.addError("Invalid email or password.");
            return result;
        }

        // Step 3: Verify password
        if (!PasswordUtil.verifyPassword(password, user.getPassword())) {
            result.addError("Invalid email or password.");
            return result;
        }

        // Step 4: Check account status
        if (user.isPending()) {
            result.addError("Your account is pending admin approval. "
                    + "Please wait for an administrator to approve your registration.");
            return result;
        }

        if (user.isDeactivated()) {
            result.addError("Your account has been deactivated. "
                    + "Please contact the administrator for assistance.");
            return result;
        }

        if (!user.isApproved()) {
            result.addError("Your account status is invalid. "
                    + "Please contact the administrator.");
            return result;
        }

        // Step 5: Login successful — clear any existing reset token
        authDAO.clearResetToken(user.getId());

        // Step 6: Set user in result
        result.setUser(user);
        return result;
    }

    /**
     * Simple result container for login operations.
     * Holds either the authenticated User or a list of errors.
     */
    public static class LoginResult {
        private User user;
        private List<String> errors = new ArrayList<>();

        /**
         * Returns the authenticated user.
         */
        public User getUser() {
            return user;
        }

        /**
         * Sets the authenticated user.
         */
        public void setUser(User user) {
            this.user = user;
        }

        /**
         * Returns the error list.
         */
        public List<String> getErrors() {
            return errors;
        }

        /**
         * Returns true if errors are present.
         */
        public boolean hasErrors() {
            return !errors.isEmpty();
        }

        /**
         * Sets the error list.
         */
        public void setErrors(List<String> errors) {
            this.errors = errors;
        }

        /**
         * Adds a single error message.
         */
        public void addError(String error) {
            this.errors.add(error);
        }
    }
}