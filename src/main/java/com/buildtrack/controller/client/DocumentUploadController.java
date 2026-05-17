package com.buildtrack.controller.client;

import com.buildtrack.model.Document;
import com.buildtrack.service.client.ClientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

/**
 * Controller for client document uploads.
 */
@WebServlet("/client/documents")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class DocumentUploadController extends HttpServlet {

    private final ClientService clientService = new ClientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int clientId = (Integer) session.getAttribute("userId");
        List<Document> documents = clientService.getDocumentsByClient(clientId);
        request.setAttribute("documents", documents);

        // Fetch projects for the dropdown
        request.setAttribute("projects", clientService.getDashboardSummary(clientId).get("projects"));

        request.getRequestDispatcher("/WEB-INF/views/client/documents.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int clientId = (Integer) session.getAttribute("userId");
        String projectIdStr = request.getParameter("projectId");
        Part filePart = request.getPart("file");

        if (projectIdStr == null || projectIdStr.trim().isEmpty() || filePart == null || filePart.getSize() == 0) {
            request.setAttribute("error", "Project and file are required.");
            doGet(request, response);
            return;
        }

        int projectId = Integer.parseInt(projectIdStr);
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Save file physically
        String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "documents";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Save into db
        Document doc = new Document();
        doc.setClientId(clientId);
        doc.setProjectId(projectId);
        doc.setFileName(fileName);
        doc.setFilePath("assets/documents/" + fileName); // Relative path

        boolean success = clientService.saveDocument(doc);

        if (success) {
            request.setAttribute("successMessage", "Document uploaded successfully!");
        } else {
            request.setAttribute("error", "Database error occurred while saving the document record.");
        }

        doGet(request, response);
    }
}