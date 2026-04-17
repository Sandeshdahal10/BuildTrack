package com.buildtrack.service.admin;

import com.buildtrack.dao.admin.AttendanceDao;
import com.buildtrack.model.Attendance;
import com.buildtrack.util.ValidationUtil;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class AttendanceService {

    private final AttendanceDao attendanceDAO = new AttendanceDao();

    // List

    public List<Attendance> getAttendanceByDate(String dateStr) {
        if (ValidationUtil.isEmpty(dateStr)) return new ArrayList<>();
        return attendanceDAO.findByDate(Date.valueOf(dateStr));
    }

    public List<Attendance> getAttendanceByProjectAndDate(int projectId, String dateStr) {
        if (ValidationUtil.isEmpty(dateStr)) return new ArrayList<>();
        return attendanceDAO.findByProjectAndDate(projectId, Date.valueOf(dateStr));
    }

    public List<Attendance> getWorkerHistory(int workerId, String monthYear) {
        return attendanceDAO.findByWorker(workerId, monthYear);
    }

    public boolean attendanceExists(int workerId, int projectId, String dateStr) {
        return attendanceDAO.exists(workerId, projectId, Date.valueOf(dateStr));
    }

    //Mark Attendance

    public List<String> markAttendance(int workerId, int projectId,
                                       String dateStr, String status, String notes,
                                       int markedBy) {
        List<String> errors = new ArrayList<>();

        if (ValidationUtil.isEmpty(dateStr)) errors.add("Date is required.");
        if (ValidationUtil.isEmpty(status)) errors.add("Attendance status is required.");
        else if (!status.equals("PRESENT") && !status.equals("ABSENT") && !status.equals("HALF_DAY")) {
            errors.add("Invalid attendance status.");
        }
        if (!errors.isEmpty()) return errors;

        Attendance a = new Attendance();
        a.setWorkerId(workerId);
        a.setProjectId(projectId);
        a.setAttendanceDate(Date.valueOf(dateStr));
        a.setStatus(status);
        a.setNotes(notes);
        a.setMarkedBy(markedBy);

        if (!attendanceDAO.insert(a)) errors.add("Failed to mark attendance.");
        return errors;
    }

    /** Batch mark attendance for multiple workers. Returns list of errors (one per worker). */
    public List<String> batchMarkAttendance(int projectId, String dateStr,
                                            String status, int[] workerIds,
                                            int markedBy) {
        List<String> errors = new ArrayList<>();
        if (ValidationUtil.isEmpty(dateStr)) { errors.add("Date is required."); return errors; }
        if (workerIds == null || workerIds.length == 0) { errors.add("No workers selected."); return errors; }

        for (int wid : workerIds) {
            Attendance a = new Attendance();
            a.setWorkerId(wid);
            a.setProjectId(projectId);
            a.setAttendanceDate(Date.valueOf(dateStr));
            a.setStatus(status);
            a.setMarkedBy(markedBy);
            if (!attendanceDAO.insert(a)) {
                errors.add("Failed to mark attendance for worker ID: " + wid);
            }
        }
        return errors;
    }

    // Payroll Helpers

    /** Returns [presentDays, halfDays] for a worker in a month. */
    public int[] getAttendanceCounts(int workerId, String monthYear) {
        return attendanceDAO.getAttendanceCounts(workerId, monthYear);
    }

    //Report Helpers

    public List<Attendance> getProjectWorkerSummary(int projectId, String monthYear) {
        return attendanceDAO.getProjectWorkerSummary(projectId, monthYear);
    }
}