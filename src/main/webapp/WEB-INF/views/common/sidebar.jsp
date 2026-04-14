<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Title</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<%
    // Get URI without context path
    String uri = request.getRequestURI().substring(request.getContextPath().length());
    String basePath = request.getContextPath();

    String activeNavClass = "flex items-center gap-3 px-3 py-2 rounded-lg bg-orange-500 hover:bg-red-500/10 text-white font-medium";
    String inactiveNavClass = "flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white";
%>

<aside class="w-56 h-screen overflow-y-auto bg-[#0b1f4d] text-white flex flex-col border-r border-blue-900/60">

    <div class="p-4 flex items-center gap-3 border-b border-blue-900/60">
        <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-amber-500 to-amber-600 flex items-center justify-center">
            <i data-lucide="building-2" class="w-4 h-4 text-slate-950"></i>
        </div>
        <span class="font-bold text-lg">BuildTrack</span>
    </div>

    <nav class="flex-1 p-3 space-y-1">

        <a href="<%= basePath %>/admin/dashboard" class="<%= uri.startsWith("/admin/dashboard") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="home" class="w-4 h-4"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= basePath %>/admin/projects" class="<%= uri.startsWith("/admin/projects") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="folder" class="w-4 h-4"></i>
            <span>Projects</span>
        </a>

        <a href="<%= basePath %>/admin/users" class="<%= uri.startsWith("/admin/users") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="user" class="w-4 h-4"></i>
            <span>Workers</span>
        </a>

        <a href="<%= basePath %>/admin/clients" class="<%= uri.startsWith("/admin/clients") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="users" class="w-4 h-4"></i>
            <span>Clients</span>
        </a>

        <a href="<%= basePath %>/admin/materials" class="<%= uri.startsWith("/admin/materials") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="package" class="w-4 h-4"></i>
            <span>Materials</span>
        </a>

        <a href="<%= basePath %>/admin/attendance" class="<%= uri.startsWith("/admin/attendance") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="check-square" class="w-4 h-4"></i>
            <span>Attendance</span>
        </a>

        <a href="<%= basePath %>/admin/payroll" class="<%= uri.startsWith("/admin/payroll") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="wallet" class="w-4 h-4"></i>
            <span>Payroll</span>
        </a>

        <a href="<%= basePath %>/admin/expenses" class="<%= uri.startsWith("/admin/expenses") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="receipt" class="w-4 h-4"></i>
            <span>Expenses</span>
        </a>

        <a href="<%= basePath %>/admin/reports" class="<%= uri.startsWith("/admin/reports") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="bar-chart-3" class="w-4 h-4"></i>
            <span>Reports</span>
        </a>

        <a href="<%= basePath %>/admin/settings" class="<%= uri.startsWith("/admin/settings") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="settings" class="w-4 h-4"></i>
            <span>Settings</span>
        </a>

    </nav>

    <div class="p-3 border-t border-blue-900/60">
        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-rose-400 hover:bg-rose-500/10 hover:text-rose-300">
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