package com.buildtrack.controller.admin;

import com.buildtrack.model.Payroll;
import com.buildtrack.model.Payslip;
import com.buildtrack.service.admin.PayrollService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

/**
 * Admin payroll management — generate, view, and mark payrolls as paid.
 *
 * GET  /admin/payroll                         → show payroll view (pick month)
 * GET  /admin/payroll?action=list&my=X        → list all payroll for a month
 * GET  /admin/payroll?action=payslip&id=X     → view a payslip
 * GET  /admin/payroll?action=worker&wid=X&my=X → view worker's payroll for month
 * POST /admin/payroll?action=generate         → generate payroll for all workers
 * POST /admin/payroll?action=generate-single  → generate payroll for one worker
 * POST /admin/payroll?action=mark-paid&id=X   → mark a payroll as paid
 */
@WebServlet("/admin/payroll")
public class PayrollController extends HttpServlet {

    private final PayrollService payrollService = new PayrollService();

    // ==================== GET ====================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // ---------- Show payroll overview ----------
            request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                    .forward(request, response);
            return;
        }

        switch (action) {

            // ---------- List all payroll for a month ----------
            case "list": {
                String monthYear = request.getParameter("my");
                List<Payroll> payrolls = payrollService.getPayrollByMonth(monthYear);
                BigDecimal totalPending = payrollService.getTotalSalaryByMonth(monthYear, "PENDING");
                BigDecimal totalPaid = payrollService.getTotalSalaryByMonth(monthYear, "PAID");

                request.setAttribute("monthYear", monthYear);
                request.setAttribute("payrolls", payrolls);
                request.setAttribute("totalPending", totalPending);
                request.setAttribute("totalPaid", totalPaid);
                request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                        .forward(request, response);
                break;
            }

            // ---------- View a single payslip ----------
            case "payslip": {
                int id = Integer.parseInt(request.getParameter("id"));
                Payslip payslip = payrollService.getPayslipById(id);
                if (payslip == null) { response.sendError(404, "Payslip not found"); return; }
                request.setAttribute("payslip", payslip);
                request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                        .forward(request, response);
                break;
            }

            // ---------- View a specific worker's payroll ----------
            case "worker": {
                int workerId = Integer.parseInt(request.getParameter("wid"));
                String monthYear = request.getParameter("my");
                Payroll p = payrollService.getWorkerPayroll(workerId, monthYear);
                request.setAttribute("workerId", workerId);
                request.setAttribute("monthYear", monthYear);
                request.setAttribute("payroll", p);
                request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                        .forward(request, response);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/payroll");
        }
    }

    // ==================== POST ====================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/payroll");
            return;
        }

        int adminId = (int) request.getSession().getAttribute("userId");

        switch (action) {

            // ---------- Generate payroll for ALL workers for a month ----------
            case "generate": {
                String monthYear = request.getParameter("monthYear");
                List<String> errors = payrollService.generateMonthlyPayroll(monthYear, adminId);

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "Payroll generated successfully for " + monthYear + ".");
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/payroll?action=list&my=" + monthYear);
                break;
            }

            // ---------- Generate payroll for a SINGLE worker ----------
            case "generate-single": {
                int workerId = Integer.parseInt(request.getParameter("workerId"));
                String monthYear = request.getParameter("monthYear");
                List<String> errors = payrollService.generateSinglePayroll(
                        workerId, monthYear, adminId
                );

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "Payroll generated for worker.");
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/payroll?action=list&my=" + monthYear);
                break;
            }

            // ---------- Mark a payroll as PAID ----------
            case "mark-paid": {
                int id = Integer.parseInt(request.getParameter("id"));
                String monthYear = request.getParameter("my");

                List<String> errors = payrollService.markAsPaid(id);

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "Payroll marked as paid.");
                }
                response.sendRedirect(request.getContextPath()
                        + "/admin/payroll?action=list&my=" + monthYear);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/payroll");
        }
    }
}