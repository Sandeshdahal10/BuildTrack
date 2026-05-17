package com.buildtrack.model;

import java.sql.Timestamp;

/**
 * ProjectDocument entity representing a document uploaded by a client for a project.
 */
public class ProjectDocument {
    private int id;
    private int projectId;
    private int clientId;
    private String fileName;
    private String filePath;
    private String fileType;
    private long fileSize;
    private Timestamp uploadedAt;

    /**
     * Creates an empty project document instance.
     */
    public ProjectDocument() {
    }

    /**
     * Creates a populated project document instance.
     *
     * @param projectId project identifier
     * @param clientId  client identifier
     * @param fileName  original file name
     * @param filePath  path where the file is stored
     * @param fileType  MIME type or file extension
     * @param fileSize  file size in bytes
     */
    public ProjectDocument(int projectId, int clientId, String fileName, String filePath,
                          String fileType, long fileSize) {
        this.projectId = projectId;
        this.clientId = clientId;
        this.fileName = fileName;
        this.filePath = filePath;
        this.fileType = fileType;
        this.fileSize = fileSize;
    }

    // Getters and Setters

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
     * Returns the project id.
     */
    public int getProjectId() {
        return projectId;
    }

    /**
     * Sets the project id.
     */
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    /**
     * Returns the client id.
     */
    public int getClientId() {
        return clientId;
    }

    /**
     * Sets the client id.
     */
    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    /**
     * Returns the file name.
     */
    public String getFileName() {
        return fileName;
    }

    /**
     * Sets the file name.
     */
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    /**
     * Returns the file path.
     */
    public String getFilePath() {
        if (filePath != null) {
            return filePath.replace('\\', '/');
        }
        return filePath;
    }

    /**
     * Sets the file path.
     */
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    /**
     * Returns the file type.
     */
    public String getFileType() {
        return fileType;
    }

    /**
     * Sets the file type.
     */
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    /**
     * Returns the file size in bytes.
     */
    public long getFileSize() {
        return fileSize;
    }

    /**
     * Sets the file size in bytes.
     */
    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
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
     * Returns formatted file size as human-readable string.
     */
    public String getFormattedFileSize() {
        if (fileSize <= 0) return "0 B";
        final String[] units = new String[]{"B", "KB", "MB", "GB"};
        int unitIndex = (int) (Math.log10(fileSize) / Math.log10(1024));
        return String.format("%.2f %s", fileSize / Math.pow(1024, unitIndex), units[unitIndex]);
    }
}
