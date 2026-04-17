package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class MaterialUsage {

    private int id;
    private int materialId;
    private int projectId;
    private BigDecimal quantityUsed;
    private BigDecimal unitCost;
    private BigDecimal totalCost;
    private Date usageDate;
    private int recordedBy;
    private String notes;
    private Timestamp createdAt;

    // Transient display fields
    private String materialName;
    private String materialUnit;
    private String projectName;
    private String recordedByName;

    public MaterialUsage() {}

    public MaterialUsage(int materialId, int projectId, BigDecimal quantityUsed,
                         BigDecimal unitCost, Date usageDate, int recordedBy, String notes) {
        this.materialId = materialId;
        this.projectId = projectId;
        this.quantityUsed = quantityUsed;
        this.unitCost = unitCost;
        this.usageDate = usageDate;
        this.recordedBy = recordedBy;
        this.notes = notes;
    }

    //Getters and Setters

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getMaterialId() {
        return materialId;
    }
    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

    public int getProjectId() {
        return projectId;
    }
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public BigDecimal getQuantityUsed() {
        return quantityUsed;
    }
    public void setQuantityUsed(BigDecimal quantityUsed) {
        this.quantityUsed = quantityUsed;
    }

    public BigDecimal getUnitCost() {
        return unitCost;
    }
    public void setUnitCost(BigDecimal unitCost) {
        this.unitCost = unitCost;
    }

    public BigDecimal getTotalCost() {
        return totalCost;
    }
    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }

    public Date getUsageDate() {
        return usageDate;
    }
    public void setUsageDate(Date usageDate) {
        this.usageDate = usageDate;
    }

    public int getRecordedBy() {
        return recordedBy;
    }
    public void setRecordedBy(int recordedBy) {
        this.recordedBy = recordedBy;
    }

    public String getNotes() {
        return notes;
    }
    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Getters setters for transient fields

    public String getMaterialName() {
        return materialName;
    }
    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public String getMaterialUnit() {
        return materialUnit;
    }
    public void setMaterialUnit(String materialUnit) {
        this.materialUnit = materialUnit;
    }

    public String getProjectName() {
        return projectName;
    }
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getRecordedByName() {
        return recordedByName;
    }
    public void setRecordedByName(String recordedByName) {
        this.recordedByName = recordedByName;
    }
}