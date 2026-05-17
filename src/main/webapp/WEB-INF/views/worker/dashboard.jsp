<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="com.buildtrack.model.Project" %>
<%@ page import="com.buildtrack.model.WorkLog" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Worker";
    String basePath = request.getContextPath();

    Integer presentCount = (Integer) request.getAttribute("presentCount");
    Integer halfDayCount = (Integer) request.getAttribute("halfDayCount");
    int totalPunchedInDays = (presentCount != null ? presentCount : 0) + (halfDayCount != null ? halfDayCount : 0);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Worker Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
        }
        .glass-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px -1px rgba(0, 0, 0, 0.1);
        }
        .gradient-text {
            color: #ea580c;
        }
        .hover-lift {
            /* hover lift effect disabled */
        }
    </style>
</head>

<body class="text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">

<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">

    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Area -->
    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden">

        <!-- TOP NAVBAR -->
        <div class="w-full shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

            <%-- Debug panel: show session info when ?debug=true --%>
            <%
                String showDebug = request.getParameter("debug");
                if ("true".equals(showDebug)) {
                    Object sessUser = session.getAttribute("user");
                    Object userId = session.getAttribute("userId");
                    Object userRole = session.getAttribute("userRole");
                    Object userName = session.getAttribute("userName");
            %>
            <div style="background:#fff4e6;border:1px solid #f1c40f;padding:8px;border-radius:8px;margin:12px;">
                <strong>DEBUG</strong>: session.user = <%= sessUser %> | userId = <%= userId %> | userRole = <%= userRole %> | userName = <%= userName %>
            </div>
            <%
                }
            %>

        <!-- CONTENT -->
        <div class="px-8 py-6 overflow-y-auto grow space-y-8">

                <!-- Welcome Section -->
                <section class="glass-card rounded-xl px-6 py-6 flex flex-col md:flex-row items-center justify-between">
                    <div>
                        <h1 class="text-3xl font-bold tracking-tight text-slate-900 mb-1">
                            Welcome back, <span class="gradient-text"><%= displayName %></span>
                        </h1>
                        <p class="text-slate-500 font-medium text-sm">
                            Here is what's happening with your assignments today.
                        </p>
                    </div>
                    <div class="mt-4 md:mt-0">
                        <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-green-50 text-green-700 font-semibold text-xs border border-green-200 shadow-sm">
                            <span class="w-2 h-2 rounded-full bg-green-500 animate-pulse"></span>
                            Active Site
                        </span>
                    </div>
                </section>

                <!-- Top Grid -->
                <%
                    List<Project> assignedProjects = (List<Project>) request.getAttribute("assignedProjects");
                    Project currentProject = (assignedProjects != null && !assignedProjects.isEmpty()) ? assignedProjects.get(0) : null;
                %>
                <div class="grid grid-cols-1 xl:grid-cols-3 gap-8">

                    <!-- Assignment Card -->
                    <article class="xl:col-span-2 glass-card rounded-xl p-6 hover-lift">
                        <div class="flex flex-col gap-6">
                            <div class="flex flex-wrap items-start justify-between gap-4">
                                <div>
                                    <div class="inline-flex items-center gap-2 rounded-full bg-orange-50 px-3 py-1.5 text-xs font-semibold uppercase tracking-wide text-orange-700 border border-orange-100">
                                        <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-2M9 5a2 2 0 0 0 2 2h2a2 2 0 0 0 2-2"></path>
                                        </svg>
                                        Current Assignment
                                    </div>
                                    <h2 class="mt-3 text-3xl font-bold text-slate-900"><%= (currentProject != null) ? currentProject.getTitle() : "No current assignment" %></h2>
                                    <p class="mt-1 text-sm font-medium text-slate-500"><%= (currentProject != null && currentProject.getStatus()!=null) ? currentProject.getStatus() : "-" %></p>
                                </div>
                                <span class="inline-flex items-center gap-2 rounded-full bg-orange-50 px-3 py-1.5 text-xs font-semibold text-orange-700 border border-orange-200">
                                    <span class="h-2.5 w-2.5 rounded-full bg-orange-500"></span>
                                    Active Site
                                </span>
                            </div>

                            <div class="grid grid-cols-1 gap-4 sm:grid-cols-3">
                                 <div class="rounded-xl border border-slate-100 bg-slate-50 p-4">
                                     <div class="text-xs uppercase tracking-wider text-slate-400 font-semibold">Role</div>
                                     <div class="mt-2 flex items-center gap-2 text-sm font-semibold text-slate-800">
                                         <%= (currentProject != null) ? "Assigned" : "-" %>
                                     </div>
                                 </div>
                                 <div class="rounded-xl border border-slate-100 bg-slate-50 p-4">
                                     <div class="text-xs uppercase tracking-wider text-slate-400 font-semibold">Duration</div>
                                     <div class="mt-2 flex items-center gap-2 text-sm font-semibold text-slate-800">
                                         <%= (currentProject != null) ? ((currentProject.getStartDate()!=null?currentProject.getStartDate():"-") + " → " + (currentProject.getEndDate()!=null?currentProject.getEndDate():"-")) : "-" %>
                                     </div>
                                 </div>
                                 <div class="rounded-xl border border-slate-100 bg-slate-50 p-4">
                                     <div class="text-xs uppercase tracking-wider text-slate-400 font-semibold">Status</div>
                                     <div class="mt-2 flex items-center gap-2 text-sm font-semibold text-slate-800">
                                         <%= (currentProject != null && currentProject.getStatus() != null) ? currentProject.getStatus() : "-" %>
                                     </div>
                                 </div>
                            </div>
                        </div>
                    </article>

                    <!-- Status with DONUT -->
                    <article class="glass-card rounded-2xl p-6 flex flex-col justify-between hover-lift">
                        <div>
                            <div class="flex justify-between items-center mb-6">
                                <h3 class="text-lg font-bold text-slate-800">Today's Status</h3>
                                <span class="bg-indigo-50 text-indigo-700 p-2 rounded-xl border border-indigo-100">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                </span>
                            </div>

                            <div class="text-center mb-6">
                                <div class="inline-flex items-center gap-2 text-xl font-bold text-slate-800 mb-1">
                                    <span class="w-3 h-3 rounded-full bg-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.5)]"></span>
                                    <%= totalPunchedInDays %> Days Punched In
                                </div>
                                <div class="text-sm text-slate-500 font-medium">Total logged attendance this month</div>
                            </div>


                        </div>


                    </article>
                </div>

                <!-- Bottom Grid -->
                <div class="grid grid-cols-1 xl:grid-cols-3 gap-8 pb-8">

                    <!-- Work Log -->
                    <article class="xl:col-span-3 glass-card rounded-2xl p-6 hover-lift">
                        <div class="flex justify-between items-center mb-6">
                            <div class="flex items-center gap-3">
                                <div class="w-10 h-10 rounded-xl bg-purple-50 border border-purple-100 flex items-center justify-center text-purple-600 shadow-inner">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path></svg>
                                </div>
                                <h3 class="text-lg font-bold text-slate-800">Recent Work Log</h3>
                            </div>
                            <a href="<%= basePath %>/worker/worklog" class="group flex items-center text-indigo-600 text-xs font-semibold hover:text-indigo-800 transition-colors bg-indigo-50 px-3 py-1.5 rounded-lg shadow-sm border border-indigo-100">
                                View All
                                <svg class="w-3.5 h-3.5 ml-1 transform group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                            </a>
                        </div>

                        <div class="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
                            <table class="w-full text-sm text-left">
                                <thead class="bg-slate-50 text-slate-500 font-semibold uppercase text-xs tracking-wider border-b border-slate-200">
                                <tr>
                                    <th class="py-4 px-6 rounded-tl-2xl">Date</th>
                                    <th class="py-4 px-6">Activity</th>
                                    <th class="py-4 px-6 text-center">Duration</th>
                                    <th class="py-4 px-6 rounded-tr-2xl">Status</th>
                                </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100">
                                <%
                                    List<WorkLog> recentLogs = (List<WorkLog>) request.getAttribute("recentLogs");
                                    if (recentLogs != null && !recentLogs.isEmpty()) {
                                        for (WorkLog wl : recentLogs) {
                                %>
                                <tr class="hover:bg-white transition-colors">
                                    <td class="py-4 px-6 font-semibold text-slate-800 flex items-center gap-3">
                                        <div class="w-2.5 h-2.5 rounded-full bg-slate-300 shadow-sm"></div>
                                        <%= (wl.getLogDate() != null) ? wl.getLogDate().toString() : "-" %>
                                    </td>
                                    <td class="py-4 px-6 font-medium text-slate-600"><%= (wl.getDescription()!=null)? wl.getDescription() : (wl.getProjectName()!=null?wl.getProjectName():"-") %></td>
                                    <td class="py-4 px-6 text-center font-semibold text-slate-700">-</td>
                                    <td class="py-4 px-6">
                                        <span class="inline-flex items-center gap-1.5 bg-amber-50 text-amber-700 border border-amber-200 px-2.5 py-1.5 rounded-lg text-xs font-bold shadow-sm">
                                            <%= (wl.getStatus()!=null)? wl.getStatus(): "Pending" %>
                                        </span>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="4" class="py-6 px-6 text-center text-sm text-slate-500">No recent work logs.</td>
                                </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </article>

                </div>

        </div>

    </main>
</div>

</body>
</html>

