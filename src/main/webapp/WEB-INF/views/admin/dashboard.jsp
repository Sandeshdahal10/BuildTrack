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
                <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <c:choose>
                    <c:when test="${not empty sessionScope.user.fullName}">
                        <h1 class="text-3xl font-bold tracking-tight text-slate-900">Good Morning, <c:out value="${sessionScope.user.fullName}" /></h1>
                    </c:when>
                    <c:otherwise>
                        <h1 class="text-3xl font-bold tracking-tight text-slate-900">Good Morning, Admin</h1>
                    </c:otherwise>
                </c:choose>
                <p class="mt-2 text-base text-slate-600">Here's what's happening with your construction projects today.</p>
            </section>

            <section class="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-4">
                <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Active Projects" />
                    <jsp:param name="value" value="${projectStats['IN_PROGRESS'] != null ? projectStats['IN_PROGRESS'] : 0}" />
                    <jsp:param name="subtitle" value="Total projects: ${projectStats['total'] != null ? projectStats['total'] : 0}" />
                    <jsp:param name="icon" value="briefcase-business" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-amber-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-amber-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Workers" />
                    <jsp:param name="value" value="${userStats['WORKER'] != null ? userStats['WORKER'] : 0}" />
                    <jsp:param name="subtitle" value="Across all projects" />
                    <jsp:param name="icon" value="users" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-cyan-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-cyan-600" />
                </jsp:include>

                <c:set var="budgetPct" value="0.0" />
                <c:if test="${globalTotalBudget > 0}">
                    <c:set var="budgetPct" value="${(globalTotalUtilized / globalTotalBudget) * 100}" />
                </c:if>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Budget Utilization" />
                    <jsp:param name="value" value="${String.format('%.1f', budgetPct)}%" />
                    <jsp:param name="subtitle" value="Rs.${globalTotalUtilized} of Rs.${globalTotalBudget}" />
                    <jsp:param name="icon" value="badge-indian-rupee" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-blue-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-blue-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Pending Approvals" />
                    <jsp:param name="value" value="${pendingUsers != null ? pendingUsers.size() : 0}" />
                    <jsp:param name="subtitle" value="Action required" />
                    <jsp:param name="icon" value="clipboard-check" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-rose-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-rose-600" />
                </jsp:include>
            </section>

            <section class="mt-6 grid grid-cols-1 gap-4 xl:grid-cols-2">
                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <h2 class="text-base font-semibold text-slate-900">Project Status</h2>
                    <div class="mt-5 flex items-center justify-center">
                        <c:set var="tot" value="${projectStats['total'] > 0 ? projectStats['total'] : 1}" />
                        <c:set var="p1" value="${(projectStats['PLANNED'] != null ? projectStats['PLANNED'] : 0) * 360 / tot}" />
                        <c:set var="p2" value="${(projectStats['IN_PROGRESS'] != null ? projectStats['IN_PROGRESS'] : 0) * 360 / tot}" />
                        <c:set var="p3" value="${(projectStats['COMPLETED'] != null ? projectStats['COMPLETED'] : 0) * 360 / tot}" />
                        
                        <div class="relative h-36 w-36 rounded-full border border-slate-200"
                             style="background: conic-gradient(
                                 #facc15 0deg ${p1}deg,
                                 #f59e0b ${p1}deg ${p1+p2}deg,
                                 #14b8a6 ${p1+p2}deg ${p1+p2+p3}deg,
                                 #ef4444 ${p1+p2+p3}deg 360deg
                             );">
                            <div class="absolute inset-4 rounded-full bg-white border border-slate-100 flex items-center justify-center">
                                <span class="font-bold text-slate-700">${projectStats['total']}</span>
                            </div>
                        </div>
                    </div>
                    <div class="mt-5 flex flex-wrap items-center justify-center gap-x-4 gap-y-2 text-xs text-slate-600">
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-yellow-400"></span>Planned (${projectStats['PLANNED'] != null ? projectStats['PLANNED'] : 0})</span>
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-amber-500"></span>In Progress (${projectStats['IN_PROGRESS'] != null ? projectStats['IN_PROGRESS'] : 0})</span>
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-teal-500"></span>Completed (${projectStats['COMPLETED'] != null ? projectStats['COMPLETED'] : 0})</span>
                        <span class="inline-flex items-center gap-1.5"><span class="h-2.5 w-2.5 rounded-full bg-red-500"></span>On Hold (${projectStats['ON_HOLD'] != null ? projectStats['ON_HOLD'] : 0})</span>
                    </div>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <div class="flex justify-between items-center">
                        <h2 class="text-base font-semibold text-slate-900">Budget vs Actual</h2>
                        <div class="flex gap-3 text-xs">
                            <span class="flex items-center gap-1"><span class="h-2 w-2 bg-amber-500 rounded-full"></span> Budget</span>
                            <span class="flex items-center gap-1"><span class="h-2 w-2 bg-teal-500 rounded-full"></span> Actual</span>
                        </div>
                    </div>
                    <div class="budget-grid mt-5 rounded-xl border border-slate-200 p-4">
                        <div class="grid h-48 grid-cols-5 items-end gap-3">
                            <c:forEach var="row" items="${budgetVsActual}" end="4">
                                <c:set var="maxVal" value="${row.totalBudget > row.actualCost ? row.totalBudget : row.actualCost}" />
                                <c:set var="bH" value="${maxVal > 0 ? (row.totalBudget / maxVal) * 100 : 0}" />
                                <c:set var="aH" value="${maxVal > 0 ? (row.actualCost / maxVal) * 100 : 0}" />
                                <div class="flex items-end justify-center gap-1 group relative" title="Budget: ${row.totalBudget} | Actual: ${row.actualCost}">
                                    <span class="w-4 sm:w-6 rounded-t bg-amber-500" style="height: ${bH}%;"></span>
                                    <span class="w-4 sm:w-6 rounded-t bg-teal-500" style="height: ${aH}%;"></span>
                                </div>
                            </c:forEach>
                            <c:if test="${empty budgetVsActual}">
                                <div class="col-span-5 text-center text-slate-400 text-sm mt-20">No financial data available</div>
                            </c:if>
                        </div>
                    </div>
                    <div class="mt-3 grid grid-cols-5 text-center text-xs text-slate-500 truncate">
                        <c:forEach var="row" items="${budgetVsActual}" end="4">
                           <span class="truncate px-1" title="${row.title}">${row.title}</span>
                        </c:forEach>
                    </div>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <h2 class="text-base font-semibold text-slate-900">Recent Projects Added</h2>
                    <ul class="mt-4 space-y-4">
                        <c:forEach var="rp" items="${recentProjects}">
                            <li class="flex items-start gap-3">
                                <span class="mt-1 h-2.5 w-2.5 rounded-full bg-blue-500"></span>
                                <div>
                                    <p class="text-sm text-slate-700 font-medium">${rp.title}</p>
                                    <p class="text-xs text-slate-500">Starts: ${rp.startDate}</p>
                                </div>
                            </li>
                        </c:forEach>
                        <c:if test="${empty recentProjects}">
                            <li class="text-sm text-slate-500 text-center mt-6">No recent projects</li>
                        </c:if>
                    </ul>
                </article>

                <article class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                    <h2 class="text-base font-semibold text-slate-900">Material Alerts & Pending Actions</h2>
                    <ul class="mt-4 space-y-4">
                        <c:forEach var="mat" items="${lowStockMaterials}" end="2">
                            <li class="flex items-start justify-between gap-4">
                                <div class="flex items-start gap-3">
                                    <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-rose-200 bg-rose-50 text-rose-600"><i data-lucide="package-open" class="h-3 w-3"></i></span>
                                    <div>
                                        <p class="text-sm text-slate-700">Low Stock: ${mat.name}</p>
                                        <p class="text-xs text-slate-500">Only ${mat.totalStock} ${mat.unit} remaining</p>
                                    </div>
                                </div>
                                <span class="rounded-md bg-rose-100 px-2 py-1 text-xs font-medium text-rose-700">Urgent</span>
                            </li>
                        </c:forEach>
                        <c:forEach var="u" items="${pendingUsers}" end="2">
                            <li class="flex items-start gap-3">
                                <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-amber-200 bg-amber-50 text-amber-600"><i data-lucide="user-plus" class="h-3 w-3"></i></span>
                                <div>
                                    <p class="text-sm text-slate-700">Pending User Approval</p>
                                    <p class="text-xs text-slate-500">${u.fullName} (${u.role})</p>
                                </div>
                            </li>
                        </c:forEach>
                        <c:if test="${empty lowStockMaterials && empty pendingUsers}">
                            <li class="flex items-start gap-3">
                                <span class="mt-0.5 inline-flex h-5 w-5 items-center justify-center rounded-full border border-green-200 bg-green-50 text-green-600"><i data-lucide="check" class="h-3 w-3"></i></span>
                                <div>
                                    <p class="text-sm text-slate-700">All caught up!</p>
                                    <p class="text-xs text-slate-500">No pending alerts</p>
                                </div>
                            </li>
                        </c:if>
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
