package com.buildtrack.service.admin;

import com.buildtrack.dao.admin.ExpenseDao;
import com.buildtrack.model.Expense;
import com.buildtrack.util.ValidationUtil;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * ExpenseService — business logic for the expenses module.
 * Handles validation, CRUD delegation, and data enrichment.
 */
public class ExpenseService {

    private final ExpenseDao expenseDAO = new ExpenseDao();

    /** Allowed expense categories. */
    private static final String[] VALID_CATEGORIES = {
            "Transport", "Rent", "Permits", "Utilities", "Equipment", "Other"
    };

    // ==================== Validation ====================

    private List<String> validateExpense(String projectIdStr, String category,
                                         String amountStr, String expenseDateStr) {
        List<String> errors = new ArrayList<>();

        // Project ID
        if (ValidationUtil.isEmpty(projectIdStr)) {
            errors.add("Project is required.");
        } else {
            try { Integer.parseInt(projectIdStr); }
            catch (NumberFormatException e) { errors.add("Invalid project ID."); }
        }

        // Category
        if (ValidationUtil.isEmpty(category)) {
            errors.add("Category is required.");
        } else {
            boolean valid = false;
            for (String vc : VALID_CATEGORIES) {
                if (vc.equalsIgnoreCase(category.trim())) { valid = true; break; }
            }
            if (!valid) {
                errors.add("Invalid category. Allowed: Transport, Rent, Permits, Utilities, Equipment, Other.");
            }
        }

        // Amount
        if (ValidationUtil.isEmpty(amountStr)) {
            errors.add("Amount is required.");
        } else {
            try {
                BigDecimal amount = new BigDecimal(amountStr);
                if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                    errors.add("Amount must be greater than zero.");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid amount. Enter a valid number.");
            }
        }

        // Expense date
        if (ValidationUtil.isEmpty(expenseDateStr)) {
            errors.add("Expense date is required.");
        } else {
            try { Date.valueOf(expenseDateStr); }
            catch (IllegalArgumentException e) { errors.add("Invalid date format."); }
        }

        return errors;
    }

    // ==================== CRUD ====================

    public List<String> createExpense(String projectIdStr, String category,
                                      String description, String amountStr,
                                      String expenseDateStr, int recordedBy) {

        List<String> errors = validateExpense(projectIdStr, category,
                amountStr, expenseDateStr);
        if (!errors.isEmpty()) return errors;

        Expense expense = new Expense();
        expense.setProjectId(Integer.parseInt(projectIdStr));
        expense.setCategory(category.trim());
        expense.setDescription(description != null ? description.trim() : null);
        expense.setAmount(new BigDecimal(amountStr));
        expense.setExpenseDate(Date.valueOf(expenseDateStr));
        expense.setRecordedBy(recordedBy);

        if (expenseDAO.insert(expense) == -1) {
            errors.add("Failed to add expense. Database error.");
        }
        return errors;
    }

    public List<String> updateExpense(int id, String projectIdStr, String category,
                                      String description, String amountStr,
                                      String expenseDateStr) {

        List<String> errors = validateExpense(projectIdStr, category,
                amountStr, expenseDateStr);
        if (!errors.isEmpty()) return errors;

        Expense existing = expenseDAO.findById(id);
        if (existing == null) { errors.add("Expense not found."); return errors; }

        existing.setProjectId(Integer.parseInt(projectIdStr));
        existing.setCategory(category.trim());
        existing.setDescription(description != null ? description.trim() : null);
        existing.setAmount(new BigDecimal(amountStr));
        existing.setExpenseDate(Date.valueOf(expenseDateStr));

        if (!expenseDAO.update(existing)) {
            errors.add("Failed to update expense.");
        }
        return errors;
    }

    public List<String> deleteExpense(int id) {
        List<String> errors = new ArrayList<>();
        if (expenseDAO.findById(id) == null) {
            errors.add("Expense not found.");
            return errors;
        }
        if (!expenseDAO.delete(id)) {
            errors.add("Failed to delete expense.");
        }
        return errors;
    }

    // ==================== Read ====================

    public Expense getById(int id) {
        return expenseDAO.findById(id);
    }

    public List<Expense> getAllExpenses() {
        return expenseDAO.findAll();
    }

    public List<Expense> getExpensesByProject(int projectId) {
        return expenseDAO.findByProject(projectId);
    }

    public List<Expense> getExpensesByProjectAndDateRange(int projectId,
                                                          String dateFrom, String dateTo) {
        return expenseDAO.findByProjectAndDateRange(projectId, dateFrom, dateTo);
    }

    public List<Expense> getRecentExpenses(int limit) {
        return expenseDAO.findRecent(limit);
    }

    // ==================== Aggregates ====================

    public BigDecimal getTotalByProject(int projectId) {
        return expenseDAO.getTotalByProject(projectId);
    }

    public BigDecimal getGrandTotal() {
        return expenseDAO.getGrandTotal();
    }

    public List<Map<String, Object>> getCategoryBreakdown(int projectId) {
        return expenseDAO.getCategoryBreakdown(projectId);
    }

    public List<Map<String, Object>> getProjectExpenseSummary() {
        return expenseDAO.getProjectExpenseSummary();
    }

    public BigDecimal getTotalByProjectAndMonth(int projectId, String monthYear) {
        return expenseDAO.getTotalByProjectAndMonth(projectId, monthYear);
    }

    public int getCount() {
        return expenseDAO.countAll();
    }

    // ==================== Utility ====================

    public String[] getValidCategories() {
        return VALID_CATEGORIES;
    }
}