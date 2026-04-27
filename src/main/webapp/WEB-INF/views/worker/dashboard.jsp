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
</head>

<body class="bg-slate-100 text-slate-900">

<div class="flex min-h-screen w-full flex-col lg:flex-row">

    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Area -->
    <main class="flex-1 flex flex-col">

        <!-- ✅ TOP NAVBAR -->
        <div class="px-6 pt-4">
            <jsp:include page="../common/adminTopbar.jsp" />
        </div>

        <!-- ✅ CONTENT -->
        <div class="px-6 py-4">
            <div class="max-w-7xl mx-auto">

                <!-- ✅ Welcome Section -->
                <section class="bg-white border border-slate-200 rounded-2xl px-6 py-6 shadow-md mb-6">
                    <h1 class="text-3xl font-bold mb-2">
                        Welcome, <%= displayName %>
                    </h1>
                    <p class="text-sm text-slate-600">
                        Track your daily assignments and work status
                    </p>
                </section>

                <!-- Top Grid -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-6">

                    <!-- Assignment -->
                    <article class="lg:col-span-2 rounded-2xl bg-gradient-to-br from-blue-600 to-blue-700 text-white p-6 shadow-md">
                        <div class="text-xs tracking-widest font-semibold text-blue-100 mb-2">
                            CURRENT ASSIGNMENT
                        </div>

                        <h2 class="text-xl font-bold mb-4">
                            Skyline Heights Tower<br>Section B - Level 12
                        </h2>

                        <div class="flex flex-wrap gap-6 mb-4">
                            <div class="flex items-center gap-3">
                                <div class="w-9 h-9 bg-white/20 rounded-lg flex items-center justify-center text-xs font-bold">W</div>
                                <div>
                                    <div class="text-xs text-blue-100">Role</div>
                                    <div class="font-semibold">Senior Welder</div>
                                </div>
                            </div>

                            <div class="flex items-center gap-3">
                                <div class="w-9 h-9 bg-white/20 rounded-lg flex items-center justify-center text-xs font-bold">C</div>
                                <div>
                                    <div class="text-xs text-blue-100">Shift</div>
                                    <div class="font-semibold">08:00 - 17:00</div>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center mb-4">
                            <div class="flex -space-x-2">
                                <div class="w-8 h-8 bg-white/30 rounded-full flex items-center justify-center text-xs font-bold border border-blue-700">AK</div>
                                <div class="w-8 h-8 bg-white/30 rounded-full flex items-center justify-center text-xs font-bold border border-blue-700">MJ</div>
                                <div class="w-8 h-8 bg-white/30 rounded-full flex items-center justify-center text-xs font-bold border border-blue-700">SH</div>
                            </div>
                            <div class="ml-3 text-sm text-blue-100">+2 teammates</div>
                        </div>

                        <div class="text-right">
                            <button class="bg-white text-blue-700 px-4 py-2 rounded-lg text-sm font-semibold hover:shadow-lg">
                                View Blueprint
                            </button>
                        </div>
                    </article>

                    <!-- ✅ Status with DONUT -->
                    <article class="bg-white border border-slate-200 rounded-2xl p-6 shadow-md text-center">

                        <div class="text-xs font-semibold text-slate-500 uppercase mb-3">
                            Today's Status
                        </div>

                        <div class="text-lg font-semibold mb-1">Punched In</div>
                        <div class="text-sm text-slate-500 mb-4">Checked in at 07:54 AM</div>

                        <!-- Donut -->
                        <div class="relative w-28 h-28 mx-auto mb-4">
                            <svg class="w-full h-full -rotate-90" viewBox="0 0 36 36">
                                <path d="M18 2.5 a 15.5 15.5 0 1 1 0 31 a 15.5 15.5 0 1 1 0 -31"
                                      fill="none" stroke="#e5e7eb" stroke-width="3"/>
                                <path d="M18 2.5 a 15.5 15.5 0 1 1 0 31 a 15.5 15.5 0 1 1 0 -31"
                                      fill="none" stroke="#f59e0b" stroke-width="3"
                                      stroke-linecap="round"
                                      stroke-dasharray="65, 100"/>
                            </svg>

                            <div class="absolute inset-0 flex flex-col items-center justify-center">
                                <div class="text-2xl font-bold">6.5</div>
                                <div class="text-xs text-slate-500">HOURS</div>
                            </div>
                        </div>

                        <button class="w-full bg-amber-100 text-amber-700 py-2 rounded-lg font-semibold text-sm hover:bg-amber-200">
                            Punch Out
                        </button>
                    </article>
                </div>

                <!-- Bottom Grid -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">

                    <!-- Summary -->
                    <article class="bg-white border border-slate-200 rounded-2xl p-6 shadow-md">
                        <h3 class="font-semibold mb-4">April Summary</h3>

                        <div class="space-y-4">
                            <div>
                                <div class="text-sm text-slate-600">Attendance</div>
                                <div class="font-bold">92%</div>
                                <div class="w-full h-2 bg-slate-200 rounded mt-1">
                                    <div class="h-2 bg-amber-500 rounded" style="width:92%"></div>
                                </div>
                            </div>

                            <div>
                                <div class="text-sm text-slate-600">Overtime</div>
                                <div class="font-bold">14.5 Hrs</div>
                            </div>

                            <div>
                                <div class="text-sm text-slate-600">Est. Earnings</div>
                                <div class="font-bold">Rs. 4,280.00</div>
                            </div>
                        </div>
                    </article>

                    <!-- Work Log -->
                    <article class="lg:col-span-2 bg-white border border-slate-200 rounded-2xl p-6 shadow-md">
                        <div class="flex justify-between mb-4">
                            <h3 class="font-semibold">Recent Work Log</h3>
                            <a href="<%= basePath %>/worker/worklog" class="text-amber-600 text-sm hover:underline">
                                View All
                            </a>
                        </div>

                        <table class="w-full text-sm">
                            <thead class="border-b text-slate-500">
                            <tr>
                                <th class="py-2 text-left">Date</th>
                                <th class="text-left">Activity</th>
                                <th class="text-center">Duration</th>
                                <th>Status</th>
                            </tr>
                            </thead>

                            <tbody class="divide-y">
                            <tr>
                                <td class="py-2 font-medium">Apr 24</td>
                                <td>Structural welding</td>
                                <td class="text-center">8h 15m</td>
                                <td><span class="bg-amber-100 text-amber-700 px-2 py-1 rounded text-xs">Approved</span></td>
                            </tr>

                            <tr>
                                <td class="py-2 font-medium">Apr 23</td>
                                <td>Site inspection</td>
                                <td class="text-center">7h 45m</td>
                                <td><span class="bg-amber-100 text-amber-700 px-2 py-1 rounded text-xs">Approved</span></td>
                            </tr>

                            <tr>
                                <td class="py-2 font-medium">Apr 22</td>
                                <td>Joint welding</td>
                                <td class="text-center">9h 30m</td>
                                <td><span class="bg-slate-100 text-slate-600 px-2 py-1 rounded text-xs">Pending</span></td>
                            </tr>
                            </tbody>
                        </table>
                    </article>

                </div>

            </div>
        </div>

    </main>
</div>

</body>
</html>