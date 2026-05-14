package com.buildtrack.service.client;

import com.buildtrack.dao.client.ClientDao;
import com.buildtrack.model.Project;
import com.buildtrack.model.User;
import com.buildtrack.util.ValidationUtil;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Service layer for client profile, projects, and dashboard summary.
 */
public class ClientService {

	private final ClientDao clientDAO = new ClientDao();
	private final ProjectTrackingService projectTrackingService = new ProjectTrackingService();

	// Client profile

	/**
	 * Returns a client by id.
	 */
	public User getClientById(int id) {
		return clientDAO.findById(id);
	}

	/**
	 * Updates client profile details with validation.
	 */
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

	/**
	 * Returns projects for a client.
	 */
	public List<Project> getProjectsByClientId(int clientId) {
		return clientDAO.findProjectsByClientId(clientId);
	}

	/**
	 * Returns project count for a client.
	 */
	public int countProjects(int clientId) {
		return clientDAO.countProjects(clientId);
	}

	/**
	 * Returns total budget for a client across projects.
	 */
	public BigDecimal getTotalBudgetForClient(int clientId) {
		return clientDAO.totalBudgetForClient(clientId);
	}

	/**
	 * Returns a dashboard summary for a client.
	 */
	public Map<String, Object> getDashboardSummary(int clientId) {
		List<Project> projects = getProjectsByClientId(clientId);
		Map<String, Object> summary = new LinkedHashMap<>();
		List<Map<String, Object>> recentUpdates = new ArrayList<>();
		List<String> notifications = new ArrayList<>();

		BigDecimal totalBudget = BigDecimal.ZERO;
		BigDecimal totalSpent = BigDecimal.ZERO;
		int activeProjects = 0;

		for (Project project : projects) {
			Project tracked = projectTrackingService.getProjectOverviewForClient(project.getId(), clientId);
			if (tracked != null) {
				project.setAssignedWorkerCount(tracked.getAssignedWorkerCount());
				project.setActualCost(tracked.getActualCost() == null ? BigDecimal.ZERO : tracked.getActualCost());
			}

			if (project.getTotalBudget() != null) {
				totalBudget = totalBudget.add(project.getTotalBudget());
			}

			if (project.getActualCost() != null) {
				totalSpent = totalSpent.add(project.getActualCost());
			}

			String status = project.getStatus();
			if ("IN_PROGRESS".equalsIgnoreCase(status)) {
				activeProjects++;
			}

			String title = project.getTitle() == null ? "Project" : project.getTitle();
			recentUpdates.add(buildUpdate(
					title + " is currently " + project.getStatusDisplayName().toLowerCase() + ".",
					project.getUpdatedAt()));
			notifications.add(title + " budget used " + String.format("%.0f", project.getBudgetUsagePercent()) + "%.");
		}

		recentUpdates.sort(Comparator.comparing(
				(Map<String, Object> row) -> (Timestamp) row.get("updatedAt"),
				Comparator.nullsLast(Comparator.reverseOrder())
		));
		if (recentUpdates.size() > 4) {
			recentUpdates = new ArrayList<>(recentUpdates.subList(0, 4));
		}
		if (notifications.isEmpty()) {
			notifications.add("No new notifications.");
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
		summary.put("recentUpdates", recentUpdates);
		summary.put("notifications", notifications);
		summary.put("unreadNotificationCount", notifications.size());
		return summary;
	}

	private Map<String, Object> buildUpdate(String message, Timestamp updatedAt) {
		Map<String, Object> row = new LinkedHashMap<>();
		row.put("message", message);
		row.put("timeAgo", toTimeAgo(updatedAt));
		row.put("dotColorClass", "bg-teal-400");
		row.put("updatedAt", updatedAt);
		return row;
	}

	private String toTimeAgo(Timestamp timestamp) {
		if (timestamp == null) {
			return "Recently";
		}
		Duration duration = Duration.between(timestamp.toLocalDateTime(), LocalDateTime.now());
		long minutes = Math.max(duration.toMinutes(), 0);
		if (minutes < 60) {
			return minutes + " min ago";
		}
		long hours = duration.toHours();
		if (hours < 24) {
			return hours + " hour" + (hours == 1 ? "" : "s") + " ago";
		}
		long days = duration.toDays();
		return days + " day" + (days == 1 ? "" : "s") + " ago";
	}
}
