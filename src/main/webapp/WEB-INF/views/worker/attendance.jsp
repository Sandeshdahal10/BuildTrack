<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="com.buildtrack.model.Attendance" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Worker";
    String basePath = request.getContextPath();

    List<Attendance> records = (List<Attendance>) request.getAttribute("records");
    if (records == null) records = Collections.emptyList();

    int totalDays = request.getAttribute("totalDays") != null ? (int) request.getAttribute("totalDays") : 0;
    int presentCount = request.getAttribute("presentCount") != null ? (int) request.getAttribute("presentCount") : 0;
    int absentCount = request.getAttribute("absentCount") != null ? (int) request.getAttribute("absentCount") : 0;
    int halfDayCount = request.getAttribute("halfDayCount") != null ? (int) request.getAttribute("halfDayCount") : 0;

    String currentMonth = (String) request.getAttribute("currentMonth");
    if (currentMonth == null || currentMonth.isEmpty()) {
        currentMonth = new SimpleDateFormat("yyyy-MM").format(new java.util.Date());
    }
%>
<%--this is comment--%>
<!-- this is pookie dinisha -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Attendance</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">

<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">
    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Area -->
    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden bg-slate-50/50">
        <!-- TOP NAVBAR -->
        <div class="px-8 pt-6 pb-2 shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <!-- CONTENT -->
        <div class="px-8 py-6 overflow-y-auto grow">
            <div class="max-w-7xl mx-auto">

                <!-- Header -->
                <div class="mb-6">
                    <h1 class="text-2xl font-bold text-slate-800 tracking-tight">Attendance</h1>
                    <p class="text-sm text-slate-500 mt-1 font-medium">Track your daily attendance records</p>
                </div>
                
                <!-- Mark Attendance (Worker) -->
                <div class="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden mb-6 p-4">
                    <h2 class="text-lg font-bold text-slate-800 mb-3">Mark Attendance</h2>
                    <form action="<%= basePath %>/worker/attendance" method="POST" class="grid grid-cols-1 sm:grid-cols-4 gap-3 items-end">
                        <div>
                            <label class="text-xs text-slate-500 font-medium">Project Name</label>
                            <select name="projectId" required class="w-full mt-1 px-3 py-2 rounded-lg border border-slate-200 bg-white text-sm">
                                <option value="">Select Project</option>
                                <c:forEach var="p" items="${assignedProjects}">
                                    <option value="${p.id}">${p.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label class="text-xs text-slate-500 font-medium">Date</label>
                            <input id="attendanceDate" name="date" type="date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                                   readonly
                                   class="w-full mt-1 px-3 py-2 rounded-lg border border-slate-200 bg-slate-100 text-sm text-slate-600 cursor-not-allowed" />
                        </div>
                        <div>
                            <label class="text-xs text-slate-500 font-medium">Status</label>
                            <select name="status" required class="w-full mt-1 px-3 py-2 rounded-lg border border-slate-200 bg-white text-sm">
                                <option value="PRESENT">Present</option>
                                <option value="ABSENT">Absent</option>
                                <option value="HALF_DAY">Half Day</option>
                            </select>
                        </div>
                        <div>
                            <label class="text-xs text-slate-500 font-medium">Notes (optional)</label>
                            <div class="flex gap-2">
                                <input name="notes" type="text" placeholder="Notes" class="w-full mt-1 px-3 py-2 rounded-lg border border-slate-200 bg-white text-sm" />
                                <button type="submit" class="mt-1 bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg text-sm font-semibold">Mark</button>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- Stats Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <!-- Total Days -->
                    <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm flex flex-col items-center justify-center transition-all hover:shadow-md">
                        <span class="text-3xl font-bold text-slate-800"><%= totalDays %></span>
                        <span class="text-xs font-semibold text-slate-500 mt-1.5 uppercase tracking-wider">Total Days</span>
                    </div>
                    <!-- Present -->
                    <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm flex flex-col items-center justify-center transition-all hover:shadow-md">
                        <span class="text-3xl font-bold text-emerald-600"><%= presentCount %></span>
                        <span class="text-xs font-semibold text-slate-500 mt-1.5 uppercase tracking-wider">Present</span>
                    </div>
                    <!-- Absent -->
                    <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm flex flex-col items-center justify-center transition-all hover:shadow-md">
                        <span class="text-3xl font-bold text-rose-600"><%= absentCount %></span>
                        <span class="text-xs font-semibold text-slate-500 mt-1.5 uppercase tracking-wider">Absent</span>
                    </div>
                    <!-- Half Day -->
                    <div class="bg-white rounded-xl p-5 border border-slate-200 shadow-sm flex flex-col items-center justify-center transition-all hover:shadow-md">
                        <span class="text-3xl font-bold text-amber-500"><%= halfDayCount %></span>
                        <span class="text-xs font-semibold text-slate-500 mt-1.5 uppercase tracking-wider">Half Day</span>
                    </div>
                </div>

                <!-- Table Section -->
                <div class="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">

                    <!-- Toolbar -->
                    <div class="p-4 border-b border-slate-200 flex flex-col sm:flex-row justify-between items-center gap-4 bg-slate-50/50">
                        <form action="<%= basePath %>/worker/attendance" method="GET" class="flex items-center gap-3">
                            <div class="flex items-center gap-2 border border-slate-200 bg-white rounded-lg px-3 py-2 shadow-sm transition-colors focus-within:border-amber-400 focus-within:ring-1 focus-within:ring-amber-400">
                                <i data-lucide="calendar" class="w-4 h-4 text-slate-400"></i>
                                <input type="month" name="month" value="<%= currentMonth %>" class="text-sm font-medium text-slate-700 bg-transparent outline-none cursor-pointer" />
                            </div>
                            <button type="submit" class="flex items-center gap-2 bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg text-sm font-semibold shadow-sm transition-all hover:shadow">
                                <i data-lucide="filter" class="w-4 h-4"></i>
                                Filter
                            </button>
                        </form>
                    </div>

                    <!-- Table -->
                    <div class="overflow-x-auto">
                        <table class="w-full text-left border-collapse whitespace-nowrap">
                            <thead>
                                <tr class="bg-slate-50/80 border-b border-slate-200">
                                    <th class="px-6 py-3.5 text-xs font-semibold text-slate-500 uppercase tracking-wider">Date</th>
                                    <th class="px-6 py-3.5 text-xs font-semibold text-slate-500 uppercase tracking-wider">Project</th>
                                    <th class="px-6 py-3.5 text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                                    <th class="px-6 py-3.5 text-xs font-semibold text-slate-500 uppercase tracking-wider">Marked By</th>
                                    <th class="px-6 py-3.5 text-xs font-semibold text-slate-500 uppercase tracking-wider">Notes</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100">

                                <% if (records.isEmpty()) { %>
                                <tr>
                                    <td colspan="5" class="px-6 py-12 text-center text-sm text-slate-400">
                                        <div class="flex flex-col items-center gap-2">
                                            <i data-lucide="calendar-x" class="w-10 h-10 text-slate-300"></i>
                                            <span>No attendance records found for this month.</span>
                                        </div>
                                    </td>
                                </tr>
                                <% } else { %>
                                    <% for (Attendance record : records) { %>
                                <tr class="hover:bg-slate-50/80 transition-colors">
                                    <td class="px-6 py-4 text-sm font-semibold text-slate-800">
                                        <%= record.getAttendanceDate() != null ? record.getAttendanceDate().toString() : "-" %>
                                    </td>
                                    <td class="px-6 py-4 text-sm font-medium text-slate-500">
                                        <%= record.getProjectName() != null ? record.getProjectName() : "-" %>
                                    </td>
                                    <td class="px-6 py-4">
                                        <%
                                            String badgeBg = "bg-slate-50 text-slate-600 border-slate-200";
                                            if ("PRESENT".equals(record.getStatus())) {
                                                badgeBg = "bg-emerald-50 text-emerald-700 border-emerald-200";
                                            } else if ("ABSENT".equals(record.getStatus())) {
                                                badgeBg = "bg-rose-50 text-rose-700 border-rose-200";
                                            } else if ("HALF_DAY".equals(record.getStatus())) {
                                                badgeBg = "bg-amber-50 text-amber-700 border-amber-200";
                                            }
                                        %>
                                        <span class="inline-flex items-center px-2.5 py-1 rounded-md border text-xs font-bold <%= badgeBg %>">
                                            <%= record.getStatusDisplayName() %>
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-sm font-medium text-slate-500">
                                        <%= record.getMarkedByName() != null ? record.getMarkedByName() : "-" %>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500">
                                        <%= record.getNotes() != null && !record.getNotes().isEmpty() ? record.getNotes() : "-" %>
                                    </td>
                                </tr>
                                    <% } %>
                                <% } %>

                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </main>
</div>

<script>
    (function () {
        var dateInput = document.getElementById("attendanceDate");
        if (!dateInput) {
            return;
        }

        function pad(value) {
            return value < 10 ? "0" + value : value;
        }

        function setTodayDate() {
            var now = new Date();
            var today = now.getFullYear() + "-" + pad(now.getMonth() + 1) + "-" + pad(now.getDate());
            dateInput.value = today;
            dateInput.min = today;
            dateInput.max = today;
        }

        setTodayDate();
        setInterval(setTodayDate, 60 * 1000);
    })();

    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
</body>
</html>
