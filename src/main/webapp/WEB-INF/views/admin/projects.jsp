<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://unpkg.com/lucide@latest"></script>
            <title>Project Management - BuildTrack</title>

        </head>

        <body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

            <div class="h-screen">
                <!-- Sidebar -->
                <div id="sidebar-container"
                    class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-slate-200 bg-white">
                    <jsp:include page="../common/sidebar.jsp" />
                </div>

                <!-- Main Content -->
                <div class="ml-0 md:ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-y-auto">

                    <!-- Top Bar -->
                    <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
                        <jsp:include page="../common/Topbar.jsp" />
                    </div>

                    <main class="flex-1 p-6">

                        <!-- Page Header -->
                        <div class="flex items-center justify-between mb-6">
                            <div>
                                <h1 class="text-2xl font-bold text-slate-800">Projects</h1>
                                <p class="text-slate-500 mt-1">Manage and track all your construction projects.</p>
                            </div>
                            <a href="<%= request.getContextPath() %>/admin/projects?action=new"
                                class="flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">
                                <i data-lucide="plus" class="h-4 w-4"></i>
                                Add Project
                            </a>
                        </div>

                        <!-- Stats Cards -->
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                            <jsp:include page="../common/statsCard.jsp">
                                <jsp:param name="title" value="Planned" />
                                <jsp:param name="value" value="${empty statusCounts ? 0 : statusCounts['PLANNED']}" />
                                <jsp:param name="icon" value="calendar-clock" />
                                <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                                <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                            </jsp:include>
                            <jsp:include page="../common/statsCard.jsp">
                                <jsp:param name="title" value="In Progress" />
                                <jsp:param name="value"
                                    value="${empty statusCounts ? 0 : statusCounts['IN_PROGRESS']}" />
                                <jsp:param name="valueClass" value="text-2xl font-bold text-orange-500 mt-1" />
                                <jsp:param name="icon" value="hammer" />
                                <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                                <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                            </jsp:include>
                            <jsp:include page="../common/statsCard.jsp">
                                <jsp:param name="title" value="Completed" />
                                <jsp:param name="value" value="${empty statusCounts ? 0 : statusCounts['COMPLETED']}" />
                                <jsp:param name="valueClass" value="text-2xl font-bold text-green-600 mt-1" />
                                <jsp:param name="icon" value="check-circle-2" />
                                <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                                <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                            </jsp:include>
                            <jsp:include page="../common/statsCard.jsp">
                                <jsp:param name="title" value="On Hold" />
                                <jsp:param name="value" value="${empty statusCounts ? 0 : statusCounts['ON_HOLD']}" />
                                <jsp:param name="valueClass" value="text-2xl font-bold text-red-500 mt-1" />
                                <jsp:param name="icon" value="pause-circle" />
                                <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                                <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                            </jsp:include>
                        </div>

                        <!-- Filters -->
                        <div
                            class="bg-white border border-slate-200 rounded-xl p-4 mb-6 flex flex-wrap items-center gap-4">
                            <div class="relative flex-1">
                                <i data-lucide="search"
                                    class="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-400"></i>
                                <input id="searchInput" type="text" placeholder="Search projects..."
                                    class="w-full rounded-lg border border-slate-300 py-2 pl-10 pr-4 text-sm outline-none focus:border-orange-300">
                            </div>
                            <div class="flex gap-2">
                                <button onclick="filterProjects('all', this)"
                                    class="filter-btn active rounded-full bg-orange-500 px-4 py-1.5 text-xs font-semibold text-white">All</button>
                                <button onclick="filterProjects('approved', this)"
                                    class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600">Approved</button>
                                <button onclick="filterProjects('denied', this)"
                                    class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600">Denied</button>
                                <button onclick="filterProjects('in progress', this)"
                                    class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600">In
                                    Progress</button>
                                <button onclick="filterProjects('completed', this)"
                                    class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600 ">Completed</button>
                                <button onclick="filterProjects('planned', this)"
                                    class="filter-btn rounded-full border border-slate-300 px-4 py-1.5 text-xs font-semibold text-slate-600 ">Planned</button>
                            </div>
                        </div>
                        <div id="projectList" class="space-y-4">
                            <c:forEach var="project" items="${projects}">
                                <jsp:include page="../common/projectCard.jsp">
                                    <jsp:param name="title" value="${project.title}" />
                                    <jsp:param name="client"
                                        value="${empty project.clientName ? 'Unassigned' : project.clientName}" />
                                    <jsp:param name="status" value="${project.statusDisplayName}" />
                                    <jsp:param name="statusRaw" value="${project.status}" />
                                    <jsp:param name="projectId" value="${project.id}" />
                                    <jsp:param name="progress"
                                        value="${project.status == 'COMPLETED' ? 100 : (project.status == 'IN_PROGRESS' ? 60 : (project.status == 'APPROVED' ? 20 : (project.status == 'ON_HOLD' ? 30 : (project.status == 'DENIED' ? 0 : 10))))}" />
                                    <jsp:param name="workers" value="${project.assignedWorkerCount}" />
                                    <jsp:param name="budget" value="NPR ${project.totalBudget}" />
                                    <jsp:param name="startDate" value="${project.startDate}" />
                                    <jsp:param name="endDate"
                                        value="${empty project.endDate ? '-' : project.endDate}" />
                                    <jsp:param name="viewLink"
                                        value="${pageContext.request.contextPath}/admin/projects/form?mode=view&amp;id=${project.id}" />
                                    <jsp:param name="editLink"
                                        value="${pageContext.request.contextPath}/admin/projects/form?mode=edit&amp;id=${project.id}" />
                                </jsp:include>
                            </c:forEach>
                        </div>

                        <p id="projectSummary" class="mt-4 text-sm text-slate-500">Showing ${empty projects ? 0 :
                            projects.size()} projects</p>
                    </main>

                </div>
            </div>

            <script>
                // Simple Search and Filter Logic
                const searchInput = document.getElementById('searchInput');
                const cards = document.querySelectorAll('.project-card');
                const filterBtns = document.querySelectorAll('.filter-btn');

                function filterProjects(status, button) {
                    // Update button styles
                    filterBtns.forEach(btn => {
                        btn.classList.remove('bg-orange-500', 'text-white', 'border-transparent');
                        btn.classList.add('border-slate-300', 'text-slate-600');
                    });
                    if (button) {
                        button.classList.add('bg-orange-500', 'text-white', 'border-transparent');
                        button.classList.remove('border-slate-300', 'text-slate-600');
                    }

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

                    const summary = document.getElementById('projectSummary');
                    if (summary) {
                        const visible = Array.from(cards).filter(card => card.style.display !== 'none').length;
                        summary.textContent = 'Showing ' + visible + ' of ' + cards.length + ' projects';
                    }
                }

                searchInput.addEventListener('input', () => {
                    // Trigger click on active button to re-filter
                    document.querySelector('.filter-btn.bg-orange-500').click();
                });

                lucide.createIcons();
            </script>

        </body>

        </html>