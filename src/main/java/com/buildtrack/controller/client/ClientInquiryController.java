package com.buildtrack.controller.client;

import java.io.IOException;
import java.util.List;

import com.buildtrack.model.Inquiry;
import com.buildtrack.service.client.ClientService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Controller for client inquiries.
 */
@WebServlet("/client/inquiries")
public class ClientInquiryController extends HttpServlet {

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
        List<Inquiry> inquiries = clientService.getInquiriesByClient(clientId);
        request.setAttribute("inquiries", inquiries);

        // Fetch projects for the dropdown
        request.setAttribute("projects", clientService.getDashboardSummary(clientId).get("projects"));

        request.getRequestDispatcher("/WEB-INF/views/client/inquiries.jsp")
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
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (projectIdStr == null || projectIdStr.trim().isEmpty() ||
                subject == null || subject.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            doGet(request, response);
            return;
        }

        int projectId = Integer.parseInt(projectIdStr);

        Inquiry inquiry = new Inquiry();
        inquiry.setClientId(clientId);
        inquiry.setProjectId(projectId);
        inquiry.setSubject(subject.trim());
        inquiry.setMessage(message.trim());

        boolean success = clientService.submitInquiry(inquiry);

        if (success) {
            request.setAttribute("successMessage", "Inquiry submitted successfully!");
        } else {
            request.setAttribute("error", "Failed to submit inquiry.");
        }

        doGet(request, response);
    }
}