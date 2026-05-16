package com.buildtrack.service.client;

import com.buildtrack.dao.client.ClientDao;
import com.buildtrack.model.MaterialUsage;
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
		List<String> errors = ValidationUtil.validateProfileUpdate(fullName, phone);
		if (!errors.isEmpty()) {
			return errors;
		}

		String normalizedFullName = ValidationUtil.sanitize(fullName);
		String normalizedPhone = ValidationUtil.sanitize(phone);

		if (!clientDAO.updateProfile(id, normalizedFullName, normalizedPhone)) {
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

	/**
	 * Returns the full budget overview for the client budget page.
	 */
	public Map<String, Object> getBudgetOverview(int clientId) {
		Map<String, Object> overview = new LinkedHashMap<>(getDashboardSummary(clientId));

		@SuppressWarnings("unchecked")
		List<Project> projects = (List<Project>) overview.getOrDefault("projects", new ArrayList<Project>());

		List<Map<String, Object>> budgetProjects = new ArrayList<>();
		List<Map<String, Object>> materialBreakdown = new ArrayList<>();
		List<Map<String, Object>> budgetDistribution = new ArrayList<>();
		List<String> budgetNotifications = new ArrayList<>();

		Map<String, MaterialAggregate> materialAggregates = new LinkedHashMap<>();
		Map<String, BigDecimal> expenseCategoryTotals = new LinkedHashMap<>();

		BigDecimal totalBudget = BigDecimal.ZERO;
		BigDecimal totalSpent = BigDecimal.ZERO;
		BigDecimal totalMaterialCost = BigDecimal.ZERO;
		BigDecimal totalExpenseCost = BigDecimal.ZERO;

		for (Project project : projects) {
			Project tracked = projectTrackingService.getProjectOverviewForClient(project.getId(), clientId);
			if (tracked != null) {
				project.setAssignedWorkerCount(tracked.getAssignedWorkerCount());
				project.setActualCost(tracked.getActualCost() == null ? BigDecimal.ZERO : tracked.getActualCost());
			} else if (project.getActualCost() == null) {
				project.setActualCost(BigDecimal.ZERO);
			}

			BigDecimal budget = safeAmount(project.getTotalBudget());
			BigDecimal spent = safeAmount(project.getActualCost());
			BigDecimal remaining = budget.subtract(spent);
			if (remaining.compareTo(BigDecimal.ZERO) < 0) {
				remaining = BigDecimal.ZERO;
			}

			totalBudget = totalBudget.add(budget);
			totalSpent = totalSpent.add(spent);

			List<MaterialUsage> usageList = projectTrackingService.getMaterialUsageForProject(project.getId());
			BigDecimal projectMaterialCost = BigDecimal.ZERO;
			for (MaterialUsage usage : usageList) {
				BigDecimal usageCost = safeAmount(usage.getTotalCost());
				projectMaterialCost = projectMaterialCost.add(usageCost);
				totalMaterialCost = totalMaterialCost.add(usageCost);

				String materialKey = safeText(usage.getMaterialName(), "Material") + "|" + safeText(usage.getMaterialUnit(), "unit");
				MaterialAggregate aggregate = materialAggregates.computeIfAbsent(materialKey,
						key -> new MaterialAggregate(safeText(usage.getMaterialName(), "Material"), safeText(usage.getMaterialUnit(), "unit")));
				aggregate.quantity = aggregate.quantity.add(safeAmount(usage.getQuantityUsed()));
				aggregate.totalCost = aggregate.totalCost.add(usageCost);
			}

			List<Map<String, Object>> expenses = projectTrackingService.getExpensesForProject(project.getId());
			BigDecimal projectExpenseCost = BigDecimal.ZERO;
			for (Map<String, Object> expense : expenses) {
				BigDecimal amount = safeAmount(expense.get("amount"));
				projectExpenseCost = projectExpenseCost.add(amount);
				totalExpenseCost = totalExpenseCost.add(amount);

				String category = safeText(expense.get("category"), "Uncategorized");
				expenseCategoryTotals.put(category,
						expenseCategoryTotals.getOrDefault(category, BigDecimal.ZERO).add(amount));
			}

			int timeProgress = projectTrackingService.getTimeProgressPercent(project.getId());
			double usagePercent = project.getBudgetUsagePercent();

			Map<String, Object> row = new LinkedHashMap<>();
			row.put("projectId", project.getId());
			row.put("title", safeText(project.getTitle(), "Project"));
			row.put("status", safeText(project.getStatusDisplayName(), "Unknown"));
			row.put("statusClass", project.getStatusBadgeClass());
			row.put("budget", budget);
			row.put("spent", spent);
			row.put("remaining", remaining);
			row.put("usagePercent", usagePercent);
			row.put("timeProgress", timeProgress);
			row.put("assignedWorkerCount", project.getAssignedWorkerCount());
			row.put("startDate", project.getStartDate());
			row.put("endDate", project.getEndDate());
			row.put("description", safeText(project.getDescription(), ""));
			row.put("searchText", buildSearchText(project, budget, spent, remaining, usagePercent));
			row.put("materialCost", projectMaterialCost);
			row.put("expenseCost", projectExpenseCost);
			budgetProjects.add(row);

			if (usagePercent >= 80) {
				budgetNotifications.add(safeText(project.getTitle(), "Project") + " has used " + String.format("%.0f", usagePercent) + "% of its budget.");
			}
			if (timeProgress >= 75 && "IN_PROGRESS".equalsIgnoreCase(project.getStatus())) {
				budgetNotifications.add(safeText(project.getTitle(), "Project") + " is nearing its planned timeline.");
			}
			if (remaining.compareTo(BigDecimal.ZERO) == 0 && budget.compareTo(BigDecimal.ZERO) > 0) {
				budgetNotifications.add(safeText(project.getTitle(), "Project") + " has reached its budget limit.");
			}
		}

		for (MaterialAggregate aggregate : materialAggregates.values()) {
			Map<String, Object> row = new LinkedHashMap<>();
			row.put("materialName", aggregate.materialName);
			row.put("materialUnit", aggregate.materialUnit);
			row.put("quantityUsed", aggregate.quantity);
			row.put("totalCost", aggregate.totalCost);
			materialBreakdown.add(row);
		}

		BigDecimal spentBase = totalMaterialCost.add(totalExpenseCost);
		budgetDistribution.addAll(buildBudgetSegments(totalBudget, totalMaterialCost, expenseCategoryTotals, spentBase));

		if (budgetNotifications.isEmpty()) {
			budgetNotifications.add("No budget alerts right now.");
		}

		overview.put("budgetProjects", budgetProjects);
		overview.put("materialBreakdown", materialBreakdown);
		overview.put("budgetDistribution", budgetDistribution);
		overview.put("budgetNotifications", budgetNotifications);
		overview.put("totalBudget", totalBudget);
		overview.put("totalSpent", totalSpent);
		overview.put("remainingBudget", totalBudget.subtract(totalSpent));
		overview.put("utilizationPercent", totalBudget.compareTo(BigDecimal.ZERO) > 0
				? totalSpent.multiply(BigDecimal.valueOf(100)).divide(totalBudget, 1, RoundingMode.HALF_UP)
				: BigDecimal.ZERO);
		overview.put("materialTotalCost", totalMaterialCost);
		overview.put("expenseTotalCost", totalExpenseCost);
		return overview;
	}

	private List<Map<String, Object>> buildBudgetSegments(BigDecimal totalBudget, BigDecimal materialTotal,
			Map<String, BigDecimal> expenseCategoryTotals, BigDecimal spentBase) {
		List<Map<String, Object>> segments = new ArrayList<>();
		BigDecimal budget = safeAmount(totalBudget);
		if (budget.compareTo(BigDecimal.ZERO) <= 0) {
			return segments;
		}

		addSegment(segments, "Material Usage", materialTotal, budget, "#f59e0b");

		List<Map.Entry<String, BigDecimal>> sortedExpenses = new ArrayList<>(expenseCategoryTotals.entrySet());
		sortedExpenses.sort((left, right) -> right.getValue().compareTo(left.getValue()));

		String[] palette = { "#0ea5e9", "#8b5cf6", "#14b8a6", "#ec4899", "#f97316" };
		int colorIndex = 0;
		BigDecimal otherExpenses = BigDecimal.ZERO;
		for (int i = 0; i < sortedExpenses.size(); i++) {
			Map.Entry<String, BigDecimal> entry = sortedExpenses.get(i);
			if (i < 4) {
				addSegment(segments, safeText(entry.getKey(), "Other Expenses"), entry.getValue(), budget,
						palette[colorIndex % palette.length]);
				colorIndex++;
			} else {
				otherExpenses = otherExpenses.add(entry.getValue());
			}
		}

		if (otherExpenses.compareTo(BigDecimal.ZERO) > 0) {
			addSegment(segments, "Other Expenses", otherExpenses, budget, "#64748b");
		}

		BigDecimal remaining = budget.subtract(spentBase);
		if (remaining.compareTo(BigDecimal.ZERO) > 0) {
			addSegment(segments, "Remaining Budget", remaining, budget, "#cbd5e1");
		}

		return segments;
	}

	private void addSegment(List<Map<String, Object>> segments, String label, BigDecimal amount, BigDecimal total,
			String color) {
		BigDecimal safeAmount = safeAmount(amount);
		if (safeAmount.compareTo(BigDecimal.ZERO) <= 0 || total.compareTo(BigDecimal.ZERO) <= 0) {
			return;
		}

		Map<String, Object> row = new LinkedHashMap<>();
		row.put("label", label);
		row.put("amount", safeAmount);
		row.put("percent", safeAmount.multiply(BigDecimal.valueOf(100)).divide(total, 1, RoundingMode.HALF_UP));
		row.put("color", color);
		segments.add(row);
	}

	private BigDecimal safeAmount(Object value) {
		if (value == null) {
			return BigDecimal.ZERO;
		}
		if (value instanceof BigDecimal) {
			return (BigDecimal) value;
		}
		if (value instanceof Number) {
			return BigDecimal.valueOf(((Number) value).doubleValue());
		}
		try {
			return new BigDecimal(value.toString());
		} catch (NumberFormatException ex) {
			return BigDecimal.ZERO;
		}
	}

	private String safeText(Object value, String fallback) {
		if (value == null) {
			return fallback;
		}
		String text = value.toString().trim();
		return text.isEmpty() ? fallback : text;
	}

	private String buildSearchText(Project project, BigDecimal budget, BigDecimal spent, BigDecimal remaining,
			double usagePercent) {
		return safeText(project.getTitle(), "project") + " "
				+ safeText(project.getDescription(), "") + " "
				+ safeText(project.getStatusDisplayName(), "status") + " "
				+ budget.toPlainString() + " "
				+ spent.toPlainString() + " "
				+ remaining.toPlainString() + " "
				+ String.format("%.0f", usagePercent) + "%";
	}

	private static final class MaterialAggregate {
		private final String materialName;
		private final String materialUnit;
		private BigDecimal quantity = BigDecimal.ZERO;
		private BigDecimal totalCost = BigDecimal.ZERO;

		private MaterialAggregate(String materialName, String materialUnit) {
			this.materialName = materialName;
			this.materialUnit = materialUnit;
		}
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
