<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    com.buildtrack.model.Project project = (com.buildtrack.model.Project) request.getAttribute("project");

    String mode = (String) request.getAttribute("formMode");
    if (mode == null || mode.isBlank()) {
        mode = request.getParameter("mode");
    }
    if (mode == null || mode.isBlank()) {
        mode = "create";
    }

    String projectId = (String) request.getAttribute("projectId");
    if (projectId == null || projectId.isBlank()) {
        projectId = request.getParameter("id");
    }
    if ((projectId == null || projectId.isBlank()) && project != null && project.getId() > 0) {
        projectId = String.valueOf(project.getId());
    }

    String projectTitleValue = (String) request.getAttribute("title");
    if ((projectTitleValue == null || projectTitleValue.isBlank()) && project != null && project.getTitle() != null) {
        projectTitleValue = project.getTitle();
    }
    if (projectTitleValue == null) {
        projectTitleValue = "";
    }

    String projectDescriptionValue = (String) request.getAttribute("description");
    if ((projectDescriptionValue == null || projectDescriptionValue.isBlank()) && project != null && project.getDescription() != null) {
        projectDescriptionValue = project.getDescription();
    }
    if (projectDescriptionValue == null) {
        projectDescriptionValue = "";
    }

    String projectClientIdValue = (String) request.getAttribute("clientId");
    if ((projectClientIdValue == null || projectClientIdValue.isBlank()) && project != null && project.getClientId() != null) {
        projectClientIdValue = String.valueOf(project.getClientId());
    }
    if (projectClientIdValue == null) {
        projectClientIdValue = "";
    }

    String projectBudgetValue = (String) request.getAttribute("totalBudget");
    if ((projectBudgetValue == null || projectBudgetValue.isBlank()) && project != null && project.getTotalBudget() != null) {
        projectBudgetValue = project.getTotalBudget().toPlainString();
    }
    if (projectBudgetValue == null) {
        projectBudgetValue = "";
    }

    String projectStartDateValue = (String) request.getAttribute("startDate");
    if ((projectStartDateValue == null || projectStartDateValue.isBlank()) && project != null && project.getStartDate() != null) {
        projectStartDateValue = project.getStartDate().toString();
    }
    if (projectStartDateValue == null) {
        projectStartDateValue = "";
    }

    String projectEndDateValue = (String) request.getAttribute("endDate");
    if ((projectEndDateValue == null || projectEndDateValue.isBlank()) && project != null && project.getEndDate() != null) {
        projectEndDateValue = project.getEndDate().toString();
    }
    if (projectEndDateValue == null) {
        projectEndDateValue = "";
    }

    String projectStatusValue = (String) request.getAttribute("status");
    if ((projectStatusValue == null || projectStatusValue.isBlank()) && project != null && project.getStatus() != null) {
        projectStatusValue = project.getStatus();
    }
    if (projectStatusValue == null || projectStatusValue.isBlank()) {
        projectStatusValue = "PLANNED";
    }

    request.setAttribute("selectedClientId", projectClientIdValue);

    boolean viewMode = "view".equalsIgnoreCase(mode);
    boolean editMode = "edit".equalsIgnoreCase(mode);
    String defaultAction = editMode ? "update" : "create";

    String formTitle = viewMode ? "Project Details" : (editMode ? "Edit Project" : "Add Project");
    String formSubtitle = viewMode
            ? "Review project information and current status."
            : (editMode
            ? "Update project details, timeline, budget, and status."
            : "Enter the new project information to create a project record.");
    String lockFields = viewMode ? "readonly" : "";
    String disableInputs = viewMode ? "disabled" : "";
%>

