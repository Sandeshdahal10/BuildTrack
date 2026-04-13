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
    private String status;       // PENDING, APPROVED, DEACTIVATED
    private BigDecimal dailyWage;
    private String resetToken;
    private Timestamp resetTokenExpiry;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ---------- Constructors ----------

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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getDailyWage() {
        return dailyWage;
    }

    public void setDailyWage(BigDecimal dailyWage) {
        this.dailyWage = dailyWage;
    }

    public String getResetToken() {
        return resetToken;
    }

    public void setResetToken(String resetToken) {
        this.resetToken = resetToken;
    }

    public Timestamp getResetTokenExpiry() {
        return resetTokenExpiry;
    }

    public void setResetTokenExpiry(Timestamp resetTokenExpiry) {
        this.resetTokenExpiry = resetTokenExpiry;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // ---------- Utility Methods ----------

    /**
     * Checks if the user account is approved and active.
     */
    public boolean isApproved() {
        return "APPROVED".equals(this.status);
    }

    /**
     * Checks if the user account is pending admin approval.
     */
    public boolean isPending() {
        return "PENDING".equals(this.status);
    }

    /**
     * Checks if the user account is deactivated.
     */
    public boolean isDeactivated() {
        return "DEACTIVATED".equals(this.status);
    }

    /**
     * Checks if the password reset token is valid (not null and not expired).
     */
    public boolean isResetTokenValid() {
        if (this.resetToken == null || this.resetTokenExpiry == null) {
            return false;
        }
        return this.resetTokenExpiry.after(new Timestamp(System.currentTimeMillis()));
    }

    /**
     * Returns the display-friendly role name.
     */
    public String getRoleDisplayName() {
        if (this.role == null) return "Unknown";
        switch (this.role) {
            case ADMIN:  return "Administrator";
            case WORKER: return "Worker";
            case CLIENT: return "Client";
            default:     return "Unknown";
        }
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", fullName='" + fullName + "', email='" + email +
                "', role=" + role + ", status='" + status + "'}";
    }
}