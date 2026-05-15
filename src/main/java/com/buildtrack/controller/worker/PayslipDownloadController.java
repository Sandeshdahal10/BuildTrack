package com.buildtrack.controller.worker;

import com.buildtrack.model.Payslip;
import com.buildtrack.model.Payroll;
import com.buildtrack.model.User;
import com.buildtrack.service.admin.PayrollService;
import com.buildtrack.util.PdfUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Streams a payslip PDF to the authenticated worker (or admin).
 * URL: /worker/payslip/download?id=PAYROLL_ID
 */
@WebServlet("/worker/payslip/download")
public class PayslipDownloadController extends HttpServlet {

    private final PayrollService payrollService = new PayrollService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing payslip id");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid payslip id");
            return;
        }

        Payslip ps = payrollService.getPayslipById(id);
        Payroll pr = payrollService.getPayrollById(id);
        if (ps == null || pr == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Payslip not found");
            return;
        }

        // Authorization: allow if user is the payroll owner or an admin
        boolean isOwner = user.getId() == pr.getWorkerId();
        boolean isAdmin = user.getRole() != null && "ADMIN".equals(user.getRole().name());
        if (!isOwner && !isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not authorized to download this payslip");
            return;
        }

        byte[] pdf;
        try {
            pdf = PdfUtil.generatePayslipPdf(ps);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to generate PDF");
            return;
        }

        response.setContentType("application/pdf");
        String filename = "payslip_" + ps.getMonthYear() + "_" + ps.getWorkerName().replaceAll("\\s+","_") + ".pdf";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setContentLength(pdf.length);

        response.getOutputStream().write(pdf);
        response.getOutputStream().flush();
    }
}
