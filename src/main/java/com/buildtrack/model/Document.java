package com.buildtrack.model;

import java.sql.Timestamp;

/**
 * Document metadata for files uploaded to a project by a client.
 */
public class Document {
    private int id;
    private int projectId;
    private int clientId;
    private String fileName;
    private String filePath;
    private Timestamp uploadedAt;

    private String clientName; // For display
    private String projectTitle; // For display

    /**
     * Creates an empty document instance.
     */
    public Document() {
    }

    /**
     * Returns the document id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the document id.
     */
    public void setId(int id) {
        this.id = id;
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
     * Returns the client id who uploaded the document.
     */
    public int getClientId() {
        return clientId;
    }

    /**
     * Sets the client id who uploaded the document.
     */
    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    /**
     * Returns the original file name.
     */
    public String getFileName() {
        return fileName;
    }

    /**
     * Sets the original file name.
     */
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    /**
     * Returns the storage path for the file.
     */
    public String getFilePath() {
        if (filePath != null) {
            return filePath.replace('\\', '/');
        }
        return filePath;
    }

    /**
     * Sets the storage path for the file.
     */
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    /**
     * Returns the upload timestamp.
     */
    public Timestamp getUploadedAt() {
        return uploadedAt;
    }

    /**
     * Sets the upload timestamp.
     */
    public void setUploadedAt(Timestamp uploadedAt) {
        this.uploadedAt = uploadedAt;
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