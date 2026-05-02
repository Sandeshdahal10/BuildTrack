package com.buildtrack.service.client;

import com.buildtrack.dao.client.ProjectTrackingDao;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.model.Project;

import java.util.List;
import java.util.Map;

public class ProjectTrackingService {

    private final ProjectTrackingDao projectTrackingDAO = new ProjectTrackingDao();

    public Project getProjectOverviewForClient(int projectId, int clientId) {
        return projectTrackingDAO.findProjectForClient(projectId, clientId);
    }

    public List<MaterialUsage> getMaterialUsageForProject(int projectId) {
        return projectTrackingDAO.findMaterialUsageForProject(projectId);
    }

    public List<Map<String, Object>> getExpensesForProject(int projectId) {
        return projectTrackingDAO.findExpensesForProject(projectId);
    }

    public int getTimeProgressPercent(int projectId) {
        return projectTrackingDAO.getTimeProgressPercent(projectId);
    }
}
