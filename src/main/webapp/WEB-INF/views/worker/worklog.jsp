<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="com.buildtrack.model.WorkLog" %>
<%@ page import="com.buildtrack.model.Project" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Worker";
    String basePath = request.getContextPath();

    List<Project> assignedProjects = (List<Project>) request.getAttribute("assignedProjects");
    if (assignedProjects == null) assignedProjects = Collections.emptyList();

    List<WorkLog> workLogs = (List<WorkLog>) request.getAttribute("workLogs");
    if (workLogs == null) workLogs = Collections.emptyList();

    String currentMonth = (String) request.getAttribute("currentMonth");
    if (currentMonth == null || currentMonth.isBlank()) {
        currentMonth = new SimpleDateFormat("yyyy-MM").format(new java.util.Date());
    }

    String success = (String) session.getAttribute("success");
    if (success != null) {
        session.removeAttribute("success");
    }

    List<String> errors = (List<String>) request.getAttribute("errors");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Work Log</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">
<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">
    <jsp:include page="../common/sidebar.jsp" />

    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden bg-slate-50/50">
        <div class="w-full shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <div class="px-8 py-6 overflow-y-auto grow">
                <div class="mb-6">
                    <h1 class="text-2xl font-bold text-slate-800 tracking-tight">Work Log</h1>
                    <p class="text-sm text-slate-500 mt-1 font-medium">Submit daily progress and review your history</p>
                </div>

                <% if (success != null) { %>
                <div class="mb-5 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm font-medium text-emerald-700">
                    <%= success %>
                </div>
                <% } %>

                <% if (errors != null && !errors.isEmpty()) { %>
                <div class="mb-5 rounded-xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm font-medium text-rose-700">
                    <ul class="list-disc pl-5">
                        <% for (String error : errors) { %>
                        <li><%= error %></li>
                        <% } %>
                    </ul>
                </div>
                <% } %>

                <div class="grid grid-cols-1 xl:grid-cols-3 gap-8">
                    <section class="xl:col-span-1 bg-white rounded-2xl border border-slate-200 shadow-sm p-6">
                        <div class="flex items-center gap-2 mb-4">
                            <div class="w-10 h-10 rounded-xl bg-amber-50 flex items-center justify-center text-amber-600">
                                <i data-lucide="file-pen-line" class="w-5 h-5"></i>
                            </div>
                            <div>
                                <h2 class="text-lg font-bold text-slate-800">Submit Work Log</h2>
                                <p class="text-xs text-slate-500">Project reference, date, description</p>
                            </div>
                        </div>

                        <form action="<%= basePath %>/worker/worklog" method="POST" class="space-y-4">
                            <div>
                                <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Project</label>
                                <select name="projectId" required class="w-full rounded-lg border border-slate-200 bg-slate-50/70 px-3 py-2.5 text-sm outline-none focus:border-amber-400 focus:ring-1 focus:ring-amber-400">
                                    <option value="">Select project</option>
                                    <% for (Project project : assignedProjects) { %>
                                    <option value="<%= project.getId() %>"><%= project.getTitle() %></option>
                                    <% } %>
                                </select>
                            </div>

                            <div>
                                <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Date</label>
                                <input type="date" name="date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                                       class="w-full rounded-lg border border-slate-200 bg-slate-50/70 px-3 py-2.5 text-sm outline-none focus:border-amber-400 focus:ring-1 focus:ring-amber-400" />
                            </div>

                            <div>
                                <label class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Description</label>
                                <textarea name="description" rows="5" placeholder="Describe the work completed today..."
                                          class="w-full rounded-lg border border-slate-200 bg-slate-50/70 px-3 py-2.5 text-sm outline-none focus:border-amber-400 focus:ring-1 focus:ring-amber-400"></textarea>
                            </div>

                            <button type="submit" class="w-full inline-flex items-center justify-center gap-2 rounded-lg bg-amber-500 px-4 py-2.5 text-sm font-semibold text-white shadow-sm transition hover:bg-amber-600">
                                <i data-lucide="save" class="w-4 h-4"></i>
                                Save Work Log
                            </button>
                        </form>
                    </section>

                    <section class="xl:col-span-2 bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden">
                        <div class="flex items-center justify-between gap-4 border-b border-slate-200 px-6 py-4 bg-slate-50/70">
                            <div>
                                <h2 class="text-lg font-bold text-slate-800">History</h2>
                                <p class="text-xs text-slate-500">Current month: <%= currentMonth %></p>
                            </div>
                            <form action="<%= basePath %>/worker/worklog" method="GET" class="flex items-center gap-2">
                                <input type="month" name="month" value="<%= currentMonth %>" class="rounded-lg border border-slate-200 bg-white px-3 py-2 text-sm outline-none" />
                                <button type="submit" class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white">Filter</button>
                            </form>
                        </div>

                        <div class="divide-y divide-slate-100">
                            <% if (workLogs.isEmpty()) { %>
                            <div class="px-6 py-12 text-center text-sm text-slate-400">
                                <div class="flex flex-col items-center gap-2">
                                    <i data-lucide="clipboard-list" class="w-10 h-10 text-slate-300"></i>
                                    <span>No work logs found for this month.</span>
                                </div>
                            </div>
                            <% } else { %>
                                <% for (WorkLog log : workLogs) { %>
                            <article class="px-6 py-5 hover:bg-slate-50/70 transition-colors">
                                <div class="flex items-start justify-between gap-4">
                                    <div>
                                        <div class="flex items-center gap-2 mb-1">
                                            <h3 class="text-base font-semibold text-slate-800"><%= log.getProjectName() != null ? log.getProjectName() : ("Project #" + log.getProjectId()) %></h3>
                                            <span class="rounded-full bg-slate-100 px-2.5 py-1 text-[11px] font-bold uppercase tracking-wider text-slate-500"><%= log.getLogDate() != null ? log.getLogDate().toString() : "-" %></span>
                                        </div>
                                        <p class="text-sm leading-6 text-slate-600"><%= log.getDescription() != null ? log.getDescription() : "-" %></p>
                                    </div>
                                </div>
                            </article>
                                <% } %>
                            <% } %>
                        </div>
                    </section>
                </div>
        </div>
    </main>
</div>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
</body>
</html>
