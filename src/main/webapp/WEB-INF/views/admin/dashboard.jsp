<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        .status-donut {
            background: conic-gradient(
                #facc15 0deg 108deg,
                #f59e0b 108deg 288deg,
                #14b8a6 288deg 331deg,
                #ef4444 331deg 360deg
            );
        }

        .budget-grid {
            background-image:
                linear-gradient(to top, #e2e8f0 1px, transparent 1px),
                linear-gradient(to right, #f1f5f9 1px, transparent 1px);
            background-size: 100% 25%, 20% 100%;
        }
    </style>
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
                <h1 class="text-3xl font-bold tracking-tight text-slate-900">Good Morning, Rojash Thapa </h1>
                <p class="mt-2 text-base text-slate-600">Here's what's happening with your construction projects today.</p>
            </section>

            <section class="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:shadow-md">
                    <div class="flex items-start justify-between gap-4">
                        <div>
                            <p class="text-sm font-semibold uppercase tracking-wide text-slate-500">Active Projects</p>
                            <p class="mt-2 text-4xl font-bold leading-none text-slate-900">12</p>
                            <p class="mt-3 text-sm text-slate-500">+2 this month</p>
                        </div>
                        <span class="inline-flex h-11 w-11 items-center justify-center rounded-xl border border-amber-200 bg-amber-50 text-amber-600">
                            <i data-lucide="briefcase-business" class="h-5 w-5"></i>
                        </span>
                    </div>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:shadow-md">
                    <div class="flex items-start justify-between gap-4">
                        <div>
                            <p class="text-sm font-semibold uppercase tracking-wide text-slate-500">Total Workers</p>
                            <p class="mt-2 text-4xl font-bold leading-none text-slate-900">48</p>
                            <p class="mt-3 text-sm text-slate-500">6 supervisors</p>
                        </div>
                        <span class="inline-flex h-11 w-11 items-center justify-center rounded-xl border border-cyan-200 bg-cyan-50 text-cyan-600">
                            <i data-lucide="users" class="h-5 w-5"></i>
                        </span>
                    </div>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:shadow-md">
                    <div class="flex items-start justify-between gap-4">
                        <div>
                            <p class="text-sm font-semibold uppercase tracking-wide text-slate-500">Budget Utilization</p>
                            <p class="mt-2 text-4xl font-bold leading-none text-slate-900">67%</p>
                            <p class="mt-3 text-sm text-slate-500">Rs.13.9M of Rs.25M</p>
                        </div>
                        <span class="inline-flex h-11 w-11 items-center justify-center rounded-xl border border-amber-200 bg-amber-50 text-amber-600">
                            <i data-lucide="badge-indian-rupee" class="h-5 w-5"></i>
                        </span>
                    </div>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:shadow-md">
                    <div class="flex items-start justify-between gap-4">
                        <div>
                            <p class="text-sm font-semibold uppercase tracking-wide text-slate-500">Pending Tasks</p>
                            <p class="mt-2 text-4xl font-bold leading-none text-slate-900">23</p>
                            <p class="mt-3 text-sm text-slate-500">8 high priority</p>
                        </div>
                        <span class="inline-flex h-11 w-11 items-center justify-center rounded-xl border border-rose-200 bg-rose-50 text-rose-600">
                            <i data-lucide="clipboard-check" class="h-5 w-5"></i>
                        </span>
                    </div>
                </article>
            </section>

            <section class="mt-6 grid grid-cols-1 gap-4 xl:grid-cols-2">
                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <h2 class="text-base font-semibold text-slate-900">Project Status</h2>
                    <div class="mt-5 flex items-center justify-center">
                        <div class="status-donut relative h-36 w-36 rounded-full border border-slate-200">
                            <div class="absolute inset-4 rounded-full bg-white border border-slate-100"></div>
                        </div>
                    </div>
                    <div class="mt-5 flex flex-wrap items-center justify-center gap-x-4 gap-y-2 text-xs text-slate-600">
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-yellow-400"></span>Planned</span>
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-amber-500"></span>In Progress</span>
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-teal-500"></span>Completed</span>
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-red-500"></span>On Hold</span>
                    </div>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <h2 class="text-base font-semibold text-slate-900">Budget vs Actual (Rs Lakhs)</h2>
                    <div class="budget-grid mt-5 rounded-xl border border-slate-200 p-4">
                        <div class="grid h-48 grid-cols-5 items-end gap-3">
                            <div class="flex items-end justify-center gap-1">
                                <span class="w-4 rounded-t bg-amber-500" style="height: 62.5%;"></span>
                                <span class="w-4 rounded-t bg-teal-500" style="height: 43.75%;"></span>
                            </div>
                            <div class="flex items-end justify-center gap-1">
                                <span class="w-4 rounded-t bg-amber-500" style="height: 40%;"></span>
                                <span class="w-4 rounded-t bg-teal-500" style="height: 35%;"></span>
                            </div>
                            <div class="flex items-end justify-center gap-1">
                                <span class="w-4 rounded-t bg-amber-500" style="height: 100%;"></span>
                                <span class="w-4 rounded-t bg-teal-500" style="height: 25%;"></span>
                            </div>
                            <div class="flex items-end justify-center gap-1">
                                <span class="w-4 rounded-t bg-amber-500" style="height: 56.25%;"></span>
                                <span class="w-4 rounded-t bg-teal-500" style="height: 56.25%;"></span>
                            </div>
                            <div class="flex items-end justify-center gap-1">
                                <span class="w-4 rounded-t bg-amber-500" style="height: 20%;"></span>
                                <span class="w-4 rounded-t bg-teal-500" style="height: 15%;"></span>
                            </div>
                        </div>
                    </div>
                    <div class="mt-3 grid grid-cols-5 text-center text-xs text-slate-500">
                        <span>Skyline</span>
                        <span>Green Valley</span>
                        <span>River Bridge</span>
                        <span>Mall Reno</span>
                        <span>School</span>
                    </div>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <h2 class="text-base font-semibold text-slate-900">Recent Activity</h2>
                    <ul class="mt-4 space-y-4">
                        <li class="flex items-start gap-3">
                            <span class="mt-1 h-2.5 w-2.5 rounded-full bg-blue-500"></span>
                            <div>
                                <p class="text-sm text-slate-700">New worker "Prakash Joshi" added to River Bridge</p>
                                <p class="text-xs text-slate-500">2 hours ago</p>
                            </div>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="mt-1 h-2.5 w-2.5 rounded-full bg-teal-500"></span>
                            <div>
                                <p class="text-sm text-slate-700">Budget approved for Industrial Warehouse project</p>
                                <p class="text-xs text-slate-500">5 hours ago</p>
                            </div>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="mt-1 h-2.5 w-2.5 rounded-full bg-amber-500"></span>
                            <div>
                                <p class="text-sm text-slate-700">Cement stock below threshold - reorder needed</p>
                                <p class="text-xs text-slate-500">1 day ago</p>
                            </div>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="mt-1 h-2.5 w-2.5 rounded-full bg-slate-400"></span>
                            <div>
                                <p class="text-sm text-slate-700">Attendance report generated for January</p>
                                <p class="text-xs text-slate-500">1 day ago</p>
                            </div>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="mt-1 h-2.5 w-2.5 rounded-full bg-cyan-500"></span>
                            <div>
                                <p class="text-sm text-slate-700">Skyline Tower project reached 68% completion</p>
                                <p class="text-xs text-slate-500">2 days ago</p>
                            </div>
                        </li>
                    </ul>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <h2 class="text-base font-semibold text-slate-900">Upcoming Deadlines</h2>
                    <ul class="mt-4 space-y-4">
                        <li class="flex items-start justify-between gap-4">
                            <div class="flex items-start gap-3">
                                <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-rose-200 bg-rose-50 text-rose-600"><i data-lucide="clock-3" class="h-3 w-3"></i></span>
                                <div>
                                    <p class="text-sm text-slate-700">Submit progress report - Skyline Tower</p>
                                    <p class="text-xs text-slate-500">Jan 31, 2025</p>
                                </div>
                            </div>
                            <span class="rounded-md bg-rose-100 px-2 py-1 text-xs font-medium text-rose-700">Urgent</span>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-slate-200 bg-slate-100 text-slate-500"><i data-lucide="clock-3" class="h-3 w-3"></i></span>
                            <div>
                                <p class="text-sm text-slate-700">Material inspection - River Bridge</p>
                                <p class="text-xs text-slate-500">Feb 3, 2025</p>
                            </div>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-slate-200 bg-slate-100 text-slate-500"><i data-lucide="clock-3" class="h-3 w-3"></i></span>
                            <div>
                                <p class="text-sm text-slate-700">Client meeting - Green Valley</p>
                                <p class="text-xs text-slate-500">Feb 5, 2025</p>
                            </div>
                        </li>
                        <li class="flex items-start gap-3">
                            <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-slate-200 bg-slate-100 text-slate-500"><i data-lucide="clock-3" class="h-3 w-3"></i></span>
                            <div>
                                <p class="text-sm text-slate-700">Budget review meeting</p>
                                <p class="text-xs text-slate-500">Feb 7, 2025</p>
                            </div>
                        </li>
                        <li class="flex items-start justify-between gap-4">
                            <div class="flex items-start gap-3">
                                <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-rose-200 bg-rose-50 text-rose-600"><i data-lucide="clock-3" class="h-3 w-3"></i></span>
                                <div>
                                    <p class="text-sm text-slate-700">Safety audit - School Building</p>
                                    <p class="text-xs text-slate-500">Feb 10, 2025</p>
                                </div>
                            </div>
                            <span class="rounded-md bg-rose-100 px-2 py-1 text-xs font-medium text-rose-700">Urgent</span>
                        </li>
                    </ul>
                </article>
            </section>
        </main>
    </div>
</div>
<script>
    lucide.createIcons();
</script>
</body>
</html>
