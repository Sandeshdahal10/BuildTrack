package com.buildtrack.service.admin;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.buildtrack.dao.admin.MaterialDao;
import com.buildtrack.model.Material;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.util.DBUtil;
import com.buildtrack.util.ValidationUtil;

/**
 * Service layer for material catalog and usage tracking.
 */
public class MaterialService {

    private final MaterialDao materialDAO = new MaterialDao();

    // Material List

    /**
     * Returns all materials.
     */
    public List<Material> getAllMaterials() {
        return materialDAO.findAll();
    }

    /**
     * Returns materials with low stock.
     */
    public List<Material> getLowStockMaterials() {
        return materialDAO.findLowStock();
    }

    /**
     * Returns a material by id.
     */
    public Material getMaterialById(int id) {
        return materialDAO.findById(id);
    }

    /**
     * Creates a new material after validation.
     */
    public List<String> createMaterial(String name, String unit, String unitPriceStr,
            String totalStockStr, String lowStockStr, String description, String projectIdStr) {
        List<String> errors = validateMaterialInput(name, unit, unitPriceStr, totalStockStr, lowStockStr);
        if (!errors.isEmpty())
            return errors;

        Material m = new Material();
        m.setName(name.trim());
        m.setUnit(unit.trim());
        m.setUnitPrice(new BigDecimal(unitPriceStr));
        m.setTotalStock(new BigDecimal(totalStockStr));
        m.setLowStockThreshold(ValidationUtil.isEmpty(lowStockStr)
                ? new BigDecimal("10")
                : new BigDecimal(lowStockStr));
        m.setDescription(description != null ? description.trim() : null);

        if (projectIdStr != null && !projectIdStr.isBlank()) {
            try {
                m.setProjectId(Integer.parseInt(projectIdStr.trim()));
            } catch (NumberFormatException ignored) {}
        }

        if (materialDAO.insert(m) == -1)
            errors.add("Failed to add material.");
        return errors;
    }

    /**
     * Updates an existing material after validation.
     */
    public List<String> updateMaterial(int id, String name, String unit, String unitPriceStr,
            String totalStockStr, String lowStockStr, String description, String projectIdStr) {
        List<String> errors = validateMaterialInput(name, unit, unitPriceStr, totalStockStr, lowStockStr);
        Material existing = materialDAO.findById(id);
        if (existing == null) {
            errors.add("Material not found.");
            return errors;
        }
        if (!errors.isEmpty())
            return errors;

        existing.setName(name.trim());
        existing.setUnit(unit.trim());
        existing.setUnitPrice(new BigDecimal(unitPriceStr));
        existing.setTotalStock(new BigDecimal(totalStockStr));
        existing.setLowStockThreshold(ValidationUtil.isEmpty(lowStockStr)
                ? new BigDecimal("10")
                : new BigDecimal(lowStockStr));
        existing.setDescription(description != null ? description.trim() : null);

        if (projectIdStr != null && !projectIdStr.isBlank()) {
            try {
                existing.setProjectId(Integer.parseInt(projectIdStr.trim()));
            } catch (NumberFormatException ignored) {}
        } else {
            existing.setProjectId(null);
        }

        if (!materialDAO.update(existing))
            errors.add("Failed to update material.");
        return errors;
    }

    /**
     * Deletes a material if it exists.
     */
    public List<String> deleteMaterial(int id) {
        List<String> errors = new ArrayList<>();
        if (materialDAO.findById(id) == null) {
            errors.add("Material not found.");
            return errors;
        }
        if (!materialDAO.delete(id))
            errors.add("Failed to delete material. It may have usage records.");
        return errors;
    }

    // Material Usage (Transactional)

