package com.buildtrack.model;

import java.sql.Date;
import java.sql.Timestamp;

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

    public Attendance() {}

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

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getWorkerId() {
        return workerId;
    }
    public void setWorkerId(int workerId) {
        this.workerId = workerId;
    }

    public int getProjectId() {
        return projectId;
    }
    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public Date getAttendanceDate() {
        return attendanceDate;
    }
    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }
    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Integer getMarkedBy() {
        return markedBy;
    }
    public void setMarkedBy(Integer markedBy) {
        this.markedBy = markedBy;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Getters and Setters for transient fields

    public String getWorkerName() {
        return workerName;
    }
    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public String getProjectName() {
        return projectName;
    }
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getMarkedByName() {
        return markedByName;
    }
    public void setMarkedByName(String markedByName) {
        this.markedByName = markedByName;
    }



    public String getStatusDisplayName() {
        if (status == null) return "Unknown";
        switch (status) {
            case "PRESENT":  return "Present";
            case "ABSENT":   return "Absent";
            case "HALF_DAY": return "Half Day";
            default:         return status;
        }
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-stone-100 text-stone-700";
        switch (status) {
            case "PRESENT":  return "bg-green-100 text-green-700";
            case "ABSENT":   return "bg-red-100 text-red-700";
            case "HALF_DAY": return "bg-amber-100 text-amber-700";
            default:         return "bg-stone-100 text-stone-700";
        }
    }

    /** Returns numeric value for payroll calculation: PRESENT=1, HALF_DAY=0.5, ABSENT=0. */
    public double getEffectiveDays() {
        if (status == null) return 0;
        switch (status) {
            case "PRESENT":  return 1.0;
            case "HALF_DAY": return 0.5;
            default:         return 0.0;
        }
    }
}