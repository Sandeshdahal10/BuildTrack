
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Project Management - BuildTrack</title>
    <style>
        /* Background Grid Pattern */
        .project-grid-bg {
            background-image: linear-gradient(to right, rgba(148, 163, 184, 0.1) 1px, transparent 1px),
            linear-gradient(to bottom, rgba(148, 163, 184, 0.1) 1px, transparent 1px);
            background-size: 24px 24px;
        }

        /* Card Styles */
        .project-card {
            position: relative;
            overflow: hidden;
            background: white;
            border: 1px solid gainsboro;
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.06);
            transition: all 0.2s ease;
        }

        .project-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.08);
        }

        /* Left Border Indicator */
        .project-card::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: orange;
        }

        /* Status Specific Colors */
        .project-card[data-status="planned"] .status-badge { background: aliceblue; color: blue; border: 1px solid lightblue; }

        .project-card[data-status="in progress"] .status-badge { background: floralwhite; color: darkorange; border: 1px solid moccasin; }

        .project-card[data-status="completed"] .status-badge { background: honeydew; color: green; border: 1px solid lightgreen; }

        .project-card[data-status="on hold"] .status-badge { background: lavenderblush; color: crimson; border: 1px solid lightpink; }

        /* Progress Bar */
        .progress-track { background: whitesmoke; border: 1px solid lightgray; }
        .progress-fill { background: linear-gradient(to right, orange, darkorange); }

        /* Animations */
        .fade-up { animation: fadeUp 0.4s ease-out; }
        @keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
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

            <!-- Page Header -->
            <div class="flex items-center justify-between mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Projects</h1>
                    <p class="text-slate-500 mt-1">Manage and track all your construction projects.</p>
                </div>
                <a href="<%= request.getContextPath() %>/admin/projects/form?mode=create" class="flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">
                    <i data-lucide="plus" class="h-4 w-4"></i>
                    Add Project
                </a>
            </div>

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div class="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
                    <p class="text-xs font-semibold uppercase text-slate-400">Planned</p>
                    <p class="text-2xl font-bold text-slate-800 mt-1">1</p>
                </div>
                <div class="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
                    <p class="text-xs font-semibold uppercase text-slate-400">In Progress</p>
                    <p class="text-2xl font-bold text-orange-500 mt-1">3</p>
                </div>
                <div class="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
                    <p class="text-xs font-semibold uppercase text-slate-400">Completed</p>
                    <p class="text-2xl font-bold text-green-600 mt-1">1</p>
                </div>
                <div class="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
                    <p class="text-xs font-semibold uppercase text-slate-400">On Hold</p>
                    <p class="text-2xl font-bold text-red-500 mt-1">1</p>
                </div>
            </div>

            <!-- Filters -->
            <div class="bg-white border border-slate-200 rounded-xl p-4 mb-6 flex flex-wrap items-center gap-4">
                <div class="relative flex-1">
                    <i data-lucide="search" class="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400"></i>
                    <input id="searchInput" type="text" placeholder="Search projects..." class="w-full rounded-lg border border-slate-300 py-2 pl-10 pr-4 text-sm outline-none focus:border-orange-300">
                </div>
                <div class="flex gap-2">
                    <button onclick="filterProjects('all')" class="filter-btn active rounded-full bg-orange-500 px-4 py-1.5 text-xs font-semibold text-white">All</button>
                    <button onclick="filterProjects('in progress')" class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600">In Progress</button>
                    <button onclick="filterProjects('completed')" class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600 ">Completed</button>
                    <button onclick="filterProjects('planned')" class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600 ">Planned</button>
                </div>
            </div>

            <!-- Project List -->
            <div id="projectList" class="project-grid-bg rounded-xl border border-slate-200 p-6 space-y-4">

                <!-- Project 1: Skyline Tower -->
                <article data-status="in progress" data-title="Skyline Tower Complex" class="project-card fade-up rounded-xl p-5">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-slate-800">Skyline Tower Complex</h3>
                                <span class="status-badge text-xs font-bold rounded-full px-2 py-0.5">In Progress</span>
                            </div>
                            <p class="text-sm text-slate-500 mb-3">Client: Amit Sharma</p>
                            <div class="flex flex-wrap gap-4 text-xs text-slate-500 mb-4">
                                <span class="flex items-center gap-1"><i data-lucide="calendar" class="w-3 h-3"></i> 2025-01-15 - 2025-12-30</span>
                                <span class="flex items-center gap-1"><i data-lucide="users" class="w-3 h-3"></i> 12 Workers</span>
                                <span class="flex items-center gap-1"><i data-lucide="wallet" class="w-3 h-3"></i> Rs 50.0L</span>
                            </div>
                            <div class="w-full">
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-slate-500">Progress</span>
                                    <span class="font-bold text-orange-600">68%</span>
                                </div>
                                <div class="progress-track h-2 rounded-full">
                                    <div class="progress-fill h-2 rounded-full" style="width: 68%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <a href="#" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-50">View</a>
                            <a href="#" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Edit</a>
                        </div>
                    </div>
                </article>

                <!-- Project 2: Green Valley -->
                <article data-status="in progress" data-title="Green Valley Residency" class="project-card fade-up rounded-xl p-5">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-slate-800">Green Valley Residency</h3>
                                <span class="status-badge text-xs font-bold rounded-full px-2 py-0.5">In Progress</span>
                            </div>
                            <p class="text-sm text-slate-500 mb-3">Client: Priya Mehta</p>
                            <div class="flex flex-wrap gap-4 text-xs text-slate-500 mb-4">
                                <span class="flex items-center gap-1"><i data-lucide="calendar" class="w-3 h-3"></i> 2025-02-01 - 2025-11-15</span>
                                <span class="flex items-center gap-1"><i data-lucide="users" class="w-3 h-3"></i> 8 Workers</span>
                                <span class="flex items-center gap-1"><i data-lucide="wallet" class="w-3 h-3"></i> Rs 32.0L</span>
                            </div>
                            <div class="w-full">
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-slate-500">Progress</span>
                                    <span class="font-bold text-orange-600">54%</span>
                                </div>
                                <div class="progress-track h-2 rounded-full">
                                    <div class="progress-fill h-2 rounded-full" style="width: 54%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <a href="#" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-50">View</a>
                            <a href="#" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Edit</a>
                        </div>
                    </div>
                </article>

                <!-- Project 3: River Bridge -->
                <article data-status="in progress" data-title="River Bridge Construction" class="project-card fade-up rounded-xl p-5">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-slate-800">River Bridge Construction</h3>
                                <span class="status-badge text-xs font-bold rounded-full px-2 py-0.5">In Progress</span>
                            </div>
                            <p class="text-sm text-slate-500 mb-3">Client: Govt. Authority</p>
                            <div class="flex flex-wrap gap-4 text-xs text-slate-500 mb-4">
                                <span class="flex items-center gap-1"><i data-lucide="calendar" class="w-3 h-3"></i> 2025-03-10 - 2026-03-10</span>
                                <span class="flex items-center gap-1"><i data-lucide="users" class="w-3 h-3"></i> 15 Workers</span>
                                <span class="flex items-center gap-1"><i data-lucide="wallet" class="w-3 h-3"></i> Rs 80.0L</span>
                            </div>
                            <div class="w-full">
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-slate-500">Progress</span>
                                    <span class="font-bold text-orange-600">35%</span>
                                </div>
                                <div class="progress-track h-2 rounded-full">
                                    <div class="progress-fill h-2 rounded-full" style="width: 35%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <a href="#" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-50">View</a>
                            <a href="#" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Edit</a>
                        </div>
                    </div>
                </article>

                <!-- Project 4: Shopping Mall (Completed) -->
                <article data-status="completed" data-title="Shopping Mall Renovation" class="project-card fade-up rounded-xl p-5">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-slate-800">Shopping Mall Renovation</h3>
                                <span class="status-badge text-xs font-bold rounded-full px-2 py-0.5">Completed</span>
                            </div>
                            <p class="text-sm text-slate-500 mb-3">Client: Rahul Industries</p>
                            <div class="flex flex-wrap gap-4 text-xs text-slate-500 mb-4">
                                <span class="flex items-center gap-1"><i data-lucide="calendar" class="w-3 h-3"></i> 2024-06-01 - 2025-06-30</span>
                                <span class="flex items-center gap-1"><i data-lucide="users" class="w-3 h-3"></i> 10 Workers</span>
                                <span class="flex items-center gap-1"><i data-lucide="wallet" class="w-3 h-3"></i> Rs 45.0L</span>
                            </div>
                            <div class="w-full">
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-slate-500">Progress</span>
                                    <span class="font-bold text-green-600">100%</span>
                                </div>
                                <div class="progress-track h-2 rounded-full">
                                    <div class="progress-fill h-2 rounded-full bg-green-500" style="width: 100%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <a href="#" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-50">View</a>
                            <a href="#" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Edit</a>
                        </div>
                    </div>
                </article>

                <!-- Project 5: Sunrise School (Planned) -->
                <article data-status="planned" data-title="Sunrise School Block A" class="project-card fade-up rounded-xl p-5">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-slate-800">Sunrise School Block A</h3>
                                <span class="status-badge text-xs font-bold rounded-full px-2 py-0.5">Planned</span>
                            </div>
                            <p class="text-sm text-slate-500 mb-3">Client: Metro Education Trust</p>
                            <div class="flex flex-wrap gap-4 text-xs text-slate-500 mb-4">
                                <span class="flex items-center gap-1"><i data-lucide="calendar" class="w-3 h-3"></i> 2025-08-01 - 2026-04-20</span>
                                <span class="flex items-center gap-1"><i data-lucide="users" class="w-3 h-3"></i> 6 Workers</span>
                                <span class="flex items-center gap-1"><i data-lucide="wallet" class="w-3 h-3"></i> Rs 18.0L</span>
                            </div>
                            <div class="w-full">
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-slate-500">Progress</span>
                                    <span class="font-bold text-blue-600">8%</span>
                                </div>
                                <div class="progress-track h-2 rounded-full">
                                    <div class="progress-fill h-2 rounded-full bg-blue-500" style="width: 8%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <a href="#" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-50">View</a>
                            <a href="#" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Edit</a>
                        </div>
                    </div>
                </article>

                <!-- Project 6: Warehouse (On Hold) -->
                <article data-status="on hold" data-title="Industrial Warehouse Expansion" class="project-card fade-up rounded-xl p-5">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <h3 class="font-bold text-slate-800">Industrial Warehouse Expansion</h3>
                                <span class="status-badge text-xs font-bold rounded-full px-2 py-0.5">On Hold</span>
                            </div>
                            <p class="text-sm text-slate-500 mb-3">Client: Atlas Supply Ltd</p>
                            <div class="flex flex-wrap gap-4 text-xs text-slate-500 mb-4">
                                <span class="flex items-center gap-1"><i data-lucide="calendar" class="w-3 h-3"></i> 2024-11-10 - 2025-10-25</span>
                                <span class="flex items-center gap-1"><i data-lucide="users" class="w-3 h-3"></i> 9 Workers</span>
                                <span class="flex items-center gap-1"><i data-lucide="wallet" class="w-3 h-3"></i> Rs 22.0L</span>
                            </div>
                            <div class="w-full">
                                <div class="flex justify-between text-xs mb-1">
                                    <span class="text-slate-500">Progress</span>
                                    <span class="font-bold text-red-600">41%</span>
                                </div>
                                <div class="progress-track h-2 rounded-full">
                                    <div class="progress-fill h-2 rounded-full bg-red-400" style="width: 41%"></div>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <a href="#" class="rounded-lg border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-50">View</a>
                            <a href="#" class="rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">Edit</a>
                        </div>
                    </div>
                </article>

            </div>
        </main>
    </div>
</div>

<script>
    // Simple Search and Filter Logic
    const searchInput = document.getElementById('searchInput');
    const cards = document.querySelectorAll('.project-card');
    const filterBtns = document.querySelectorAll('.filter-btn');

    function filterProjects(status) {
        // Update button styles
        filterBtns.forEach(btn => {
            btn.classList.remove('bg-orange-500', 'text-white', 'border-transparent');
            btn.classList.add('border-slate-300', 'text-slate-600');
        });
        event.target.classList.add('bg-orange-500', 'text-white', 'border-transparent');
        event.target.classList.remove('border-slate-300', 'text-slate-600');

        // Filter cards
        const searchTerm = searchInput.value.toLowerCase();

        cards.forEach(card => {
            const cardStatus = card.getAttribute('data-status');
            const title = card.getAttribute('data-title').toLowerCase();

            const matchesStatus = (status === 'all' || cardStatus === status);
            const matchesSearch = title.includes(searchTerm);

            if (matchesStatus && matchesSearch) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    searchInput.addEventListener('input', () => {
        // Trigger click on active button to re-filter
        document.querySelector('.filter-btn.bg-orange-500').click();
    });

    lucide.createIcons();
</script>

</body>
</html>
```