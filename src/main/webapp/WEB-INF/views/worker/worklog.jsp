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
    <style>
        /* Custom subtle fade-in animation for entries */
        .fade-in {
            animation: fadeIn 0.7s cubic-bezier(0.4, 0, 0.2, 1);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        /* Soft glass effect for cards */
        .glass {
            background: rgba(255,255,255,0.85);
            backdrop-filter: blur(4px);
        }
        /* Subtle shadow on hover */
        .card-hover:hover {
            box-shadow: 0 6px 24px 0 rgba(0,0,0,0.07), 0 1.5px 4px 0 rgba(0,0,0,0.03);
            transform: translateY(-2px) scale(1.01);
        }
        /* Modern button */
        .modern-btn {
            background: linear-gradient(90deg, #fbbf24 0%, #f59e42 100%);
            box-shadow: 0 2px 8px 0 rgba(251,191,36,0.08);
        }
        .modern-btn:hover {
            background: linear-gradient(90deg, #f59e42 0%, #fbbf24 100%);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-50 via-slate-100 to-amber-50 text-slate-900">
<div class="grid min-h-screen w-full grid-cols-[214px_minmax(0,1fr)] max-[1100px]:grid-cols-1">
    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Content -->
    <main class="bg-transparent px-5 pb-7 pt-4">
        <!-- Navbar -->
        <jsp:include page="../common/adminTopbar.jsp" />

        <!-- Title Section -->
        <section class="rounded-2xl border border-slate-100 glass px-7 py-5 shadow mb-4 flex flex-col gap-1.5">
            <h1 class="m-0 text-3xl font-bold leading-none tracking-tight text-amber-600">Work Log</h1>
            <p class="mt-1 text-sm text-slate-500">Track your daily work entries</p>
        </section>

        <!-- Add Button -->
        <div class="mb-4 flex justify-end">
            <button class="modern-btn inline-flex items-center gap-2 rounded-lg text-white px-5 py-2.5 text-base font-semibold shadow transition-all duration-200 hover:scale-105 focus:outline-none focus:ring-2 focus:ring-amber-300">
                <svg viewBox="0 0 24 24" class="h-4 w-4" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M12 5v14"></path>
                    <path d="M5 12h14"></path>
                </svg>
                Add Work Entry
            </button>
        </div>

        <!-- Work Log Entries -->
        <div class="space-y-3">
            <!-- Entry 1 -->
            <article class="rounded-2xl border border-slate-100 glass px-6 py-5 shadow-sm card-hover fade-in transition-all duration-200">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-9 h-9 rounded-xl bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-base shadow">S</div>
                            <h3 class="m-0 text-lg font-semibold text-slate-800 tracking-tight">Skyline Tower</h3>
                        </div>
                        <p class="m-0 text-[15px] text-slate-600 ml-11">Completed concrete pouring on 5th floor slab</p>
                        <p class="m-0 text-xs text-slate-400 ml-11 mt-1">2025-01-28</p>
                    </div>
                    <span class="rounded-full border border-teal-200 bg-teal-50 px-3 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap shadow-sm">Approved</span>
                </div>
            </article>

            <!-- Entry 2 -->
            <article class="rounded-2xl border border-slate-100 glass px-6 py-5 shadow-sm card-hover fade-in transition-all duration-200">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-9 h-9 rounded-xl bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-base shadow">S</div>
                            <h3 class="m-0 text-lg font-semibold text-slate-800 tracking-tight">Skyline Tower</h3>
                        </div>
                        <p class="m-0 text-[15px] text-slate-600 ml-11">Inspected steel reinforcement for 6th floor</p>
                        <p class="m-0 text-xs text-slate-400 ml-11 mt-1">2025-01-27</p>
                    </div>
                    <span class="rounded-full border border-teal-200 bg-teal-50 px-3 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap shadow-sm">Approved</span>
                </div>
            </article>

            <!-- Entry 3 -->
            <article class="rounded-2xl border border-slate-100 glass px-6 py-5 shadow-sm card-hover fade-in transition-all duration-200">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-9 h-9 rounded-xl bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-base shadow">R</div>
                            <h3 class="m-0 text-lg font-semibold text-slate-800 tracking-tight">River Bridge</h3>
                        </div>
                        <p class="m-0 text-[15px] text-slate-600 ml-11">Supervised pile driving work at section B-3</p>
                        <p class="m-0 text-xs text-slate-400 ml-11 mt-1">2025-01-26</p>
                    </div>
                    <span class="rounded-full border border-amber-200 bg-amber-50 px-3 py-0.5 text-xs font-semibold text-amber-700 whitespace-nowrap shadow-sm">Pending</span>
                </div>
            </article>

            <!-- Entry 4 -->
            <article class="rounded-2xl border border-slate-100 glass px-6 py-5 shadow-sm card-hover fade-in transition-all duration-200">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-9 h-9 rounded-xl bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-base shadow">S</div>
                            <h3 class="m-0 text-lg font-semibold text-slate-800 tracking-tight">Skyline Tower</h3>
                        </div>
                        <p class="m-0 text-[15px] text-slate-600 ml-11">Daily site inspection and safety check</p>
                        <p class="m-0 text-xs text-slate-400 ml-11 mt-1">2025-01-25</p>
                    </div>
                    <span class="rounded-full border border-teal-200 bg-teal-50 px-3 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap shadow-sm">Approved</span>
                </div>
            </article>

            <!-- Entry 5 -->
            <article class="rounded-2xl border border-slate-100 glass px-6 py-5 shadow-sm card-hover fade-in transition-all duration-200">
                <div class="flex items-start justify-between">
                    <div>
                        <div class="flex items-center gap-2 mb-1">
                            <div class="w-9 h-9 rounded-xl bg-amber-100 flex items-center justify-center text-amber-600 font-bold text-base shadow">R</div>
                            <h3 class="m-0 text-lg font-semibold text-slate-800 tracking-tight">River Bridge</h3>
                        </div>
                        <p class="m-0 text-[15px] text-slate-600 ml-11">Concrete mix preparation and quality test</p>
                        <p class="m-0 text-xs text-slate-400 ml-11 mt-1">2025-01-24</p>
                    </div>
                    <span class="rounded-full border border-teal-200 bg-teal-50 px-3 py-0.5 text-xs font-semibold text-teal-700 whitespace-nowrap shadow-sm">Approved</span>
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
