package com.buildtrack.model;

import java.sql.Timestamp;

/**
 * Inquiry submitted by a client about a project.
 */
public class Inquiry {
    private int id;
    private int clientId;
    private int projectId;
    private String subject;
    private String message;
    private String adminReply;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String clientName; // For display
    private String projectTitle; // For display

    /**
     * Creates an empty inquiry instance.
     */
    public Inquiry() {
    }

    /**
     * Returns the inquiry id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the inquiry id.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the client id who created the inquiry.
     */
    public int getClientId() {
        return clientId;
    }

    /**
     * Sets the client id who created the inquiry.
     */
    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    /**
     * Returns the related project id.
     */
    public int getProjectId() {
        return projectId;
    }

    /**
     * Sets the related project id.
     */
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    /**
     * Returns the inquiry subject.
     */
    public String getSubject() {
        return subject;
    }

    /**
     * Sets the inquiry subject.
     */
    public void setSubject(String subject) {
        this.subject = subject;
    }

    /**
     * Returns the inquiry message.
     */
    public String getMessage() {
        return message;
    }

    /**
     * Sets the inquiry message.
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /**
     * Returns the admin reply.
     */
    public String getAdminReply() {
        return adminReply;
    }

    /**
     * Sets the admin reply.
     */
    public void setAdminReply(String adminReply) {
        this.adminReply = adminReply;
    }

    /**
     * Returns the inquiry status.
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the inquiry status.
     */
    public void setStatus(String status) {
        this.status = status;
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

    /**
     * Returns the client name for display.
     */
    public String getClientName() {
        return clientName;
    }

    /**
     * Sets the client name for display.
     */
    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    /**
     * Returns the project title for display.
     */
    public String getProjectTitle() {
        return projectTitle;
    }

    /**
     * Sets the project title for display.
     */
    public void setProjectTitle(String projectTitle) {
        this.projectTitle = projectTitle;
    }
}