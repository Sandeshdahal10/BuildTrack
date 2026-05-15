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
            background: rgba(255, 255, 255, 0.7);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.5);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
        }
        .gradient-text {
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .hover-lift {
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .hover-lift:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
    </style>
</head>

<body class="text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">

<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">
    <!-- Decorative background elements -->
    <div class="absolute top-[-10%] left-[-10%] w-[30rem] h-[30rem] bg-blue-400 rounded-full mix-blend-multiply filter blur-[100px] opacity-20"></div>
    <div class="absolute top-[20%] right-[-10%] w-[30rem] h-[30rem] bg-purple-400 rounded-full mix-blend-multiply filter blur-[100px] opacity-20"></div>
    <div class="absolute bottom-[-10%] left-[20%] w-[30rem] h-[30rem] bg-indigo-400 rounded-full mix-blend-multiply filter blur-[100px] opacity-20"></div>

    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Area -->
    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden">

        <!-- TOP NAVBAR -->
        <div class="px-8 pt-6 pb-2 shrink-0">
            <jsp:include page="../common/adminTopbar.jsp" />
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
        <div class="px-8 py-6 overflow-y-auto grow">
            <div class="max-w-7xl mx-auto space-y-8">

                <!-- Welcome Section -->
                <section class="glass-card rounded-3xl px-8 py-8 flex flex-col md:flex-row items-center justify-between">
                    <div>
                        <h1 class="text-4xl font-extrabold tracking-tight mb-2">
                            Welcome back, <span class="gradient-text"><%= displayName %></span>
                        </h1>
                        <p class="text-slate-500 font-medium text-lg">
                            Here is what's happening with your assignments today.
                        </p>
                    </div>
                    <div class="mt-4 md:mt-0">
                        <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-green-100/80 backdrop-blur-sm text-green-700 font-semibold text-sm shadow-sm border border-green-200">
                            <span class="w-2.5 h-2.5 rounded-full bg-green-500 animate-pulse"></span>
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
                    <article class="xl:col-span-2 glass-card rounded-3xl p-8 shadow-xl hover-lift">
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
                                <div class="rounded-2xl border border-orange-100/70 bg-white/70 p-4">
                                    <div class="text-xs uppercase tracking-wider text-slate-400 font-semibold">Role</div>
                                    <div class="mt-2 flex items-center gap-2 text-sm font-semibold text-slate-800">
                                        <%= (currentProject != null) ? "Assigned" : "-" %>
                                    </div>
                                </div>
                                <div class="rounded-2xl border border-orange-100/70 bg-white/70 p-4">
                                    <div class="text-xs uppercase tracking-wider text-slate-400 font-semibold">Duration</div>
                                    <div class="mt-2 flex items-center gap-2 text-sm font-semibold text-slate-800">
                                        <%= (currentProject != null) ? ((currentProject.getStartDate()!=null?currentProject.getStartDate():"-") + " → " + (currentProject.getEndDate()!=null?currentProject.getEndDate():"-")) : "-" %>
                                    </div>
                                </div>
                                <div class="rounded-2xl border border-orange-100/70 bg-white/70 p-4">
                                    <div class="text-xs uppercase tracking-wider text-slate-400 font-semibold">Status</div>
                                    <div class="mt-2 flex items-center gap-2 text-sm font-semibold text-slate-800">
                                        <%= (currentProject != null && currentProject.getStatus() != null) ? currentProject.getStatus() : "-" %>
                                    </div>
                                </div>
                            </div>

                            <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between border-t border-slate-200/70 pt-5">
                                <div class="flex items-center">
                                    <div class="flex -space-x-3">
                                        <img class="w-9 h-9 rounded-full border-2 border-white shadow-sm" src="https://ui-avatars.com/api/?name=Alex+K&background=6366f1&color=fff" alt="Team">
                                        <img class="w-9 h-9 rounded-full border-2 border-white shadow-sm" src="https://ui-avatars.com/api/?name=Maria+J&background=ec4899&color=fff" alt="Team">
                                        <img class="w-9 h-9 rounded-full border-2 border-white shadow-sm" src="https://ui-avatars.com/api/?name=Sam+H&background=10b981&color=fff" alt="Team">
                                        <div class="w-9 h-9 rounded-full border-2 border-white bg-slate-100 text-[11px] flex items-center justify-center font-bold text-slate-700">+2</div>
                                    </div>
                                    <div class="ml-4 text-sm text-slate-500 font-medium">Team Members</div>
                                </div>
                                <button class="w-full sm:w-auto bg-orange-600 text-white px-5 py-2.5 rounded-xl text-sm font-semibold hover:bg-orange-700 transition-colors flex items-center justify-center gap-2">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path></svg>
                                    View Blueprint
                                </button>
                            </div>
                        </div>
                    </article>

                    <!-- Status with DONUT -->
                    <article class="glass-card rounded-3xl p-8 shadow-xl flex flex-col justify-between hover-lift">
                        <div>
                            <div class="flex justify-between items-center mb-6">
                                <h3 class="text-lg font-bold text-slate-800">Today's Status</h3>
                                <span class="bg-indigo-100/50 text-indigo-700 p-2 rounded-xl backdrop-blur-sm">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                </span>
                            </div>

                            <div class="text-center mb-6">
                                <div class="inline-flex items-center gap-2 text-xl font-bold text-slate-800 mb-1">
                                    <span class="w-3 h-3 rounded-full bg-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.5)]"></span>
                                    Punched In
                                </div>
                                <div class="text-sm text-slate-500 font-medium">Checked in at 07:54 AM</div>
                            </div>

                            <!-- Donut -->
                            <div class="relative w-40 h-40 mx-auto mb-6">
                                <svg class="w-full h-full -rotate-90 transform drop-shadow-md" viewBox="0 0 36 36">
                                    <path d="M18 2.5 a 15.5 15.5 0 1 1 0 31 a 15.5 15.5 0 1 1 0 -31"
                                          fill="none" stroke="#f1f5f9" stroke-width="3"/>
                                    <!-- 6.5 hours out of ~8 is ~81% => 81 of 100 -->
                                    <path d="M18 2.5 a 15.5 15.5 0 1 1 0 31 a 15.5 15.5 0 1 1 0 -31"
                                          fill="none" stroke="url(#gradient)" stroke-width="3.5"
                                          stroke-linecap="round"
                                          stroke-dasharray="81, 100" class="animate-[dash_1.5s_ease-out_forwards]"/>
                                    <defs>
                                        <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="0%">
                                            <stop offset="0%" stop-color="#3b82f6" />
                                            <stop offset="100%" stop-color="#8b5cf6" />
                                        </linearGradient>
                                    </defs>
                                </svg>
                                <style>
                                    @keyframes dash {
                                        from { stroke-dasharray: 0, 100; }
                                        to { stroke-dasharray: 81, 100; }
                                    }
                                </style>

                                <div class="absolute inset-0 flex flex-col items-center justify-center">
                                    <div class="text-4xl font-extrabold text-slate-800">6.5</div>
                                    <div class="text-xs font-bold text-slate-400 tracking-widest mt-1">HOURS</div>
                                </div>
                            </div>
                        </div>

                        <button class="w-full bg-gradient-to-r from-orange-400 to-red-500 text-white py-3.5 rounded-xl font-bold text-sm shadow-[0_4px_14px_0_rgba(249,115,22,0.39)] hover:shadow-[0_6px_20px_rgba(249,115,22,0.23)] hover:-translate-y-0.5 transition-all duration-200 flex items-center justify-center gap-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
                            Punch Out
                        </button>
                    </article>
                </div>

                <!-- Bottom Grid -->
                <div class="grid grid-cols-1 xl:grid-cols-3 gap-8 pb-8">

                    <!-- Summary -->
                    <article class="glass-card rounded-3xl p-8 shadow-xl hover-lift">
                        <div class="flex items-center gap-3 mb-6">
                            <div class="w-12 h-12 rounded-2xl bg-blue-100 flex items-center justify-center text-blue-600 shadow-inner">
                                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path></svg>
                            </div>
                            <h3 class="text-xl font-bold text-slate-800">April Summary</h3>
                        </div>

                        <div class="space-y-6">
                            <div class="group">
                                <div class="flex justify-between items-end mb-2">
                                    <div class="text-sm font-medium text-slate-500">Attendance</div>
                                    <div class="font-bold text-slate-800 group-hover:text-blue-600 transition-colors">92%</div>
                                </div>
                                <div class="w-full h-2.5 bg-slate-200/50 rounded-full overflow-hidden shadow-inner backdrop-blur-sm">
                                    <div class="h-full bg-gradient-to-r from-blue-400 to-blue-600 rounded-full w-[92%] relative">
                                        <div class="absolute top-0 right-0 bottom-0 w-8 bg-white/20 animate-[shimmer_2s_infinite]"></div>
                                    </div>
                                </div>
                                <style>
                                    @keyframes shimmer {
                                        0% { transform: translateX(-100%); }
                                        100% { transform: translateX(400%); }
                                    }
                                </style>
                            </div>

                            <div class="p-5 rounded-2xl bg-white/50 border border-slate-100 flex items-center justify-between hover:bg-white transition-colors cursor-pointer shadow-sm">
                                <div>
                                    <div class="text-sm font-medium text-slate-500 mb-1">Overtime</div>
                                    <div class="font-bold text-xl text-slate-800">14.5 <span class="text-sm font-medium text-slate-400">Hrs</span></div>
                                </div>
                                <div class="w-10 h-10 rounded-full bg-orange-100 flex items-center justify-center text-orange-500">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                </div>
                            </div>

                            <div class="p-5 rounded-2xl bg-gradient-to-r from-indigo-50/80 to-purple-50/80 border border-indigo-100/50 flex items-center justify-between hover:from-indigo-100 hover:to-purple-100 transition-colors cursor-pointer shadow-sm backdrop-blur-sm">
                                <div>
                                    <div class="text-sm font-medium text-indigo-800/60 mb-1">Est. Earnings</div>
                                    <div class="font-bold text-2xl text-indigo-900">Rs. 4,280</div>
                                </div>
                                <div class="w-10 h-10 rounded-full bg-indigo-200/50 flex items-center justify-center text-indigo-700">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08-.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                </div>
                            </div>
                        </div>
                    </article>

                    <!-- Work Log -->
                    <article class="xl:col-span-2 glass-card rounded-3xl p-8 shadow-xl hover-lift">
                        <div class="flex justify-between items-center mb-6">
                            <div class="flex items-center gap-3">
                                <div class="w-12 h-12 rounded-2xl bg-purple-100 flex items-center justify-center text-purple-600 shadow-inner">
                                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"></path></svg>
                                </div>
                                <h3 class="text-xl font-bold text-slate-800">Recent Work Log</h3>
                            </div>
                            <a href="<%= basePath %>/worker/worklog" class="group flex items-center text-indigo-600 text-sm font-semibold hover:text-indigo-800 transition-colors bg-indigo-50/80 backdrop-blur-sm px-4 py-2 rounded-xl shadow-sm border border-indigo-100">
                                View All
                                <svg class="w-4 h-4 ml-1 transform group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path></svg>
                            </a>
                        </div>

                        <div class="overflow-hidden rounded-2xl border border-slate-200/60 bg-white/60 backdrop-blur-md shadow-sm">
                            <table class="w-full text-sm text-left">
                                <thead class="bg-slate-50/80 text-slate-500 font-semibold uppercase text-xs tracking-wider border-b border-slate-200/60">
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
        </div>

    </main>
</div>

</body>
</html>

