package com.buildtrack.dao.admin;

import com.buildtrack.model.Project;
import com.buildtrack.model.User;
import com.buildtrack.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for project CRUD and worker assignments.
 */
public class ProjectDao {

    // CRUD Operation
    /**
     * Returns all projects ordered by creation date.
     */
    public List<Project> findAll() {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name AS client_name " +
                "FROM projects p LEFT JOIN users u ON p.client_id = u.id " +
                "ORDER BY p.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next())
                list.add(mapRow(rs, true));
        } catch (SQLException e) {
            System.err.println("Project Dao error" + e.getMessage());
        }
        return list;
    }

    /**
     * Returns all projects assigned to a specific worker with client details and worker counts.
     */
    public List<Project> findAssignedProjectsForWorker(int workerId) {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name AS client_name, " +
                "COALESCE((SELECT COUNT(*) FROM project_workers pw2 WHERE pw2.project_id = p.id AND pw2.is_active = 1),0) AS assigned_count " +
                "FROM project_workers pw " +
                "JOIN projects p ON pw.project_id = p.id " +
                "LEFT JOIN users u ON p.client_id = u.id " +
                "WHERE pw.worker_id = ? AND pw.is_active = 1 " +
                "ORDER BY p.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, workerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Project p = mapRow(rs, true);
                p.setAssignedWorkerCount(rs.getInt("assigned_count"));
                list.add(p);
            }
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] findAssignedProjectsForWorker error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Returns projects filtered by status.
     *
     * @param status project status
     * @return matching projects
     */
    public List<Project> findByStatus(String status) {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT p.*, u.full_name AS client_name " +
                "FROM projects p LEFT JOIN users u ON p.client_id = u.id " +
                "WHERE p.status = ? ORDER BY p.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
                list.add(mapRow(rs, true));
        } catch (SQLException e) {
            System.err.println("Project Dao findBy Status Error" + e.getMessage());
        }
        return list;
    }

    /**
     * Finds a project by id.
     *
     * @param id project id
     * @return project or null if not found
     */
    public Project findById(int id) {
        String sql = "SELECT p.*, u.full_name AS client_name " +
                "FROM projects p LEFT JOIN users u ON p.client_id = u.id " +
                "WHERE p.id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapRow(rs, true);
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] findById error: " + e.getMessage());
        }
        return null;
    }

    /**
     * Inserts a new project.
     *
     * @param p project to insert
     * @return generated id, or -1 if insert failed
     */
    public int insert(Project p) {
        String sql = "INSERT INTO projects (title,description,client_id,start_date,end_date,total_budget,status) " +
                "VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            if (p.getClientId() != null)
                ps.setInt(3, p.getClientId());
            else
                ps.setNull(3, Types.INTEGER);
            ps.setDate(4, p.getStartDate());
            ps.setDate(5, p.getEndDate());
            ps.setBigDecimal(6, p.getTotalBudget());
            ps.setString(7, p.getStatus());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next())
                return keys.getInt(1);
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] insert error: " + e.getMessage());
        }
        return -1;
    }

    /**
     * Updates an existing project.
     *
     * @param p project to update
     * @return true if update succeeded
     */
    public boolean update(Project p) {
        String sql = "UPDATE projects SET title=?,description=?,client_id=?,start_date=?," +
                "end_date=?,total_budget=?,status=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            if (p.getClientId() != null)
                ps.setInt(3, p.getClientId());
            else
                ps.setNull(3, Types.INTEGER);
            ps.setDate(4, p.getStartDate());
            ps.setDate(5, p.getEndDate());
            ps.setBigDecimal(6, p.getTotalBudget());
            ps.setString(7, p.getStatus());
            ps.setInt(8, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] update error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Updates the status of an existing project.
     *
     * @param id project id
     * @param status new status
     * @return true if update succeeded
     */
    public boolean updateStatus(int id, String status) {
        String sql = "UPDATE projects SET status=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] updateStatus error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Deletes a project by id.
     *
     * @param id project id
     * @return true if delete succeeded
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM projects WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] delete error: " + e.getMessage());
        }
        return false;
    }

    // Logic of Counting
    /**
     * Returns project count for a status.
     */
    public int countByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM projects WHERE status = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("ProjectDAO countByStatus error: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Returns total project count.
     */
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM projects";
        try (Connection conn = DBUtil.getConnection();
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("ProjectDAO countAll error: " + e.getMessage());
        }
        return 0;
    }

    // Worker Assignment

    /**
     * Assigns a worker to a project.
     */
    public boolean assignWorker(int projectId, int workerId, String assignedRole) {
        String sql = "INSERT INTO project_workers (project_id,worker_id,assigned_role,assigned_date,is_active) " +
                "VALUES (?,?,?,CURDATE(),1)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setInt(2, workerId);
            ps.setString(3, assignedRole);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) {
                System.err.println("[ProjectDAO] Worker already assigned to project.");
            } else {
                System.err.println("[ProjectDAO] assignWorker error: " + e.getMessage());
            }
        }
        return false;
    }

    /**
     * Removes a worker from a project.
     */
    public boolean removeWorker(int projectId, int workerId) {
        String sql = "UPDATE project_workers SET is_active=0, removed_date=CURDATE() " +
                "WHERE project_id=? AND worker_id=? AND is_active=1";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setInt(2, workerId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] removeWorker error: " + e.getMessage());
        }
        return false;
    }

    /**
     * Returns assigned workers for a project.
     */
    public List<User> findAssignedWorkers(int projectId) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT u.id, u.full_name, u.email, u.phone, u.role, u.status, u.daily_wage, " +
                "pw.assigned_role, pw.assigned_date " +
                "FROM project_workers pw JOIN users u ON pw.worker_id = u.id " +
                "WHERE pw.project_id = ? AND pw.is_active = 1 " +
                "ORDER BY pw.assigned_date DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setRole(com.buildtrack.model.Role.fromString(rs.getString("role")));
                u.setStatus(rs.getString("status"));
                u.setDailyWage(rs.getBigDecimal("daily_wage"));
                // Store assigned_role in phone temporarily — we'll use a map in controller
                list.add(u);
            }
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] findAssignedWorkers error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Returns the count of active assigned workers for a project.
     */
    public int countAssignedWorkers(int projectId) {
        String sql = "SELECT COUNT(*) FROM project_workers WHERE project_id=? AND is_active=1";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] countAssignedWorkers error: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Simple inner class for worker+role mapping.
     */
    public static class AssignedWorker {
        public com.buildtrack.model.User user;
        public String assignedRole;
        public Date assignedDate;
    }

    /**
     * Returns assigned workers with role and assignment date.
     */
    public List<AssignedWorker> findAssignedWorkersWithRole(int projectId) {
        List<AssignedWorker> list = new ArrayList<>();
        String sql = "SELECT u.id, u.full_name, u.email, u.phone, u.role, u.status, u.daily_wage, " +
                "pw.assigned_role, pw.assigned_date " +
                "FROM project_workers pw JOIN users u ON pw.worker_id = u.id " +
                "WHERE pw.project_id = ? AND pw.is_active = 1 ORDER BY pw.assigned_date DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AssignedWorker aw = new AssignedWorker();
                com.buildtrack.model.User u = new com.buildtrack.model.User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setRole(com.buildtrack.model.Role.fromString(rs.getString("role")));
                u.setStatus(rs.getString("status"));
                u.setDailyWage(rs.getBigDecimal("daily_wage"));
                aw.user = u;
                aw.assignedRole = rs.getString("assigned_role");
                aw.assignedDate = rs.getDate("assigned_date");
                list.add(aw);
            }
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] findAssignedWorkersWithRole error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Returns documents for a project.
     */
    public List<com.buildtrack.model.ProjectDocument> getDocumentsByProjectId(int projectId) {
        List<com.buildtrack.model.ProjectDocument> list = new ArrayList<>();
        String sql = "SELECT * FROM project_documents WHERE project_id = ? ORDER BY uploaded_at DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                com.buildtrack.model.ProjectDocument doc = new com.buildtrack.model.ProjectDocument();
                doc.setId(rs.getInt("id"));
                doc.setProjectId(rs.getInt("project_id"));
                doc.setClientId(rs.getInt("client_id"));
                doc.setFileName(rs.getString("file_name"));
                doc.setFilePath(rs.getString("file_path"));
                doc.setFileType(rs.getString("file_type"));
                doc.setFileSize(rs.getLong("file_size"));
                list.add(doc);
            }
        } catch (SQLException e) {
            System.err.println("[ProjectDAO] getDocumentsByProjectId error: " + e.getMessage());
        }
        return list;
    }

    /**
     * Maps a result set row to a Project.
     *
     * @param rs         result set positioned on a row
     * @param withClient whether to populate client name
     * @return mapped project
     * @throws SQLException if column access fails
     */
    private Project mapRow(ResultSet rs, boolean withClient) throws SQLException {
        Project p = new Project();
        p.setId(rs.getInt("id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        int cid = rs.getInt("client_id");
        p.setClientId(rs.wasNull() ? null : cid);
        p.setStartDate(rs.getDate("start_date"));
        p.setEndDate(rs.getDate("end_date"));
        p.setTotalBudget(rs.getBigDecimal("total_budget"));
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        if (withClient)
            p.setClientName(rs.getString("client_name"));
        return p;
    }
}
