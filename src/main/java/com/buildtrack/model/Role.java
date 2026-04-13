package com.buildtrack.model;

/**
 * Enumeration of user roles in the BuildTrack system.
 * Used for Role-Based Access Control (RBAC).
 */
public enum Role {
    ADMIN,
    WORKER,
    CLIENT;

    /**
     * Checks if the given string matches any role (case-insensitive).
     */
    public static Role fromString(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Role.valueOf(value.trim().toUpperCase());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    /**
     * Returns the lowercase string representation of the role.
     */
    public String toLower() {
        return this.name().toLowerCase();
    }

    /**
     * Returns the dashboard URL path for this role.
     */
    public String getDashboardPath() {
        return "/" + this.toLower() + "/dashboard";
    }
}