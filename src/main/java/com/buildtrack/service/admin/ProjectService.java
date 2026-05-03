package com.buildtrack.service.admin;

import com.buildtrack.dao.admin.ProjectDao;
import com.buildtrack.model.Project;
import com.buildtrack.util.ValidationUtil;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Service layer for project CRUD and worker assignments.
 */
public class ProjectService {

    private final ProjectDao projectDAO = new ProjectDao();

    // List

    /**
     * Returns all projects.
     */
    public List<Project> getAllProjects() {
        return projectDAO.findAll();
    }

    /**
     * Returns projects filtered by status.
     */
    public List<Project> getProjectsByStatus(String status) {
        return projectDAO.findByStatus(status);
    }

    /**
     * Returns a project by id.
     */
    public Project getProjectById(int id) {
        return projectDAO.findById(id);
    }

    // Create

    /**
     * Creates a project after validation.
     */
    public List<String> createProject(String title, String description, String clientIdStr,
            String startDateStr, String endDateStr,
            String totalBudgetStr, String status) {
        List<String> errors = new ArrayList<>();

        if (ValidationUtil.isEmpty(title)) {
            errors.add("Project title is required.");
        } else if (title.length() > 200) {
            errors.add("Project title must not exceed 200 characters.");
        }

        if (ValidationUtil.isEmpty(startDateStr)) {
            errors.add("Start date is required.");
        }

        if (!ValidationUtil.isEmpty(endDateStr) && !ValidationUtil.isEmpty(startDateStr)) {
            try {
                Date start = Date.valueOf(startDateStr);
                Date end = Date.valueOf(endDateStr);
                if (end.before(start)) {
                    errors.add("End date cannot be before start date.");
                }
            } catch (IllegalArgumentException e) {
                errors.add("Invalid date format.");
            }
        }

        BigDecimal budget = BigDecimal.ZERO;
        if (!ValidationUtil.isEmpty(totalBudgetStr)) {
            try {
                budget = new BigDecimal(totalBudgetStr);
                if (budget.compareTo(BigDecimal.ZERO) < 0) {
                    errors.add("Budget cannot be negative.");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid budget amount.");
            }
        }

        // Validate status
        if (!ValidationUtil.isEmpty(status)) {
            if (!status.equals("PLANNED") && !status.equals("IN_PROGRESS")
                    && !status.equals("COMPLETED") && !status.equals("ON_HOLD")) {
                errors.add("Invalid project status.");
            }
        } else {
            status = "PLANNED";
        }

        if (!errors.isEmpty())
            return errors;

        Integer clientId = null;
        if (!ValidationUtil.isEmpty(clientIdStr)) {
            try {
                clientId = Integer.parseInt(clientIdStr);
            } catch (NumberFormatException e) {
                errors.add("Invalid client ID.");
                return errors;
            }
        }

        Project p = new Project();
        p.setTitle(title.trim());
        p.setDescription(description != null ? description.trim() : null);
        p.setClientId(clientId);
        p.setStartDate(Date.valueOf(startDateStr));
        p.setEndDate(ValidationUtil.isEmpty(endDateStr) ? null : Date.valueOf(endDateStr));
        p.setTotalBudget(budget);
        p.setStatus(status);

        int id = projectDAO.insert(p);
        if (id == -1)
            errors.add("Failed to create project. Database error.");
        return errors;
    }

    // Update

    /**
     * Updates a project after validation.
     */
    public List<String> updateProject(int id, String title, String description, String clientIdStr,
            String startDateStr, String endDateStr,
            String totalBudgetStr, String status) {
        List<String> errors = new ArrayList<>();

        Project existing = projectDAO.findById(id);
        if (existing == null) {
            errors.add("Project not found.");
            return errors;
        }

        if (ValidationUtil.isEmpty(title)) {
            errors.add("Project title is required.");
        } else if (title.length() > 200) {
            errors.add("Project title must not exceed 200 characters.");
        }

        if (ValidationUtil.isEmpty(startDateStr)) {
            errors.add("Start date is required.");
        }

        if (!ValidationUtil.isEmpty(endDateStr) && !ValidationUtil.isEmpty(startDateStr)) {
            try {
                Date start = Date.valueOf(startDateStr);
                Date end = Date.valueOf(endDateStr);
                if (end.before(start))
                    errors.add("End date cannot be before start date.");
            } catch (IllegalArgumentException e) {
                errors.add("Invalid date format.");
            }
        }

        BigDecimal budget = BigDecimal.ZERO;
        if (!ValidationUtil.isEmpty(totalBudgetStr)) {
            try {
                budget = new BigDecimal(totalBudgetStr);
                if (budget.compareTo(BigDecimal.ZERO) < 0)
                    errors.add("Budget cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid budget amount.");
            }
        }

        if (!ValidationUtil.isEmpty(status)) {
            if (!status.equals("PLANNED") && !status.equals("IN_PROGRESS")
                    && !status.equals("COMPLETED") && !status.equals("ON_HOLD")) {
                errors.add("Invalid project status.");
            }
        } else {
            status = existing.getStatus();
        }

        if (!errors.isEmpty())
            return errors;

        Integer clientId = null;
        if (!ValidationUtil.isEmpty(clientIdStr)) {
            try {
                clientId = Integer.parseInt(clientIdStr);
            } catch (NumberFormatException ignored) {
            }
        }

        existing.setTitle(title.trim());
        existing.setDescription(description != null ? description.trim() : null);
        existing.setClientId(clientId);
        existing.setStartDate(Date.valueOf(startDateStr));
        existing.setEndDate(ValidationUtil.isEmpty(endDateStr) ? null : Date.valueOf(endDateStr));
        existing.setTotalBudget(budget);
        existing.setStatus(status);

        if (!projectDAO.update(existing))
            errors.add("Failed to update project.");
        return errors;
    }

    // Delete

    /**
     * Deletes a project after checking existence.
     */
    public List<String> deleteProject(int id) {
        List<String> errors = new ArrayList<>();
        Project existing = projectDAO.findById(id);
        if (existing == null) {
            errors.add("Project not found.");
            return errors;
        }
        if (!projectDAO.delete(id))
            errors.add("Failed to delete project. It may have linked records.");
        return errors;
    }

    // Worker Assignment

    /**
     * Assigns a worker to a project.
     */
    public List<String> assignWorker(int projectId, int workerId, String assignedRole) {
        List<String> errors = new ArrayList<>();
        if (projectDAO.findById(projectId) == null)
            errors.add("Project not found.");
        if (ValidationUtil.isEmpty(assignedRole))
            assignedRole = "Labourer";
        if (!errors.isEmpty())
            return errors;
        if (!projectDAO.assignWorker(projectId, workerId, assignedRole)) {
            errors.add("Failed to assign worker. They may already be assigned.");
        }
        return errors;
    }

    /**
     * Removes a worker from a project.
     */
    public List<String> removeWorker(int projectId, int workerId) {
        List<String> errors = new ArrayList<>();
        if (!projectDAO.removeWorker(projectId, workerId)) {
            errors.add("Failed to remove worker from project.");
        }
        return errors;
    }

    /**
     * Returns assigned workers with roles for a project.
     */
    public List<ProjectDao.AssignedWorker> getAssignedWorkers(int projectId) {
        return projectDAO.findAssignedWorkersWithRole(projectId);
    }

    // Stats

    /**
     * Returns counts of projects by status.
     */
    public Map<String, Integer> getStatusCounts() {
        Map<String, Integer> counts = new java.util.LinkedHashMap<>();
        counts.put("total", projectDAO.countAll());
        counts.put("PLANNED", projectDAO.countByStatus("PLANNED"));
        counts.put("IN_PROGRESS", projectDAO.countByStatus("IN_PROGRESS"));
        counts.put("COMPLETED", projectDAO.countByStatus("COMPLETED"));
        counts.put("ON_HOLD", projectDAO.countByStatus("ON_HOLD"));
        return counts;
    }
}