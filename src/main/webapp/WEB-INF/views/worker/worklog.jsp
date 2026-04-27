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
    <title>BuildTrack | Work Log</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 text-slate-900">
<div class="grid min-h-screen w-full grid-cols-[214px_minmax(0,1fr)] max-[1100px]:grid-cols-1">
    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Content -->
    <main class="bg-slate-50 px-5 pb-7 pt-4">
        <!-- Navbar -->
        <jsp:include page="../common/adminTopbar.jsp" />

        <!-- Title Section -->
        <section class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm mb-3.5">
            <h1 class="m-0 text-3xl font-bold leading-none">Work Log</h1>
            <p class="mt-1 text-xs text-slate-600">Track your daily work entries</p>
        </section>

        <!-- Add Button -->
        <div class="mb-4 flex justify-end">
            <button class="inline-flex items-center gap-2 rounded-lg bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 text-sm font-semibold shadow-sm transition-colors">
                <svg viewBox="0 0 24 24" class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 5v14"></path>
                    <path d="M5 12h14"></path>
                </svg>
                Add Work Entry
            </button>
        </div>

        <!-- Work Log Entries -->
        <div class="space-y-2.5">
            <!-- Entry 1 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-8 h-8 rounded-lg bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-xs">S</div>
                            <h3 class="m-0 text-base font-semibold text-slate-900">Skyline Tower</h3>
                        </div>
                        <p class="m-0 text-sm text-slate-600 ml-10">Completed concrete pouring on 5th floor slab</p>
                        <p class="m-0 text-xs text-slate-500 ml-10 mt-1">2025-01-28</p>
                    </div>
                    <span class="rounded-full border border-teal-300 bg-teal-50 px-2.5 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap">Approved</span>
                </div>
            </article>

            <!-- Entry 2 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-8 h-8 rounded-lg bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-xs">S</div>
                            <h3 class="m-0 text-base font-semibold text-slate-900">Skyline Tower</h3>
                        </div>
                        <p class="m-0 text-sm text-slate-600 ml-10">Inspected steel reinforcement for 6th floor</p>
                        <p class="m-0 text-xs text-slate-500 ml-10 mt-1">2025-01-27</p>
                    </div>
                    <span class="rounded-full border border-teal-300 bg-teal-50 px-2.5 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap">Approved</span>
                </div>
            </article>

            <!-- Entry 3 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-8 h-8 rounded-lg bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-xs">R</div>
                            <h3 class="m-0 text-base font-semibold text-slate-900">River Bridge</h3>
                        </div>
                        <p class="m-0 text-sm text-slate-600 ml-10">Supervised pile driving work at section B-3</p>
                        <p class="m-0 text-xs text-slate-500 ml-10 mt-1">2025-01-26</p>
                    </div>
                    <span class="rounded-full border border-amber-300 bg-amber-50 px-2.5 py-0.5 text-xs font-semibold text-amber-700 whitespace-nowrap">Pending</span>
                </div>
            </article>

            <!-- Entry 4 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-8 h-8 rounded-lg bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-xs">S</div>
                            <h3 class="m-0 text-base font-semibold text-slate-900">Skyline Tower</h3>
                        </div>
                        <p class="m-0 text-sm text-slate-600 ml-10">Daily site inspection and safety check</p>
                        <p class="m-0 text-xs text-slate-500 ml-10 mt-1">2025-01-25</p>
                    </div>
                    <span class="rounded-full border border-teal-300 bg-teal-50 px-2.5 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap">Approved</span>
                </div>
            </article>

            <!-- Entry 5 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-8 h-8 rounded-lg bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-xs">R</div>
                            <h3 class="m-0 text-base font-semibold text-slate-900">River Bridge</h3>
                        </div>
                        <p class="m-0 text-sm text-slate-600 ml-10">Concrete mix preparation and quality test</p>
                        <p class="m-0 text-xs text-slate-500 ml-10 mt-1">2025-01-24</p>
                    </div>
                    <span class="rounded-full border border-teal-300 bg-teal-50 px-2.5 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap">Approved</span>
                </div>
            </article>
        </div>
    </main>
</div>

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    lucide.createIcons();
</script>
</body>
</html>
