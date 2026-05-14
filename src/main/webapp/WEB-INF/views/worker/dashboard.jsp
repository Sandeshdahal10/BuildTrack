<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
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
                <div class="grid grid-cols-1 xl:grid-cols-3 gap-8">

                    <!-- Assignment Card -->
                    <article class="xl:col-span-2 rounded-3xl bg-gradient-to-br from-slate-900 via-indigo-950 to-slate-900 text-white p-8 shadow-2xl relative overflow-hidden hover-lift group">
                        <!-- Abstract shapes -->
                        <div class="absolute top-0 right-0 -mt-4 -mr-4 w-32 h-32 bg-white opacity-5 rounded-full blur-2xl group-hover:opacity-10 transition-opacity duration-500"></div>
                        <div class="absolute bottom-0 right-1/4 w-40 h-40 bg-blue-500 opacity-10 rounded-full blur-3xl"></div>

                        <div class="relative z-10 flex flex-col h-full justify-between">
                            <div>
                                <div class="flex justify-between items-start mb-6">
                                    <div class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-white/10 border border-white/20 text-xs font-semibold tracking-wide uppercase text-indigo-200 backdrop-blur-md">
                                        <svg class="w-3.5 h-3.5" fill="currentColor" viewBox="0 0 20 20"><path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/><path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/></svg>
                                        Current Assignment
                                    </div>
                                    <button class="text-white/70 hover:text-white transition-colors bg-white/5 hover:bg-white/10 p-2 rounded-full backdrop-blur-md">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h.01M12 12h.01M19 12h.01M6 12a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0zm7 0a1 1 0 11-2 0 1 1 0 012 0z"></path></svg>
                                    </button>
                                </div>

                                <h2 class="text-3xl font-bold mb-6 leading-tight">
                                    Skyline Heights Tower<br>
                                    <span class="text-indigo-300 font-medium text-xl">Section B - Level 12</span>
                                </h2>

                                <div class="grid grid-cols-2 sm:grid-cols-3 gap-4 mb-8">
                                    <div class="bg-white/5 border border-white/10 rounded-2xl p-4 backdrop-blur-sm">
                                        <div class="text-indigo-200 text-xs uppercase tracking-wider mb-1.5 font-medium">Role</div>
                                        <div class="font-semibold text-white flex items-center gap-2">
                                            <svg class="w-4 h-4 text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path></svg>
                                            Senior Welder
                                        </div>
                                    </div>
                                    <div class="bg-white/5 border border-white/10 rounded-2xl p-4 backdrop-blur-sm">
                                        <div class="text-indigo-200 text-xs uppercase tracking-wider mb-1.5 font-medium">Shift</div>
                                        <div class="font-semibold text-white flex items-center gap-2">
                                            <svg class="w-4 h-4 text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            08:00 - 17:00
                                        </div>
                                    </div>
                                    <div class="bg-white/5 border border-white/10 rounded-2xl p-4 backdrop-blur-sm hidden sm:block">
                                        <div class="text-indigo-200 text-xs uppercase tracking-wider mb-1.5 font-medium">Supervisor</div>
                                        <div class="font-semibold text-white flex items-center gap-2">
                                            <div class="w-5 h-5 rounded-full bg-gradient-to-r from-blue-400 to-indigo-500 text-[10px] flex items-center justify-center font-bold">DR</div>
                                            D. Rogers
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex flex-col sm:flex-row items-center justify-between pt-5 border-t border-white/10 gap-5 sm:gap-0 mt-auto">
                                <div class="flex items-center w-full sm:w-auto">
                                    <div class="flex -space-x-3">
                                        <img class="w-10 h-10 rounded-full border-2 border-slate-900 shadow-sm" src="https://ui-avatars.com/api/?name=Alex+K&background=6366f1&color=fff" alt="Team">
                                        <img class="w-10 h-10 rounded-full border-2 border-slate-900 shadow-sm" src="https://ui-avatars.com/api/?name=Maria+J&background=ec4899&color=fff" alt="Team">
                                        <img class="w-10 h-10 rounded-full border-2 border-slate-900 shadow-sm" src="https://ui-avatars.com/api/?name=Sam+H&background=10b981&color=fff" alt="Team">
                                        <div class="w-10 h-10 rounded-full border-2 border-slate-900 bg-white/10 backdrop-blur-sm flex items-center justify-center text-xs font-bold text-white">+2</div>
                                    </div>
                                    <div class="ml-4 text-sm text-indigo-200 font-medium">Team Members</div>
                                </div>
                                <button class="w-full sm:w-auto bg-white text-slate-900 px-6 py-3 rounded-xl text-sm font-bold hover:bg-indigo-50 hover:shadow-[0_0_20px_rgba(255,255,255,0.3)] transition-all duration-300 transform group-hover:scale-105 flex items-center justify-center gap-2">
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
                                <tr class="hover:bg-white transition-colors">
                                    <td class="py-4 px-6 font-semibold text-slate-800 flex items-center gap-3">
                                        <div class="w-2.5 h-2.5 rounded-full bg-slate-300 shadow-sm"></div>
                                        Apr 24
                                    </td>
                                    <td class="py-4 px-6 font-medium text-slate-600">Structural welding</td>
                                    <td class="py-4 px-6 text-center font-semibold text-slate-700">8h 15m</td>
                                    <td class="py-4 px-6">
                                        <span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-700 border border-emerald-200 px-2.5 py-1.5 rounded-lg text-xs font-bold shadow-sm">
                                            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                                            Approved
                                        </span>
                                    </td>
                                </tr>
                                <tr class="hover:bg-white transition-colors">
                                    <td class="py-4 px-6 font-semibold text-slate-800 flex items-center gap-3">
                                        <div class="w-2.5 h-2.5 rounded-full bg-slate-300 shadow-sm"></div>
                                        Apr 23
                                    </td>
                                    <td class="py-4 px-6 font-medium text-slate-600">Site inspection</td>
                                    <td class="py-4 px-6 text-center font-semibold text-slate-700">7h 45m</td>
                                    <td class="py-4 px-6">
                                        <span class="inline-flex items-center gap-1.5 bg-emerald-50 text-emerald-700 border border-emerald-200 px-2.5 py-1.5 rounded-lg text-xs font-bold shadow-sm">
                                            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path></svg>
                                            Approved
                                        </span>
                                    </td>
                                </tr>
                                <tr class="hover:bg-white transition-colors">
                                    <td class="py-4 px-6 font-semibold text-slate-800 flex items-center gap-3">
                                        <div class="w-2.5 h-2.5 rounded-full bg-amber-400 shadow-[0_0_8px_rgba(251,191,36,0.6)] animate-pulse"></div>
                                        Apr 22
                                    </td>
                                    <td class="py-4 px-6 font-medium text-slate-600">Joint welding</td>
                                    <td class="py-4 px-6 text-center font-semibold text-slate-700">9h 30m</td>
                                    <td class="py-4 px-6">
                                        <span class="inline-flex items-center gap-1.5 bg-amber-50 text-amber-700 border border-amber-200 px-2.5 py-1.5 rounded-lg text-xs font-bold shadow-sm">
                                            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                                            Pending
                                        </span>
                                    </td>
                                </tr>
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