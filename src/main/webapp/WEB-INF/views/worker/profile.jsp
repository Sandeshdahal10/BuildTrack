<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Worker";
    String basePath = request.getContextPath();

    String email = (user != null && user.getEmail() != null) ? user.getEmail() : "-";
    String phone = (user != null && user.getPhone() != null) ? user.getPhone() : "-";
    String role = (user != null) ? user.getRoleDisplayName() : "Worker";
    String status = (user != null && user.getStatus() != null) ? user.getStatus() : "UNKNOWN";
    String dailyWage = (user != null && user.getDailyWage() != null) ? "Rs. " + user.getDailyWage().toPlainString() : "-";
    String joinedDate = (user != null && user.getCreatedAt() != null)
            ? new SimpleDateFormat("MMMM dd, yyyy").format(user.getCreatedAt())
            : "-";

    // Initials for avatar
    String initials = "W";
    if (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty()) {
        String[] parts = user.getFullName().trim().split("\\s+");
        if (parts.length >= 2) {
            initials = ("" + parts[0].charAt(0) + parts[parts.length - 1].charAt(0)).toUpperCase();
        } else {
            initials = ("" + parts[0].charAt(0)).toUpperCase();
        }
    }
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
<body class="bg-slate-50 text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">

<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">
    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Area -->
    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden bg-slate-50/50">
        <!-- TOP NAVBAR -->
        <div class="px-8 pt-6 pb-2 shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <!-- CONTENT -->
        <div class="px-8 py-6 overflow-y-auto grow">
            <div class="max-w-4xl mx-auto">

                <!-- Header -->
                <div class="mb-6">
                    <h1 class="text-2xl font-bold text-slate-800 tracking-tight">Profile</h1>
                    <p class="text-sm text-slate-500 mt-1 font-medium">Your personal information</p>
                </div>

                <!-- Profile Card -->
                <div class="bg-white rounded-2xl border border-slate-200 shadow-sm overflow-hidden mb-6">

                    <!-- Banner + Avatar -->
                    <div class="relative">
                        <div class="h-32 bg-gradient-to-r from-slate-800 via-slate-700 to-slate-600"></div>
                        <div class="absolute -bottom-12 left-8">
                            <div class="w-24 h-24 rounded-2xl bg-gradient-to-br from-amber-400 to-amber-600 flex items-center justify-center text-white text-3xl font-bold shadow-lg border-4 border-white">
                                <%= initials %>
                            </div>
                        </div>
                    </div>

                    <!-- Name & Role -->
                    <div class="pt-16 pb-6 px-8">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <div>
                                <h2 class="text-xl font-bold text-slate-900"><%= displayName %></h2>
                                <p class="text-sm font-medium text-slate-500 mt-0.5"><%= role %></p>
                            </div>
                            <div>
                                <%
                                    String statusBg = "bg-slate-100 text-slate-600 border-slate-200";
                                    if ("APPROVED".equals(status)) {
                                        statusBg = "bg-emerald-50 text-emerald-700 border-emerald-200";
                                    } else if ("PENDING".equals(status)) {
                                        statusBg = "bg-amber-50 text-amber-700 border-amber-200";
                                    } else if ("DEACTIVATED".equals(status)) {
                                        statusBg = "bg-rose-50 text-rose-700 border-rose-200";
                                    }
                                %>
                                <span class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg border text-xs font-bold <%= statusBg %>">
                                    <span class="w-1.5 h-1.5 rounded-full
                                        <% if ("APPROVED".equals(status)) { %>bg-emerald-500<% }
                                           else if ("PENDING".equals(status)) { %>bg-amber-500<% }
                                           else if ("DEACTIVATED".equals(status)) { %>bg-rose-500<% }
                                           else { %>bg-slate-400<% } %>
                                    "></span>
                                    <%= status.substring(0, 1).toUpperCase() + status.substring(1).toLowerCase() %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Details Grid -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-5 mb-6">

                    <!-- Contact Information -->
                    <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                        <div class="flex items-center gap-2.5 mb-5">
                            <div class="w-9 h-9 rounded-lg bg-blue-50 flex items-center justify-center">
                                <i data-lucide="contact" class="w-4.5 h-4.5 text-blue-600"></i>
                            </div>
                            <h3 class="text-sm font-bold text-slate-800 uppercase tracking-wider">Contact Information</h3>
                        </div>
                        <div class="space-y-4">
                            <div class="flex items-center gap-3">
                                <i data-lucide="mail" class="w-4 h-4 text-slate-400 shrink-0"></i>
                                <div>
                                    <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">Email</p>
                                    <p class="text-sm font-semibold text-slate-700 mt-0.5"><%= email %></p>
                                </div>
                            </div>
                            <div class="flex items-center gap-3">
                                <i data-lucide="phone" class="w-4 h-4 text-slate-400 shrink-0"></i>
                                <div>
                                    <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">Phone</p>
                                    <p class="text-sm font-semibold text-slate-700 mt-0.5"><%= phone %></p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Employment Details -->
                    <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                        <div class="flex items-center gap-2.5 mb-5">
                            <div class="w-9 h-9 rounded-lg bg-amber-50 flex items-center justify-center">
                                <i data-lucide="briefcase" class="w-4.5 h-4.5 text-amber-600"></i>
                            </div>
                            <h3 class="text-sm font-bold text-slate-800 uppercase tracking-wider">Employment Details</h3>
                        </div>
                        <div class="space-y-4">
                            <div class="flex items-center gap-3">
                                <i data-lucide="wallet" class="w-4 h-4 text-slate-400 shrink-0"></i>
                                <div>
                                    <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">Daily Wage</p>
                                    <p class="text-sm font-semibold text-slate-700 mt-0.5"><%= dailyWage %></p>
                                </div>
                            </div>
                            <div class="flex items-center gap-3">
                                <i data-lucide="calendar" class="w-4 h-4 text-slate-400 shrink-0"></i>
                                <div>
                                    <p class="text-xs font-medium text-slate-400 uppercase tracking-wider">Joined</p>
                                    <p class="text-sm font-semibold text-slate-700 mt-0.5"><%= joinedDate %></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Feedback Messages -->
                <% String error = (String) request.getAttribute("error"); %>
                <% String success = (String) request.getAttribute("success"); %>
                <% if (error != null) { %>
                <div class="mb-6 flex items-center gap-3 px-4 py-3 rounded-xl bg-rose-50 border border-rose-200 text-rose-700 text-sm font-medium">
                    <i data-lucide="alert-circle" class="w-4 h-4 shrink-0"></i>
                    <%= error %>
                </div>
                <% } %>
                <% if (success != null) { %>
                <div class="mb-6 flex items-center gap-3 px-4 py-3 rounded-xl bg-emerald-50 border border-emerald-200 text-emerald-700 text-sm font-medium">
                    <i data-lucide="check-circle-2" class="w-4 h-4 shrink-0"></i>
                    <%= success %>
                </div>
                <% } %>

                <!-- Change Password Section -->
                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6 mb-6">
                    <div class="flex items-center gap-2.5 mb-5">
                        <div class="w-9 h-9 rounded-lg bg-slate-100 flex items-center justify-center">
                            <i data-lucide="lock" class="w-4.5 h-4.5 text-slate-600"></i>
                        </div>
                        <h3 class="text-sm font-bold text-slate-800 uppercase tracking-wider">Change Password</h3>
                    </div>

                    <form action="<%= basePath %>/worker/profile" method="POST" class="space-y-4 max-w-md">
                        <div>
                            <label for="currentPassword" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Current Password</label>
                            <div class="relative">
                                <i data-lucide="key-round" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                                <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password"
                                       class="w-full pl-10 pr-4 py-2.5 rounded-lg border border-slate-200 bg-slate-50/50 text-sm font-medium text-slate-700 outline-none transition-colors focus:border-amber-400 focus:ring-1 focus:ring-amber-400 focus:bg-white" />
                            </div>
                        </div>
                        <div>
                            <label for="newPassword" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">New Password</label>
                            <div class="relative">
                                <i data-lucide="lock" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password"
                                       class="w-full pl-10 pr-4 py-2.5 rounded-lg border border-slate-200 bg-slate-50/50 text-sm font-medium text-slate-700 outline-none transition-colors focus:border-amber-400 focus:ring-1 focus:ring-amber-400 focus:bg-white" />
                            </div>
                        </div>
                        <div>
                            <label for="confirmPassword" class="block text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1.5">Confirm Password</label>
                            <div class="relative">
                                <i data-lucide="lock" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400"></i>
                                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password"
                                       class="w-full pl-10 pr-4 py-2.5 rounded-lg border border-slate-200 bg-slate-50/50 text-sm font-medium text-slate-700 outline-none transition-colors focus:border-amber-400 focus:ring-1 focus:ring-amber-400 focus:bg-white" />
                            </div>
                        </div>
                        <button type="submit" class="flex items-center gap-2 bg-amber-500 hover:bg-amber-600 text-white px-5 py-2.5 rounded-lg text-sm font-semibold shadow-sm transition-all hover:shadow mt-2">
                            <i data-lucide="save" class="w-4 h-4"></i>
                            Update Password
                        </button>
                    </form>
                </div>

                <!-- Logout -->
                <div class="bg-white rounded-xl border border-slate-200 shadow-sm p-6">
                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                        <div>
                            <h3 class="text-sm font-bold text-slate-800">Sign Out</h3>
                            <p class="text-xs text-slate-500 mt-0.5">Log out of your BuildTrack account</p>
                        </div>
                        <a href="<%= basePath %>/logout" class="inline-flex items-center gap-2 px-4 py-2.5 rounded-lg border border-rose-200 bg-rose-50 text-rose-700 text-sm font-semibold hover:bg-rose-100 transition-colors">
                            <i data-lucide="log-out" class="w-4 h-4"></i>
                            Logout
                        </a>
                    </div>
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
