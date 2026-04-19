<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

    boolean viewMode = "view".equalsIgnoreCase(mode);
    boolean editMode = "edit".equalsIgnoreCase(mode);

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
    <div class="fixed inset-y-0 left-0 z-30 w-56">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-y-auto">
        <div class="sticky top-0 z-20">
            <jsp:include page="../common/adminTopbar.jsp" />
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
                    <input type="hidden" name="action" value="<%= editMode ? "update" : "create" %>" />
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
                            <input name="clientId" type="number" value="<%= projectClientIdValue %>" placeholder="Client ID" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Total Budget (Rs)</label>
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
                            <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                                <i data-lucide="save" class="h-4 w-4"></i>
                                <%= editMode ? "Update Project" : "Save Project" %>
                            </button>
                            <button type="button" class="inline-flex items-center gap-2 rounded-lg border border-rose-300 bg-rose-50 px-4 py-2 text-sm font-semibold text-rose-700 transition hover:bg-rose-100">
                                <i data-lucide="trash-2" class="h-4 w-4"></i>
                                Delete Project
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
