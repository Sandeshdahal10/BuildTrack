<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="com.buildtrack.model.Inquiry" %>
<%@ page import="com.buildtrack.model.Project" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>BuildTrack | Client Inquiries</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="m-0 min-h-screen bg-slate-50 text-slate-900">
<div class="h-screen flex font-semibold">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <main class="ml-0 md:ml-56 overflow-hidden flex-1 overflow-y-auto bg-slate-50 px-5 pb-7 pt-4 flex flex-col">
        <!-- Top bar Header -->
        <div class="mb-3 flex items-center justify-between text-[11px] text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>
                <p class="m-0">Friday, April 17, 2026</p>
                <p class="m-0 text-[11px]">07:13 PM</p>
            </div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
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

        <!-- Page Header -->
        <section class="mb-5 rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.06)]">
            <h1 class="m-0 text-3xl font-bold leading-tight text-slate-800">Support Inquiries</h1>
            <p class="mt-1 text-xs text-slate-500">Ask questions, request modifications, or submit feedback regarding your ongoing construction projects.</p>
        </section>

        <!-- Feedback Messages -->
        <c:if test="${not empty successMessage}">
            <div class="mb-4 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700 flex items-center gap-2">
                <i data-lucide="check-circle" class="w-5 h-5 shrink-0 text-emerald-600"></i>
                <span>${successMessage}</span>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="mb-4 rounded-xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-700 flex items-center gap-2">
                <i data-lucide="alert-circle" class="w-5 h-5 shrink-0 text-rose-600"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Two Column Content Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start flex-1 min-h-0">
            <!-- Left: Past inquiries list (7 cols) -->
            <div class="lg:col-span-7 flex flex-col gap-4 max-h-[calc(100vh-250px)] overflow-y-auto pr-1">
                <h2 class="text-lg font-bold text-slate-700 flex items-center gap-2 mb-1">
                    <i data-lucide="history" class="w-4 h-4 text-slate-500"></i> My Inquiry History
                </h2>

                <c:if test="${empty inquiries}">
                    <div class="rounded-2xl border border-dashed border-slate-200 bg-white p-8 text-center">
                        <div class="mx-auto w-12 h-12 rounded-full bg-slate-100 flex items-center justify-center mb-3">
                            <i data-lucide="message-square" class="w-6 h-6 text-slate-400"></i>
                        </div>
                        <h3 class="text-sm font-semibold text-slate-700">No Inquiries Found</h3>
                        <p class="text-xs text-slate-500 mt-1 max-w-sm mx-auto">Submit a new inquiry using the form on the right to get support from our admins.</p>
                    </div>
                </c:if>

                <c:forEach var="inq" items="${inquiries}">
                    <div class="rounded-xl border border-slate-200 bg-white p-4 shadow-[0_2px_8px_rgba(15,23,42,0.02)] hover:shadow-md transition">
                        <div class="flex items-center justify-between gap-3 mb-2 flex-wrap">
                            <div>
                                <span class="text-[11px] font-bold text-orange-600 uppercase bg-orange-50 px-2 py-0.5 rounded-full">${inq.projectTitle}</span>
                                <h3 class="text-base font-bold text-slate-800 mt-1">${inq.subject}</h3>
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${inq.status == 'RESOLVED' || inq.status == 'COMPLETED'}">
                                        <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-emerald-50 px-2.5 py-1 text-emerald-700 border border-emerald-200">
                                            <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Completed
                                        </span>
                                    </c:when>
                                    <c:when test="${inq.status == 'IN_PROGRESS'}">
                                        <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-blue-50 px-2.5 py-1 text-blue-700 border border-blue-200">
                                            <span class="w-1.5 h-1.5 rounded-full bg-blue-500 animate-pulse"></span> In Progress
                                        </span>
                                    </c:when>
                                    <c:when test="${inq.status == 'PENDING'}">
                                        <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-amber-50 px-2.5 py-1 text-amber-700 border border-amber-200">
                                            <span class="w-1.5 h-1.5 rounded-full bg-amber-500 animate-pulse"></span> Pending
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-slate-50 px-2.5 py-1 text-slate-600 border border-slate-200">
                                            ${inq.status}
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <p class="text-xs text-slate-600 bg-slate-50/50 rounded-lg p-3 border border-slate-100 font-medium whitespace-pre-line leading-relaxed">${inq.message}</p>
                        
                        <div class="mt-2.5 flex items-center justify-between text-[10px] text-slate-400">
                            <span class="flex items-center gap-1"><i data-lucide="clock" class="w-3 h-3"></i> Submitted on ${inq.createdAt}</span>
                        </div>

                        <!-- Admin Reply Card -->
                        <c:if test="${not empty inq.adminReply}">
                            <div class="mt-3.5 rounded-xl border border-blue-100 bg-blue-50/60 p-3 shadow-inner">
                                <div class="flex items-center gap-1.5 text-xs font-bold text-blue-800 mb-1">
                                    <i data-lucide="shield-check" class="w-4 h-4 text-blue-600"></i>
                                    <span>Administrator Response</span>
                                </div>
                                <p class="text-xs text-slate-700 leading-relaxed pl-1 whitespace-pre-line font-medium">${inq.adminReply}</p>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>

            <!-- Right: Submit Inquiry Form (5 cols) -->
            <div class="lg:col-span-5 bg-white rounded-2xl border border-slate-200 p-5 shadow-[0_12px_32px_rgba(15,23,42,0.04)]">
                <h2 class="text-lg font-bold text-slate-800 flex items-center gap-2 mb-4">
                    <i data-lucide="help-circle" class="w-5 h-5 text-orange-500"></i> Submit New Inquiry
                </h2>

                <form method="POST" action="<%= request.getContextPath() %>/client/inquiries" class="space-y-4">
                    <div>
                        <label for="projectId" class="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Select Project <span class="text-rose-500">*</span></label>
                        <select id="projectId" name="projectId" required class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-700 outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition">
                            <option value="">-- Choose a project --</option>
                            <c:forEach var="p" items="${projects}">
                                <option value="${p.id}">${p.title}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <label for="subject" class="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Subject / Topic <span class="text-rose-500">*</span></label>
                        <input type="text" id="subject" name="subject" required placeholder="e.g. Budget variance, timeline delay request"
                               class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-800 outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition" />
                    </div>

                    <div>
                        <label for="message" class="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Detailed Message <span class="text-rose-500">*</span></label>
                        <textarea id="message" name="message" required rows="6" placeholder="Describe your question, request, or issue in detail..."
                                  class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-800 outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition"></textarea>
                    </div>

                    <button type="submit" class="w-full inline-flex items-center justify-center gap-2 rounded-lg bg-orange-500 hover:bg-orange-600 px-4 py-2.5 font-bold text-xs text-white shadow-md hover:shadow-lg transition">
                        <i data-lucide="send" class="w-4 h-4"></i> Submit Inquiry
                    </button>
                </form>
            </div>
        </div>
    </main>
</div>

<script>
    (function () {
        lucide.createIcons();

        // Notification menu toggle
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

        // User menu toggle
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
        }
    })();
</script>
</body>
</html>
