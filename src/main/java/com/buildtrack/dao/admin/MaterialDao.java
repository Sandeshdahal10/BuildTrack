package com.buildtrack.dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.buildtrack.model.Material;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.util.DBUtil;

/**
 * DAO for material catalog and usage records.
 */
public class MaterialDao {

    // Material CRUD

    /**
     * Returns all materials ordered by name.
     */
    public List<Material> findAll() {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT m.*, p.title AS project_name FROM materials m LEFT JOIN projects p ON m.project_id = p.id ORDER BY m.name ASC";
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next())
                list.add(mapMaterial(rs));
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findAll error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Returns materials with stock at or below their low stock threshold.
     */
    public List<Material> findLowStock() {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT m.*, p.title AS project_name FROM materials m LEFT JOIN projects p ON m.project_id = p.id WHERE m.total_stock <= m.low_stock_threshold ORDER BY m.total_stock ASC";
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next())
                list.add(mapMaterial(rs));
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findLowStock error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Finds a material by id.
     *
     * @param id material id
     * @return material or null if not found
     */
    public Material findById(int id) {
        String sql = "SELECT m.*, p.title AS project_name FROM materials m LEFT JOIN projects p ON m.project_id = p.id WHERE m.id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapMaterial(rs);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findById error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Inserts a new material.
     *
     * @param m material to insert
     * @return generated id, or -1 if insert failed
     */
    public int insert(Material m) {
        String sql = "INSERT INTO materials (name,unit,unit_price,total_stock,low_stock_threshold,description,project_id) " +
                "VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getUnit());
            ps.setBigDecimal(3, m.getUnitPrice());
            ps.setBigDecimal(4, m.getTotalStock());
            ps.setBigDecimal(5, m.getLowStockThreshold());
            ps.setString(6, m.getDescription());
            if (m.getProjectId() != null) {
                ps.setInt(7, m.getProjectId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next())
                return keys.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] insert error: " + e.getMessage());
        }
        return -1;
    }

