package com.buildtrack.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Project entity with scheduling, budget, and status details.
 */
public class Project {
    private int id;
    private String title;
    private String description;
    private Integer clientId;
    private Date startDate;
    private Date endDate;
    private BigDecimal totalBudget;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // For displaying only in UI
    private String ClientName;
    private int assignedWorkerCount;
    private BigDecimal actualCost; // sum of material use * total cost

    /**
     * Creates an empty project instance.
     */
    public Project() {
    }

    /**
     * Creates a populated project instance.
     *
     * @param title       project title
     * @param description project description
     * @param clientId    client identifier
     * @param startDate   planned start date
     * @param endDate     planned end date
     * @param totalBudget total project budget
     * @param status      project status
     */
    public Project(String title, String description, Integer clientId, Date startDate, Date endDate,
            BigDecimal totalBudget, String status) {
        this.title = title;
        this.description = description;
        this.clientId = clientId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalBudget = totalBudget;
        this.status = status;
    }

    // Getter and Setters Method

    /**
     * Returns the project id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the project id.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the project title.
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the project title.
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Returns the project status.
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the project status.
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Returns the project description.
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the project description.
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Returns the client id.
     */
    public Integer getClientId() {
        return clientId;
    }

    /**
     * Sets the client id.
     */
    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }

    /**
     * Returns the start date.
     */
    public Date getStartDate() {
        return startDate;
    }

    /**
     * Sets the start date.
     */
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    /**
     * Returns the end date.
     */
    public Date getEndDate() {
        return endDate;
    }

    /**
     * Sets the end date.
     */
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    /**
     * Returns the total budget.
     */
    public BigDecimal getTotalBudget() {
        return totalBudget;
    }

    /**
     * Sets the total budget.
     */
    public void setTotalBudget(BigDecimal totalBudget) {
        this.totalBudget = totalBudget;
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

    // UI displaying getter setter

    /**
     * Returns the client name for display.
     */
    public String getClientName() {
        return ClientName;
    }

    /**
     * Sets the client name for display.
     */
    public void setClientName(String clientName) {
        ClientName = clientName;
    }

    /**
     * Returns the assigned worker count.
     */
    public int getAssignedWorkerCount() {
        return assignedWorkerCount;
    }

    /**
     * Sets the assigned worker count.
     */
    public void setAssignedWorkerCount(int assignedWorkerCount) {
        this.assignedWorkerCount = assignedWorkerCount;
    }

    /**
     * Returns the actual cost.
     */
    public BigDecimal getActualCost() {
        return actualCost;
    }

    /**
     * Sets the actual cost.
     */
    public void setActualCost(BigDecimal actualCost) {
        this.actualCost = actualCost;
    }

    /**
     * Returns a display-friendly status name.
     */
    public String getStatusDisplayName() {
        if (status == null)
            return "Unknown";
        return switch (status) {
            case "PLANNED" -> "Planned";
            case "IN_PROGRESS" -> "In Progress";
            case "COMPLETED" -> "Completed";
            case "ON_HOLD" -> "On Hold";
            default -> status;
        };
    }

    /**
     * Returns a CSS class name for the status badge.
     */
    public String getStatusBadgeClass() {
        if (status == null)
            return "bg-stone-100 text-stone-700";
        return switch (status) {
            case "PLANNED" -> "bg-blue-100 text-blue-700";
            case "IN_PROGRESS" -> "bg-amber-100 text-amber-700";
            case "COMPLETED" -> "bg-green-100 text-green-700";
            case "ON_HOLD" -> "bg-red-100 text-red-700";
            default -> "bg-stone-100 text-stone-700";
        };
    }

    /**
     * Returns remaining budget based on actual cost.
     */
    public BigDecimal getRemainingBudget() {
        if (totalBudget == null)
            return BigDecimal.ZERO;
        if (actualCost == null)
            return totalBudget;
        return totalBudget.subtract(actualCost);
    }

    /**
     * Returns the budget usage percentage.
     */
    public double getBudgetUsagePercent() {
        if (totalBudget == null || totalBudget.compareTo(BigDecimal.ZERO) == 0)
            return 0;
        if (actualCost == null)
            return 0;
        return actualCost.multiply(BigDecimal.valueOf(100))
                .divide(totalBudget, 1, RoundingMode.HALF_UP).doubleValue();
    }
}
