<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Daily Attendance - BuildTrack</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen flex">
    <!-- Sidebar -->
    <div class="fixed inset-y-0 left-0 w-56 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <!-- Main Content -->
    <div class="ml-56 flex flex-1 flex-col overflow-y-auto">

        <!-- Top Bar -->
        <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
            <jsp:include page="../common/adminTopbar.jsp" />
        </div>

        <main class="flex-1 p-6">

            <div class=" flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Attendance Management</h1>
                    <p class="text-slate-500 mt-1">Mark daily attendance and view worker status.</p>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">

                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">Total Workers</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">45</p>
                        </div>
                        <div class="p-3 rounded-lg bg-slate-100">
                            <i data-lucide="users" class="w-5 h-5 text-slate-600"></i>
                        </div>
                    </div>
                </div>

                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">Present Today</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">38</p>
                        </div>
                        <div class="p-3 rounded-lg bg-green-100">
                            <i data-lucide="user-check" class="w-5 h-5 text-green-600"></i>
                        </div>
                    </div>
                </div>

                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">Absent Today</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">5</p>
                        </div>
                        <div class="p-3 rounded-lg bg-red-100">
                            <i data-lucide="user-x" class="w-5 h-5 text-red-600"></i>
                        </div>
                    </div>
                </div>

                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">On Leave</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">2</p>
                        </div>
                        <div class="p-3 rounded-lg bg-amber-100">
                            <i data-lucide="calendar-off" class="w-5 h-5 text-amber-600"></i>
                        </div>
                    </div>
                </div>

            </div>

            <div class="bg-white border border-slate-200 rounded-xl p-4 mb-4 shadow-sm">
                <div class="flex flex-wrap items-center gap-4">
                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Date:</span>
                        <input type="date" value="2025-04-12" class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-400">
                    </div>

                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Project:</span>
                        <select class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-400 bg-white">
                            <option>All Projects</option>
                            <option>Skyline Tower</option>
                            <option>Green Valley</option>
                        </select>
                    </div>

                    <div class="ml-auto">
                        <input type="text" placeholder="Search worker..." class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-400">
                    </div>
                </div>
            </div>

            <div class="bg-slate-100/50 rounded-xl p-4 space-y-3">

                <jsp:include page="../common/attendanceRow.jsp">
                    <jsp:param name="name" value="Ramesh Kumar" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=12" />
                    <jsp:param name="role" value="Mason" />
                    <jsp:param name="project" value="Skyline Tower" />
                    <jsp:param name="status" value="present" />
                </jsp:include>

                <!-- Row 2 -->
                <jsp:include page="../common/attendanceRow.jsp">
                    <jsp:param name="name" value="Suresh Yadav" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=15" />
                    <jsp:param name="role" value="Laborer" />
                    <jsp:param name="project" value="Skyline Tower" />
                    <jsp:param name="status" value="present" />
                </jsp:include>

                <!-- Row 3 -->
                <jsp:include page="../common/attendanceRow.jsp">
                    <jsp:param name="name" value="Mahesh Singh" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=16" />
                    <jsp:param name="role" value="Carpenter" />
                    <jsp:param name="project" value="Green Valley" />
                    <jsp:param name="status" value="absent" />
                </jsp:include>

                <!-- Row 4 -->
                <jsp:include page="../common/attendanceRow.jsp">
                    <jsp:param name="name" value="Ganesh Patel" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=17" />
                    <jsp:param name="role" value="Electrician" />
                    <jsp:param name="project" value="River Bridge" />
                    <jsp:param name="status" value="half-day" />
                </jsp:include>
            </div>

        </main>
    </div>
</div>

<script> lucide.createIcons(); </script>
</body>
</html>