package com.buildtrack.controller.client;

import com.buildtrack.service.client.ClientProjectService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller for handling client project submission.
 * Handles both GET (form display) and POST (form submission).
 */
@WebServlet("/client/addProject")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024, // 5 MB
        maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class ClientAddProjectServlet extends HttpServlet {

    private final ClientProjectService projectService = new ClientProjectService();

    /**
     * Displays the add project form.
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Session validation
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer userIdObj = (Integer) session.getAttribute("userId");
        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Forward to form JSP
        request.getRequestDispatcher("/WEB-INF/views/client/addProject.jsp")
                .forward(request, response);
    }

    /**
     * Handles project form submission.
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Session validation
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer userIdObj = (Integer) session.getAttribute("userId");
        if (userIdObj == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int clientId = userIdObj;
        List<String> errors = new ArrayList<>();

        try {
            // Extract form parameters
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String budgetStr = request.getParameter("budget");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String status = "PLANNED"; // Enforce approval workflow

            // Validate required fields
            if (title == null || title.trim().isEmpty()) {
                errors.add("Project title is required.");
            }
            if (description == null || description.trim().isEmpty()) {
                errors.add("Project description is required.");
            }
            if (budgetStr == null || budgetStr.trim().isEmpty()) {
                errors.add("Budget is required.");
            }
            if (startDateStr == null || startDateStr.trim().isEmpty()) {
                errors.add("Start date is required.");
            }
            if (endDateStr == null || endDateStr.trim().isEmpty()) {
                errors.add("End date is required.");
            }
            if (status == null || status.trim().isEmpty()) {
                errors.add("Status is required.");
            }

            // Parse and validate budget
            BigDecimal budget = null;
            if (!errors.isEmpty()) {
                // Skip budget parsing if there are already errors
            } else {
                try {
                    budget = new BigDecimal(budgetStr);
                    if (budget.compareTo(BigDecimal.ZERO) < 0) {
                        errors.add("Budget must be a positive number.");
                    }
                } catch (NumberFormatException e) {
                    errors.add("Budget must be a valid number.");
                }
            }

            // Parse and validate dates
            Date startDate = null;
            Date endDate = null;
            if (!errors.isEmpty()) {
                // Skip date parsing if there are already errors
            } else {
                try {
                    startDate = Date.valueOf(startDateStr);
                    endDate = Date.valueOf(endDateStr);
                    if (endDate.before(startDate)) {
                        errors.add("End date must be after or equal to start date.");
                    }
                } catch (IllegalArgumentException e) {
                    errors.add("Invalid date format. Use YYYY-MM-DD.");
                }
            }

            // If validation errors exist, return to form with errors
            if (!errors.isEmpty()) {
                session.setAttribute("formErrors", errors);
                session.setAttribute("formData", new java.util.HashMap<>() {{
                    put("title", title);
                    put("description", description);
                    put("budget", budgetStr);
                    put("startDate", startDateStr);
                    put("endDate", endDateStr);
                    put("status", status);
                }});
                response.sendRedirect(request.getContextPath() + "/client/addProject");
                return;
            }

            // Create project
            int projectId = projectService.createProject(clientId, title, description, budget, startDate, endDate, status);

            if (projectId <= 0) {
                errors.add("Failed to create project. Please try again.");
                session.setAttribute("formErrors", errors);
                response.sendRedirect(request.getContextPath() + "/client/addProject");
                return;
            }

            // Handle file upload (optional)
            Part filePart = request.getPart("document");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = extractFileName(filePart);
                byte[] fileData = readFileData(filePart);
                String fileType = filePart.getContentType();

                String fileError = projectService.saveProjectDocument(projectId, clientId, fileName, fileData, fileType);
                if (!fileError.isEmpty()) {
                    errors.add(fileError);
                    session.setAttribute("formErrors", errors);
                    response.sendRedirect(request.getContextPath() + "/client/addProject");
                    return;
                }
            }

            // Success - clear form data and set success message
            session.removeAttribute("formErrors");
            session.removeAttribute("formData");
            session.setAttribute("successMessage", "Project created successfully!");
            response.sendRedirect(request.getContextPath() + "/client/project");

        } catch (Exception e) {
            System.err.println("[ClientAddProjectServlet] Error processing project submission: " + e.getMessage());
            e.printStackTrace();
            errors.add("An unexpected error occurred. Please try again.");
            session.setAttribute("formErrors", errors);
            response.sendRedirect(request.getContextPath() + "/client/addProject");
        }
    }

    /**
     * Extracts file name from Part object.
     */
    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).replaceAll("\"", "").trim();
            }
        }
        return System.currentTimeMillis() + "_file";
    }

    /**
     * Reads file data from Part object as byte array.
     */
    private byte[] readFileData(Part part) throws IOException {
        try (InputStream is = part.getInputStream()) {
            return is.readAllBytes();
        }
    }
}
