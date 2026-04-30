<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String uri = request.getRequestURI().substring(request.getContextPath().length());
    String basePath = request.getContextPath();

    String activeNavClass = "flex items-center gap-3 px-3 py-2 rounded-lg bg-orange-500 hover:bg-red-500/10 text-white font-medium";
    String inactiveNavClass = "flex items-center gap-3 px-3 py-2 rounded-lg text-slate-300 hover:bg-white/10 hover:text-white";
%>

<aside class="w-56 min-h-screen overflow-y-auto bg-[#0b1f4d] text-white flex flex-col border-r border-blue-900/60">

    <div class="p-4 flex items-center gap-3 border-b border-blue-900/60">
        <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-amber-500 to-amber-600 flex items-center justify-center">
            <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-slate-950" fill="none" stroke-width="2" aria-hidden="true">
                <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                <rect x="14" y="14" width="6" height="6" rx="1"></rect>
            </svg>
        </div>
        <span class="font-bold text-lg">BuildTrack</span>
    </div>

    <nav class="flex-1 p-3 space-y-1">

        <a href="<%= basePath %>/client/dashboard" class="<%= uri.startsWith("/client/dashboard") ? activeNavClass : inactiveNavClass %>">
            <svg viewBox="0 0 24 24" class="w-4 h-4 stroke-current" fill="none" stroke-width="2" aria-hidden="true">
                <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                <rect x="14" y="14" width="6" height="6" rx="1"></rect>
            </svg>
            <span>Dashboard</span>
        </a>

        <a href="<%= basePath %>/client/project" class="<%= uri.startsWith("/client/project") ? activeNavClass : inactiveNavClass %>">
            <svg viewBox="0 0 24 24" class="w-4 h-4 stroke-current" fill="none" stroke-width="2" aria-hidden="true">
                <path d="M3 7h6l2 2h10v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7z"></path>
                <path d="M3 7a2 2 0 0 1 2-2h4l2 2"></path>
            </svg>
            <span>My Projects</span>
        </a>

        <a href="<%= basePath %>/client/budget" class="<%= uri.startsWith("/client/budget") ? activeNavClass : inactiveNavClass %>">
            <svg viewBox="0 0 24 24" class="w-4 h-4 stroke-current" fill="none" stroke-width="2" aria-hidden="true">
                <path d="M12 3v18"></path>
                <path d="M16 7.5c0-1.7-1.8-3-4-3s-4 1.3-4 3 1.5 2.5 4 3 4 1.3 4 3-1.8 3-4 3-4-1.3-4-3"></path>
            </svg>
            <span>Budget</span>
        </a>

    </nav>

    <div class="p-3 border-t border-blue-900/60">
        <a href="<%= basePath %>/logout" class="flex items-center gap-3 px-3 py-2 rounded-lg text-rose-400 hover:bg-rose-500/10 hover:text-rose-300">
            <svg viewBox="0 0 24 24" class="w-4 h-4 stroke-current" fill="none" stroke-width="2" aria-hidden="true">
                <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                <path d="M16 17l5-5-5-5"></path>
                <path d="M21 12H9"></path>
            </svg>
            <span>Logout</span>
        </a>
    </div>

</aside>

