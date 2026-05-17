<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    com.buildtrack.model.User worker = (com.buildtrack.model.User) request.getAttribute("worker");

    String mode = (String) request.getAttribute("formMode");
    if (mode == null || mode.isBlank()) {
        mode = request.getParameter("mode");
    }
    if (mode == null || mode.isBlank()) {
        mode = "create";
    }

    String workerId = request.getParameter("id");
    boolean hasId = workerId != null && !workerId.isBlank();
    boolean viewMode = "view".equalsIgnoreCase(mode);
    boolean editMode = "edit".equalsIgnoreCase(mode);

    String formTitle = viewMode ? "Worker Details" : (editMode ? "Edit Worker" : "Add Worker");
    String formSubtitle = viewMode
            ? "Review worker profile, role, and assignment details."
            : (editMode
            ? "Update worker information and assignment details."
            : "Create a new worker profile for project allocation.");

    String lockFields = viewMode ? "readonly" : "";
    String disableInputs = viewMode ? "disabled" : "";

    String fullNameValue = request.getParameter("fullName");
    if ((fullNameValue == null || fullNameValue.isBlank()) && worker != null && worker.getFullName() != null) {
        fullNameValue = worker.getFullName();
    }
    if (fullNameValue == null) fullNameValue = "";

    String emailValue = request.getParameter("email");
    if ((emailValue == null || emailValue.isBlank()) && worker != null && worker.getEmail() != null) {
        emailValue = worker.getEmail();
    }
    if (emailValue == null) emailValue = "";

    String phoneValue = request.getParameter("phone");
    if ((phoneValue == null || phoneValue.isBlank()) && worker != null && worker.getPhone() != null) {
        phoneValue = worker.getPhone();
    }
    if (phoneValue == null) phoneValue = "";

    String skillValue = request.getParameter("role");
    if ((skillValue == null || skillValue.isBlank()) && worker != null && worker.getRoleDisplayName() != null) {
        skillValue = worker.getRoleDisplayName();
    }
    if (skillValue == null) skillValue = "";

    Integer assignedProjectId = (Integer) request.getAttribute("assignedProjectId");
    java.util.List<com.buildtrack.model.Project> projects = (java.util.List<com.buildtrack.model.Project>) request.getAttribute("projects");

    String statusValue = request.getParameter("status");
    if ((statusValue == null || statusValue.isBlank()) && worker != null && worker.getStatus() != null) {
        statusValue = worker.getStatus();
    }
    if (statusValue == null) statusValue = "APPROVED";
    if (statusValue.equalsIgnoreCase("APPROVED") || statusValue.equalsIgnoreCase("ACTIVE")) statusValue = "Active";
    else if (statusValue.equalsIgnoreCase("DEACTIVATED")) statusValue = "Deactivated";
    else if (statusValue.equalsIgnoreCase("PENDING")) statusValue = "Pending";

    String dailyWageValue = request.getParameter("dailyWage");
    if ((dailyWageValue == null || dailyWageValue.isBlank()) && worker != null && worker.getDailyWage() != null) {
        dailyWageValue = worker.getDailyWage().toPlainString();
    }
    if (dailyWageValue == null) dailyWageValue = "0.00";
%>

<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Worker Form - BuildTrack</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">
<div class="h-screen">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-y-auto w-full max-w-full">
        <div class="sticky top-0 z-20">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-4 sm:p-6 lg:p-8">
            <section class="rounded-2xl border border-slate-200 bg-white px-6 py-6 shadow-sm">
                <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                    <div>
                        <h1 class="text-3xl font-bold tracking-tight text-slate-900"><%= formTitle %></h1>
                        <p class="mt-2 text-base text-slate-600"><%= formSubtitle %></p>
                        <% if (hasId) { %>
                            <p class="mt-2 text-sm font-medium text-slate-500">Worker ID: #<%= workerId %></p>
                        <% } %>
                    </div>
                    <a href="<%= request.getContextPath() %>/admin/workers" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                        <i data-lucide="arrow-left" class="h-4 w-4"></i>
                        Back to Workers
                    </a>
                </div>
            </section>

            <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">

                <form class="space-y-6" method="post" action="<%= request.getContextPath() %>/admin/workers">
                    <input type="hidden" name="mode" value="<%= mode %>" />
                    <% if (hasId) { %><input type="hidden" name="id" value="<%= workerId %>" /><% } %>

                    <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                        <div class="md:col-span-2 border-l-4 border-orange-500 pl-4">
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Full Name</label>
                            <input type="text" name="fullName" value="<%= fullNameValue %>" placeholder="Enter worker full name" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Email</label>
                            <input type="email" name="email" value="<%= emailValue %>" placeholder="worker@example.com" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Phone Number</label>
                            <input type="tel" name="phone" value="<%= phoneValue %>" placeholder="98XXXXXXXX" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Skill / Role</label>
                            <input type="text" name="role" value="<%= skillValue %>" placeholder="Mason, Electrician, Plumber..." <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Assigned Project</label>
                            <select name="projectId" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>">
                                <option value="">Unassigned</option>
                                <% if (projects != null) {
                                    for (com.buildtrack.model.Project p : projects) {
                                        boolean isSelected = (assignedProjectId != null && assignedProjectId.equals(p.getId()));
                                %>
                                        <option value="<%= p.getId() %>" <%= isSelected ? "selected" : "" %>><%= p.getTitle() %></option>
                                <%  }
                                } %>
                            </select>
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Joining Date</label>
                            <input type="date" name="joiningDate" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Status</label>
                            <select name="status" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>">
                                <option <%= "Active".equals(statusValue) ? "selected" : "" %> value="Active">Active</option>
                                <option <%= "Deactivated".equals(statusValue) ? "selected" : "" %> value="Deactivated">Deactivated</option>
                                <% if ("Pending".equals(statusValue)) { %>
                                <option selected value="Pending">Pending</option>
                                <% } %>
                            </select>
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Daily Wage (NPR)</label>
                            <input type="number" step="0.01" min="0" name="dailyWage" value="<%= dailyWageValue %>" placeholder="Enter daily wage" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-3 border-t border-slate-200 pt-4">
                        <% if (viewMode) { %>
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=edit<%= hasId ? "&id=" + workerId : "" %>" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                                <i data-lucide="pencil" class="h-4 w-4"></i>
                                Edit Worker
                            </a>
                        <% } else { %>
                            <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                                <i data-lucide="save" class="h-4 w-4"></i>
                                <%= editMode ? "Update Worker" : "Save Worker" %>
                            </button>
                            <button type="reset" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                                <i data-lucide="rotate-ccw" class="h-4 w-4"></i>
                                Reset
                            </button>
                        <% } %>
                    </div>
                </form>
            </section>
        </main>
    </div>
</div>

<script>
    lucide.createIcons();
</script>
</body>
</html>

