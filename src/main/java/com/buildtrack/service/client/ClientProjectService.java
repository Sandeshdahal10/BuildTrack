package com.buildtrack.service.client;

import com.buildtrack.dao.client.ClientProjectDAO;
import com.buildtrack.model.Project;
import com.buildtrack.model.ProjectDocument;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Service layer for client project creation and management.
 * Handles business logic, validation, and file operations.
 */
public class ClientProjectService {

    private final ClientProjectDAO projectDAO = new ClientProjectDAO();

    // File upload configuration
    private static final String UPLOAD_DIR = "uploads/documents";
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5 MB
    private static final String[] ALLOWED_EXTENSIONS = {".pdf", ".doc", ".docx", ".jpg", ".jpeg", ".png"};

    /**
     * Creates a new project with server-side validation.
     * Returns the project ID if successful, or -1 if failed.
     *
     * @param clientId    client identifier
     * @param title       project title
     * @param description project description
     * @param budget      total budget
     * @param startDate   start date
     * @param endDate     end date
     * @param status      project status
     * @return project ID if successful, -1 on failure
     */
    public int createProject(int clientId, String title, String description,
                            BigDecimal budget, Date startDate, Date endDate, String status) {
        List<String> errors = validateProjectInput(title, description, budget, startDate, endDate, status);
        if (!errors.isEmpty()) {
            return -1;
        }

        // Create project
        Project project = new Project(title, description, clientId, startDate, endDate, budget, status);
        return projectDAO.createProject(project);
    }

    /**
     * Validates and saves an uploaded project document.
     * Returns error message or empty string if successful.
     *
     * @param projectId  project identifier
     * @param clientId   client identifier
     * @param fileName   original file name
     * @param fileData   file bytes
     * @param fileType   MIME type or file extension
     * @return error message or empty string if successful
     */
    public String saveProjectDocument(int projectId, int clientId, String fileName,
                                     byte[] fileData, String fileType) {
        // Validate file
        String fileError = validateFile(fileName, fileData.length, fileType);
        if (!fileError.isEmpty()) {
            return fileError;
        }

        try {
            // Ensure upload directory exists
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                if (!uploadDir.mkdirs()) {
                    return "Failed to create upload directory.";
                }
            }

            // Generate unique file name
            String uniqueFileName = generateUniqueFileName(fileName);
            String filePath = UPLOAD_DIR + File.separator + uniqueFileName;

            // Save file to disk
            File file = new File(filePath);
            try (java.io.FileOutputStream fos = new java.io.FileOutputStream(file)) {
                fos.write(fileData);
            }

            // Save document record to database
            ProjectDocument document = new ProjectDocument(projectId, clientId, fileName, filePath, fileType, fileData.length);
            int docId = projectDAO.saveProjectDocument(document);

            if (docId <= 0) {
                // Delete file if database save fails
                if (!file.delete()) {
                    System.err.println("Warning: Failed to delete file after database error: " + filePath);
                }
                return "Failed to save document. Please try again.";
            }

            return ""; // Success
        } catch (IOException e) {
            System.err.println("[ClientProjectService] saveProjectDocument IO error: " + e.getMessage());
            return "Error uploading file: " + e.getMessage();
        }
    }

    /**
     * Validates project input fields.
     *
     * @return list of validation error messages
     */
    private List<String> validateProjectInput(String title, String description,
                                              BigDecimal budget, Date startDate, Date endDate, String status) {
        List<String> errors = new ArrayList<>();

        // Title validation
        if (title == null || title.trim().isEmpty()) {
            errors.add("Project title is required.");
        } else if (title.length() > 100) {
            errors.add("Project title must not exceed 100 characters.");
        }

        // Description validation
        if (description == null || description.trim().isEmpty()) {
            errors.add("Project description is required.");
        } else if (description.length() > 500) {
            errors.add("Project description must not exceed 500 characters.");
        }

        // Budget validation
        if (budget == null || budget.compareTo(BigDecimal.ZERO) < 0) {
            errors.add("Budget must be a valid positive number.");
        }

        // Date validation
        if (startDate == null) {
            errors.add("Start date is required.");
        }
        if (endDate == null) {
            errors.add("End date is required.");
        }
        if (startDate != null && endDate != null && endDate.before(startDate)) {
            errors.add("End date must be after or equal to start date.");
        }

        // Status validation
        if (status == null || status.trim().isEmpty()) {
            errors.add("Project status is required.");
        } else if (!isValidStatus(status)) {
            errors.add("Invalid project status.");
        }

        return errors;
    }

    /**
     * Validates file upload.
     *
     * @return error message or empty string if valid
     */
    private String validateFile(String fileName, long fileSize, String fileType) {
        if (fileName == null || fileName.trim().isEmpty()) {
            return ""; // File is optional
        }

        // Check file size
        if (fileSize > MAX_FILE_SIZE) {
            return "File size must not exceed 5 MB.";
        }

        // Check file extension
        String extension = fileName.toLowerCase();
        int dotIndex = extension.lastIndexOf('.');
        if (dotIndex == -1) {
            return "File must have a valid extension.";
        }

        extension = extension.substring(dotIndex);
        boolean isAllowed = false;
        for (String allowed : ALLOWED_EXTENSIONS) {
            if (extension.equals(allowed)) {
                isAllowed = true;
                break;
            }
        }

        if (!isAllowed) {
            return "Only PDF, DOC, DOCX, JPG, and PNG files are allowed.";
        }

        return ""; // Valid
    }

    /**
     * Checks if the provided status is valid.
     */
    private boolean isValidStatus(String status) {
        return status.equalsIgnoreCase("PLANNED") ||
               status.equalsIgnoreCase("IN_PROGRESS") ||
               status.equalsIgnoreCase("COMPLETED") ||
               status.equalsIgnoreCase("ON_HOLD");
    }

    /**
     * Generates a unique file name using UUID.
     */
    private String generateUniqueFileName(String originalFileName) {
        int dotIndex = originalFileName.lastIndexOf('.');
        if (dotIndex == -1) {
            return UUID.randomUUID().toString();
        }

        String extension = originalFileName.substring(dotIndex);
        return UUID.randomUUID().toString() + extension;
    }

    /**
     * Checks if a project belongs to the given client.
     */
    public boolean projectBelongsToClient(int projectId, int clientId) {
        return projectDAO.projectBelongsToClient(projectId, clientId);
    }
}
