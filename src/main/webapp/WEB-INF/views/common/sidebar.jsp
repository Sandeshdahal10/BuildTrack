<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="com.buildtrack.model.Role" %>
<%
    // Get URI without context path
    String uri = request.getRequestURI().substring(request.getContextPath().length());
    String basePath = request.getContextPath();

    User currentUser = (User) session.getAttribute("user");
    Role role = (currentUser != null) ? currentUser.getRole() : null;

    // Fallback: Detect role from request URI prefix
    if (role == null) {
        if (uri.startsWith("/admin")) {
            role = Role.ADMIN;
        } else if (uri.startsWith("/client")) {
            role = Role.CLIENT;
        } else if (uri.startsWith("/worker")) {
            role = Role.WORKER;
        }
    }

    // Modern Nav Styles
    String activeNavClass = "flex items-center gap-3 px-3 py-2.5 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 text-white font-semibold shadow-md shadow-orange-500/20 transition-all duration-300";
    String inactiveNavClass = "flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-300 hover:bg-white/10 hover:text-white transition-all duration-200 font-medium";
%>

<!-- Sidebar Navigation Drawer -->
<aside class="w-56 h-screen overflow-y-auto bg-[#0b1f4d] text-white flex flex-col border-r border-blue-900/60 shrink-0">

    <!-- Header Logo & Branding -->
    <div class="p-4 flex items-center justify-between border-b border-blue-900/60 h-20 shrink-0">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 flex items-center justify-center">
                <img src="<%= basePath %>/assets/image/BuildTrackLogo.png" alt="BuildTrack" class="w-9 h-9 object-contain"/>
            </div>
            <span class="font-bold text-xl tracking-wide">BuildTrack</span>
        </div>
        <!-- Mobile close button (if custom callback exists) -->
        <button id="sidebarCloseBtn" onclick="if(typeof toggleSidebar === 'function') { toggleSidebar(); } else { document.getElementById('sidebar-container')?.classList.add('-translate-x-full'); }" class="md:hidden p-1.5 text-slate-400 hover:text-white rounded-lg hover:bg-white/10 transition-colors">
            <svg viewBox="0 0 24 24" class="w-5 h-5 stroke-current fill-none" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
        </button>
    </div>

    <!-- User Persona Badge (Displays role dynamically) -->
    <div class="px-4 py-3 bg-blue-950/40 border-b border-blue-900/40 flex items-center gap-2.5">
        <span class="h-2 w-2 rounded-full bg-emerald-400 animate-pulse"></span>
        <span class="text-[10px] uppercase tracking-wider font-extrabold text-slate-400">
            <%= (role != null) ? role.name() : "GUEST" %> Portal
        </span>
    </div>

    <!-- Navigation Content -->
    <nav class="flex-1 p-3.5 space-y-1.5 overflow-y-auto">
        <% if (role == Role.ADMIN) { %>
            <!-- Admin Role Features -->
            <a href="<%= basePath %>/admin/dashboard" class="<%= uri.startsWith("/admin/dashboard") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="home" class="w-4 h-4"></i>
                <span>Dashboard</span>
            </a>

            <a href="<%= basePath %>/admin/projects" class="<%= uri.startsWith("/admin/projects") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="folder" class="w-4 h-4"></i>
                <span>Projects</span>
            </a>

            <a href="<%= basePath %>/admin/workers" class="<%= uri.startsWith("/admin/workers") ? activeNavClass : inactiveNavClass %>">
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

        <% } else if (role == Role.CLIENT) { %>
            <!-- Client Role Features -->
            <a href="<%= basePath %>/client/dashboard" class="<%= uri.startsWith("/client/dashboard") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="layout-dashboard" class="w-4 h-4"></i>
                <span>Dashboard</span>
            </a>

            <a href="<%= basePath %>/client/project" class="<%= uri.startsWith("/client/project") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="briefcase" class="w-4 h-4"></i>
                <span>My Projects</span>
            </a>

            <a href="<%= basePath %>/client/budget" class="<%= uri.startsWith("/client/budget") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="pie-chart" class="w-4 h-4"></i>
                <span>Budget</span>
            </a>

            <a href="<%= basePath %>/client/inquiries" class="<%= uri.startsWith("/client/inquiries") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="message-square" class="w-4 h-4"></i>
                <span>Inquiries</span>
            </a>

        <% } else if (role == Role.WORKER) { %>
            <!-- Worker Role Features -->
            <a href="<%= basePath %>/worker/dashboard" class="<%= uri.startsWith("/worker/dashboard") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="home" class="w-4 h-4"></i>
                <span>Dashboard</span>
            </a>

            <a href="<%= basePath %>/worker/attendance" class="<%= uri.startsWith("/worker/attendance") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="check-square" class="w-4 h-4"></i>
                <span>Attendance</span>
            </a>

            <a href="<%= basePath %>/worker/projects" class="<%= uri.startsWith("/worker/project") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="briefcase" class="w-4 h-4"></i>
                <span>Projects</span>
            </a>

            <a href="<%= basePath %>/worker/worklog" class="<%= uri.startsWith("/worker/worklog") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="clipboard-list" class="w-4.5 h-4.5"></i>
                <span>Work Log</span>
            </a>

            <a href="<%= basePath %>/worker/payslip" class="<%= uri.startsWith("/worker/payslip") ? activeNavClass : inactiveNavClass %>">
                <i data-lucide="wallet" class="w-4 h-4"></i>
                <span>Payslips</span>
            </a>
        <% } %>
    </nav>

</aside>

<!-- Import Lucide Library directly so that icons initialize automatically on all host pages -->
<script src="https://unpkg.com/lucide@latest"></script>
<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
