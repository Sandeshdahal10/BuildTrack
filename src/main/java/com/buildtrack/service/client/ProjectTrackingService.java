package com.buildtrack.service.client;

import com.buildtrack.dao.client.ProjectTrackingDao;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.model.Project;

import java.util.List;
import java.util.Map;

/**
 * Service layer for client-side project tracking views.
 */
public class ProjectTrackingService {

    private final ProjectTrackingDao projectTrackingDAO = new ProjectTrackingDao();

    /**
     * Returns project overview if the project belongs to the client.
     */
    public Project getProjectOverviewForClient(int projectId, int clientId) {
        return projectTrackingDAO.findProjectForClient(projectId, clientId);
    }

    /**
     * Returns material usage for a project.
     */
    public List<MaterialUsage> getMaterialUsageForProject(int projectId) {
        return projectTrackingDAO.findMaterialUsageForProject(projectId);
    }

    /**
     * Returns manual expenses for a project.
     */
    public List<Map<String, Object>> getExpensesForProject(int projectId) {
        return projectTrackingDAO.findExpensesForProject(projectId);
    }

    /**
     * Returns approximate time progress percent for a project.
     */
    public int getTimeProgressPercent(int projectId) {
        return projectTrackingDAO.getTimeProgressPercent(projectId);
    }
}
