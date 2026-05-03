package com.buildtrack.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Attendance record for a worker on a project for a specific date.
 */
public class Attendance {

    private int id;
    private int workerId;
    private int projectId;
    private Date attendanceDate;
    private String status; // PRESENT, ABSENT, HALF_DAY
    private String notes;
    private Integer markedBy;
    private Timestamp createdAt;

    // Transient display fields
    private String workerName;
    private String projectName;
    private String markedByName;

    /**
     * Creates an empty attendance record.
     */
    public Attendance() {
    }

    /**
     * Creates a populated attendance record.
     *
     * @param workerId       worker identifier
     * @param projectId      project identifier
     * @param attendanceDate date of attendance
     * @param status         attendance status
     * @param notes          optional notes
     * @param markedBy       admin id who marked attendance
     */
    public Attendance(int workerId, int projectId, Date attendanceDate,
            String status, String notes, Integer markedBy) {
        this.workerId = workerId;
        this.projectId = projectId;
        this.attendanceDate = attendanceDate;
        this.status = status;
        this.notes = notes;
        this.markedBy = markedBy;
    }

    // Getters & Setters

    /**
     * Returns the attendance id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the attendance id.
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Returns the worker id.
     */
    public int getWorkerId() {
        return workerId;
    }

    /**
     * Sets the worker id.
     */
    public void setWorkerId(int workerId) {
        this.workerId = workerId;
    }

    /**
     * Returns the project id.
     */
    public int getProjectId() {
        return projectId;
    }

    /**
     * Sets the project id.
     */
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    /**
     * Returns the attendance date.
     */
    public Date getAttendanceDate() {
        return attendanceDate;
    }

    /**
     * Sets the attendance date.
     */
    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    /**
     * Returns the attendance status.
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the attendance status.
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Returns the attendance notes.
     */
    public String getNotes() {
        return notes;
    }

    /**
     * Sets the attendance notes.
     */
    public void setNotes(String notes) {
        this.notes = notes;
    }

    /**
     * Returns the admin id who marked attendance.
     */
    public Integer getMarkedBy() {
        return markedBy;
    }

    /**
     * Sets the admin id who marked attendance.
     */
    public void setMarkedBy(Integer markedBy) {
        this.markedBy = markedBy;
    }

    /**
     * Returns the creation timestamp.
     */
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    /**
     * Sets the creation timestamp.
     */
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Getters and Setters for transient fields

    /**
     * Returns the worker name for display.
     */
    public String getWorkerName() {
        return workerName;
    }

    /**
     * Sets the worker name for display.
     */
    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    /**
     * Returns the project name for display.
     */
    public String getProjectName() {
        return projectName;
    }

    /**
     * Sets the project name for display.
     */
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    /**
     * Returns the marker name for display.
     */
    public String getMarkedByName() {
        return markedByName;
    }

    /**
     * Sets the marker name for display.
     */
    public void setMarkedByName(String markedByName) {
        this.markedByName = markedByName;
    }

    /**
     * Returns a user-friendly label for the attendance status.
     */
    public String getStatusDisplayName() {
        if (status == null)
            return "Unknown";
        switch (status) {
            case "PRESENT":
                return "Present";
            case "ABSENT":
                return "Absent";
            case "HALF_DAY":
                return "Half Day";
            default:
                return status;
        }
    }

    /**
     * Returns a CSS class name for the status badge.
     */
    public String getStatusBadgeClass() {
        if (status == null)
            return "bg-stone-100 text-stone-700";
        switch (status) {
            case "PRESENT":
                return "bg-green-100 text-green-700";
            case "ABSENT":
                return "bg-red-100 text-red-700";
            case "HALF_DAY":
                return "bg-amber-100 text-amber-700";
            default:
                return "bg-stone-100 text-stone-700";
        }
    }

    /**
     * Returns numeric value for payroll calculation: PRESENT=1, HALF_DAY=0.5,
     * ABSENT=0.
     */
    public double getEffectiveDays() {
        if (status == null)
            return 0;
        switch (status) {
            case "PRESENT":
                return 1.0;
            case "HALF_DAY":
                return 0.5;
            default:
                return 0.0;
        }
    }
}