<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String uri = request.getRequestURI().substring(request.getContextPath().length());
    String basePath = request.getContextPath();
%>

<aside class="w-64 min-h-screen flex flex-col border-r border-slate-300 bg-gradient-to-b from-slate-800 to-slate-900 text-white shadow-xl">

    <!-- Header -->
    <div class="flex items-center gap-3 px-4 py-4 border-b border-slate-700 bg-slate-900/60">
        <div class="grid h-8 w-8 place-items-center rounded-lg bg-gradient-to-br from-amber-400 to-orange-500 shadow-md">
            <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-slate-900" fill="none" stroke-width="2">
                <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                <rect x="14" y="14" width="6" height="6" rx="1"></rect>
            </svg>
        </div>
        <span class="text-lg font-semibold">BuildTrack</span>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 px-3 py-4 space-y-2 overflow-y-auto">

        <%-- Reusable class pattern --%>
        <%
            String activeClass = "bg-gradient-to-r from-amber-500 to-orange-500 text-white shadow-md";
            String inactiveClass = "text-slate-300 hover:bg-slate-700/50 hover:text-white";
        %>

        <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium <%= uri.contains("/worker/dashboard") ? activeClass : inactiveClass %>"
           href="<%= basePath %>/worker/dashboard">
            <span>Dashboard</span>
        </a>

        <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium <%= uri.contains("/worker/attendance") ? activeClass : inactiveClass %>"
           href="<%= basePath %>/worker/attendance">
            <span>Attendance</span>
        </a>

        <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium <%= uri.contains("/worker/worklog") ? activeClass : inactiveClass %>"
           href="<%= basePath %>/worker/worklog">
            <span>Work Log</span>
        </a>

        <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium <%= uri.contains("/worker/payslip") ? activeClass : inactiveClass %>"
           href="<%= basePath %>/worker/payslip">
            <span>Payslips</span>
        </a>

        <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium <%= uri.contains("/worker/profile") ? activeClass : inactiveClass %>"
           href="<%= basePath %>/worker/profile">
            <span>Profile</span>
        </a>

    </nav>

    <!-- Bottom Section -->
    <div class="px-3 py-4 border-t border-slate-700 bg-slate-900/40 space-y-2">

        <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium text-slate-300 hover:bg-slate-700/50 hover:text-white"
           href="<%= basePath %>/worker/upgrade">
            <span>Upgrade Plan</span>
        </a>

        <a class="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium text-slate-300 hover:bg-red-500/20 hover:text-red-400"
           href="<%= basePath %>/logout">
            <span>Logout</span>
        </a>

    </div>

</aside>