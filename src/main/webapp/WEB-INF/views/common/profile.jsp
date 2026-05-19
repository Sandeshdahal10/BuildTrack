<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    String basePath = request.getContextPath();
    if (user == null) {
        response.sendRedirect(basePath + "/login");
        return;
    }

    String fullName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "User";
    String email = (user != null && user.getEmail() != null && !user.getEmail().trim().isEmpty())
            ? user.getEmail()
            : "-";
    String phone = (user != null && user.getPhone() != null && !user.getPhone().trim().isEmpty())
            ? user.getPhone()
            : "-";

    String roleName = (user != null && user.getRole() != null) ? user.getRole().name() : "USER";
    String roleLabel = (user != null && user.getRole() != null) ? user.getRole().toString() : "User";
    String status = (user != null && user.getStatus() != null) ? user.getStatus() : "UNKNOWN";
    if (status == null || status.trim().isEmpty()) {
        status = "UNKNOWN";
    }
    String statusLabel = status.substring(0, 1).toUpperCase() + status.substring(1).toLowerCase();

    String joinedDate = "-";
    if (user != null && user.getCreatedAt() != null) {
        joinedDate = new SimpleDateFormat("MMMM dd, yyyy").format(user.getCreatedAt());
    }

    String dailyWage = (user != null && user.getDailyWage() != null)
            ? "NPR " + user.getDailyWage().toPlainString()
            : "-";

    Object activeProjectsObj = request.getAttribute("activeProjects");
    String activeProjects = activeProjectsObj != null ? String.valueOf(activeProjectsObj) : "-";

    List<String> profileErrors = (List<String>) request.getAttribute("profileErrors");
    if (profileErrors == null) {
        Object fallbackErrors = request.getAttribute("errors");
        if (fallbackErrors instanceof List) {
            profileErrors = (List<String>) fallbackErrors;
        }
    }
    String successMessage = request.getAttribute("success") != null ? String.valueOf(request.getAttribute("success")) : null;
    String errorMessage = request.getAttribute("error") != null ? String.valueOf(request.getAttribute("error")) : null;
    if (errorMessage == null && request.getAttribute("errors") instanceof String) {
        errorMessage = String.valueOf(request.getAttribute("errors"));
    }

    boolean isClient = "CLIENT".equalsIgnoreCase(roleName);
    boolean isWorker = "WORKER".equalsIgnoreCase(roleName);

    String initials = "U";
    if (fullName != null && !fullName.trim().isEmpty()) {
        String[] parts = fullName.trim().split("\\s+");
        if (parts.length >= 2) {
            initials = ("" + parts[0].charAt(0) + parts[parts.length - 1].charAt(0)).toUpperCase();
        } else {
            initials = ("" + parts[0].charAt(0)).toUpperCase();
        }
    }

    String profileAction = basePath + "/" + roleName.toLowerCase() + "/profile";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 antialiased">
