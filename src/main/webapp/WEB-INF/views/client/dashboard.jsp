<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Client";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Client Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">
<div class="h-screen overflow-hidden">
    <!-- Sidebar Container -->
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <!-- Main Content Area -->
    <div class="ml-0 md:ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-hidden">
        <!-- Top Navbar Header -->
        <div class="sticky top-0 z-20 shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <!-- Dashboard Content Viewport -->
        <main class="flex-1 overflow-y-auto px-6 py-6 space-y-6">
            
            <!-- Welcome Header Card -->
            <section class="rounded-2xl border border-slate-200 bg-white px-6 py-6 shadow-sm">
                <h1 class="text-3xl font-bold tracking-tight text-slate-900">Welcome back, <%= displayName %></h1>
                <p class="mt-1.5 text-sm text-slate-500 font-medium">Stay updated on your construction projects today.</p>
            </section>

            <!-- Stats Grid Section -->
            <section class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Active Projects" />
                    <jsp:param name="value" value="${dashboardSummary.activeProjects}" />
                    <jsp:param name="subtitle" value="Out of ${dashboardSummary.totalProjects} total projects" />
                    <jsp:param name="icon" value="briefcase" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-amber-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-amber-600" />
                </jsp:include>

                <c:set var="spentFormatted">
                    NPR <fmt:formatNumber value="${dashboardSummary.totalSpent}" type="number" maxFractionDigits="0"/>
                </c:set>
                <c:set var="budgetFormatted">
                    NPR <fmt:formatNumber value="${dashboardSummary.totalBudget}" type="number" maxFractionDigits="0"/>
                </c:set>
                <c:set var="utilizationFormatted">
                    <fmt:formatNumber value="${dashboardSummary.utilizationPercent}" maxFractionDigits="1"/>% utilized
                </c:set>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Budget Spent" />
                    <jsp:param name="value" value="${spentFormatted} / ${budgetFormatted}" />
                    <jsp:param name="subtitle" value="${utilizationFormatted}" />
                    <jsp:param name="icon" value="wallet" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-blue-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-blue-600" />
                </jsp:include>
            </section>

            <!-- Main Info Columns -->
            <div class="grid grid-cols-1 gap-6">
                <!-- Projects Progress Panel -->
                <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h2 class="text-lg font-bold text-slate-800 flex items-center gap-2 mb-6 border-b border-slate-100 pb-3">
                        <i data-lucide="folder" class="w-5 h-5 text-amber-500"></i>
                        Your Projects
                    </h2>

                    <c:if test="${empty dashboardSummary.projects}">
                        <div class="py-12 text-center text-sm text-slate-400">
                            <p class="font-bold text-slate-500">No projects registered yet.</p>
                            <p class="mt-1">Click the "Request New Project" button on the sidebar to get started!</p>
                        </div>
                    </c:if>
                    
                    <div class="space-y-6">
                        <c:forEach var="p" items="${dashboardSummary.projects}" varStatus="loop">
                            <div class="${loop.index > 0 ? 'border-t border-slate-100 pt-5' : ''}">
                                <div class="mb-3 flex items-center justify-between flex-wrap gap-2">
                                    <div>
                                        <p class="text-base font-bold text-slate-800">${p.title}</p>
                                        <p class="mt-0.5 text-xs text-slate-400 font-semibold">${p.assignedWorkerCount} workers active</p>
                                    </div>
                                    <span class="font-bold text-[10px] uppercase tracking-wider px-3 py-1 rounded-full ${p.statusBadgeClass}">${p.statusDisplayName}</span>
                                </div>
                                <div class="mb-3 h-2.5 w-full overflow-hidden rounded-full bg-slate-100 shadow-inner">
                                    <div class="h-full rounded-full bg-gradient-to-r from-amber-400 via-amber-300 to-emerald-500 transition-all duration-500" style="width: ${p.budgetUsagePercent > 100 ? 100 : p.budgetUsagePercent}%"></div>
                                </div>
                                <div class="flex justify-between text-xs text-slate-500 font-bold">
                                    <span>Budget: NPR <fmt:formatNumber value="${p.totalBudget}" type="number" maxFractionDigits="0"/> &nbsp;•&nbsp; Spent: NPR <fmt:formatNumber value="${p.actualCost}" type="number" maxFractionDigits="0"/></span>
                                    <span class="text-orange-500"><fmt:formatNumber value="${p.budgetUsagePercent}" maxFractionDigits="1"/>%</span>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>

                <!-- Recent Updates Panel -->
                <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h2 class="text-lg font-bold text-slate-800 flex items-center gap-2 mb-6 border-b border-slate-100 pb-3">
                        <i data-lucide="clock" class="w-5 h-5 text-amber-500"></i>
                        Recent Updates
                    </h2>
                    
                    <c:if test="${empty dashboardSummary.recentUpdates}">
                        <div class="py-8 text-center text-sm text-slate-400">
                            No recent updates logged yet.
                        </div>
                    </c:if>
                    
                    <ul class="space-y-6">
                        <c:forEach var="update" items="${dashboardSummary.recentUpdates}">
                            <li class="grid grid-cols-[20px_minmax(0,1fr)] gap-3 border-l-2 border-slate-100 pl-4 pb-1 last:pb-0">
                                <span class="mt-[6px] h-3 w-3 rounded-full border-2 border-white bg-orange-500 ring-4 ring-orange-50 shrink-0"></span>
                                <div>
                                    <p class="text-sm font-medium text-slate-700">${update.message}</p>
                                    <p class="text-xs text-slate-400 mt-1.5 font-semibold">
                                        <fmt:formatDate value="${update.updatedAt}" pattern="MMM d, yyyy h:mm a"/>
                                    </p>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </section>
            </div>

        </main>
    </div>
</div>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
</body>
</html>