<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Project Form</title>
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
                    </div>
                    <a href="<%= request.getContextPath() %>/admin/projects" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                        <i data-lucide="arrow-left" class="h-4 w-4"></i>
                        Back to Projects
                    </a>
                </div>
            </section>

            <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <form method="post" action="<%= request.getContextPath() %>/admin/projects" class="space-y-6">
                    <input type="hidden" id="projectActionField" name="action" value="<%= defaultAction %>" />
                    <input type="hidden" name="id" value="<%= projectId == null ? "" : projectId %>" />
                    <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                        <div class="md:col-span-2">
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Project Title</label>
                            <input name="title" type="text" value="<%= projectTitleValue %>" placeholder="Enter project title" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div class="md:col-span-2">
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Description</label>
                            <textarea name="description" rows="4" placeholder="Describe scope, goals, and key notes" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>"><%= projectDescriptionValue %></textarea>
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Client</label>
                            <select name="clientId" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>">
                                <option value="">Unassigned</option>
                                <c:forEach var="client" items="${clients}">
                                    <option value="${client.id}" ${client.id == selectedClientId ? 'selected' : ''}>${client.fullName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Total Budget (NPR)</label>
                            <input name="totalBudget" type="number" value="<%= projectBudgetValue %>" placeholder="5000000" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Start Date</label>
                            <input name="startDate" type="date" value="<%= projectStartDateValue %>" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">End Date</label>
                            <input name="endDate" type="date" value="<%= projectEndDateValue %>" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Status</label>
                            <select name="status" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>">
                                <option value="PLANNED" <%= "PLANNED".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>Planned</option>
                                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>In Progress</option>
                                <option value="COMPLETED" <%= "COMPLETED".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>Completed</option>
                                <option value="ON_HOLD" <%= "ON_HOLD".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>On Hold</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-3 border-t border-slate-200 pt-4">
                        <% if (viewMode) { %>
                            <a href="<%= request.getContextPath() %>/admin/projects?action=edit&id=<%= projectId == null ? "" : projectId %>" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                                <i data-lucide="pencil" class="h-4 w-4"></i>
                                Edit Project
                            </a>
                        <% } else { %>
                            <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600" onclick="document.getElementById('projectActionField').value='<%= defaultAction %>'">
                                <i data-lucide="save" class="h-4 w-4"></i>
                                <%= editMode ? "Update Project" : "Save Project" %>
                            </button>
                            <% if (editMode && projectId != null && !projectId.isBlank()) { %>
                                <button type="submit" class="inline-flex items-center gap-2 rounded-lg border border-rose-300 bg-rose-50 px-4 py-2 text-sm font-semibold text-rose-700 transition hover:bg-rose-100" onclick="document.getElementById('projectActionField').value='delete'; return confirm('Delete this project? This action cannot be undone.');">
                                    <i data-lucide="trash-2" class="h-4 w-4"></i>
                                    Delete Project
                                </button>
                            <% } %>
                            <button type="reset" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100" onclick="document.getElementById('projectActionField').value='<%= defaultAction %>'">
                                <i data-lucide="rotate-ccw" class="h-4 w-4"></i>
                                Reset
                            </button>
                        <% } %>
                    </div>
                </form>
                
                <c:if test="${not empty projectDocuments}">
                    <div class="mt-8 border-t border-slate-200 pt-6">
                        <h3 class="text-lg font-bold text-slate-800 mb-4">Project Documents</h3>
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                            <c:forEach var="doc" items="${projectDocuments}">
                                <div class="flex items-start gap-3 rounded-xl border border-slate-200 bg-slate-50 p-4">
                                    <div class="mt-1 flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-blue-100 text-blue-600">
                                        <i data-lucide="file-text" class="h-5 w-5"></i>
                                    </div>
                                    <div class="min-w-0 flex-1">
                                        <p class="truncate text-sm font-semibold text-slate-900" title="${doc.fileName}">${doc.fileName}</p>
                                        <p class="text-xs text-slate-500">${doc.fileSize / 1024} KB</p>
                                        <a href="<%= request.getContextPath() %>/${doc.filePath}" target="_blank" class="mt-2 inline-block text-xs font-medium text-orange-600 hover:text-orange-700">View Document &rarr;</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
            </section>
        </main>
    </div>
</div>

<script>
    lucide.createIcons();
</script>
</body>
</html>
