<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.buildtrack.model.Attendance" %>
<%@ page import="com.buildtrack.model.Project" %>
<%@ page import="com.buildtrack.dao.admin.ProjectDao" %>
<%
    List<Project> projects = (List<Project>) request.getAttribute("projects");
    if (projects == null) projects = Collections.emptyList();

    List<Attendance> records = (List<Attendance>) request.getAttribute("records");
    if (records == null) records = Collections.emptyList();

    List<Attendance> existingAttendance = (List<Attendance>) request.getAttribute("existingAttendance");
    if (existingAttendance == null) existingAttendance = Collections.emptyList();

    List<ProjectDao.AssignedWorker> assignedWorkers = (List<ProjectDao.AssignedWorker>) request.getAttribute("assignedWorkers");
    if (assignedWorkers == null) assignedWorkers = Collections.emptyList();

    Map<Integer, Attendance> existingByWorker = new HashMap<>();
    for (Attendance a : existingAttendance) existingByWorker.put(a.getWorkerId(), a);

    Project selectedProject = (Project) request.getAttribute("project");
    String attendanceDate = (String) request.getAttribute("attendanceDate");
    if (attendanceDate == null || attendanceDate.isBlank()) {
        attendanceDate = (String) request.getAttribute("date");
    }
    if (attendanceDate == null || attendanceDate.isBlank()) {
        attendanceDate = LocalDate.now().toString();
    }

    String selectedProjectId = "";
    if (request.getAttribute("projectId") != null) {
        selectedProjectId = String.valueOf(request.getAttribute("projectId"));
    }
    if (selectedProject != null) {
        selectedProjectId = String.valueOf(selectedProject.getId());
    }

    List<String> errors = (List<String>) request.getAttribute("errors");
    if (errors == null) errors = Collections.emptyList();
    String success = request.getAttribute("success") != null ? String.valueOf(request.getAttribute("success")) : "";

    List<Attendance> statsSource = !records.isEmpty() ? records : existingAttendance;
    int totalWorkers = !records.isEmpty() ? records.size() : assignedWorkers.size();
    int presentCount = 0;
    int absentCount = 0;
    int halfDayCount = 0;
    for (Attendance a : statsSource) {
        if ("PRESENT".equals(a.getStatus())) presentCount++;
        else if ("ABSENT".equals(a.getStatus())) absentCount++;
        else if ("HALF_DAY".equals(a.getStatus())) halfDayCount++;
    }
    boolean markMode = selectedProject != null && !assignedWorkers.isEmpty();
