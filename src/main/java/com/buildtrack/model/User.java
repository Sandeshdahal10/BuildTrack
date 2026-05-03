package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * User model representing all three user types:
 * Admin, Worker, and Client.
 */
public class User {

    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private Role role;
    private String status; // PENDING, APPROVED, DEACTIVATED
    private BigDecimal dailyWage;
    private String resetToken;
    private Timestamp resetTokenExpiry;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ---------- Constructors ----------

    /**
     * Creates an empty user instance.
     */
    public User() {
    }

    /**
     * Constructor for registration (without id, timestamps, reset fields).
     */
    public User(String fullName, String email, String phone,
            String password, Role role, BigDecimal dailyWage) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
        this.dailyWage = dailyWage;
        this.status = "PENDING";
    }

    // ---------- Getters and Setters ----------

    /**
     * Returns the user id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the user id.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the full name.
     */
    public String getFullName() {
        return fullName;
    }

    /**
     * Sets the full name.
     */
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    /**
     * Returns the email address.
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the email address.
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Returns the phone number.
     */
    public String getPhone() {
        return phone;
    }

    /**
     * Sets the phone number.
     */
    public void setPhone(String phone) {
        this.phone = phone;
    }

    /**
     * Returns the password hash.
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the password hash.
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Returns the user role.
     */
    public Role getRole() {
        return role;
    }

    /**
     * Sets the user role.
     */
    public void setRole(Role role) {
        this.role = role;
    }

    /**
     * Returns the account status.
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the account status.
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Returns the daily wage.
     */
    public BigDecimal getDailyWage() {
        return dailyWage;
    }

    /**
     * Sets the daily wage.
     */
    public void setDailyWage(BigDecimal dailyWage) {
        this.dailyWage = dailyWage;
    }

    /**
     * Returns the reset token.
     */
    public String getResetToken() {
        return resetToken;
    }

    /**
     * Sets the reset token.
     */
    public void setResetToken(String resetToken) {
        this.resetToken = resetToken;
    }

    /**
     * Returns the reset token expiry timestamp.
     */
    public Timestamp getResetTokenExpiry() {
        return resetTokenExpiry;
    }

    /**
     * Sets the reset token expiry timestamp.
     */
    public void setResetTokenExpiry(Timestamp resetTokenExpiry) {
        this.resetTokenExpiry = resetTokenExpiry;
    }

    /**
     * Returns the creation timestamp.
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets the creation timestamp.
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Returns the last update timestamp.
     */
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    /**
     * Sets the last update timestamp.
     */
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // ---------- Utility Methods ----------

    /**
     * Checks if the user account is approved and active.
     *
     * @return true if approved
     */
    public boolean isApproved() {
        return "APPROVED".equals(this.status);
    }

    /**
     * Checks if the user account is pending admin approval.
     *
     * @return true if pending
     */
    public boolean isPending() {
        return "PENDING".equals(this.status);
    }

    /**
     * Checks if the user account is deactivated.
     *
     * @return true if deactivated
     */
    public boolean isDeactivated() {
        return "DEACTIVATED".equals(this.status);
    }

    /**
     * Checks if the password reset token is valid (not null and not expired).
     *
     * @return true if the reset token is valid
     */
    public boolean isResetTokenValid() {
        if (this.resetToken == null || this.resetTokenExpiry == null) {
            return false;
        }
        return this.resetTokenExpiry.after(new Timestamp(System.currentTimeMillis()));
    }

    /**
     * Returns the display-friendly role name.
     *
     * @return role display name
     */
    public String getRoleDisplayName() {
        if (this.role == null)
            return "Unknown";
        switch (this.role) {
            case ADMIN:
                return "Administrator";
            case WORKER:
                return "Worker";
            case CLIENT:
                return "Client";
            default:
                return "Unknown";
        }
    }

    /**
     * Returns a simple string representation of the user.
     */
    @Override
    public String toString() {
        return "User{id=" + id + ", fullName='" + fullName + "', email='" + email +
                "', role=" + role + ", status='" + status + "'}";
    }
}