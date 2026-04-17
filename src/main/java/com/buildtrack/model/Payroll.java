package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payroll {

    private int id;
    private int workerId;
    private String monthYear; // YYYY-MM
    private int totalDays;
    private int halfDays;
    private BigDecimal dailyWage;
    private BigDecimal totalSalary;
    private String status; // PENDING, PAID
    private int generatedBy;
    private Timestamp generatedAt;
    private Timestamp paidAt;

    // Transient display fields
    private String workerName;
    private String workerEmail;

    public Payroll() {}

    public Payroll(int workerId, String monthYear, int totalDays,
                   int halfDays, BigDecimal dailyWage, int generatedBy) {
        this.workerId = workerId;
        this.monthYear = monthYear;
        this.totalDays = totalDays;
        this.halfDays = halfDays;
        this.dailyWage = dailyWage;
        this.generatedBy = generatedBy;
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

    public String getMonthYear() {
        return monthYear;
    }
    public void setMonthYear(String monthYear) {
        this.monthYear = monthYear;
    }

    public int getTotalDays() {
        return totalDays;
    }
    public void setTotalDays(int totalDays) {
        this.totalDays = totalDays;
    }

    public int getHalfDays() {
        return halfDays;
    }
    public void setHalfDays(int halfDays) {
        this.halfDays = halfDays;
    }

    public BigDecimal getDailyWage() {
        return dailyWage;
    }
    public void setDailyWage(BigDecimal dailyWage) {
        this.dailyWage = dailyWage;
    }

    public BigDecimal getTotalSalary() {
        return totalSalary;
    }
    public void setTotalSalary(BigDecimal totalSalary) {
        this.totalSalary = totalSalary;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public int getGeneratedBy() {
        return generatedBy;
    }
    public void setGeneratedBy(int generatedBy) {
        this.generatedBy = generatedBy;
    }

    public Timestamp getGeneratedAt() {
        return generatedAt;
    }
    public void setGeneratedAt(Timestamp generatedAt) {
        this.generatedAt = generatedAt;
    }

    public Timestamp getPaidAt() {
        return paidAt;
    }
    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }

    //Getters and setters for Transient Fields

    public String getWorkerName() { return workerName; }
    public void setWorkerName(String workerName) { this.workerName = workerName; }

    public String getWorkerEmail() { return workerEmail; }
    public void setWorkerEmail(String workerEmail) { this.workerEmail = workerEmail; }

    // ---------- Utility ----------

    /** Calculate total salary manually (mirrors DB GENERATED column). */
    public BigDecimal calculateSalary() {
        if (dailyWage == null) return BigDecimal.ZERO;
        double effectiveDays = totalDays + (halfDays * 0.5);
        return dailyWage.multiply(BigDecimal.valueOf(effectiveDays))
                .setScale(2, BigDecimal.ROUND_HALF_UP);
    }

    public String getStatusDisplayName() {
        return "PAID".equals(status) ? "Paid" : "Pending";
    }

    public String getStatusBadgeClass() {
        return "PAID".equals(status)
                ? "bg-green-100 text-green-700"
                : "bg-amber-100 text-amber-700";
    }

    /** Display format: "January 2026" */
    public String getMonthYearDisplay() {
        if (monthYear == null || monthYear.length() != 7) return "";
        String[] parts = monthYear.split("-");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        String[] monthNames = {"January","February","March","April","May","June",
                "July","August","September","October","November","December"};
        return monthNames[month - 1] + " " + year;
    }
}