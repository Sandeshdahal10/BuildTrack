package com.buildtrack.controller.admin;

import java.io.IOException;

import com.buildtrack.service.admin.InquiryService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/updateInquiryStatus")
public class InquiryController extends HttpServlet {

    private final InquiryService inquiryService = new InquiryService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String inquiryIdStr = request.getParameter("inquiryId");
        String status = request.getParameter("status");

        if (inquiryIdStr != null && status != null) {
            int inquiryId = Integer.parseInt(inquiryIdStr);
            inquiryService.updateInquiry(inquiryId, null, status.toUpperCase()); // Using exact DB enum values
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/reports");
    }
}