<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projects - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
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
    </style>
</head>
<body class="bg-slate-50 text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">

<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">
    <!-- Sidebar included directly to avoid wrapper and margin mismatch -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Content Area -->
    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden bg-slate-50/50">
        <!-- Top Bar -->
        <div class="w-full shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <!-- CONTENT -->
        <div class="px-8 py-6 overflow-y-auto grow">
            <div class="max-w-7xl mx-auto">
                <!-- Page Header -->
                <div class="mb-6">
                    <h1 class="text-2xl font-bold text-slate-800 tracking-tight">Projects</h1>
                    <p class="text-sm text-slate-500 mt-1 font-medium">View all construction projects assigned to you</p>
                </div>

                <!-- Project List -->
                <div class="space-y-5 fade-in">
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
                                    <jsp:param name="budget" value="NPR ${project.totalBudget}"/>
                                    <jsp:param name="startDate" value="${project.startDate}"/>
                                    <jsp:param name="endDate" value="${empty project.endDate ? '-' : project.endDate}"/>
                                    <jsp:param name="viewLink" value="${pageContext.request.contextPath}/worker/projects/form?mode=view&amp;id=${project.id}"/>
                                    <jsp:param name="editLink" value="${pageContext.request.contextPath}/worker/projects/form?mode=edit&amp;id=${project.id}"/>
                                </jsp:include>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="rounded-2xl border border-slate-200 bg-white p-12 text-center shadow-sm max-w-xl mx-auto mt-8">
                                <div class="w-16 h-16 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center mx-auto mb-4">
                                    <i data-lucide="folder-open" class="w-8 h-8"></i>
                                </div>
                                <h3 class="text-lg font-bold text-slate-800">No Assigned Projects</h3>
                                <p class="text-slate-500 font-medium mt-1 text-sm">You are not currently assigned to any active projects.</p>
                                <p class="text-slate-400 text-xs mt-3">Please contact your system administrator to get assigned to a project.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
</body>
</html>
