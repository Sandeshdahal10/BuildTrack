<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "sag";

    Integer currentClientUserId = null;
    if (session.getAttribute("userId") != null) {
        currentClientUserId = (Integer) session.getAttribute("userId");
    } else if (user != null) {
        currentClientUserId = user.getId();
    }
    java.util.List<com.buildtrack.model.Notification> clientHeaderNotifications = new java.util.ArrayList<>();
    int clientHeaderUnreadCount = 0;
    if (currentClientUserId != null) {
        com.buildtrack.dao.NotificationDao headerNotifDao = new com.buildtrack.dao.NotificationDao();
        clientHeaderNotifications = headerNotifDao.getNotificationsByUserId(currentClientUserId);
        clientHeaderUnreadCount = headerNotifDao.getUnreadCount(currentClientUserId);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Client Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 bg-white text-slate-900">
<div class="h-screen flex font-semibold">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <main class="ml-0 md:ml-56 overflow-hidden flex-1 overflow-y-auto bg-white px-5 pb-7 pt-4">
        <div class="mb-3 flex items-center justify-between text-[11px] text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>Thursday, April 16, 2026</div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                <input id="dashboardSearchInput" class="min-w-[205px] rounded-md border border-slate-200 bg-white px-2.5 py-1.5 text-xs text-slate-900 outline-none max-[760px]:min-w-0 max-[760px]:flex-1" type="text" placeholder="Search dashboard..." aria-label="Search dashboard">
                <div class="relative">
                <button id="notificationButton" class="relative grid h-7 w-7 place-items-center rounded-full border border-slate-200 bg-white p-0" type="button" aria-label="Notifications" aria-expanded="false" aria-controls="notificationMenu">
                    <svg viewBox="0 0 24 24" class="h-3.5 w-3.5 stroke-slate-900" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5"></path>
                        <path d="M9 17a3 3 0 0 0 6 0"></path>
                    </svg>
                    <span id="notificationBadge" class="absolute -right-0.5 -top-0.5 min-w-[14px] rounded-full border border-white bg-amber-500 px-0.5 text-center text-[9px] font-bold leading-3 text-slate-800 <%= clientHeaderUnreadCount == 0 ? "hidden" : "" %>"><%= clientHeaderUnreadCount %></span>
                </button>
                <div id="notificationMenu" class="absolute right-0 top-9 z-20 hidden w-72 rounded-xl border border-slate-200 bg-white p-3 shadow-lg">
                    <div class="mb-2 flex items-center justify-between">
                        <p class="m-0 text-sm font-semibold text-slate-900">Notifications</p>
                        <button id="markAllReadButton" class="text-xs font-semibold text-amber-600 <%= clientHeaderUnreadCount == 0 ? "hidden" : "" %>" type="button">Mark all read</button>
                    </div>
                    <ul class="m-0 list-none space-y-2 p-0 text-xs text-slate-600 max-h-60 overflow-y-auto">
                        <% if (clientHeaderNotifications.isEmpty()) { %>
                            <li class="rounded-lg bg-slate-50 px-2.5 py-2 text-center text-slate-400">No new notifications.</li>
                        <% } else { %>
                            <% for (com.buildtrack.model.Notification n : clientHeaderNotifications) { %>
                                <li class="rounded-lg <%= n.isRead() ? "bg-slate-50 text-slate-500" : "bg-amber-50/70 text-slate-800 font-medium" %> px-2.5 py-2 border-b border-slate-100 last:border-b-0"><%= n.getMessage() %></li>
                            <% } %>
                        <% } %>
                    </ul>
                </div>
                </div>
                <div class="relative">
                    <button id="userMenuButton" class="flex items-center gap-1.5 rounded-full border border-slate-200 bg-white px-2 py-1 text-left" type="button" aria-haspopup="true" aria-expanded="false">
                        <div class="grid h-6 w-6 place-items-center rounded-full bg-amber-300 text-[11px] font-bold text-slate-700"><%= displayName.substring(0, 1).toUpperCase() %></div>
                        <span class="text-xs text-slate-900"><%= displayName %></span>
                        <svg class="ml-1 h-3.5 w-3.5 text-slate-500" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.188l3.71-3.956a.75.75 0 111.08 1.04l-4.24 4.52a.75.75 0 01-1.08 0l-4.24-4.52a.75.75 0 01.02-1.06z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                    <div id="userMenu" class="absolute right-0 mt-2 hidden w-40 overflow-hidden rounded-xl border border-slate-200 bg-white text-xs shadow-lg">
                        <a href="<%= request.getContextPath() %>/client/profile" class="flex items-center gap-2 px-3 py-2 text-slate-700 hover:bg-slate-50">Profile</a>
                        <a href="<%= request.getContextPath() %>/logout" class="flex items-center gap-2 px-3 py-2 text-rose-600 hover:bg-rose-50">Log Out</a>
                    </div>
                </div>
            </div>
        </div>

        <section class="dashboard-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)] transition duration-200" data-search="welcome dashboard <%= displayName %> stay updated construction projects">
            <h1 class="m-0 text-[34px] font-semibold leading-none">Welcome, <%= displayName %></h1>
            <p class="mt-1 text-xs text-slate-600">Stay updated on your construction projects.</p>
        </section>

        <section class="mt-3.5 grid grid-cols-1 md:grid-cols-2 gap-3.5">
            <article class="dashboard-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_8px_20px_rgba(15,23,42,0.04)] hover:shadow transition duration-200" data-search="active projects ${dashboardSummary.activeProjects}">
                <p class="m-0 text-[11px] font-bold uppercase tracking-wider text-slate-400">Active Projects</p>
                <p class="mb-0 mt-1.5 text-3xl font-black text-slate-800">${dashboardSummary.activeProjects}</p>
                <p class="m-0 mt-1 text-[11px] text-slate-500 font-semibold">Out of ${dashboardSummary.totalProjects} total projects</p>
            </article>
            <article class="dashboard-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_8px_20px_rgba(15,23,42,0.04)] hover:shadow transition duration-200" data-search="budget spent ${dashboardSummary.totalSpent} total ${dashboardSummary.totalBudget} ${dashboardSummary.utilizationPercent} percent utilized">
                <p class="m-0 text-[11px] font-bold uppercase tracking-wider text-slate-400">Budget Spent</p>
                <p class="mb-0 mt-1.5 text-2xl font-black text-slate-800">
                    NPR <fmt:formatNumber value="${dashboardSummary.totalSpent}" type="number" groupingUsed="true" maxFractionDigits="0"/> 
                    / NPR <fmt:formatNumber value="${dashboardSummary.totalBudget}" type="number" groupingUsed="true" maxFractionDigits="0"/>
                </p>
                <p class="m-0 mt-1 text-[11px] text-orange-500 font-bold"><fmt:formatNumber value="${dashboardSummary.utilizationPercent}" maxFractionDigits="1"/>% utilized</p>
            </article>
        </section>

        <section class="dashboard-search-item mt-3.5 rounded-2xl border border-slate-200 bg-white px-5 py-5 shadow-[0_10px_24px_rgba(15,23,42,0.04)] transition duration-200" data-search="your projects <c:forEach var='p' items='${dashboardSummary.projects}'><c:out value='${p.title}'/> </c:forEach>">
            <h2 class="mb-4 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                Your Projects
            </h2>

            <c:if test="${empty dashboardSummary.projects}">
                <div class="py-10 text-center text-xs text-slate-400">
                    <p class="font-bold text-slate-500 text-sm">No projects registered yet.</p>
                    <p class="mt-1">Click the "Request New Project" button on the sidebar to get started!</p>
                </div>
            </c:if>
            <c:forEach var="p" items="${dashboardSummary.projects}" varStatus="loop">
                <div class="${loop.index > 0 ? 'mt-6 border-t border-slate-100 pt-5' : ''}">
                    <div class="mb-2 flex items-center justify-between flex-wrap gap-2">
                        <div>
                            <p class="m-0 text-sm font-bold text-slate-800">${p.title}</p>
                            <p class="mt-0.5 text-[10px] text-slate-500 font-bold">${p.assignedWorkerCount} workers active</p>
                        </div>
                        <span class="font-bold text-[9px] uppercase tracking-wider px-2.5 py-0.5 rounded-full ${p.statusBadgeClass}">${p.statusDisplayName}</span>
                    </div>
                    <div class="mb-2 h-2 w-full overflow-hidden rounded-full bg-slate-100 shadow-inner">
                        <div class="h-full rounded-full bg-gradient-to-r from-amber-400 via-amber-300 to-emerald-500 transition-all duration-500" style="width: ${p.budgetUsagePercent > 100 ? 100 : p.budgetUsagePercent}%"></div>
                    </div>
                    <div class="flex justify-between text-[11px] text-slate-500 font-bold">
                        <span>Budget: NPR <fmt:formatNumber value="${p.totalBudget}" type="number" maxFractionDigits="0"/> &nbsp;•&nbsp; Spent: NPR <fmt:formatNumber value="${p.actualCost}" type="number" maxFractionDigits="0"/></span>
                        <span class="text-orange-500"><fmt:formatNumber value="${p.budgetUsagePercent}" maxFractionDigits="1"/>%</span>
                    </div>
                </div>
            </c:forEach>
        </section>

        <section class="dashboard-search-item mt-3.5 rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.04)] transition duration-200" data-search="recent updates <c:forEach var='u' items='${dashboardSummary.recentUpdates}'><c:out value='${u.message}'/> </c:forEach>">
            <h2 class="mb-3.5 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 8v4l3 3m6-3a9 9 0 1 1-18 0 9 9 0 0 1 18 0z"></path></svg>
                Recent Updates
            </h2>
            <ul class="m-0 grid list-none gap-4 p-0">
                <c:forEach var="update" items="${dashboardSummary.recentUpdates}">
                    <li class="grid grid-cols-[18px_minmax(0,1fr)] gap-2.5 border-l-2 border-slate-100 pl-3">
                        <span class="mt-[5px] h-2.5 w-2.5 rounded-full border border-white bg-orange-500 ring-4 ring-orange-50"></span>
                        <div>
                            <p class="m-0 text-xs font-semibold text-slate-700">${update.message}</p>
                            <p class="mt-0.5 text-[9px] font-bold text-slate-400">
                                <fmt:formatDate value="${update.updatedAt}" pattern="MMM d, yyyy h:mm a"/>
                            </p>
                        </div>
                    </li>
                </c:forEach>
                <c:if test="${empty dashboardSummary.recentUpdates}">
                    <li class="py-4 text-center text-xs text-slate-400">No recent updates logged yet.</li>
                </c:if>
            </ul>
        </section>
        <p id="emptySearchState" class="mt-4 hidden rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-600">No dashboard results matched your search.</p>
    </main>
</div>
<script>
    (function () {
        var searchInput = document.getElementById("dashboardSearchInput");
        var items = Array.prototype.slice.call(document.querySelectorAll(".dashboard-search-item"));
        var emptyState = document.getElementById("emptySearchState");

        function filterDashboard() {
            var query = (searchInput.value || "").toLowerCase().trim();
            var visible = 0;

            items.forEach(function (item) {
                var searchable = (item.getAttribute("data-search") || "").toLowerCase();
                var isMatch = query === "" || searchable.indexOf(query) !== -1;
                item.classList.toggle("hidden", !isMatch);
                if (isMatch) {
                    visible += 1;
                }
            });

            emptyState.classList.toggle("hidden", visible !== 0);
        }

        if (searchInput) {
            searchInput.addEventListener("input", filterDashboard);
        }

        var notificationButton = document.getElementById("notificationButton");
        var notificationMenu = document.getElementById("notificationMenu");
        var notificationBadge = document.getElementById("notificationBadge");
        var markAllReadButton = document.getElementById("markAllReadButton");

        function closeNotifications() {
            notificationMenu.classList.add("hidden");
            notificationButton.setAttribute("aria-expanded", "false");
        }

        if (notificationButton && notificationMenu) {
            notificationButton.addEventListener("click", function (event) {
                event.stopPropagation();
                notificationMenu.classList.toggle("hidden");
                notificationButton.setAttribute("aria-expanded", notificationMenu.classList.contains("hidden") ? "false" : "true");
            });

            document.addEventListener("click", function (event) {
                if (!notificationMenu.contains(event.target) && event.target !== notificationButton) {
                    closeNotifications();
                }
            });

            document.addEventListener("keydown", function (event) {
                if (event.key === "Escape") {
                    closeNotifications();
                }
            });
        }

        if (markAllReadButton && notificationBadge) {
            markAllReadButton.addEventListener("click", function () {
                fetch('<%= request.getContextPath() %>/notifications/mark-read', { method: 'POST' })
                    .then(response => {
                        notificationBadge.classList.add("hidden");
                        markAllReadButton.textContent = "All caught up";
                        markAllReadButton.disabled = true;
                        document.querySelectorAll("#notificationMenu li").forEach(li => {
                            li.className = "rounded-lg bg-slate-50 text-slate-500 px-2.5 py-2 border-b border-slate-100 last:border-b-0";
                        });
                    });
            });
        }

        var userMenuButton = document.getElementById("userMenuButton");
        var userMenu = document.getElementById("userMenu");

        function closeUserMenu() {
            userMenu.classList.add("hidden");
            userMenuButton.setAttribute("aria-expanded", "false");
        }

        if (userMenuButton && userMenu) {
            userMenuButton.addEventListener("click", function (event) {
                event.stopPropagation();
                userMenu.classList.toggle("hidden");
                userMenuButton.setAttribute("aria-expanded", userMenu.classList.contains("hidden") ? "false" : "true");
            });

            document.addEventListener("click", function (event) {
                if (!userMenu.contains(event.target) && event.target !== userMenuButton) {
                    closeUserMenu();
                }
            });

            document.addEventListener("keydown", function (event) {
                if (event.key === "Escape") {
                    closeUserMenu();
                }
            });
        }
    })();
</script>
</body>
</html>
