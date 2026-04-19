
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Project Management - BuildTrack</title>

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
                <a href="<%= request.getContextPath() %>/admin/projects?action=new" class="flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">
                    <i data-lucide="plus" class="h-4 w-4"></i>
                    Add Project
                </a>
            </div>

            <!-- Stats Cards -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Planned" />
                    <jsp:param name="value" value="2" />
                    <jsp:param name="icon" value="calendar-clock" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="In Progress" />
                    <jsp:param name="value" value="4" />
                    <jsp:param name="valueClass" value="text-2xl font-bold text-orange-500 mt-1" />
                    <jsp:param name="icon" value="hammer" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Completed" />
                    <jsp:param name="value" value="3" />
                    <jsp:param name="valueClass" value="text-2xl font-bold text-green-600 mt-1" />
                    <jsp:param name="icon" value="check-circle-2" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="On Hold" />
                    <jsp:param name="value" value="1" />
                    <jsp:param name="valueClass" value="text-2xl font-bold text-red-500 mt-1" />
                    <jsp:param name="icon" value="pause-circle" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                </jsp:include>
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
            <jsp:include page="../common/projectCard.jsp">
                <jsp:param name="title" value="Skyline Tower Complex"/>
                <jsp:param name="client" value="Amit Sharma"/>
                <jsp:param name="status" value="In Progress"/>
                <jsp:param name="statusColor" value="text-orange-600"/>
                <jsp:param name="progress" value="68"/>
                <jsp:param name="workers" value="12"/>
                <jsp:param name="budget" value="Rs 50.0L"/>
                <jsp:param name="startDate" value="2025-01-15"/>
                <jsp:param name="endDate" value="2025-12-30"/>
                <jsp:param name="viewLink" value="${pageContext.request.contextPath}/admin/projects/form?mode=view&amp;id=1"/>
                <jsp:param name="editLink" value="${pageContext.request.contextPath}/admin/projects/form?mode=edit&amp;id=1"/>
            </jsp:include>

            <jsp:include page="../common/projectCard.jsp">
                <jsp:param name="title" value="Green Valley Residency"/>
                <jsp:param name="client" value="Priya Mehta"/>
                <jsp:param name="status" value="In Progress"/>
                <jsp:param name="statusColor" value="text-orange-600"/>
                <jsp:param name="progress" value="54"/>
                <jsp:param name="workers" value="8"/>
                <jsp:param name="budget" value="Rs 32.0L"/>
                <jsp:param name="startDate" value="2025-02-01"/>
                <jsp:param name="endDate" value="2025-11-15"/>
                <jsp:param name="viewLink" value="${pageContext.request.contextPath}/admin/projects/form?mode=view&amp;id=2"/>
                <jsp:param name="editLink" value="${pageContext.request.contextPath}/admin/projects/form?mode=edit&amp;id=2"/>
            </jsp:include>
            <jsp:include page="../common/projectCard.jsp">
                <jsp:param name="title" value="River Bridge Construction"/>
                <jsp:param name="client" value="Govt. Authority"/>
                <jsp:param name="status" value="In Progress"/>
                <jsp:param name="statusColor" value="text-orange-600"/>
                <jsp:param name="progress" value="35"/>
                <jsp:param name="workers" value="15"/>
                <jsp:param name="budget" value="Rs 80.0L"/>
                <jsp:param name="startDate" value="2025-03-10"/>
                <jsp:param name="endDate" value="2026-03-10"/>
                <jsp:param name="viewLink" value="${pageContext.request.contextPath}/admin/projects/form?mode=view&amp;id=3"/>
                <jsp:param name="editLink" value="${pageContext.request.contextPath}/admin/projects/form?mode=edit&amp;id=3"/>
            </jsp:include>
                </main>

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