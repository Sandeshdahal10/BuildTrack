<%
    String uri = request.getRequestURI().substring(request.getContextPath().length());
    String basePath = request.getContextPath();
%>

<!-- Mobile overlay -->
<div id="sidebar-overlay" class="fixed inset-0 bg-slate-900/50 z-40 lg:hidden hidden transition-opacity duration-300 opacity-0" onclick="toggleSidebar()"></div>

<!-- Sidebar -->
<aside id="worker-sidebar" class="fixed lg:static top-0 left-0 z-50 w-64 h-screen overflow-y-auto bg-[#0b1f4d] text-white flex flex-col border-r border-blue-900/60 transition-transform duration-300 ease-in-out transform -translate-x-full lg:translate-x-0">

    <!-- Header -->
    <div class="p-4 flex items-center justify-between gap-3 border-b border-blue-900/60 h-20 shrink-0">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 flex items-center justify-center bg-white/0">
                <img src="<%= basePath %>/assets/image/BuildTrackLogo.png" alt="BuildTrack" class="w-9 h-9 object-contain" />
            </div>
            <span class="font-bold text-xl tracking-wide">BuildTrack</span>
        </div>
        <!-- Close button for mobile -->
        <button onclick="toggleSidebar()" class="lg:hidden p-2 text-slate-400 hover:text-white rounded-lg hover:bg-white/10 transition-colors">
            <i data-lucide="x" class="w-5 h-5"></i>
        </button>
    </div>

    <!-- Navigation -->
    <nav class="flex-1 p-4 space-y-1.5 overflow-y-auto">

        <%-- Reusable class pattern --%>
        <%
            String activeNavClass = "flex items-center gap-3 px-3 py-2.5 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 text-white font-semibold shadow-md shadow-orange-500/20";
            String inactiveNavClass = "flex items-center gap-3 px-3 py-2.5 rounded-xl text-slate-300 hover:bg-white/10 hover:text-white transition-all font-medium";
        %>

        <a href="<%= basePath %>/worker/dashboard" class="<%= uri.startsWith("/worker/dashboard") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="home" class="w-4.5 h-4.5"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= basePath %>/worker/attendance" class="<%= uri.startsWith("/worker/attendance") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="check-square" class="w-4.5 h-4.5"></i>
            <span>Attendance</span>
        </a>

        <a href="<%= basePath %>/worker/projects" class="<%= uri.startsWith("/worker/project") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="briefcase" class="w-4.5 h-4.5"></i>
            <span>Projects</span>
        </a>

        <a href="<%= basePath %>/worker/worklog" class="<%= uri.startsWith("/worker/worklog") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="clipboard-list" class="w-4.5 h-4.5"></i>
            <span>Work Log</span>
        </a>

        <a href="<%= basePath %>/worker/payslip" class="<%= uri.startsWith("/worker/payslip") ? activeNavClass : inactiveNavClass %>">
            <i data-lucide="wallet" class="w-4.5 h-4.5"></i>
            <span>Payslips</span>
        </a>

    </nav>


</aside>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('worker-sidebar');
        const overlay = document.getElementById('sidebar-overlay');
        
        if (!sidebar || !overlay) return;

        if (sidebar.classList.contains('-translate-x-full')) {
            // Open sidebar
            sidebar.classList.remove('-translate-x-full');
            overlay.classList.remove('hidden');
            // Small delay to allow display:block to apply before changing opacity for the fade-in effect
            setTimeout(() => {
                overlay.classList.remove('opacity-0');
            }, 10);
        } else {
            // Close sidebar
            sidebar.classList.add('-translate-x-full');
            overlay.classList.add('opacity-0');
            // Wait for transition to finish before hiding overlay
            setTimeout(() => {
                overlay.classList.add('hidden');
            }, 300);
        }
    }
    
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>