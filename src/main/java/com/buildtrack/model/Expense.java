package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Expense model — represents a manual/non-material expense
 * logged by admin (transport, rent, permits, utilities, etc.).
 */
public class Expense {

    private int id;
    private int projectId;
    private String category;
    private String description;
    private BigDecimal amount;
    private Date expenseDate;
    private int recordedBy;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Transient display fields (populated by JOINs)
    private String projectName;
    private String recordedByName;

    // ---------- Constructor ----------

    /**
     * Creates an empty expense instance.
     */
    public Expense() {
    }

    /**
     * Creates a populated expense instance.
     *
     * @param projectId   project identifier
     * @param category    expense category
     * @param description description or notes
     * @param amount      expense amount
     * @param expenseDate date of the expense
     * @param recordedBy  admin id who recorded the expense
     */
    public Expense(int projectId, String category, String description,
            BigDecimal amount, Date expenseDate, int recordedBy) {
        this.projectId = projectId;
        this.category = category;
        this.description = description;
        this.amount = amount;
        this.expenseDate = expenseDate;
        this.recordedBy = recordedBy;
    }

    // ---------- Getters & Setters ----------

    /**
     * Returns the expense id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the expense id.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the related project id.
     */
    public int getProjectId() {
        return projectId;
    }

    /**
     * Sets the related project id.
     */
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    /**
     * Returns the expense category.
     */
    public String getCategory() {
        return category;
    }

    /**
     * Sets the expense category.
     */
    public void setCategory(String category) {
        this.category = category;
    }

    /**
     * Returns the expense description.
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the expense description.
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Returns the expense amount.
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * Sets the expense amount.
     */
    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    /**
     * Returns the expense date.
     */
    public Date getExpenseDate() {
        return expenseDate;
    }

    /**
     * Sets the expense date.
     */
    public void setExpenseDate(Date expenseDate) {
        this.expenseDate = expenseDate;
    }

    /**
     * Returns the admin id who recorded the expense.
     */
    public int getRecordedBy() {
        return recordedBy;
    }

    /**
     * Sets the admin id who recorded the expense.
     */
    public void setRecordedBy(int recordedBy) {
        this.recordedBy = recordedBy;
    }

    /**
     * Returns the creation timestamp.
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets the creation timestamp.
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Returns the last update timestamp.
     */
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    /**
     * Sets the last update timestamp.
     */
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Transient

    /**
     * Returns the project name for display.
     */
    public String getProjectName() {
        return projectName;
    }

    /**
     * Sets the project name for display.
     */
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    /**
     * Returns the recorder name for display.
     */
    public String getRecordedByName() {
        return recordedByName;
    }

    /**
     * Sets the recorder name for display.
     */
    public void setRecordedByName(String recordedByName) {
        this.recordedByName = recordedByName;
    }

    // ---------- Display Helpers ----------

    /**
     * Returns a CSS class name for the category badge.
     */
    public String getCategoryBadgeClass() {
        if (category == null)
            return "bg-stone-100 text-stone-700";
        switch (category.toLowerCase()) {
            case "transport":
                return "bg-blue-100 text-blue-700";
            case "rent":
                return "bg-purple-100 text-purple-700";
            case "permits":
                return "bg-green-100 text-green-700";
            case "utilities":
                return "bg-cyan-100 text-cyan-700";
            case "equipment":
                return "bg-amber-100 text-amber-700";
            default:
                return "bg-stone-100 text-stone-700";
        }
    }
}