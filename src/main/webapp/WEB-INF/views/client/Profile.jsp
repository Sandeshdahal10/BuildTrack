<%--
  Created by IntelliJ IDEA.
  User: Aspire3
  Date: 5/1/2026
  Time: 1:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%
     User user = (User) session.getAttribute("user");
     String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
             ? user.getFullName()
             : "Client";
     String displayEmail = (user != null && user.getEmail() != null && !user.getEmail().trim().isEmpty())
             ? user.getEmail()
             : "email@example.com";
     String displayPhone = (user != null && user.getPhone() != null && !user.getPhone().trim().isEmpty())
             ? user.getPhone()
             : "Not provided";
     String displayRole = (user != null && user.getRole() != null)
             ? "Client"
             : "Unknown";
     String displayCompany = "BuildTrack Construction";
     String memberSince = "January 2025";
     int activeProjects = 2;
    java.util.List<String> profileErrors = null;
    if (request.getAttribute("errors") instanceof java.util.List) {
        profileErrors = (java.util.List<String>) request.getAttribute("errors");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Client Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 bg-white text-slate-900">
<div class="h-screen flex font-semibold">
    <div class="fixed inset-y-0 left-0 w-56 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/clientsidebar.jsp" />
    </div>

    <main class="ml-56 flex-1 overflow-y-auto bg-white px-5 pb-7 pt-4">
        <div class="mb-3 flex items-center justify-between text-[11px] text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>
                <div id="topbar-date">Friday, May 1, 2026</div>
                <div id="topbar-time">01:55 PM</div>
            </div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                <input id="searchInput" class="min-w-[205px] rounded-md border border-slate-200 bg-white px-2.5 py-1.5 text-xs text-slate-900 outline-none max-[760px]:min-w-0 max-[760px]:flex-1" type="text" placeholder="Search..." aria-label="Search">
                <div class="relative">
                    <button id="notificationButton" class="relative grid h-7 w-7 place-items-center rounded-full border border-slate-200 bg-white p-0" type="button" aria-label="Notifications" aria-expanded="false" aria-controls="notificationMenu">
                        <svg viewBox="0 0 24 24" class="h-3.5 w-3.5 stroke-slate-900" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <path d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5"></path>
                            <path d="M9 17a3 3 0 0 0 6 0"></path>
                        </svg>
                        <span id="notificationBadge" class="absolute -right-0.5 -top-0.5 min-w-[14px] rounded-full border border-white bg-amber-500 px-0.5 text-center text-[9px] font-bold leading-3 text-slate-800">3</span>
                    </button>
                    <div id="notificationMenu" class="absolute right-0 top-9 z-20 hidden w-72 rounded-xl border border-slate-200 bg-white p-3 shadow-lg">
                        <div class="mb-2 flex items-center justify-between">
                            <p class="m-0 text-sm font-semibold text-slate-900">Notifications</p>
                            <button id="markAllReadButton" class="text-xs font-semibold text-amber-600" type="button">Mark all read</button>
                        </div>
                        <ul class="m-0 list-none space-y-2 p-0 text-xs text-slate-600">
                            <li class="rounded-lg bg-slate-50 px-2.5 py-2">Your profile has been updated successfully.</li>
                            <li class="rounded-lg bg-slate-50 px-2.5 py-2">New message from admin team.</li>
                            <li class="rounded-lg bg-slate-50 px-2.5 py-2">Payment invoice ready for download.</li>
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

        <!-- Profile Header -->
        <section class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)]">
            <h1 class="m-0 text-[34px] font-semibold leading-none">Profile</h1>
            <p class="mt-1 text-xs text-slate-600">Manage your personal information</p>
        </section>

        <% if (profileErrors != null && !profileErrors.isEmpty()) { %>
        <div class="mt-3 rounded-xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-700">
            <ul class="m-0 list-disc pl-5">
                <% for (String error : profileErrors) { %>
                <li><%= error %></li>
                <% } %>
            </ul>
        </div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
        <div class="mt-3 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700">
            <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <!-- Profile Card -->
        <section class="mt-3.5 rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)]">
            <div class="flex items-start justify-between gap-5">
                <div class="flex items-start gap-4">
                    <!-- Avatar -->
                    <div class="flex h-24 w-24 flex-shrink-0 items-center justify-center rounded-2xl bg-gradient-to-br from-amber-400 to-amber-500 text-3xl font-bold text-slate-700">
                        <%= displayName.substring(0, 1).toUpperCase() %>
                    </div>
                    <!-- User Info -->
                    <div>
                        <h2 class="m-0 text-xl font-semibold"><%= displayName %></h2>
                        <p class="mt-0.5 text-sm text-slate-600"><%= displayRole %> • <%= displayCompany %></p>
                        <p class="mt-1 text-xs text-slate-500">Member since <%= memberSince %></p>
                    </div>
                </div>
                <!-- Edit Button -->
                <button id="editProfileButton" type="button" class="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-900 transition hover:bg-slate-50 hover:border-slate-300">
                    <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" aria-hidden="true">
                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                    </svg>
                    <span>Edit</span>
                </button>
            </div>

            <!-- Profile Details Grid -->
            <form id="profileForm" method="POST" action="<%= request.getContextPath() %>/client/profile">
            <div class="mt-6 grid grid-cols-2 gap-8 border-t border-slate-200 pt-6 max-[760px]:grid-cols-1">
                <!-- Full Name -->
                <div>
                    <p class="m-0 text-xs uppercase tracking-wide text-slate-600">Full Name</p>
                    <div class="mt-2 flex items-center gap-2">
                        <svg viewBox="0 0 24 24" class="h-4 w-4 text-slate-400" fill="none" stroke-width="2" stroke="currentColor" aria-hidden="true">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        <input id="profileFullName" name="fullName" type="text" value="<%= displayName %>" data-original="<%= displayName %>" data-editable="true" disabled
                               class="w-full bg-transparent text-sm font-semibold text-slate-700 outline-none" />
                    </div>
                </div>

                <!-- Email -->
                <div>
                    <p class="m-0 text-xs uppercase tracking-wide text-slate-600">Email</p>
                    <div class="mt-2 flex items-center gap-2">
                        <svg viewBox="0 0 24 24" class="h-4 w-4 text-slate-400" fill="none" stroke-width="2" stroke="currentColor" aria-hidden="true">
                            <rect x="2" y="4" width="20" height="16" rx="2"></rect>
                            <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
                        </svg>
                        <input type="text" value="<%= displayEmail %>" disabled
                               class="w-full bg-transparent text-sm font-semibold text-slate-700 outline-none" />
                    </div>
                </div>

                <!-- Phone -->
                <div>
                    <p class="m-0 text-xs uppercase tracking-wide text-slate-600">Phone</p>
                    <div class="mt-2 flex items-center gap-2">
                        <svg viewBox="0 0 24 24" class="h-4 w-4 text-slate-400" fill="none" stroke-width="2" stroke="currentColor" aria-hidden="true">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                        </svg>
                        <input id="profilePhone" name="phone" type="text" value="<%= displayPhone %>" data-original="<%= displayPhone %>" data-editable="true" disabled
                               class="w-full bg-transparent text-sm font-semibold text-slate-700 outline-none" />
                    </div>
                </div>

                <!-- Projects -->
                <div>
                    <p class="m-0 text-xs uppercase tracking-wide text-slate-600">Projects</p>
                    <div class="mt-2 flex items-center gap-2">
                        <svg viewBox="0 0 24 24" class="h-4 w-4 text-slate-400" fill="none" stroke-width="2" stroke="currentColor" aria-hidden="true">
                            <path d="M3 7v6a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V7"></path>
                            <path d="M17 3H7a2 2 0 0 0-2 2v2h14V5a2 2 0 0 0-2-2z"></path>
                        </svg>
                        <span class="text-sm font-semibold"><%= activeProjects %> active projects</span>
                    </div>
                </div>
            </div>
            <div id="profileActions" class="mt-6 hidden flex flex-wrap items-center gap-3">
                <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-amber-500 px-4 py-2 text-sm font-semibold text-white hover:bg-amber-600">
                    Save Changes
                </button>
                <button id="cancelProfileEdit" type="button" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                    Cancel
                </button>
            </div>
            </form>
        </section>
    </main>
</div>

<script>
    (function () {
        // Update date and time
        var dateNode = document.getElementById("topbar-date");
        var timeNode = document.getElementById("topbar-time");

        if (dateNode && timeNode) {
            function renderClock() {
                var now = new Date();
                dateNode.textContent = now.toLocaleDateString("en-GB", {
                    weekday: "long",
                    month: "long",
                    day: "numeric",
                    year: "numeric"
                });
                timeNode.textContent = now.toLocaleTimeString("en-GB", {
                    hour: "2-digit",
                    minute: "2-digit",
                    hour12: true
                });
            }
            renderClock();
            setInterval(renderClock, 60000);
        }

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
                notificationBadge.classList.add("hidden");
                markAllReadButton.textContent = "All caught up";
                markAllReadButton.disabled = true;
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

        var editButton = document.getElementById("editProfileButton");
        var actions = document.getElementById("profileActions");
        var cancelButton = document.getElementById("cancelProfileEdit");
        var editableInputs = Array.prototype.slice.call(document.querySelectorAll("[data-editable='true']"));

        function setEditing(isEditing) {
            editableInputs.forEach(function (input) {
                input.disabled = !isEditing;
                input.classList.toggle("bg-slate-100", isEditing);
                input.classList.toggle("rounded-md", isEditing);
                input.classList.toggle("px-2", isEditing);
                input.classList.toggle("py-1.5", isEditing);
                input.classList.toggle("border", isEditing);
                input.classList.toggle("border-slate-200", isEditing);
            });
            if (actions) {
                actions.classList.toggle("hidden", !isEditing);
            }
            if (editButton) {
                editButton.classList.toggle("hidden", isEditing);
            }
        }

        if (editButton) {
            editButton.addEventListener("click", function () {
                setEditing(true);
            });
        }

        if (cancelButton) {
            cancelButton.addEventListener("click", function () {
                editableInputs.forEach(function (input) {
                    if (input.dataset.original) {
                        input.value = input.dataset.original;
                    }
                });
                setEditing(false);
            });
        }
    })();
</script>
</body>
</html>