<div class="h-screen overflow-hidden">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-hidden">
        <div class="sticky top-0 z-20 shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 overflow-y-auto px-6 py-6">
            <section class="mb-6">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Profile</h1>
                        <p class="mt-1 text-slate-500">Account details and preferences.</p>
                    </div>
                </div>
            </section>

            <% if (profileErrors != null && !profileErrors.isEmpty()) { %>
                <div class="mb-4 rounded-xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-700">
                    <ul class="m-0 list-disc pl-5">
                        <% for (String err : profileErrors) { %>
                            <li><%= err %></li>
                        <% } %>
                    </ul>
                </div>
            <% } %>
            <% if (errorMessage != null) { %>
                <div class="mb-4 rounded-xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-700">
                    <%= errorMessage %>
                </div>
            <% } %>
            <% if (successMessage != null) { %>
                <div class="mb-4 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700">
                    <%= successMessage %>
                </div>
            <% } %>

            <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div class="flex items-center gap-4">
                        <div class="flex h-14 w-14 items-center justify-center rounded-2xl bg-amber-300 text-lg font-bold text-slate-900">
                            <%= initials %>
                        </div>
                        <div>
                            <p class="text-lg font-semibold text-slate-900"><%= fullName %></p>
                            <p class="text-sm text-slate-500"><%= roleLabel %></p>
                        </div>
                    </div>
                    <div>
                        <span class="inline-flex items-center gap-1.5 rounded-lg border px-3 py-1.5 text-xs font-bold
                            <%= "APPROVED".equals(status) ? "bg-emerald-50 text-emerald-700 border-emerald-200" :
                                "PENDING".equals(status) ? "bg-amber-50 text-amber-700 border-amber-200" :
                                "DEACTIVATED".equals(status) ? "bg-rose-50 text-rose-700 border-rose-200" :
                                "bg-slate-100 text-slate-600 border-slate-200" %>">
                            <span class="h-1.5 w-1.5 rounded-full
                                <%= "APPROVED".equals(status) ? "bg-emerald-500" :
                                    "PENDING".equals(status) ? "bg-amber-500" :
                                    "DEACTIVATED".equals(status) ? "bg-rose-500" :
                                    "bg-slate-400" %>"></span>
                            <%= statusLabel %>
                        </span>
                    </div>
                </div>

                <div class="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
                    <div class="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3">
                        <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Email</p>
                        <p class="mt-1 text-sm font-semibold text-slate-800"><%= email %></p>
                    </div>
                    <div class="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3">
                        <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Phone</p>
                        <p class="mt-1 text-sm font-semibold text-slate-800"><%= phone %></p>
                    </div>
                    <div class="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3">
                        <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Joined</p>
                        <p class="mt-1 text-sm font-semibold text-slate-800"><%= joinedDate %></p>
                    </div>
                    <% if (isWorker) { %>
                        <div class="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3">
                            <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Daily Wage</p>
                            <p class="mt-1 text-sm font-semibold text-slate-800"><%= dailyWage %></p>
                        </div>
                    <% } %>
                    <% if (isClient && activeProjectsObj != null) { %>
                        <div class="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3">
                            <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Projects</p>
                            <p class="mt-1 text-sm font-semibold text-slate-800"><%= activeProjects %> active</p>
                        </div>
                    <% } %>
                </div>
            </section>

            <% if (isClient) { %>
                <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <div class="flex items-center justify-between gap-4">
                        <h2 class="text-base font-bold text-slate-800">Edit Profile</h2>
                        <button id="editProfileButton" type="button" class="inline-flex items-center gap-1.5 rounded-lg border border-slate-200 bg-white px-4 py-2 text-sm font-semibold text-slate-900 transition hover:bg-slate-50 hover:border-slate-300">
                            <i data-lucide="pencil" class="h-4 w-4"></i>
                            <span>Edit</span>
                        </button>
                    </div>
                    <form id="profileForm" method="POST" action="<%= profileAction %>" class="mt-4 space-y-4 max-w-md">
                        <div>
                            <label for="profileFullName" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Full Name</label>
                            <input id="profileFullName" name="fullName" type="text" value="<%= fullName %>" data-original="<%= fullName %>" data-editable="true" disabled
                                   class="w-full rounded-lg border border-slate-200 bg-slate-50/50 px-3 py-2 text-sm font-medium text-slate-700 outline-none" />
                        </div>
                        <div>
                            <label for="profilePhone" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Phone</label>
                            <input id="profilePhone" name="phone" type="text" value="<%= phone %>" data-original="<%= phone %>" data-editable="true" disabled
                                   class="w-full rounded-lg border border-slate-200 bg-slate-50/50 px-3 py-2 text-sm font-medium text-slate-700 outline-none" />
                        </div>
                        <div id="profileActions" class="hidden flex flex-wrap items-center gap-3">
                            <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-amber-500 px-4 py-2 text-sm font-semibold text-white hover:bg-amber-600">
                                Save Changes
                            </button>
                            <button id="cancelProfileEdit" type="button" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                                Cancel
                            </button>
                        </div>
                    </form>
                </section>
            <% } %>

            <% if (isWorker || isClient) { %>
                <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h2 class="text-base font-bold text-slate-800">Change Password</h2>
                    <form action="<%= profileAction %>" method="POST" class="mt-4 space-y-4 max-w-md">
                        <div>
                            <label for="currentPassword" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password"
                                   class="w-full rounded-lg border border-slate-200 bg-slate-50/50 px-3 py-2 text-sm font-medium text-slate-700 outline-none" />
                        </div>
                        <div>
                            <label for="newPassword" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password"
                                   class="w-full rounded-lg border border-slate-200 bg-slate-50/50 px-3 py-2 text-sm font-medium text-slate-700 outline-none" />
                        </div>
                        <div>
                            <label for="confirmPassword" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password"
                                   class="w-full rounded-lg border border-slate-200 bg-slate-50/50 px-3 py-2 text-sm font-medium text-slate-700 outline-none" />
                        </div>
                        <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-amber-500 px-4 py-2 text-sm font-semibold text-white hover:bg-amber-600">
                            Update Password
                        </button>
                    </form>
                </section>
            <% } %>

            <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                    <div>
                        <h3 class="text-sm font-bold text-slate-800">Sign Out</h3>
                        <p class="text-xs text-slate-500 mt-0.5">Log out of your BuildTrack account</p>
                    </div>
                    <a href="<%= basePath %>/logout" class="inline-flex items-center gap-2 px-4 py-2.5 rounded-lg border border-rose-200 bg-rose-50 text-rose-700 text-sm font-semibold hover:bg-rose-100">
                        <i data-lucide="log-out" class="w-4 h-4"></i>
                        Log Out
                    </a>
                </div>
            </section>
        </main>
    </div>
</div>

<script>
    (function () {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        var editButton = document.getElementById("editProfileButton");
        var actions = document.getElementById("profileActions");
        var cancelButton = document.getElementById("cancelProfileEdit");
        var editableInputs = Array.prototype.slice.call(document.querySelectorAll("[data-editable='true']"));

        function setEditing(isEditing) {
            editableInputs.forEach(function (input) {
                input.disabled = !isEditing;
                input.classList.toggle("bg-white", isEditing);
                input.classList.toggle("border", isEditing);
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

