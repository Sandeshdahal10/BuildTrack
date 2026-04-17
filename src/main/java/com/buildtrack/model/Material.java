package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

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

    public Material() {}

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

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getUnit() {
        return unit;
    }
    public void setUnit(String unit) {
        this.unit = unit;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }
    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getTotalStock() {
        return totalStock;
    }
    public void setTotalStock(BigDecimal totalStock) {
        this.totalStock = totalStock;
    }

    public BigDecimal getLowStockThreshold() {
        return lowStockThreshold;
    }
    public void setLowStockThreshold(BigDecimal lowStockThreshold) {
        this.lowStockThreshold = lowStockThreshold;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
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



    /** True if totalStock <= lowStockThreshold. */
    public boolean isLowStock() {
        if (totalStock == null || lowStockThreshold == null) return false;
        return totalStock.compareTo(lowStockThreshold) <= 0;
    }

    /** True if totalStock <= 0. */
    public boolean isOutOfStock() {
        return totalStock != null && totalStock.compareTo(BigDecimal.ZERO) <= 0;
    }
}