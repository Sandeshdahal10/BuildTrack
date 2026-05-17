package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Material catalog entry with pricing and stock levels.
 */
public class Material {

    private int id;
    private String name;
    private String unit; // kg, bags, pieces, m3, etc.
    private BigDecimal unitPrice;
    private BigDecimal totalStock;
    private BigDecimal lowStockThreshold;
    private String description;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Integer projectId;
    private String projectName;

    /**
     * Creates an empty material instance.
     */
    public Material() {
    }

    /**
     * Creates a populated material instance.
     *
     * @param name              material name
     * @param unit              unit of measure
     * @param unitPrice         price per unit
     * @param totalStock        total stock on hand
     * @param lowStockThreshold threshold for low stock alerts
     * @param description       optional description
     */
    public Material(String name, String unit, BigDecimal unitPrice,
            BigDecimal totalStock, BigDecimal lowStockThreshold, String description) {
        this.name = name;
        this.unit = unit;
        this.unitPrice = unitPrice;
        this.totalStock = totalStock;
        this.lowStockThreshold = lowStockThreshold;
        this.description = description;
    }

    // Getters and Setters

    /**
     * Returns the material id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the material id.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the material name.
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the material name.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Returns the unit of measure.
     */
    public String getUnit() {
        return unit;
    }

    /**
     * Sets the unit of measure.
     */
    public void setUnit(String unit) {
        this.unit = unit;
    }

    /**
     * Returns the unit price.
     */
    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    /**
     * Sets the unit price.
     */
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    /**
     * Returns the total stock value.
     */
    public BigDecimal getTotalStock() {
        return totalStock;
    }

    /**
     * Sets the total stock value.
     */
    public void setTotalStock(BigDecimal totalStock) {
        this.totalStock = totalStock;
    }

    /**
     * Returns the low stock threshold.
     */
    public BigDecimal getLowStockThreshold() {
        return lowStockThreshold;
    }

    /**
     * Sets the low stock threshold.
     */
    public void setLowStockThreshold(BigDecimal lowStockThreshold) {
        this.lowStockThreshold = lowStockThreshold;
    }

    /**
     * Returns the material description.
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the material description.
     */
    public void setDescription(String description) {
        this.description = description;
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

    /**
     * Returns true if total stock is at or below the low stock threshold.
     */
    public boolean isLowStock() {
        if (totalStock == null || lowStockThreshold == null)
            return false;
        return totalStock.compareTo(lowStockThreshold) <= 0;
    }

    /**
     * Returns true if total stock is zero or below.
     */
    public boolean isOutOfStock() {
        return totalStock != null && totalStock.compareTo(BigDecimal.ZERO) <= 0;
    }

    public Integer getProjectId() {
        return projectId;
    }

    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
}