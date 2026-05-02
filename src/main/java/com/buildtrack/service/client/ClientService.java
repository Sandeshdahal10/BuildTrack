package com.buildtrack.service.client;

import com.buildtrack.dao.client.ClientDao;
import com.buildtrack.model.Project;
import com.buildtrack.model.User;
import com.buildtrack.util.ValidationUtil;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ClientService {

	private final ClientDao clientDAO = new ClientDao();
	private final ProjectTrackingService projectTrackingService = new ProjectTrackingService();

	// Client profile

	public User getClientById(int id) {
		return clientDAO.findById(id);
	}

	public List<String> updateProfile(int id, String fullName, String phone) {
		List<String> errors = new ArrayList<>();

		if (ValidationUtil.isEmpty(fullName)) {
			errors.add("Full name is required.");
		}
		if (ValidationUtil.isEmpty(phone)) {
			errors.add("Phone is required.");
		}
		if (!errors.isEmpty()) {
			return errors;
		}

		if (!clientDAO.updateProfile(id, fullName.trim(), phone.trim())) {
			errors.add("Failed to update profile.");
		}
		return errors;
	}

	// Projects and budget

	public List<Project> getProjectsByClientId(int clientId) {
		return clientDAO.findProjectsByClientId(clientId);
	}

	public int countProjects(int clientId) {
		return clientDAO.countProjects(clientId);
	}

	public BigDecimal getTotalBudgetForClient(int clientId) {
		return clientDAO.totalBudgetForClient(clientId);
	}

	public Map<String, Object> getDashboardSummary(int clientId) {
		List<Project> projects = getProjectsByClientId(clientId);
		Map<String, Object> summary = new LinkedHashMap<>();

		BigDecimal totalBudget = BigDecimal.ZERO;
		BigDecimal totalSpent = BigDecimal.ZERO;
		int activeProjects = 0;

		for (Project project : projects) {
			if (project.getTotalBudget() != null) {
				totalBudget = totalBudget.add(project.getTotalBudget());
			}

			Project tracked = projectTrackingService.getProjectOverviewForClient(project.getId(), clientId);
			if (tracked != null && tracked.getActualCost() != null) {
				totalSpent = totalSpent.add(tracked.getActualCost());
			}

			String status = project.getStatus();
			if ("IN_PROGRESS".equalsIgnoreCase(status)) {
				activeProjects++;
			}
		}

		BigDecimal remainingBudget = totalBudget.subtract(totalSpent);
		BigDecimal utilizationPercent = BigDecimal.ZERO;
		if (totalBudget.compareTo(BigDecimal.ZERO) > 0) {
			utilizationPercent = totalSpent.multiply(BigDecimal.valueOf(100))
					.divide(totalBudget, 1, RoundingMode.HALF_UP);
		}

		summary.put("projects", projects);
		summary.put("totalProjects", projects.size());
		summary.put("activeProjects", activeProjects);
		summary.put("totalBudget", totalBudget);
		summary.put("totalSpent", totalSpent);
		summary.put("remainingBudget", remainingBudget);
		summary.put("utilizationPercent", utilizationPercent);
		return summary;
	}
}
