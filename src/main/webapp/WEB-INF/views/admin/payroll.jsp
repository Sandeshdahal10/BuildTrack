<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.time.YearMonth" %>
<%@ page import="com.buildtrack.model.Payroll" %>
<%@ page import="com.buildtrack.model.Payslip" %>
<%!
    private String money(BigDecimal value) {
        if (value == null) return "Rs 0.00";
        return "Rs " + value.setScale(2, RoundingMode.HALF_UP).toPlainString();
    }

    private BigDecimal safeSalary(Payroll payroll) {
        if (payroll == null) return BigDecimal.ZERO;
        if (payroll.getTotalSalary() != null) return payroll.getTotalSalary();
        if (payroll.getDailyWage() == null) return BigDecimal.ZERO;
        BigDecimal effectiveDays = BigDecimal.valueOf(payroll.getTotalDays())
                .add(BigDecimal.valueOf(payroll.getHalfDays()).multiply(BigDecimal.valueOf(0.5d)));
        return payroll.getDailyWage().multiply(effectiveDays).setScale(2, RoundingMode.HALF_UP);
    }
%>
<%
    String monthYear = String.valueOf(request.getAttribute("monthYear"));
    if ("null".equals(monthYear)) monthYear = null;
    if (monthYear == null || monthYear.trim().isEmpty()) {
        monthYear = YearMonth.now().toString();
    }

    String statusFilter = request.getParameter("status");
    if (statusFilter == null) statusFilter = "";

    List<Payroll> payrolls = new ArrayList<>();
    Object payrollsAttr = request.getAttribute("payrolls");
    if (payrollsAttr instanceof List<?>) {
        for (Object item : (List<?>) payrollsAttr) {
            if (item instanceof Payroll) payrolls.add((Payroll) item);
        }
    }

    Payroll singlePayroll = (Payroll) request.getAttribute("payroll");
    if (singlePayroll != null && payrolls.isEmpty()) {
        payrolls.add(singlePayroll);
    }

    List<Payroll> displayPayrolls = new ArrayList<>();
    for (Payroll p : payrolls) {
        if (p == null) continue;
        if (statusFilter.trim().isEmpty() || statusFilter.equalsIgnoreCase(p.getStatus())) {
            displayPayrolls.add(p);
        }
    }

    BigDecimal totalPending = request.getAttribute("totalPending") instanceof BigDecimal
            ? (BigDecimal) request.getAttribute("totalPending") : BigDecimal.ZERO;
    BigDecimal totalPaid = request.getAttribute("totalPaid") instanceof BigDecimal
            ? (BigDecimal) request.getAttribute("totalPaid") : BigDecimal.ZERO;
    if (totalPending.compareTo(BigDecimal.ZERO) == 0 && totalPaid.compareTo(BigDecimal.ZERO) == 0 && !payrolls.isEmpty()) {
        for (Payroll p : payrolls) {
            if (p == null) continue;
            BigDecimal salary = safeSalary(p);
            if ("PAID".equals(p.getStatus())) totalPaid = totalPaid.add(salary);
            else totalPending = totalPending.add(salary);
        }
    }
    BigDecimal totalPayroll = totalPaid.add(totalPending);

    int workersPaid = 0;
    for (Payroll p : payrolls) if (p != null && "PAID".equals(p.getStatus())) workersPaid++;
    String workersPaidLabel = workersPaid + " / " + payrolls.size();

    Payslip payslip = (Payslip) request.getAttribute("payslip");

    List<String> errors = new ArrayList<>();
    Object errorsAttr = request.getAttribute("errors");
    if (errorsAttr instanceof List<?>) {
        for (Object item : (List<?>) errorsAttr) errors.add(String.valueOf(item));
    } else if (errorsAttr != null) {
        errors.add(String.valueOf(errorsAttr));
    }
    if (errors.isEmpty()) errors = Collections.emptyList();
    String success = request.getAttribute("success") != null ? String.valueOf(request.getAttribute("success")) : "";
