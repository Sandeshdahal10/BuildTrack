<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Projects - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        /* Subtle fade-in for project cards */
        .fade-in {
            animation: fadeIn 0.7s cubic-bezier(0.4, 0, 0.2, 1);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        /* Glass effect for cards */
        .glass {
            background: rgba(255,255,255,0.85);
            backdrop-filter: blur(4px);
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
<body class="h-screen overflow-hidden bg-gradient-to-br from-slate-50 via-slate-100 to-amber-50 text-slate-900">

<div class="h-screen">
    <!-- Sidebar -->
    <div class="fixed inset-y-0 left-0 z-30 w-56">
        <jsp:include page="../common/WorkerSideBar.jsp" />
    </div>

    <!-- Main Content -->
    <div class="ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-y-auto">
        <!-- Top Bar -->
        <div class="sticky top-0 z-20">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-6 lg:p-8">
            <!-- Page Header -->
            <div class="flex flex-col sm:flex-row sm:items-center justify-between mb-8 gap-4">
                <div>
                    <h1 class="text-3xl font-bold tracking-tight text-amber-600">Projects</h1>
                    <p class="text-slate-500 mt-1">Manage all construction projects</p>
                </div>
                <button class="modern-btn flex items-center gap-2 rounded-lg px-5 py-2.5 text-base font-semibold text-white shadow transition-all duration-200 hover:scale-105 focus:outline-none focus:ring-2 focus:ring-amber-300">
                    <i data-lucide="plus" class="h-4 w-4"></i>
                    Add New Project
                </button>
            </div>

            <!-- Project List -->
            <div class="space-y-5">
                <c:choose>
                    <c:when test="${not empty projects}">
                        <c:forEach var="project" items="${projects}">
                            <jsp:include page="../common/projectCard.jsp">
                                <jsp:param name="title" value="${project.title}"/>
                                <jsp:param name="client" value="${empty project.clientName ? 'Unassigned' : project.clientName}"/>
                                <jsp:param name="status" value="${project.statusDisplayName}"/>
                                <jsp:param name="statusRaw" value="${project.status}"/>
                                <jsp:param name="progress" value="${project.status == 'COMPLETED' ? 100 : (project.status == 'IN_PROGRESS' ? 60 : (project.status == 'ON_HOLD' ? 30 : 10))}"/>
                                <jsp:param name="workers" value="${project.assignedWorkerCount}"/>
                                <jsp:param name="budget" value="Rs ${project.totalBudget}"/>
                                <jsp:param name="startDate" value="${project.startDate}"/>
                                <jsp:param name="endDate" value="${empty project.endDate ? '-' : project.endDate}"/>
                                <jsp:param name="viewLink" value="${pageContext.request.contextPath}/worker/projects/form?mode=view&amp;id=${project.id}"/>
                                <jsp:param name="editLink" value="${pageContext.request.contextPath}/worker/projects/form?mode=edit&amp;id=${project.id}"/>
                            </jsp:include>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- Fallback / Mock Data matching screenshot -->
                        <jsp:include page="../common/projectCard.jsp">
                            <jsp:param name="title" value="Skyline Tower Complex"/>
                            <jsp:param name="client" value="Amit Sharma"/>
                            <jsp:param name="status" value="In Progress"/>
                            <jsp:param name="progress" value="68"/>
                            <jsp:param name="workers" value="12"/>
                            <jsp:param name="budget" value="Rs 50.0L"/>
                            <jsp:param name="startDate" value="2025-01-15"/>
                            <jsp:param name="endDate" value="2025-12-30"/>
                            <jsp:param name="viewLink" value="#"/>
                            <jsp:param name="editLink" value="#"/>
                        </jsp:include>

                        <jsp:include page="../common/projectCard.jsp">
                            <jsp:param name="title" value="Green Valley Residency"/>
                            <jsp:param name="client" value="Priya Mehta"/>
                            <jsp:param name="status" value="In Progress"/>
                            <jsp:param name="progress" value="88"/>
                            <jsp:param name="workers" value="8"/>
                            <jsp:param name="budget" value="Rs 32.0L"/>
                            <jsp:param name="startDate" value="2025-02-01"/>
                            <jsp:param name="endDate" value="2025-11-15"/>
                            <jsp:param name="viewLink" value="#"/>
                            <jsp:param name="editLink" value="#"/>
                        </jsp:include>

                        <jsp:include page="../common/projectCard.jsp">
                            <jsp:param name="title" value="River Bridge Construction"/>
                            <jsp:param name="client" value="Govt. Authority"/>
                            <jsp:param name="status" value="In Progress"/>
                            <jsp:param name="progress" value="25"/>
                            <jsp:param name="workers" value="15"/>
                            <jsp:param name="budget" value="Rs 80.0L"/>
                            <jsp:param name="startDate" value="2025-03-10"/>
                            <jsp:param name="endDate" value="2026-03-10"/>
                            <jsp:param name="viewLink" value="#"/>
                            <jsp:param name="editLink" value="#"/>
                        </jsp:include>

                        <jsp:include page="../common/projectCard.jsp">
                            <jsp:param name="title" value="Shopping Mall Renovation"/>
                            <jsp:param name="client" value="Rahul Industries"/>
                            <jsp:param name="status" value="Completed"/>
                            <jsp:param name="progress" value="100"/>
                            <jsp:param name="workers" value="20"/>
                            <jsp:param name="budget" value="Rs 120.0L"/>
                            <jsp:param name="startDate" value="2024-06-01"/>
                            <jsp:param name="endDate" value="2025-02-28"/>
                            <jsp:param name="viewLink" value="#"/>
                            <jsp:param name="editLink" value="#"/>
                        </jsp:include>
                    </c:otherwise>
                </c:choose>
            </div>

        </main>
    </div>
</div>

<script>
    lucide.createIcons();
</script>
</body>
</html>
