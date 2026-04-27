package com.buildtrack.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Date;
import java.sql.Timestamp;

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

    public Project() {
    }

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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getClientId() {
        return clientId;
    }

    public void setClientId(Integer clientId) {
        this.clientId = clientId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public BigDecimal getTotalBudget() {
        return totalBudget;
    }

    public void setTotalBudget(BigDecimal totalBudget) {
        this.totalBudget = totalBudget;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // UI displaying getter setter

    public String getClientName() {
        return ClientName;
    }

    public void setClientName(String clientName) {
        ClientName = clientName;
    }

    public int getAssignedWorkerCount() {
        return assignedWorkerCount;
    }

    public void setAssignedWorkerCount(int assignedWorkerCount) {
        this.assignedWorkerCount = assignedWorkerCount;
    }

    public BigDecimal getActualCost() {
        return actualCost;
    }

    public void setActualCost(BigDecimal actualCost) {
        this.actualCost = actualCost;
    }

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

    public BigDecimal getRemainingBudget() {
        if (totalBudget == null)
            return BigDecimal.ZERO;
        if (actualCost == null)
            return totalBudget;
        return totalBudget.subtract(actualCost);
    }

    public double getBudgetUsagePercent() {
        if (totalBudget == null || totalBudget.compareTo(BigDecimal.ZERO) == 0)
            return 0;
        if (actualCost == null)
            return 0;
        return actualCost.multiply(BigDecimal.valueOf(100))
                .divide(totalBudget, 1, RoundingMode.HALF_UP).doubleValue();
    }
}
