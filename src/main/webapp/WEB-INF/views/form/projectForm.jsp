<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
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
                    <input type="hidden" name="mode" value="<%= editMode ? "edit" : "create" %>" />
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
                            <input name="client" type="text" value="<%= projectClientValue %>" placeholder="Client name" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Total Budget (Rs)</label>
                            <input name="budget" type="number" value="<%= projectBudgetValue %>" placeholder="5000000" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
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
                                <option <%= "Planned".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>Planned</option>
                                <option <%= "In Progress".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>In Progress</option>
                                <option <%= "Completed".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>Completed</option>
                                <option <%= "On Hold".equalsIgnoreCase(projectStatusValue) ? "selected" : "" %>>On Hold</option>
                            </select>
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-3 border-t border-slate-200 pt-4">
                        <% if (viewMode) { %>
                            <a href="<%= request.getContextPath() %>/admin/projects/<%= projectId == null ? "" : projectId %>/edit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
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