    /**
     * Log material usage for a project.
     * This is TRANSACTIONAL: inserts usage record AND deducts stock.
     * Both succeed or both roll back.
     */
    public List<String> logUsage(int materialId, int projectId, String quantityStr,
            String usageDateStr, int recordedBy, String notes) {
        List<String> errors = new ArrayList<>();

        if (materialDAO.findById(materialId) == null)
            errors.add("Material not found.");
        if (ValidationUtil.isEmpty(quantityStr))
            errors.add("Quantity is required.");
        else {
            try {
                BigDecimal qty = new BigDecimal(quantityStr);
                if (qty.compareTo(BigDecimal.ZERO) <= 0)
                    errors.add("Quantity must be positive.");
            } catch (NumberFormatException e) {
                errors.add("Invalid quantity.");
            }
        }
        if (ValidationUtil.isEmpty(usageDateStr))
            errors.add("Usage date is required.");
        if (!errors.isEmpty())
            return errors;

        Material material = materialDAO.findById(materialId);
        BigDecimal quantity = new BigDecimal(quantityStr);

        if (material.getTotalStock().compareTo(quantity) < 0) {
            errors.add("Insufficient stock. Available: " + material.getTotalStock()
                    + " " + material.getUnit());
            return errors;
        }

        MaterialUsage mu = new MaterialUsage();
        mu.setMaterialId(materialId);
        mu.setProjectId(projectId);
        mu.setQuantityUsed(quantity);
        mu.setUnitCost(material.getUnitPrice()); // use current unit price
        mu.setUsageDate(Date.valueOf(usageDateStr));
        mu.setRecordedBy(recordedBy);
        mu.setNotes(notes);

        // Transactional insert
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            int usageId = materialDAO.insertUsage(conn, mu);
            if (usageId == -1)
                throw new SQLException("Failed to insert usage record.");

            boolean deducted = materialDAO.deductStock(conn, materialId, quantity);
            if (!deducted)
                throw new SQLException("Failed to deduct stock (insufficient or race condition).");

            conn.commit();
            return errors; // empty = success

        } catch (SQLException e) {
            errors.add("Failed to log material usage: " + e.getMessage());
            try {
                if (conn != null)
                    conn.rollback();
            } catch (SQLException ignored) {
            }
            return errors;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ignored) {
                }
                try {
                    conn.close();
                } catch (SQLException ignored) {
                }
            }
        }
    }

    // Usage Queries

    /**
     * Returns usage records for a project.
     */
    public List<MaterialUsage> getUsageByProject(int projectId) {
        return materialDAO.findUsageByProject(projectId);
    }

    /**
     * Returns usage summary for a project.
     */
    public List<MaterialUsage> getUsageSummaryByProject(int projectId) {
        return materialDAO.getUsageSummaryByProject(projectId);
    }

    /**
     * Returns recent usage records.
     */
    public List<MaterialUsage> getRecentUsage(int limit) {
        return materialDAO.findRecentUsage(limit);
    }

    /**
     * Returns total material usage cost for a project.
     */
    public BigDecimal getTotalCostByProject(int projectId) {
        return materialDAO.getTotalCostByProject(projectId);
    }

    /**
     * Returns total stock value across all materials.
     */
    public BigDecimal getTotalStockValue() {
        return materialDAO.getTotalStockValue();
    }

    /**
     * Returns total usage cost for the current month.
     */
    public BigDecimal getUsedCostThisMonth() {
        return materialDAO.getUsedCostThisMonth();
    }

    /**
     * Returns the current month label.
     */
    public String getCurrentMonthLabel() {
        return LocalDate.now().getMonth().name();
    }

    // Stats

    /**
     * Returns material statistics for dashboards.
     */
    public Map<String, Integer> getMaterialStats() {
        Map<String, Integer> stats = new java.util.LinkedHashMap<>();
        stats.put("totalMaterials", materialDAO.countAll());
        stats.put("lowStockCount", materialDAO.countLowStock());
        return stats;
    }

    // Private Helper

    /**
     * Validates material input fields and returns error messages.
     */
    private List<String> validateMaterialInput(String name, String unit,
            String unitPriceStr, String totalStockStr,
            String lowStockStr) {
        List<String> errors = new ArrayList<>();
        if (ValidationUtil.isEmpty(name))
            errors.add("Material name is required.");
        if (ValidationUtil.isEmpty(unit))
            errors.add("Unit is required.");
        if (ValidationUtil.isEmpty(unitPriceStr))
            errors.add("Unit price is required.");
        else {
            try {
                if (new BigDecimal(unitPriceStr).compareTo(BigDecimal.ZERO) < 0)
                    errors.add("Unit price cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid unit price.");
            }
        }
        if (ValidationUtil.isEmpty(totalStockStr))
            errors.add("Total stock is required.");
        else {
            try {
                if (new BigDecimal(totalStockStr).compareTo(BigDecimal.ZERO) < 0)
                    errors.add("Stock cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid stock quantity.");
            }
        }
        if (!ValidationUtil.isEmpty(lowStockStr)) {
            try {
                if (new BigDecimal(lowStockStr).compareTo(BigDecimal.ZERO) < 0)
                    errors.add("Low stock threshold cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid low stock threshold.");
            }
        }
        return errors;
    }
}