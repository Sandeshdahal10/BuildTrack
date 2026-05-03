package com.buildtrack.model;

import java.math.BigDecimal;

/**
 * Payslip DTO — combines payroll data with worker info for display.
 * Used when viewing or downloading a payslip.
 */
public class Payslip {

    private int payrollId;
    private String workerName;
    private String workerEmail;
    private String workerPhone;
    private String monthYearDisplay;
    private String monthYear; // YYYY-MM
    private int totalDays;
    private int halfDays;
    private double effectiveDays;
    private BigDecimal dailyWage;
    private BigDecimal totalSalary;
    private String status;
    private String generatedByName;
    private String generatedAt;
    private String paidAt;

    // Getters & Setters

    /**
     * Returns the payroll id.
     */
    public int getPayrollId() {
        return payrollId;
    }

    /**
     * Sets the payroll id.
     */
    public void setPayrollId(int payrollId) {
        this.payrollId = payrollId;
    }

    /**
     * Returns the worker name.
     */
    public String getWorkerName() {
        return workerName;
    }

    /**
     * Sets the worker name.
     */
    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    /**
     * Returns the worker email.
     */
    public String getWorkerEmail() {
        return workerEmail;
    }

    /**
     * Sets the worker email.
     */
    public void setWorkerEmail(String workerEmail) {
        this.workerEmail = workerEmail;
    }

    /**
     * Returns the worker phone number.
     */
    public String getWorkerPhone() {
        return workerPhone;
    }

    /**
     * Sets the worker phone number.
     */
    public void setWorkerPhone(String workerPhone) {
        this.workerPhone = workerPhone;
    }

    /**
     * Returns the display label for the payroll month.
     */
    public String getMonthYearDisplay() {
        return monthYearDisplay;
    }

    /**
     * Sets the display label for the payroll month.
     */
    public void setMonthYearDisplay(String monthYearDisplay) {
        this.monthYearDisplay = monthYearDisplay;
    }

    /**
     * Returns the payroll month (YYYY-MM).
     */
    public String getMonthYear() {
        return monthYear;
    }

    /**
     * Sets the payroll month (YYYY-MM).
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
     * Returns the effective days for payroll calculation.
     */
    public double getEffectiveDays() {
        return effectiveDays;
    }

    /**
     * Sets the effective days for payroll calculation.
     */
    public void setEffectiveDays(double effectiveDays) {
        this.effectiveDays = effectiveDays;
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
     * Returns the name of the admin who generated payroll.
     */
    public String getGeneratedByName() {
        return generatedByName;
    }

    /**
     * Sets the name of the admin who generated payroll.
     */
    public void setGeneratedByName(String generatedByName) {
        this.generatedByName = generatedByName;
    }

    /**
     * Returns the generation timestamp as a string.
     */
    public String getGeneratedAt() {
        return generatedAt;
    }

    /**
     * Sets the generation timestamp as a string.
     */
    public void setGeneratedAt(String generatedAt) {
        this.generatedAt = generatedAt;
    }

    /**
     * Returns the paid timestamp as a string.
     */
    public String getPaidAt() {
        return paidAt;
    }

    /**
     * Sets the paid timestamp as a string.
     */
    public void setPaidAt(String paidAt) {
        this.paidAt = paidAt;
    }
}