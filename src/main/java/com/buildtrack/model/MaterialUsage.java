package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * Material usage record for a project.
 */
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

    /**
     * Creates an empty usage record.
     */
    public MaterialUsage() {
    }

    /**
     * Creates a populated usage record.
     *
     * @param materialId   material identifier
     * @param projectId    project identifier
     * @param quantityUsed quantity used
     * @param unitCost     cost per unit
     * @param usageDate    date of usage
     * @param recordedBy   admin id who recorded usage
     * @param notes        optional notes
     */
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

    // Getters and Setters

    /**
     * Returns the usage id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the usage id.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the material id.
     */
    public int getMaterialId() {
        return materialId;
    }

    /**
     * Sets the material id.
     */
    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

    /**
     * Returns the project id.
     */
    public int getProjectId() {
        return projectId;
    }

    /**
     * Sets the project id.
     */
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    /**
     * Returns the quantity used.
     */
    public BigDecimal getQuantityUsed() {
        return quantityUsed;
    }

    /**
     * Sets the quantity used.
     */
    public void setQuantityUsed(BigDecimal quantityUsed) {
        this.quantityUsed = quantityUsed;
    }

    /**
     * Returns the unit cost.
     */
    public BigDecimal getUnitCost() {
        return unitCost;
    }

    /**
     * Sets the unit cost.
     */
    public void setUnitCost(BigDecimal unitCost) {
        this.unitCost = unitCost;
    }

    /**
     * Returns the total cost.
     */
    public BigDecimal getTotalCost() {
        return totalCost;
    }

    /**
     * Sets the total cost.
     */
    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }

    /**
     * Returns the usage date.
     */
    public Date getUsageDate() {
        return usageDate;
    }

    /**
     * Sets the usage date.
     */
    public void setUsageDate(Date usageDate) {
        this.usageDate = usageDate;
    }

    /**
     * Returns the recorder admin id.
     */
    public int getRecordedBy() {
        return recordedBy;
    }

    /**
     * Sets the recorder admin id.
     */
    public void setRecordedBy(int recordedBy) {
        this.recordedBy = recordedBy;
    }

    /**
     * Returns the notes.
     */
    public String getNotes() {
        return notes;
    }

    /**
     * Sets the notes.
     */
    public void setNotes(String notes) {
        this.notes = notes;
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

    // Getters setters for transient fields

    /**
     * Returns the material name for display.
     */
    public String getMaterialName() {
        return materialName;
    }

    /**
     * Sets the material name for display.
     */
    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    /**
     * Returns the material unit for display.
     */
    public String getMaterialUnit() {
        return materialUnit;
    }

    /**
     * Sets the material unit for display.
     */
    public void setMaterialUnit(String materialUnit) {
        this.materialUnit = materialUnit;
    }

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
}