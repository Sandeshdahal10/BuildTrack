package com.buildtrack.service.admin;

import com.buildtrack.dao.admin.AttendanceDao;
import com.buildtrack.dao.admin.PayrollDao;
import com.buildtrack.dao.admin.UserDao;
import com.buildtrack.model.Payroll;
import com.buildtrack.model.Payslip;
import com.buildtrack.model.User;
import com.buildtrack.util.DBUtil;
import com.buildtrack.util.ValidationUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Service layer for payroll generation and queries.
 */
public class PayrollService {

    private final PayrollDao payrollDAO = new PayrollDao();
    private final AttendanceDao attendanceDAO = new AttendanceDao();
    private final UserDao userDAO = new UserDao();

    // Queries

    /**
     * Returns payroll records for a month.
     */
    public List<Payroll> getPayrollByMonth(String monthYear) {
        if (ValidationUtil.isEmpty(monthYear))
            return new ArrayList<>();
        return payrollDAO.findByMonth(monthYear);
    }

    /**
     * Returns a payroll record by id.
     */
    public Payroll getPayrollById(int id) {
        return payrollDAO.findById(id);
    }

    /**
     * Returns a payslip by payroll id.
     */
    public Payslip getPayslipById(int id) {
        return payrollDAO.findPayslipById(id);
    }

    /**
     * Returns a worker payroll record for a month.
     */
    public Payroll getWorkerPayroll(int workerId, String monthYear) {
        return payrollDAO.findByWorkerAndMonth(workerId, monthYear);
    }

    /**
     * Returns true if payroll exists for a worker and month.
     */
    public boolean payrollExists(int workerId, String monthYear) {
        return payrollDAO.exists(workerId, monthYear);
    }

    /**
     * Returns total salary for a month, optionally filtered by status.
     */
    public BigDecimal getTotalSalaryByMonth(String monthYear, String status) {
        return payrollDAO.getTotalSalaryByMonth(monthYear, status);
    }

    // Generate Payroll

    /**
     * Generate payroll for ALL approved workers for a given month.
     * Uses a transaction so all succeed or all roll back.
     */
    public List<String> generateMonthlyPayroll(String monthYear, int generatedBy) {
        List<String> errors = new ArrayList<>();

        if (ValidationUtil.isEmpty(monthYear) || !monthYear.matches("\\d{4}-\\d{2}")) {
            errors.add("Invalid month-year format. Use YYYY-MM.");
            return errors;
        }

        // Get all approved workers with a daily wage > 0
        List<User> workers = userDAO.findByRoleAndStatus("WORKER", "APPROVED");
        if (workers.isEmpty()) {
            errors.add("No approved workers found.");
            return errors;
        }

        Connection conn = null;
        int generated = 0, skipped = 0;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            for (User worker : workers) {
                // Skip workers with no daily wage set
                if (worker.getDailyWage() == null
                        || worker.getDailyWage().compareTo(BigDecimal.ZERO) == 0) {
                    skipped++;
                    continue;
                }

                // Skip if payroll already exists
                if (payrollDAO.exists(worker.getId(), monthYear)) {
                    skipped++;
                    continue;
                }

                // Get attendance counts
                int[] counts = attendanceDAO.getAttendanceCounts(worker.getId(), monthYear);
                int presentDays = counts[0];
                int halfDays = counts[1];

                // Skip workers with zero attendance
                if (presentDays == 0 && halfDays == 0) {
                    skipped++;
                    continue;
                }

                Payroll p = new Payroll();
                p.setWorkerId(worker.getId());
                p.setMonthYear(monthYear);
                p.setTotalDays(presentDays);
                p.setHalfDays(halfDays);
                p.setDailyWage(worker.getDailyWage());
                p.setGeneratedBy(generatedBy);

                int id = payrollDAO.insert(conn, p);
                if (id == -1) {
                    throw new SQLException("Failed to insert payroll for worker: " + worker.getEmail());
                }
                generated++;
            }

            conn.commit();

            if (generated == 0) {
                errors.add("No new payroll records generated. All workers were either skipped "
                        + "(no wage set, already generated, or no attendance) or no eligible workers found.");
            }

        } catch (SQLException e) {
            errors.add("Payroll generation failed: " + e.getMessage());
            try {
                if (conn != null)
                    conn.rollback();
            } catch (SQLException ignored) {
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException ignored) {
            }
        }

        return errors;
    }

    /**
     * Generate payroll for a SINGLE worker for a given month.
     */
    public List<String> generateSinglePayroll(int workerId, String monthYear, int generatedBy) {
        List<String> errors = new ArrayList<>();

        if (!monthYear.matches("\\d{4}-\\d{2}")) {
            errors.add("Invalid month-year format.");
            return errors;
        }

        User worker = userDAO.findById(workerId);
        if (worker == null) {
            errors.add("Worker not found.");
            return errors;
        }
        if (worker.getDailyWage() == null || worker.getDailyWage().compareTo(BigDecimal.ZERO) == 0) {
            errors.add("Worker has no daily wage set. Please set the wage first.");
            return errors;
        }
        if (payrollDAO.exists(workerId, monthYear)) {
            errors.add("Payroll already exists for this worker and month.");
            return errors;
        }

        int[] counts = attendanceDAO.getAttendanceCounts(workerId, monthYear);
        int presentDays = counts[0], halfDays = counts[1];
        if (presentDays == 0 && halfDays == 0) {
            errors.add("No attendance records found for this worker in " + monthYear + ".");
            return errors;
        }

        Payroll p = new Payroll();
        p.setWorkerId(workerId);
        p.setMonthYear(monthYear);
        p.setTotalDays(presentDays);
        p.setHalfDays(halfDays);
        p.setDailyWage(worker.getDailyWage());
        p.setGeneratedBy(generatedBy);

        if (payrollDAO.insert(p) == -1)
            errors.add("Failed to generate payroll.");
        return errors;
    }

    // Mark as Paid

    /**
     * Marks a payroll record as paid.
     */
    public List<String> markAsPaid(int payrollId) {
        List<String> errors = new ArrayList<>();
        Payroll p = payrollDAO.findById(payrollId);
        if (p == null) {
            errors.add("Payroll record not found.");
            return errors;
        }
        if ("PAID".equals(p.getStatus())) {
            errors.add("Payroll is already marked as paid.");
            return errors;
        }
        if (!payrollDAO.markAsPaid(payrollId))
            errors.add("Failed to mark payroll as paid.");
        return errors;
    }
}