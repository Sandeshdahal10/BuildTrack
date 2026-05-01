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

    public Expense() {}

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

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public Date getExpenseDate() { return expenseDate; }
    public void setExpenseDate(Date expenseDate) { this.expenseDate = expenseDate; }

    public int getRecordedBy() { return recordedBy; }
    public void setRecordedBy(int recordedBy) { this.recordedBy = recordedBy; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    // Transient

    public String getProjectName() { return projectName; }
    public void setProjectName(String projectName) { this.projectName = projectName; }

    public String getRecordedByName() { return recordedByName; }
    public void setRecordedByName(String recordedByName) { this.recordedByName = recordedByName; }

    // ---------- Display Helpers ----------

    public String getCategoryBadgeClass() {
        if (category == null) return "bg-stone-100 text-stone-700";
        switch (category.toLowerCase()) {
            case "transport":  return "bg-blue-100 text-blue-700";
            case "rent":       return "bg-purple-100 text-purple-700";
            case "permits":    return "bg-green-100 text-green-700";
            case "utilities":  return "bg-cyan-100 text-cyan-700";
            case "equipment":  return "bg-amber-100 text-amber-700";
            default:           return "bg-stone-100 text-stone-700";
        }
    }
}