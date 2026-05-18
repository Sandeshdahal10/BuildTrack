package com.buildtrack.service.worker;

import com.buildtrack.dao.worker.WorkLogDao;
import com.buildtrack.model.Project;
import com.buildtrack.model.WorkLog;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Service layer for worker work logs.
 */
public class WorkLogService {

	private final WorkLogDao workLogDao = new WorkLogDao();

	public List<String> createWorkLog(int workerId, String projectIdStr, String dateStr, String description) {
		List<String> errors = new ArrayList<>();

		if (projectIdStr == null || projectIdStr.isBlank()) {
			errors.add("Project is required.");
		}
		if (dateStr == null || dateStr.isBlank()) {
			errors.add("Date is required.");
		}
		if (description == null || description.isBlank()) {
			errors.add("Description is required.");
		} else if (description.trim().length() > 1000) {
			errors.add("Description must not exceed 1000 characters.");
		}

		int projectId;
		try {
			projectId = Integer.parseInt(projectIdStr);
		} catch (Exception e) {
			errors.add("Invalid project selected.");
			return errors;
		}

		LocalDate logDate;
		try {
			logDate = LocalDate.parse(dateStr);
		} catch (Exception e) {
			errors.add("Invalid date format.");
			return errors;
		}

		if (!errors.isEmpty()) {
			return errors;
		}

		WorkLog workLog = new WorkLog();
		workLog.setWorkerId(workerId);
		workLog.setProjectId(projectId);
		workLog.setLogDate(Date.valueOf(logDate));
		workLog.setDescription(description.trim());

		if (!workLogDao.insert(workLog)) {
			errors.add("Failed to save work log.");
		}

		return errors;
	}

	public List<WorkLog> getWorkerLogs(int workerId, String monthYear) {
		return workLogDao.findByWorker(workerId, monthYear);
	}

	public List<Project> getAssignedProjects(int workerId) {
		return workLogDao.findAssignedProjects(workerId);
	}
}
