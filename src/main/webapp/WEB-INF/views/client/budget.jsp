<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Client";

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
    
    // Compute dynamic CSS conic-gradient based on database cost distribution values
    java.util.Map<?, ?> budgetSummaryMap = (java.util.Map<?, ?>) request.getAttribute("budgetSummary");
    String conicGradientStr = "conic-gradient(#cbd5e1 0deg 360deg)";
    if (budgetSummaryMap != null && budgetSummaryMap.get("budgetDistribution") != null) {
        java.util.List<java.util.Map<String, Object>> distribution = 
            (java.util.List<java.util.Map<String, Object>>) budgetSummaryMap.get("budgetDistribution");
        if (distribution != null && !distribution.isEmpty()) {
            StringBuilder sb = new StringBuilder("conic-gradient(");
            double currentAngle = 0;
            for (int i = 0; i < distribution.size(); i++) {
                java.util.Map<String, Object> segment = distribution.get(i);
                Number percentNum = (Number) segment.get("percent");
                double percent = percentNum != null ? percentNum.doubleValue() : 0;
                double segmentAngle = percent * 3.6;
                String color = (String) segment.get("color");
                
                double nextAngle = currentAngle + segmentAngle;
                if (i == distribution.size() - 1) {
                    nextAngle = 360.0;
                }
                
                sb.append(color).append(" ").append(String.format(java.util.Locale.US, "%.1f", currentAngle)).append("deg ")
                  .append(String.format(java.util.Locale.US, "%.1f", nextAngle)).append("deg");
                
                if (i < distribution.size() - 1) {
                    sb.append(", ");
                }
                currentAngle = nextAngle;
            }
            sb.append(")");
            conicGradientStr = sb.toString();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Budget</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 min-h-screen bg-white text-slate-900">
<div class="h-screen flex font-semibold">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/clientsidebar.jsp" />
    </div>

    <main class="ml-0 md:ml-56 overflow-hidden flex-1 overflow-y-auto bg-white px-5 pb-7 pt-4">
        <div class="mb-3 flex items-center justify-between text-[11px] text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>Friday, April 17, 2026</div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                <input id="budgetSearchInput" class="min-w-[205px] rounded-md border border-slate-200 bg-white px-2.5 py-1.5 text-xs text-slate-900 outline-none max-[760px]:min-w-0 max-[760px]:flex-1" type="text" placeholder="Search budget..." aria-label="Search budget">
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

        <section class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)]" data-search="budget track expenditures">
            <h1 class="m-0 text-[34px] font-semibold leading-none">Budget</h1>
            <p class="mt-1 text-xs text-slate-600">Track project expenditures and budgets</p>
        </section>

        <section class="mt-3.5 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3.5">
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_8px_20px_rgba(15,23,42,0.04)] hover:shadow transition duration-200" data-search="total budget ${budgetSummary.totalBudget}">
                <p class="m-0 text-[10px] font-bold uppercase tracking-wider text-slate-400">Total Budget</p>
                <p class="mb-0 mt-1.5 text-2xl font-extrabold text-slate-800">
                    NPR <fmt:formatNumber value="${budgetSummary.totalBudget}" type="number" groupingUsed="true" maxFractionDigits="0"/>
                </p>
            </article>
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_8px_20px_rgba(15,23,42,0.04)] hover:shadow transition duration-200" data-search="total spent ${budgetSummary.totalSpent}">
                <p class="m-0 text-[10px] font-bold uppercase tracking-wider text-slate-400">Total Spent</p>
                <p class="mb-0 mt-1.5 text-2xl font-extrabold text-orange-600">
                    NPR <fmt:formatNumber value="${budgetSummary.totalSpent}" type="number" groupingUsed="true" maxFractionDigits="0"/>
                </p>
            </article>
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_8px_20px_rgba(15,23,42,0.04)] hover:shadow transition duration-200" data-search="remaining budget ${budgetSummary.remainingBudget}">
                <p class="m-0 text-[10px] font-bold uppercase tracking-wider text-slate-400">Remaining</p>
                <p class="mb-0 mt-1.5 text-2xl font-extrabold text-emerald-600">
                    NPR <fmt:formatNumber value="${budgetSummary.remainingBudget}" type="number" groupingUsed="true" maxFractionDigits="0"/>
                </p>
            </article>
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_8px_20px_rgba(15,23,42,0.04)] hover:shadow transition duration-200" data-search="utilization ${budgetSummary.utilizationPercent} percent">
                <p class="m-0 text-[10px] font-bold uppercase tracking-wider text-slate-400">Utilization</p>
                <p class="mb-0 mt-1.5 text-2xl font-extrabold text-slate-700">
                    <fmt:formatNumber value="${budgetSummary.utilizationPercent}" maxFractionDigits="1"/>%
                </p>
            </article>
        </section>

        <section class="budget-search-item mt-4 rounded-2xl border border-slate-200 bg-white px-5 py-5 text-slate-900 shadow-[0_10px_24px_rgba(15,23,42,0.04)]" data-search="budget vs expenditure <c:forEach var='p' items='${budgetSummary.budgetProjects}'><c:out value='${p.title}'/> </c:forEach>">
            <h2 class="mb-4 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
                Budget vs Expenditure
            </h2>

            <c:if test="${empty budgetSummary.budgetProjects}">
                <p class="text-xs text-slate-400 py-6 text-center">No projects assigned to you yet.</p>
            </c:if>
            <c:forEach var="p" items="${budgetSummary.budgetProjects}" varStatus="loop">
                <div class="${loop.index > 0 ? 'mt-6 border-t border-slate-100 pt-5' : ''}">
                    <div class="mb-2 flex items-center justify-between text-xs flex-wrap gap-2">
                        <span class="font-bold text-slate-800 text-sm">${p.title}</span>
                        <span class="text-slate-500 font-bold">
                            NPR <fmt:formatNumber value="${p.spent}" type="number" maxFractionDigits="0"/> 
                            / NPR <fmt:formatNumber value="${p.budget}" type="number" maxFractionDigits="0"/>
                        </span>
                    </div>
                    <div class="h-2.5 w-full overflow-hidden rounded-full bg-slate-100 shadow-inner">
                        <div class="h-full rounded-full bg-gradient-to-r from-amber-400 via-amber-300 to-emerald-500 transition-all duration-500" style="width: ${p.usagePercent > 100 ? 100 : p.usagePercent}%"></div>
                    </div>
                    <div class="mt-2 flex items-center justify-between text-xs">
                        <span class="text-slate-400 font-semibold"><fmt:formatNumber value="${p.usagePercent}" maxFractionDigits="1"/>% utilized</span>
                        <span class="font-bold text-[9px] uppercase tracking-wider px-2.5 py-0.5 rounded-full ${p.statusClass}">${p.status}</span>
                    </div>
                </div>
            </c:forEach>
        </section>

        <section class="mt-4 grid grid-cols-1 xl:grid-cols-2 gap-4">
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_10px_24px_rgba(15,23,42,0.04)]" data-search="cost distribution <c:forEach var='seg' items='${budgetSummary.budgetDistribution}'><c:out value='${seg.label}'/> </c:forEach>">
                <h2 class="mb-4 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                    <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M21.21 15.89A10 10 0 1 1 8 2.83M22 12A10 10 0 0 0 12 2v10z"></path></svg>
                    Cost Distribution
                </h2>
                <div class="flex min-h-[280px] flex-col items-center justify-center">
                    <div class="relative h-44 w-44 rounded-full shadow-inner border border-slate-100 flex items-center justify-center transition duration-300 hover:scale-105" style="background: <%= conicGradientStr %>;">
                        <div class="absolute h-28 w-28 rounded-full bg-white flex flex-col items-center justify-center shadow-md border border-slate-100/40">
                            <span class="text-[9px] text-slate-400 font-extrabold uppercase tracking-widest">Total Spent</span>
                            <span class="text-sm font-black text-slate-800 mt-0.5">NPR <fmt:formatNumber value="${budgetSummary.totalSpent}" type="number" maxFractionDigits="0"/></span>
                        </div>
                    </div>
                    <div class="mt-6 flex flex-wrap justify-center gap-x-4 gap-y-2 text-[11px] text-slate-600 max-w-sm">
                        <c:forEach var="seg" items="${budgetSummary.budgetDistribution}">
                            <span class="inline-flex items-center gap-1.5 font-bold">
                                <span class="h-2.5 w-2.5 rounded-full" style="background-color: ${seg.color}"></span>
                                ${seg.label} (<fmt:formatNumber value="${seg.percent}" maxFractionDigits="1"/>%)
                            </span>
                        </c:forEach>
                        <c:if test="${empty budgetSummary.budgetDistribution}">
                            <span class="text-slate-400 text-xs py-4">No data logged yet.</span>
                        </c:if>
                    </div>
                </div>
            </article>

            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_10px_24px_rgba(15,23,42,0.04)]" data-search="material cost breakdown <c:forEach var='item' items='${budgetSummary.materialBreakdown}'><c:out value='${item.materialName}'/> </c:forEach>">
                <h2 class="mb-4 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                    <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8z"></path></svg>
                    Material Cost Breakdown
                </h2>
                <div class="overflow-x-auto max-h-[300px] overflow-y-auto pr-1">
                    <table class="w-full border-collapse text-xs">
                        <thead>
                        <tr class="border-b border-slate-200 text-left text-[10px] font-bold uppercase tracking-wider text-slate-400 sticky top-0 bg-white z-10">
                            <th class="px-2 py-2 pb-3">Material</th>
                            <th class="px-2 py-2 pb-3">Quantity</th>
                            <th class="px-2 py-2 pb-3 text-right">Cost</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${budgetSummary.materialBreakdown}">
                            <tr class="border-b border-slate-100 hover:bg-slate-50/50 transition">
                                <td class="px-2 py-2.5 font-bold text-slate-800 text-sm">${item.materialName}</td>
                                <td class="px-2 py-2.5 font-bold text-slate-400">
                                    <fmt:formatNumber value="${item.quantityUsed}" type="number" maxFractionDigits="2"/> ${item.materialUnit}
                                </td>
                                <td class="px-2 py-2.5 font-black text-slate-800 text-right">
                                    NPR <fmt:formatNumber value="${item.totalCost}" type="number" groupingUsed="true" maxFractionDigits="0"/>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty budgetSummary.materialBreakdown}">
                            <tr>
                                <td colspan="3" class="text-xs text-slate-400 text-center py-10">No material usage logged yet.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </article>
        </section>
        <p id="emptySearchState" class="mt-4 hidden rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-600">No budget results matched your search.</p>
    </main>
</div>
<script>
    (function () {
        var searchInput = document.getElementById("budgetSearchInput");
        var items = Array.prototype.slice.call(document.querySelectorAll(".budget-search-item"));
        var emptyState = document.getElementById("emptySearchState");

        function filterBudget() {
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
            searchInput.addEventListener("input", filterBudget);
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
