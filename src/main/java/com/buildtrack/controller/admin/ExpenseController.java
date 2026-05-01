package com.buildtrack.controller.admin;

import com.buildtrack.model.Expense;
import com.buildtrack.model.Project;
import com.buildtrack.service.admin.ExpenseService;
import com.buildtrack.service.admin.ProjectService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * Expense Controller — full CRUD for manual expenses.
 * GET  /admin/expenses                          → expense dashboard (overview)
 * GET  /admin/expenses?action=add               → add expense form
 * GET  /admin/expenses?action=edit&id=X         → edit expense form
 * GET  /admin/expenses?action=details&pid=X     → expense breakdown per project
 * GET  /admin/expenses?action=recent            → recent entries across all projects
 * POST /admin/expenses?action=create             → create expense
 * POST /admin/expenses?action=update             → update expense
 * POST /admin/expenses?action=delete&id=X        → delete expense
 */
@WebServlet("/admin/expenses")
public class ExpenseController extends HttpServlet {

    private final ExpenseService expenseService = new ExpenseService();
    private final ProjectService projectService = new ProjectService();

    // ==================== GET ====================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // ========== OVERVIEW ==========
            BigDecimal grandTotal = expenseService.getGrandTotal();
            List<Map<String, Object>> projectSummary = expenseService.getProjectExpenseSummary();
            List<Expense> recentExpenses = expenseService.getRecentExpenses(10);
            int totalCount = expenseService.getCount();

            request.setAttribute("grandTotal", grandTotal);
            request.setAttribute("projectSummary", projectSummary);
            request.setAttribute("recentExpenses", recentExpenses);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("categories", expenseService.getValidCategories());

            request.getRequestDispatcher("/WEB-INF/views/admin/expenses.jsp")
                    .forward(request, response);
            return;
        }

        switch (action) {

            case "add": {
                // ========== ADD FORM ==========
                request.setAttribute("projects", projectService.getAllProjects());
                request.setAttribute("categories", expenseService.getValidCategories());
                request.getRequestDispatcher("/WEB-INF/views/admin/expense-add.jsp")
                        .forward(request, response);
                break;
            }

            case "edit": {
                // ========== EDIT FORM ==========
                int id = Integer.parseInt(request.getParameter("id"));
                Expense expense = expenseService.getById(id);
                if (expense == null) { response.sendError(404, "Expense not found"); return; }

                request.setAttribute("expense", expense);
                request.setAttribute("projects", projectService.getAllProjects());
                request.setAttribute("categories", expenseService.getValidCategories());
                request.getRequestDispatcher("/WEB-INF/views/admin/expense-add.jsp")
                        .forward(request, response);
                break;
            }

            case "details": {
                // ========== PROJECT EXPENSE BREAKDOWN ==========
                int projectId = Integer.parseInt(request.getParameter("pid"));
                Project project = projectService.getProjectById(projectId);
                if (project == null) { response.sendError(404, "Project not found"); return; }

                String dateFrom = request.getParameter("from");
                String dateTo = request.getParameter("to");

                List<Expense> expenseList;
                if (dateFrom != null && !dateFrom.isEmpty()
                        || dateTo != null && !dateTo.isEmpty()) {
                    expenseList = expenseService.getExpensesByProjectAndDateRange(
                            projectId, dateFrom, dateTo);
                } else {
                    expenseList = expenseService.getExpensesByProject(projectId);
                }

                BigDecimal projectTotal = expenseService.getTotalByProject(projectId);
                List<Map<String, Object>> categoryBreakdown =
                        expenseService.getCategoryBreakdown(projectId);

                request.setAttribute("project", project);
                request.setAttribute("expenseList", expenseList);
                request.setAttribute("projectTotal", projectTotal);
                request.setAttribute("categoryBreakdown", categoryBreakdown);
                request.setAttribute("dateFrom", dateFrom);
                request.setAttribute("dateTo", dateTo);

                request.getRequestDispatcher("/WEB-INF/views/admin/expense-details.jsp")
                        .forward(request, response);
                break;
            }

            case "recent": {
                // ========== RECENT (all projects) ==========
                List<Expense> allRecent = expenseService.getRecentExpenses(50);
                BigDecimal recentTotal = BigDecimal.ZERO;
                for (Expense e : allRecent) {
                    if (e.getAmount() != null) recentTotal = recentTotal.add(e.getAmount());
                }

                request.setAttribute("recentExpenses", allRecent);
                request.setAttribute("recentTotal", recentTotal);
                request.getRequestDispatcher("/WEB-INF/views/admin/expenses.jsp")
                        .forward(request, response);
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/expenses");
        }
    }

    // ==================== POST ====================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/expenses");
            return;
        }

        int adminId = (int) request.getSession().getAttribute("userId");

        switch (action) {

            case "create": {
                // ========== CREATE ==========
                List<String> errors = expenseService.createExpense(
                        request.getParameter("projectId"),
                        request.getParameter("category"),
                        request.getParameter("description"),
                        request.getParameter("amount"),
                        request.getParameter("expenseDate"),
                        adminId
                );

                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    preserveForm(request);
                    request.setAttribute("projects", projectService.getAllProjects());
                    request.setAttribute("categories", expenseService.getValidCategories());
                    request.getRequestDispatcher("/WEB-INF/views/admin/expense-add.jsp")
                            .forward(request, response);
                } else {
                    request.getSession().setAttribute("success",
                            "Expense added successfully.");
                    response.sendRedirect(request.getContextPath()
                            + "/admin/expenses");
                }
                break;
            }

            case "update": {
                // ========== UPDATE ==========
                int id = Integer.parseInt(request.getParameter("id"));
                List<String> errors = expenseService.updateExpense(
                        id,
                        request.getParameter("projectId"),
                        request.getParameter("category"),
                        request.getParameter("description"),
                        request.getParameter("amount"),
                        request.getParameter("expenseDate")
                );

                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    request.setAttribute("expense", expenseService.getById(id));
                    request.setAttribute("projects", projectService.getAllProjects());
                    request.setAttribute("categories", expenseService.getValidCategories());
                    request.getRequestDispatcher("/WEB-INF/views/admin/expense-add.jsp")
                            .forward(request, response);
                } else {
                    request.getSession().setAttribute("success",
                            "Expense updated successfully.");
                    response.sendRedirect(request.getContextPath()
                            + "/admin/expenses");
                }
                break;
            }

            case "delete": {
                // ========== DELETE ==========
                int id = Integer.parseInt(request.getParameter("id"));
                List<String> errors = expenseService.deleteExpense(id);

                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "Expense deleted successfully.");
                }

                String redirectPid = request.getParameter("pid");
                if (redirectPid != null && !redirectPid.isEmpty()) {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/expenses?action=details&pid=" + redirectPid);
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/expenses");
                }
                break;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/admin/expenses");
        }
    }

    // ==================== Helper ====================

    private void preserveForm(HttpServletRequest request) {
        request.setAttribute("f_projectId", request.getParameter("projectId"));
        request.setAttribute("f_category", request.getParameter("category"));
        request.setAttribute("f_description", request.getParameter("description"));
        request.setAttribute("f_amount", request.getParameter("amount"));
        request.setAttribute("f_expenseDate", request.getParameter("expenseDate"));
    }
}