%>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Daily Attendance - BuildTrack</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen flex">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 w-full max-w-full overflow-hidden flex-1 flex flex-1 flex-col overflow-y-auto">

        <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-6">

            <div class="mb-6">
                <h1 class="text-2xl font-bold text-slate-800">Attendance Management</h1>
                <p class="mt-1 text-slate-500">Mark daily attendance and view worker status.</p>
            </div>

            <% if (!errors.isEmpty()) { %>
            <div class="mb-4 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-700">
                <ul class="list-disc space-y-1 pl-5">
                    <% for (String err : errors) { %><li><%= err %></li><% } %>
                </ul>
            </div>
            <% } %>

            <% if (!success.isBlank()) { %>
            <div class="mb-4 rounded-lg border border-green-200 bg-green-50 p-4 text-sm text-green-700">
                <%= success %>
            </div>
            <% } %>

            <div class="mb-6 grid grid-cols-1 gap-4 md:grid-cols-4">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Workers" />
                    <jsp:param name="value" value="<%= String.valueOf(totalWorkers) %>" />
                    <jsp:param name="icon" value="users" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Present" />
                    <jsp:param name="value" value="<%= String.valueOf(presentCount) %>" />
                    <jsp:param name="icon" value="user-check" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Absent" />
                    <jsp:param name="value" value="<%= String.valueOf(absentCount) %>" />
                    <jsp:param name="icon" value="user-x" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Half Day" />
                    <jsp:param name="value" value="<%= String.valueOf(halfDayCount) %>" />
                    <jsp:param name="icon" value="clock-3" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-amber-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-amber-600" />
                </jsp:include>
            </div>

            <div class="mb-4 rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                <form action="<%= request.getContextPath() %>/admin/attendance" method="GET" class="flex flex-wrap items-center gap-4">
                    <input type="hidden" name="action" value="view" />
                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Date:</span>
                        <input type="date" name="date" value="<%= attendanceDate %>" class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-400" />
                    </div>

                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Project:</span>
                        <select name="pid" class="rounded-lg border border-slate-300 bg-white p-2 text-sm outline-none focus:border-orange-400">
                            <option value="">All Projects</option>
                            <% for (Project p : projects) { String pid = String.valueOf(p.getId()); %>
                            <option value="<%= pid %>" <%= pid.equals(selectedProjectId) ? "selected" : "" %>><%= p.getTitle() %></option>
                            <% } %>
                        </select>
                    </div>

                    <button type="submit" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">
                        View Records
                    </button>

                    <% if (!selectedProjectId.isBlank()) { %>
                    <a href="<%= request.getContextPath() %>/admin/attendance?action=mark&pid=<%= selectedProjectId %>&date=<%= attendanceDate %>" class="rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                        Open Marking View
                    </a>
                    <% } %>
                </form>
            </div>

            <% if (markMode) { %>
            <div class="mb-4 rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                <h2 class="mb-1 text-lg font-bold text-slate-800">Mark Attendance: <%= selectedProject.getTitle() %></h2>
                <p class="text-sm text-slate-500">Date: <%= attendanceDate %></p>
            </div>

            <div class="mb-6 rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                <h3 class="mb-3 text-sm font-semibold text-slate-700">Batch Mark Selected Workers</h3>
                <form action="<%= request.getContextPath() %>/admin/attendance?action=batch-mark" method="POST" class="space-y-4">
                    <input type="hidden" name="projectId" value="<%= selectedProject.getId() %>" />
                    <input type="hidden" name="date" value="<%= attendanceDate %>" />

                    <div class="flex items-center gap-3">
                        <label class="text-sm font-medium text-slate-600">Status</label>
                        <select name="status" class="rounded-lg border border-slate-300 bg-white px-3 py-2 text-sm outline-none focus:border-orange-400">
                            <option value="PRESENT">Present</option>
                            <option value="ABSENT">Absent</option>
                            <option value="HALF_DAY">Half Day</option>
                        </select>
                        <button type="submit" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Apply to Selected</button>
                    </div>

                    <div class="space-y-2">
                        <% for (ProjectDao.AssignedWorker aw : assignedWorkers) {
                            Attendance existing = existingByWorker.get(aw.user.getId());
                            String currentStatus = existing != null ? existing.getStatusDisplayName() : "Not Marked";
                            String role = aw.assignedRole != null ? aw.assignedRole : "Worker";
                        %>
                        <label class="flex items-center justify-between rounded-lg border border-slate-200 p-3">
                            <div class="flex items-center gap-3">
                                <input type="checkbox" name="workerIds" value="<%= aw.user.getId() %>" class="h-4 w-4 rounded border-slate-300 text-orange-500" />
                                <div>
                                    <p class="text-sm font-semibold text-slate-800"><%= aw.user.getFullName() %></p>
                                    <p class="text-xs text-slate-500"><%= role %></p>
                                </div>
                            </div>
                            <span class="rounded-full bg-slate-100 px-2.5 py-1 text-xs font-medium text-slate-600">Current: <%= currentStatus %></span>
                        </label>
                        <% } %>
                    </div>
                </form>
            </div>

            <div class="rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                <h3 class="mb-3 text-sm font-semibold text-slate-700">Update Individual Worker</h3>
                <div class="space-y-3">
                    <% for (ProjectDao.AssignedWorker aw : assignedWorkers) {
                        Attendance existing = existingByWorker.get(aw.user.getId());
                        String selectedStatus = existing != null ? existing.getStatus() : "PRESENT";
                        String notes = existing != null && existing.getNotes() != null ? existing.getNotes() : "";
                    %>
                    <form action="<%= request.getContextPath() %>/admin/attendance?action=mark" method="POST" class="grid grid-cols-1 items-center gap-3 rounded-lg border border-slate-200 p-3 md:grid-cols-12">
                        <input type="hidden" name="workerId" value="<%= aw.user.getId() %>" />
                        <input type="hidden" name="projectId" value="<%= selectedProject.getId() %>" />
                        <input type="hidden" name="date" value="<%= attendanceDate %>" />

                        <div class="md:col-span-3">
                            <p class="text-sm font-semibold text-slate-800"><%= aw.user.getFullName() %></p>
                            <p class="text-xs text-slate-500"><%= aw.assignedRole != null ? aw.assignedRole : "Worker" %></p>
                        </div>

                        <div class="md:col-span-2">
                            <select name="status" class="w-full rounded-lg border border-slate-300 bg-white px-3 py-2 text-sm outline-none focus:border-orange-400">
                                <option value="PRESENT" <%= "PRESENT".equals(selectedStatus) ? "selected" : "" %>>Present</option>
                                <option value="ABSENT" <%= "ABSENT".equals(selectedStatus) ? "selected" : "" %>>Absent</option>
                                <option value="HALF_DAY" <%= "HALF_DAY".equals(selectedStatus) ? "selected" : "" %>>Half Day</option>
                            </select>
                        </div>

                        <div class="md:col-span-5">
                            <input type="text" name="notes" value="<%= notes %>" placeholder="Optional notes" class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm outline-none focus:border-orange-400" />
                        </div>

                        <div class="md:col-span-2 text-right">
                            <button type="submit" class="rounded-lg bg-blue-600 px-3 py-2 text-sm font-semibold text-white hover:bg-blue-700">Update</button>
                        </div>
                    </form>
                    <% } %>
                </div>
            </div>
            <% } else { %>
            <div class="rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                <h2 class="mb-3 text-lg font-bold text-slate-800">Attendance Records</h2>

                <% if (records.isEmpty()) { %>
                <div class="rounded-lg border border-dashed border-slate-300 p-8 text-center text-sm text-slate-500">
                    No attendance records found for the selected filter.
                </div>
                <% } %>

                <div class="space-y-3">
                    <% for (Attendance row : records) { %>
                    <div class="flex flex-col justify-between gap-3 rounded-lg border border-slate-200 p-3 md:flex-row md:items-center">
                        <div>
                            <p class="text-sm font-semibold text-slate-800"><%= row.getWorkerName() %></p>
                            <p class="text-xs text-slate-500"><%= row.getProjectName() %> • Marked by: <%= row.getMarkedByName() != null ? row.getMarkedByName() : "N/A" %></p>
                        </div>
                        <div class="flex items-center gap-3">
                            <span class="rounded-full px-2.5 py-1 text-xs font-bold <%= row.getStatusBadgeClass() %>"><%= row.getStatusDisplayName() %></span>
                            <a href="<%= request.getContextPath() %>/admin/attendance?action=mark&pid=<%= row.getProjectId() %>&date=<%= attendanceDate %>" class="rounded-lg border border-slate-300 bg-white px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50">Edit</a>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>

        </main>
    </div>
</div>

<script>lucide.createIcons();</script>
</body>
</html>