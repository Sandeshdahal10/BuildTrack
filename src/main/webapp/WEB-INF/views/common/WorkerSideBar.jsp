
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Worker Sidebar</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<%
    String uri = request.getRequestURI().substring(request.getContextPath().length());
    String basePath = request.getContextPath();
%>

<aside class="w-56 h-screen overflow-y-auto bg-[#0b1f4d] text-white flex flex-col border-r border-blue-900/60">

    <!-- Header -->
    <div class="p-4 flex items-center gap-3 border-b border-blue-900/60">
        <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-amber-500 to-amber-600 flex items-center justify-center">
            <i data-lucide="building-2" class="w-4 h-4 text-slate-950"></i>
        </div>
        <span class="font-bold text-lg">BuildTrack</span>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 p-3 space-y-1">

        <%-- Reusable class pattern --%>
        <%
            String activeNavClass = "flex items-center gap-3 px-3 py-2 rounded-lg bg-orange-500 hover:bg-red-500/10 text-white font-medium";
            String inactiveNavClass = "flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white";
        %>

        <a href="<%= basePath %>/worker/dashboard" class="<%= uri.startsWith("/worker/dashboard") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="home" class="w-4 h-4"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= basePath %>/worker/attendance" class="<%= uri.startsWith("/worker/attendance") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="check-square" class="w-4 h-4"></i>
            <span>Attendance</span>
        </a>

        <a href="<%= basePath %>/worker/worklog" class="<%= uri.startsWith("/worker/worklog") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="clipboard-list" class="w-4 h-4"></i>
            <span>Work Log</span>
        </a>

        <a href="<%= basePath %>/worker/payslip" class="<%= uri.startsWith("/worker/payslip") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="wallet" class="w-4 h-4"></i>
            <span>Payslips</span>
        </a>

        <a href="<%= basePath %>/worker/profile" class="<%= uri.startsWith("/worker/profile") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="user" class="w-4 h-4"></i>
            <span>Profile</span>
        </a>

    </nav>

    <!-- Bottom Section -->
    <div class="p-3 border-t border-blue-900/60">
        <a href="<%= basePath %>/worker/upgrade" class="flex items-center gap-3 px-3 py-2 rounded-lg text-amber-400 hover:bg-amber-500/10 hover:text-amber-300">
            <i data-lucide="zap" class="w-4 h-4"></i>
            <span>Upgrade Plan</span>
        </a>
        <a href="<%= basePath %>/logout" class="flex items-center gap-3 px-3 py-2 rounded-lg text-rose-400 hover:bg-rose-500/10 hover:text-rose-300">
            <i data-lucide="log-out" class="w-4 h-4"></i>
            <span>Logout</span>
        </a>
    </div>


</aside>

<script>
    lucide.createIcons();
</script>

</body>
</html>