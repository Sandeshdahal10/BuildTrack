package com.buildtrack.dao.admin;

import com.buildtrack.model.Material;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialDao {

    // Material CRUD

    public List<Material> findAll() {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT * FROM materials ORDER BY name ASC";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapMaterial(rs));
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findAll error: " + e.getMessage());
        }
        return list;
    }

    public List<Material> findLowStock() {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT * FROM materials WHERE total_stock <= low_stock_threshold ORDER BY total_stock ASC";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapMaterial(rs));
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findLowStock error: " + e.getMessage());
        }
        return list;
    }

    public Material findById(int id) {
        String sql = "SELECT * FROM materials WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapMaterial(rs);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findById error: " + e.getMessage());
        }
        return null;
    }

    public int insert(Material m) {
        String sql = "INSERT INTO materials (name,unit,unit_price,total_stock,low_stock_threshold,description) " +
                "VALUES (?,?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getUnit());
            ps.setBigDecimal(3, m.getUnitPrice());
            ps.setBigDecimal(4, m.getTotalStock());
            ps.setBigDecimal(5, m.getLowStockThreshold());
            ps.setString(6, m.getDescription());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] insert error: " + e.getMessage());
        }
        return -1;
    }

    public boolean update(Material m) {
        String sql = "UPDATE materials SET name=?,unit=?,unit_price=?,total_stock=?," +
                "low_stock_threshold=?,description=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, m.getName());
            ps.setString(2, m.getUnit());
            ps.setBigDecimal(3, m.getUnitPrice());
            ps.setBigDecimal(4, m.getTotalStock());
            ps.setBigDecimal(5, m.getLowStockThreshold());
            ps.setString(6, m.getDescription());
            ps.setInt(7, m.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] update error: " + e.getMessage());
        }
        return false;
    }

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

    public int countAll() {
        String sql = "SELECT COUNT(*) FROM materials";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] countAll error: " + e.getMessage());
        }
        return 0;
    }

    public int countLowStock() {
        String sql = "SELECT COUNT(*) FROM materials WHERE total_stock <= low_stock_threshold";
        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] countLowStock error: " + e.getMessage());
        }
        return 0;
    }

    //  Stock Update (for usage deduction)

    /** Deduct stock. Accepts external connection for transactions. */
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

    //Material Usage

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
            while (rs.next()) list.add(mapUsage(rs));
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] findUsageByProject error: " + e.getMessage());
        }
        return list;
    }

    public java.math.BigDecimal getTotalCostByProject(int projectId) {
        String sql = "SELECT COALESCE(SUM(total_cost),0) FROM material_usage WHERE project_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] getTotalCostByProject error: " + e.getMessage());
        }
        return java.math.BigDecimal.ZERO;
    }

    /** Insert usage record. Accepts external connection for transactions. */
    public int insertUsage(Connection conn, MaterialUsage mu) {
        String sql = "INSERT INTO material_usage (material_id,project_id,quantity_used,unit_cost,usage_date,recorded_by,notes) " +
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
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) {
            System.err.println("[MaterialDAO] insertUsage error: " + e.getMessage());
        }
        return -1;
    }

    /** Usage summary per material for a project (for reports). */
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
        return m;
    }

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