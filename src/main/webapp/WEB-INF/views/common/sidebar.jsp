<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<aside class="w-56 h-screen overflow-y-auto bg-[#0b1f4d] text-white flex flex-col border-r border-blue-900/60">

    <div class="p-4 flex items-center gap-3 border-b border-blue-900/60">
        <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-amber-500 to-amber-600 flex items-center justify-center">
            <i data-lucide="building-2" class="w-4 h-4 text-slate-950"></i>
        </div>
        <span class="font-bold text-lg">BuildTrack</span>
    </div>

    <nav class="flex-1 p-3 space-y-1">

        <a href="/admin/dashboard" class="flex items-center gap-3 px-3 py-2 rounded-lg bg-amber-400/15 text-amber-300">
            <i data-lucide="home" class="w-4 h-4"></i>
            <span>Dashboard</span>
        </a>

        <a href="/admin/projects" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="folder" class="w-4 h-4"></i>
            <span>Projects</span>
        </a>

        <a href="" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="user" class="w-4 h-4"></i>
            <span>Workers</span>
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="users" class="w-4 h-4"></i>
            <span>Clients</span>
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="package" class="w-4 h-4"></i>
            <span>Materials</span>
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="check-square" class="w-4 h-4"></i>
            <span>Attendance</span>
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="wallet" class="w-4 h-4"></i>
            <span>Payroll</span>
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="receipt" class="w-4 h-4"></i>
            <span>Expenses</span>
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="bar-chart-3" class="w-4 h-4"></i>
            <span>Reports</span>
        </a>

        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white">
            <i data-lucide="settings" class="w-4 h-4"></i>
            <span>Settings</span>
        </a>

    </nav>

    <div class="p-3 border-t border-blue-900/60">
        <a href="#" class="flex items-center gap-3 px-3 py-2 rounded-lg text-rose-600 hover:bg-rose-50 hover:text-rose-700">
            <i data-lucide="log-out" class="w-4 h-4"></i>
            <span>Logout</span>
        </a>
    </div>

</aside>