%>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Payroll Management - BuildTrack</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen flex">
    <div class="fixed inset-y-0 left-0 w-56 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-56 flex flex-1 flex-col overflow-y-auto">

        <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-6">

            <div class="mb-6 flex flex-col justify-between gap-4 md:flex-row md:items-center">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Payroll Management</h1>
                    <p class="mt-1 text-slate-500">Calculate wages and manage payments.</p>
                </div>
                <form action="<%= request.getContextPath() %>/admin/payroll?action=generate" method="POST">
                    <input type="hidden" name="monthYear" value="<%= monthYear %>" />
                    <button type="submit" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Generate Monthly Payroll</button>
                </form>
            </div>

            <% if (!errors.isEmpty()) { %>
            <div class="mb-4 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-700">
                <ul class="list-disc space-y-1 pl-5">
                    <% for (String err : errors) { %><li><%= err %></li><% } %>
                </ul>
            </div>
            <% } %>

            <% if (!success.trim().isEmpty()) { %>
            <div class="mb-4 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-700"><%= success %></div>
            <% } %>

            <div class="mb-6 grid grid-cols-1 gap-4 md:grid-cols-4">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Payroll" />
                    <jsp:param name="value" value="<%= money(totalPayroll) %>" />
                    <jsp:param name="icon" value="wallet" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-blue-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-blue-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Amount Paid" />
                    <jsp:param name="value" value="<%= money(totalPaid) %>" />
                    <jsp:param name="icon" value="check-circle" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Pending Amount" />
                    <jsp:param name="value" value="<%= money(totalPending) %>" />
                    <jsp:param name="icon" value="clock" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Workers Paid" />
                    <jsp:param name="value" value="<%= workersPaidLabel %>" />
                    <jsp:param name="icon" value="users" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>
            </div>

            <div class="mb-4 rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                <form action="<%= request.getContextPath() %>/admin/payroll" method="GET" class="flex flex-wrap items-center gap-4">
                    <input type="hidden" name="action" value="list" />
                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Month:</span>
                        <input type="month" name="my" value="<%= monthYear %>" class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-400" />
                    </div>

                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Status:</span>
                        <select name="status" class="rounded-lg border border-slate-300 bg-white p-2 text-sm outline-none focus:border-orange-400">
                            <option value="" <%= statusFilter.trim().isEmpty() ? "selected" : "" %>>All Status</option>
                            <option value="PAID" <%= "PAID".equalsIgnoreCase(statusFilter) ? "selected" : "" %>>Paid</option>
                            <option value="PENDING" <%= "PENDING".equalsIgnoreCase(statusFilter) ? "selected" : "" %>>Pending</option>
                        </select>
                    </div>

                    <button type="submit" class="rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">Apply</button>
                </form>
            </div>

            <% if (payslip != null) { %>
            <div class="mb-4 rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                <h2 class="mb-2 text-lg font-bold text-slate-800">Payslip Details</h2>
                <p class="text-sm text-slate-600">Worker: <span class="font-medium"><%= payslip.getWorkerName() %></span></p>
                <p class="text-sm text-slate-600">Month: <span class="font-medium"><%= payslip.getMonthYearDisplay() %></span></p>
                <p class="text-sm text-slate-600">Effective Days: <span class="font-medium"><%= payslip.getEffectiveDays() %></span></p>
                <p class="text-sm text-slate-600">Daily Wage: <span class="font-medium"><%= money(payslip.getDailyWage()) %></span></p>
                <p class="text-sm text-slate-600">Total Salary: <span class="font-medium"><%= money(payslip.getTotalSalary()) %></span></p>
            </div>
            <% } %>

            <div class="space-y-3 rounded-xl bg-slate-100/50 p-4">
                <% if (displayPayrolls.isEmpty()) { %>
                <div class="rounded-lg border border-dashed border-slate-300 bg-white p-8 text-center text-sm text-slate-500">
                    No payroll records found for the selected month/filter.
                </div>
                <% } %>

                <% for (Payroll p : displayPayrolls) {
                    String effectiveDays = String.valueOf(p.getTotalDays() + (p.getHalfDays() * 0.5));
                    boolean paid = "PAID".equals(p.getStatus());
                    String statusDisplay = paid ? "Paid" : "Pending";
                    String statusBadgeClass = paid
                            ? "bg-green-100 text-green-700"
                            : "bg-amber-100 text-amber-700";
                    BigDecimal salary = safeSalary(p);
                %>
                <div class="flex flex-col justify-between gap-4 rounded-xl border border-slate-200 bg-white p-4 md:flex-row md:items-center">
                    <div class="min-w-[220px]">
                        <h4 class="text-sm font-bold text-slate-800"><%= p.getWorkerName() %></h4>
                        <p class="text-xs text-slate-500"><%= p.getWorkerEmail() %></p>
                    </div>

                    <div class="flex flex-1 items-center gap-6 text-sm md:justify-center">
                        <div class="text-center">
                            <p class="text-xs text-slate-400">Effective Days</p>
                            <p class="font-bold text-slate-700"><%= effectiveDays %></p>
                        </div>
                        <div class="border-l border-slate-100 pl-6 text-center">
                            <p class="text-xs text-slate-400">Daily Rate</p>
                            <p class="font-bold text-slate-700"><%= money(p.getDailyWage()) %></p>
                        </div>
                        <div class="border-l border-slate-100 pl-6 text-center">
                            <p class="text-xs text-slate-400">Gross Pay</p>
                            <p class="font-bold text-orange-600"><%= money(salary) %></p>
                        </div>
                    </div>

                    <div class="flex items-center gap-3">
                        <span class="rounded-full px-3 py-1 text-xs font-bold <%= statusBadgeClass %>"><%= statusDisplay %></span>

                        <a href="<%= request.getContextPath() %>/admin/payroll?action=payslip&id=<%= p.getId() %>" class="rounded-lg border border-slate-200 p-2 text-slate-500 transition hover:bg-slate-50 hover:text-slate-700" title="View Payslip">
                            <i data-lucide="file-text" class="h-4 w-4"></i>
                        </a>

                        <% if (paid) { %>
                        <button type="button" class="pointer-events-none rounded-lg bg-green-500 p-2 text-white opacity-50" title="Already Paid">
                            <i data-lucide="check-circle" class="h-4 w-4"></i>
                        </button>
                        <% } else { %>
                        <form action="<%= request.getContextPath() %>/admin/payroll?action=mark-paid&id=<%= p.getId() %>&my=<%= monthYear %>" method="POST">
                            <button type="submit" class="rounded-lg bg-green-500 p-2 text-white transition hover:bg-green-600" title="Process Payment">
                                <i data-lucide="check-circle" class="h-4 w-4"></i>
                            </button>
                        </form>
                        <% } %>
                    </div>
                </div>
                <% } %>
            </div>

        </main>
    </div>
</div>

<script>lucide.createIcons();</script>
</body>
</html>