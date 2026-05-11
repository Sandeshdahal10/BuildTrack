package com.buildtrack.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Payroll record for a worker for a specific month.
 */
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

    /**
     * Creates an empty payroll instance.
     */
    public Payroll() {
    }

    /**
     * Creates a populated payroll instance.
     *
     * @param workerId    worker identifier
     * @param monthYear   payroll month (YYYY-MM)
     * @param totalDays   number of present days
     * @param halfDays    number of half days
     * @param dailyWage   wage per day
     * @param generatedBy admin id who generated payroll
     */
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

    /**
     * Returns the payroll id.
     */
    public int getId() {
        return id;
    }

    /**
     * Sets the payroll id.
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
     * Returns the month-year value (YYYY-MM).
     */
    public String getMonthYear() {
        return monthYear;
    }

    /**
     * Sets the month-year value (YYYY-MM).
     */
    public void setMonthYear(String monthYear) {
        this.monthYear = monthYear;
    }

    /**
     * Returns the total present days.
     */
    public int getTotalDays() {
        return totalDays;
    }

    /**
     * Sets the total present days.
     */
    public void setTotalDays(int totalDays) {
        this.totalDays = totalDays;
    }

    /**
     * Returns the total half days.
     */
    public int getHalfDays() {
        return halfDays;
    }

    /**
     * Sets the total half days.
     */
    public void setHalfDays(int halfDays) {
        this.halfDays = halfDays;
    }

    /**
     * Returns the daily wage.
     */
    public BigDecimal getDailyWage() {
        return dailyWage;
    }

    /**
     * Sets the daily wage.
     */
    public void setDailyWage(BigDecimal dailyWage) {
        this.dailyWage = dailyWage;
    }

    /**
     * Returns the total salary.
     */
    public BigDecimal getTotalSalary() {
        return totalSalary;
    }

    /**
     * Sets the total salary.
     */
    public void setTotalSalary(BigDecimal totalSalary) {
        this.totalSalary = totalSalary;
    }

    /**
     * Returns the payroll status.
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the payroll status.
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * Returns the admin id who generated payroll.
     */
    public int getGeneratedBy() {
        return generatedBy;
    }

    /**
     * Sets the admin id who generated payroll.
     */
    public void setGeneratedBy(int generatedBy) {
        this.generatedBy = generatedBy;
    }

    /**
     * Returns the generation timestamp.
     */
    public Timestamp getGeneratedAt() {
        return generatedAt;
    }

    /**
     * Sets the generation timestamp.
     */
    public void setGeneratedAt(Timestamp generatedAt) {
        this.generatedAt = generatedAt;
    }

    /**
     * Returns the paid timestamp.
     */
    public Timestamp getPaidAt() {
        return paidAt;
    }

    /**
     * Sets the paid timestamp.
     */
    public void setPaidAt(Timestamp paidAt) {
        this.paidAt = paidAt;
    }

    // Getters and setters for Transient Fields

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
     * Returns the worker email for display.
     */
    public String getWorkerEmail() {
        return workerEmail;
    }

    /**
     * Sets the worker email for display.
     */
    public void setWorkerEmail(String workerEmail) {
        this.workerEmail = workerEmail;
    }

    // ---------- Utility ----------

    /**
     * Calculates total salary manually (mirrors DB GENERATED column).
     */
    public BigDecimal calculateSalary() {
        if (dailyWage == null)
            return BigDecimal.ZERO;
        double effectiveDays = totalDays + (halfDays * 0.5);
        return dailyWage.multiply(BigDecimal.valueOf(effectiveDays))
                .setScale(2, BigDecimal.ROUND_HALF_UP);
    }

    /**
     * Returns a user-friendly status label.
     */
    public String getStatusDisplayName() {
        return "PAID".equals(status) ? "Paid" : "Pending";
    }

    /**
     * Returns a CSS class name for the status badge.
     */
    public String getStatusBadgeClass() {
        return "PAID".equals(status)
                ? "bg-green-100 text-green-700"
                : "bg-amber-100 text-amber-700";
    }

    /**
     * Returns a display label for the payroll month (e.g., "January 2026").
     */
    public String getMonthYearDisplay() {
        if (monthYear == null || monthYear.length() != 7)
            return "";
        String[] parts = monthYear.split("-");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]);
        String[] monthNames = { "January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December" };
        return monthNames[month - 1] + " " + year;
    }
}