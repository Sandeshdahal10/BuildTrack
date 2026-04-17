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

    //  Getters & Setters

    public int getPayrollId() {
        return payrollId;
    }
    public void setPayrollId(int payrollId) {
        this.payrollId = payrollId;
    }

    public String getWorkerName() {
        return workerName;
    }
    public void setWorkerName(String workerName) {
        this.workerName = workerName;
    }

    public String getWorkerEmail() {
        return workerEmail;
    }
    public void setWorkerEmail(String workerEmail) {
        this.workerEmail = workerEmail;
    }

    public String getWorkerPhone() {
        return workerPhone;
    }
    public void setWorkerPhone(String workerPhone) {
        this.workerPhone = workerPhone;
    }

    public String getMonthYearDisplay() {
        return monthYearDisplay;
    }
    public void setMonthYearDisplay(String monthYearDisplay) {
        this.monthYearDisplay = monthYearDisplay;
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

    public double getEffectiveDays() {
        return effectiveDays;
    }
    public void setEffectiveDays(double effectiveDays) {
        this.effectiveDays = effectiveDays;
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

    public String getGeneratedByName() {
        return generatedByName;
    }
    public void setGeneratedByName(String generatedByName) {
        this.generatedByName = generatedByName;
    }

    public String getGeneratedAt() {
        return generatedAt;
    }
    public void setGeneratedAt(String generatedAt) {
        this.generatedAt = generatedAt;
    }

    public String getPaidAt() {
        return paidAt;
    }
    public void setPaidAt(String paidAt) {
        this.paidAt = paidAt;
    }
}