    /**
     * Updates an existing material.
     *
     * @param m material to update
     * @return true if update succeeded
     */
    public boolean update(Material m) {
        String sql = "UPDATE materials SET name=?,unit=?,unit_price=?,total_stock=?," +
                "low_stock_threshold=?,description=?,project_id=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getUnit());
            ps.setBigDecimal(3, m.getUnitPrice());
            ps.setBigDecimal(4, m.getTotalStock());
            ps.setBigDecimal(5, m.getLowStockThreshold());
            ps.setString(6, m.getDescription());
            if (m.getProjectId() != null) {
                ps.setInt(7, m.getProjectId());
            } else {
                ps.setNull(7, java.sql.Types.INTEGER);
            }
            ps.setInt(8, m.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] update error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Deletes a material by id.
     *
     * @param id material id
     * @return true if delete succeeded
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM materials WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] delete error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Returns total material count.
     */
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM materials";
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] countAll error: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Returns the count of low stock materials.
     */
    public int countLowStock() {
        String sql = "SELECT COUNT(*) FROM materials WHERE total_stock <= low_stock_threshold";
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] countLowStock error: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Returns the total stock value across all materials.
     */
    public java.math.BigDecimal getTotalStockValue() {
        String sql = "SELECT COALESCE(SUM(total_stock * unit_price), 0) FROM materials";
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] getTotalStockValue error: " + e.getMessage());
        }
        return java.math.BigDecimal.ZERO;
    }

    /**
     * Returns total usage cost for the current month.
     */
    public java.math.BigDecimal getUsedCostThisMonth() {
        String sql = "SELECT COALESCE(SUM(total_cost), 0) FROM material_usage " +
                "WHERE YEAR(usage_date) = YEAR(CURDATE()) AND MONTH(usage_date) = MONTH(CURDATE())";
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] getUsedCostThisMonth error: " + e.getMessage());
        }
        return java.math.BigDecimal.ZERO;
    }

    // Stock Update (for usage deduction)

    /**
     * Deducts stock. Accepts external connection for transactions.
     *
     * @param conn       open connection
     * @param materialId material id
     * @param quantity   quantity to deduct
     * @return true if stock was deducted
     */
    public boolean deductStock(Connection conn, int materialId, java.math.BigDecimal quantity) {
        String sql = "UPDATE materials SET total_stock = total_stock - ? WHERE id = ? AND total_stock >= ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, quantity);
            ps.setInt(2, materialId);
            ps.setBigDecimal(3, quantity);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] deductStock error: " + e.getMessage());
        }
        return false;
    }

    // Material Usage

    /**
     * Returns usage records for a project ordered by date.
     */
    public List<MaterialUsage> findUsageByProject(int projectId) {
        List<MaterialUsage> list = new ArrayList<>();
        String sql = "SELECT mu.*, m.name AS material_name, m.unit AS material_unit, " +
                "p.title AS project_name, u.full_name AS recorded_by_name " +
                "FROM material_usage mu " +
                "JOIN materials m ON mu.material_id = m.id " +
                "JOIN projects p ON mu.project_id = p.id " +
                "JOIN users u ON mu.recorded_by = u.id " +
                "WHERE mu.project_id = ? ORDER BY mu.usage_date DESC, mu.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapUsage(rs));
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findUsageByProject error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Returns recent usage records across projects.
     *
     * @param limit max rows
     */
    public List<MaterialUsage> findRecentUsage(int limit) {
        List<MaterialUsage> list = new ArrayList<>();
        String sql = "SELECT mu.*, m.name AS material_name, m.unit AS material_unit, " +
                "p.title AS project_name, u.full_name AS recorded_by_name " +
                "FROM material_usage mu " +
                "JOIN materials m ON mu.material_id = m.id " +
                "JOIN projects p ON mu.project_id = p.id " +
                "JOIN users u ON mu.recorded_by = u.id " +
                "ORDER BY mu.usage_date DESC, mu.created_at DESC LIMIT ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapUsage(rs));
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findRecentUsage error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Returns total material usage cost for a project.
     */
    public java.math.BigDecimal getTotalCostByProject(int projectId) {
        String sql = "SELECT COALESCE(SUM(total_cost),0) FROM material_usage WHERE project_id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] getTotalCostByProject error: " + e.getMessage());
        }
        return java.math.BigDecimal.ZERO;
    }

    /**
     * Inserts a usage record using the provided connection.
     *
     * @param conn open connection
     * @param mu   usage record
     * @return generated id, or -1 if insert failed
     */
    public int insertUsage(Connection conn, MaterialUsage mu) {
        String sql = "INSERT INTO material_usage (material_id,project_id,quantity_used,unit_cost,usage_date,recorded_by,notes) "
                +
                "VALUES (?,?,?,?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, mu.getMaterialId());
            ps.setInt(2, mu.getProjectId());
            ps.setBigDecimal(3, mu.getQuantityUsed());
            ps.setBigDecimal(4, mu.getUnitCost());
            ps.setDate(5, mu.getUsageDate());
            ps.setInt(6, mu.getRecordedBy());
            ps.setString(7, mu.getNotes());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next())
                return keys.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] insertUsage error: " + e.getMessage());
        }
        return -1;
    }

    /**
     * Returns usage summary per material for a project.
     */
    public List<MaterialUsage> getUsageSummaryByProject(int projectId) {
        List<MaterialUsage> list = new ArrayList<>();
        String sql = "SELECT mu.material_id, m.name AS material_name, m.unit AS material_unit, " +
                "SUM(mu.quantity_used) AS quantity_used, mu.unit_cost, SUM(mu.total_cost) AS total_cost " +
                "FROM material_usage mu JOIN materials m ON mu.material_id = m.id " +
                "WHERE mu.project_id = ? GROUP BY mu.material_id, m.name, m.unit, mu.unit_cost " +
                "ORDER BY total_cost DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                MaterialUsage mu = new MaterialUsage();
                mu.setMaterialId(rs.getInt("material_id"));
                mu.setMaterialName(rs.getString("material_name"));
                mu.setMaterialUnit(rs.getString("material_unit"));
                mu.setQuantityUsed(rs.getBigDecimal("quantity_used"));
                mu.setUnitCost(rs.getBigDecimal("unit_cost"));
                mu.setTotalCost(rs.getBigDecimal("total_cost"));
                list.add(mu);
            }
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] getUsageSummaryByProject error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Maps a result set row to a Material.
     *
     * @param rs result set positioned on a row
     * @return mapped material
     * @throws SQLException if column access fails
     */
    private Material mapMaterial(ResultSet rs) throws SQLException {
        Material m = new Material();
        m.setId(rs.getInt("id"));
        m.setName(rs.getString("name"));
        m.setUnit(rs.getString("unit"));
        m.setUnitPrice(rs.getBigDecimal("unit_price"));
        m.setTotalStock(rs.getBigDecimal("total_stock"));
        m.setLowStockThreshold(rs.getBigDecimal("low_stock_threshold"));
        m.setDescription(rs.getString("description"));
        m.setCreatedAt(rs.getTimestamp("created_at"));
        m.setUpdatedAt(rs.getTimestamp("updated_at"));
        m.setProjectId(rs.getObject("project_id") != null ? rs.getInt("project_id") : null);
        try {
            m.setProjectName(rs.getString("project_name"));
        } catch (SQLException ignored) {}
        return m;
    }

    /**
     * Maps a result set row to a MaterialUsage.
     *
     * @param rs result set positioned on a row
     * @return mapped usage record
     * @throws SQLException if column access fails
     */
    private MaterialUsage mapUsage(ResultSet rs) throws SQLException {
        MaterialUsage mu = new MaterialUsage();
        mu.setId(rs.getInt("id"));
        mu.setMaterialId(rs.getInt("material_id"));
        mu.setProjectId(rs.getInt("project_id"));
        mu.setQuantityUsed(rs.getBigDecimal("quantity_used"));
        mu.setUnitCost(rs.getBigDecimal("unit_cost"));
        mu.setTotalCost(rs.getBigDecimal("total_cost"));
        mu.setUsageDate(rs.getDate("usage_date"));
        mu.setRecordedBy(rs.getInt("recorded_by"));
        mu.setNotes(rs.getString("notes"));
        mu.setCreatedAt(rs.getTimestamp("created_at"));
        mu.setMaterialName(rs.getString("material_name"));
        mu.setMaterialUnit(rs.getString("material_unit"));
        mu.setProjectName(rs.getString("project_name"));
        mu.setRecordedByName(rs.getString("recorded_by_name"));
        return mu;
    }
}