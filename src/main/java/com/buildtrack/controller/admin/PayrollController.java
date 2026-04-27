package com.buildtrack.controller.admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.buildtrack.model.Payroll;
import com.buildtrack.model.Payslip;
import com.buildtrack.model.User;
import com.buildtrack.service.admin.PayrollService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Admin payroll management — generate, view, and mark payrolls as paid.
 *
 * GET /admin/payroll → show payroll view (pick month)
 * GET /admin/payroll?action=list&my=X → list all payroll for a month
 * GET /admin/payroll?action=payslip&id=X → view a payslip
 * GET /admin/payroll?action=worker&wid=X&my=X → view worker's payroll for month
 * POST /admin/payroll?action=generate → generate payroll for all workers
 * POST /admin/payroll?action=generate-single → generate payroll for one worker
 * POST /admin/payroll?action=mark-paid&id=X → mark a payroll as paid
 */
@WebServlet("/admin/payroll")
public class PayrollController extends HttpServlet {

    private final PayrollService payrollService = new PayrollService();

    // ==================== GET ====================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if (action == null) {
                // ---------- Show payroll overview for current month ----------
                String monthYear = YearMonth.now().toString();
                List<Payroll> payrolls = payrollService.getPayrollByMonth(monthYear);
                BigDecimal totalPending = payrollService.getTotalSalaryByMonth(monthYear, "PENDING");
                BigDecimal totalPaid = payrollService.getTotalSalaryByMonth(monthYear, "PAID");

                request.setAttribute("monthYear", monthYear);
                request.setAttribute("payrolls", payrolls);
                request.setAttribute("totalPending", totalPending);
                request.setAttribute("totalPaid", totalPaid);
                transferFlashMessages(request);
                request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                        .forward(request, response);
                return;
            }

            switch (action) {

                // ---------- List all payroll for a month ----------
                case "list" -> {
                    String monthYear = normalizeMonthYear(request.getParameter("my"));
                    List<Payroll> payrolls = payrollService.getPayrollByMonth(monthYear);
                    BigDecimal totalPending = payrollService.getTotalSalaryByMonth(monthYear, "PENDING");
                    BigDecimal totalPaid = payrollService.getTotalSalaryByMonth(monthYear, "PAID");

                    request.setAttribute("monthYear", monthYear);
                    request.setAttribute("payrolls", payrolls);
                    request.setAttribute("totalPending", totalPending);
                    request.setAttribute("totalPaid", totalPaid);
                    transferFlashMessages(request);
                    request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                            .forward(request, response);
                }

                // ---------- View a single payslip ----------
                case "payslip" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Payslip payslip = payrollService.getPayslipById(id);
                    if (payslip == null) {
                        response.sendError(404, "Payslip not found");
                        return;
                    }
                    request.setAttribute("payslip", payslip);
                    transferFlashMessages(request);
                    request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                            .forward(request, response);
                }

                // ---------- View a specific worker's payroll ----------
                case "worker" -> {
                    int workerId = Integer.parseInt(request.getParameter("wid"));
                    String monthYear = request.getParameter("my");
                    Payroll p = payrollService.getWorkerPayroll(workerId, monthYear);
                    request.setAttribute("workerId", workerId);
                    request.setAttribute("monthYear", monthYear);
                    request.setAttribute("payroll", p);
                    transferFlashMessages(request);
                    request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                            .forward(request, response);
                }

                default -> response.sendRedirect(request.getContextPath() + "/admin/payroll");
            }
        } catch (ServletException | IOException | RuntimeException e) {
            System.err.println("[PayrollController] GET payroll failed.");
            e.printStackTrace(System.err);

            if (response.isCommitted()) {
                return;
            }

            request.setAttribute("errors", List.of("Unable to load payroll right now. Please try again."));
            request.setAttribute("monthYear", YearMonth.now().toString());
            request.setAttribute("payrolls", Collections.<Payroll>emptyList());
            request.setAttribute("totalPending", BigDecimal.ZERO);
            request.setAttribute("totalPaid", BigDecimal.ZERO);
            try {
                request.getRequestDispatcher("/WEB-INF/views/admin/payroll.jsp")
                        .forward(request, response);
            } catch (ServletException | IOException | RuntimeException viewException) {
                System.err.println("[PayrollController] Failed to render payroll fallback view.");
                viewException.printStackTrace(System.err);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Unable to render payroll page.");
            }
        }
    }

    private void transferFlashMessages(HttpServletRequest request) {
        Object errors = request.getSession().getAttribute("errors");
        if (errors != null) {
            if (errors instanceof List<?> errorList) {
                List<String> normalized = new ArrayList<>();
                for (Object item : errorList) {
                    normalized.add(String.valueOf(item));
                }
                request.setAttribute("errors", normalized);
            } else {
                request.setAttribute("errors", Collections.singletonList(String.valueOf(errors)));
            }
            request.getSession().removeAttribute("errors");
        }
        Object success = request.getSession().getAttribute("success");
        if (success != null) {
            request.setAttribute("success", String.valueOf(success));
            request.getSession().removeAttribute("success");
        }
    }

    // ==================== POST ====================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if (action == null) {
                response.sendRedirect(request.getContextPath() + "/admin/payroll");
                return;
            }

            Integer adminId = resolveAdminId(request);
            if (adminId == null) {
                request.getSession().setAttribute("errors", List.of("Your session has expired. Please sign in again."));
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            switch (action) {

                // ---------- Generate payroll for ALL workers for a month ----------
                case "generate" -> {
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
                }

                // ---------- Generate payroll for a SINGLE worker ----------
                case "generate-single" -> {
                    int workerId = Integer.parseInt(request.getParameter("workerId"));
                    String monthYear = request.getParameter("monthYear");
                    List<String> errors = payrollService.generateSinglePayroll(
                            workerId, monthYear, adminId);

                    if (!errors.isEmpty()) {
                        request.getSession().setAttribute("errors", errors);
                    } else {
                        request.getSession().setAttribute("success",
                                "Payroll generated for worker.");
                    }
                    response.sendRedirect(request.getContextPath()
                            + "/admin/payroll?action=list&my=" + monthYear);
                }

                // ---------- Mark a payroll as PAID ----------
                case "mark-paid" -> {
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
                }

                default -> response.sendRedirect(request.getContextPath() + "/admin/payroll");
            }
        } catch (IOException | RuntimeException e) {
            System.err.println("[PayrollController] POST payroll action failed.");
            e.printStackTrace(System.err);
            request.getSession().setAttribute("errors", List.of("Unable to process payroll action. Please try again."));
            response.sendRedirect(request.getContextPath() + "/admin/payroll");
        }
    }

    private Integer resolveAdminId(HttpServletRequest request) {
        Object userId = request.getSession().getAttribute("userId");
        if (userId instanceof Integer id) {
            return id;
        }

        Object userObj = request.getSession().getAttribute("user");
        if (userObj instanceof User user) {
            return user.getId();
        }
        return null;
    }

    private String normalizeMonthYear(String monthYear) {
        if (monthYear == null || monthYear.isBlank() || !monthYear.matches("\\d{4}-\\d{2}")) {
            return YearMonth.now().toString();
        }
        return monthYear;
    }
}