<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.buildtrack.model.User" %>
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

        <section class="mt-3.5 grid grid-cols-2 gap-3.5 max-[760px]:grid-cols-1">
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)]" data-search="total budget rs 82.0l">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Total Budget</p>
                <p class="mb-0 mt-1 text-4xl font-semibold leading-none text-slate-900">NPR 82.0L</p>
            </article>
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)]" data-search="total spent rs 48.4l">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Total Spent</p>
                <p class="mb-0 mt-1 text-4xl font-semibold leading-none">NPR 48.4L</p>
            </article>
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)]" data-search="remaining rs 33.6l">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Remaining</p>
                <p class="mb-0 mt-1 text-4xl font-semibold leading-none text-slate-900">NPR 33.6L</p>
            </article>
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)]" data-search="utilization 59 percent">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Utilization</p>
                <p class="mb-0 mt-1 text-4xl font-semibold leading-none">59%</p>
            </article>
        </section>

        <section class="budget-search-item mt-4 rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)]" data-search="budget vs expenditure skyline tower complex green valley residency 68 45 utilized">
            <h2 class="mb-4 mt-0 text-lg font-semibold">Budget vs Expenditure</h2>

            <div>
                <div class="mb-1 flex items-center justify-between text-sm">
                    <span class="font-semibold">Skyline Tower Complex</span>
                    <span class="text-slate-500">NPR 34.0L / NPR 50.0L</span>
                </div>
                <div class="h-3 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[68%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-500"></div></div>
                <p class="mt-1 text-xs text-slate-500">68% utilized</p>
            </div>

            <div class="mt-4">
                <div class="mb-1 flex items-center justify-between text-sm">
                    <span class="font-semibold">Green Valley Residency</span>
                    <span class="text-slate-500">NPR 14.4L / NPR 32.0L</span>
                </div>
                <div class="h-3 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[45%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-500"></div></div>
                <p class="mt-1 text-xs text-slate-500">45% utilized</p>
            </div>
        </section>

        <section class="mt-4 grid grid-cols-2 gap-4 max-[1200px]:grid-cols-1">
            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)]" data-search="cost distribution labour material equipment miscellaneous">
                <h2 class="mb-4 mt-0 text-lg font-semibold">Cost Distribution</h2>
                <div class="flex min-h-[300px] flex-col items-center justify-center">
                    <div class="relative h-44 w-44 rounded-full" style="background: conic-gradient(#f59e0b 0deg 162deg, #14b8a6 162deg 284deg, #3b82f6 284deg 338deg, #8b5cf6 338deg 360deg);">
                        <div class="absolute left-1/2 top-1/2 h-24 w-24 -translate-x-1/2 -translate-y-1/2 rounded-full bg-white"></div>
                    </div>
                    <div class="mt-5 flex flex-wrap justify-center gap-3 text-xs text-slate-600">
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-amber-500"></span>Labour</span>
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-teal-500"></span>Material</span>
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-blue-500"></span>Equipment</span>
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-violet-500"></span>Miscellaneous</span>
                    </div>
                </div>
            </article>

            <article class="budget-search-item rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)]" data-search="material cost breakdown cement iron rods sand bricks steel pipes paint electrical wire">
                <h2 class="mb-4 mt-0 text-lg font-semibold">Material Cost Breakdown</h2>
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse text-sm">
                        <thead>
                        <tr class="border-b border-slate-200 text-left text-xs uppercase tracking-wide text-slate-500">
                            <th class="px-2 py-2">Material</th>
                            <th class="px-2 py-2">Quantity</th>
                            <th class="px-2 py-2">Cost</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="border-b border-slate-100"><td class="px-2 py-2">Cement</td><td class="px-2 py-2">1,200 bags</td><td class="px-2 py-2 font-semibold">NPR 4,56,000</td></tr>
                        <tr class="border-b border-slate-100"><td class="px-2 py-2">Iron Rods</td><td class="px-2 py-2">5,000 kg</td><td class="px-2 py-2 font-semibold">NPR 2,75,000</td></tr>
                        <tr class="border-b border-slate-100"><td class="px-2 py-2">Sand</td><td class="px-2 py-2">30 cu.m</td><td class="px-2 py-2 font-semibold">NPR 36,000</td></tr>
                        <tr class="border-b border-slate-100"><td class="px-2 py-2">Bricks</td><td class="px-2 py-2">25,000 pcs</td><td class="px-2 py-2 font-semibold">NPR 2,00,000</td></tr>
                        <tr class="border-b border-slate-100"><td class="px-2 py-2">Steel Pipes</td><td class="px-2 py-2">80 pcs</td><td class="px-2 py-2 font-semibold">NPR 6,800</td></tr>
                        <tr class="border-b border-slate-100"><td class="px-2 py-2">Paint</td><td class="px-2 py-2">25 cans</td><td class="px-2 py-2 font-semibold">NPR 70,000</td></tr>
                        <tr><td class="px-2 py-2">Electrical Wire</td><td class="px-2 py-2">2,000 m</td><td class="px-2 py-2 font-semibold">NPR 30,000</td></tr>
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
