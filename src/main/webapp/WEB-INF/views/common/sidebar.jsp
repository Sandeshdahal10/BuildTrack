<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="com.buildtrack.model.Role" %>

<%
    String uri = request.getRequestURI()
            .substring(request.getContextPath().length());

    String basePath = request.getContextPath();

    User currentUser = (User) session.getAttribute("user");

    Role role = null;

    if (currentUser != null) {
        role = currentUser.getRole();
    }

    if (role == null) {

        if (uri.startsWith("/admin")) {
            role = Role.ADMIN;

        } else if (uri.startsWith("/client")) {
            role = Role.CLIENT;

        } else if (uri.startsWith("/worker")) {
            role = Role.WORKER;
        }
    }

    String activeNavClass =
            "flex items-center gap-3 px-3 py-2.5 rounded-xl " +
                "bg-[rgba(255,255,255,0.14)] text-white font-semibold shadow-lg shadow-black/25 ring-1 ring-white/20 translate-x-0.5 " +
                    "transition-all duration-300";

    String inactiveNavClass =
            "flex items-center gap-3 px-3 py-2.5 rounded-xl " +
                "text-slate-300 hover:bg-white/10 hover:text-white hover:translate-x-0.5 " +
                    "transition-all duration-200 font-medium";
%>

<aside
        class="w-56 h-screen overflow-y-auto bg-[#0b1f4d] text-white flex flex-col border-r border-blue-900/60 shrink-0">

    <div class="p-4 flex items-center justify-between border-b border-blue-900/60 h-20 shrink-0">

        <div class="flex items-center gap-3">
            <div class="w-9 h-9 flex items-center justify-center">
                <img
                        src="<%= basePath %>/assets/image/BuildTrackLogo.png"
                        alt="BuildTrack"
                        class="w-9 h-9 object-contain" />
            </div>

            <span class="font-bold text-xl tracking-wide">
                BuildTrack
            </span>
        </div>

        <button
                id="sidebarCloseBtn"
                onclick="if(typeof toggleSidebar === 'function') { toggleSidebar(); }"
                class="md:hidden p-1.5 text-slate-400 hover:text-white rounded-lg hover:bg-white/10 transition-colors">

            <svg
                    viewBox="0 0 24 24"
                    class="w-5 h-5 stroke-current fill-none"
                    stroke-width="2">

                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
        </button>
    </div>

    <nav class="flex-1 p-3.5 space-y-1.5 overflow-y-auto">

        <% if (role == Role.ADMIN) { %>

        <a href="<%= basePath %>/admin/dashboard"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/dashboard") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="layout-dashboard" class="w-4 h-4"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= basePath %>/admin/projects"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/projects") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="folder-kanban" class="w-4 h-4"></i>
            <span>Projects</span>
        </a>

        <a href="<%= basePath %>/admin/workers"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/workers") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="hard-hat" class="w-4 h-4"></i>
            <span>Workers</span>
        </a>

        <a href="<%= basePath %>/admin/clients"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/clients") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="users" class="w-4 h-4"></i>
            <span>Clients</span>
        </a>

        <a href="<%= basePath %>/admin/materials"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/materials") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="package" class="w-4 h-4"></i>
            <span>Materials</span>
        </a>

        <a href="<%= basePath %>/admin/attendance"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/attendance") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="clipboard-check" class="w-4 h-4"></i>
            <span>Attendance</span>
        </a>

        <a href="<%= basePath %>/admin/payroll"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/payroll") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="wallet" class="w-4 h-4"></i>
            <span>Payroll</span>
        </a>

        <a href="<%= basePath %>/admin/expenses"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/expenses") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="receipt" class="w-4 h-4"></i>
            <span>Expenses</span>
        </a>

        <a href="<%= basePath %>/admin/reports"
              data-sidebar-link
           class="<%= uri.startsWith("/admin/reports") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="bar-chart-3" class="w-4 h-4"></i>
            <span>Reports</span>
        </a>

        <% } else if (role == Role.CLIENT) { %>

        <a href="<%= basePath %>/client/dashboard"
              data-sidebar-link
           class="<%= uri.startsWith("/client/dashboard") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="layout-dashboard" class="w-4 h-4"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= basePath %>/client/project"
              data-sidebar-link
           class="<%= uri.startsWith("/client/project") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="briefcase" class="w-4 h-4"></i>
            <span>My Projects</span>
        </a>

        <a href="<%= basePath %>/client/budget"
              data-sidebar-link
           class="<%= uri.startsWith("/client/budget") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="pie-chart" class="w-4 h-4"></i>
            <span>Budget</span>
        </a>

        <a href="<%= basePath %>/client/inquiries"
              data-sidebar-link
           class="<%= uri.startsWith("/client/inquiries") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="message-square" class="w-4 h-4"></i>
            <span>Inquiries</span>
        </a>

        <%-- ================= WORKER ================= --%>
        <% } else if (role == Role.WORKER) { %>

        <a href="<%= basePath %>/worker/dashboard"
              data-sidebar-link
           class="<%= uri.startsWith("/worker/dashboard") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="layout-dashboard" class="w-4 h-4"></i>
            <span>Dashboard</span>
        </a>

        <a href="<%= basePath %>/worker/attendance"
              data-sidebar-link
           class="<%= uri.startsWith("/worker/attendance") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="clipboard-check" class="w-4 h-4"></i>
            <span>Attendance</span>
        </a>

        <a href="<%= basePath %>/worker/projects"
              data-sidebar-link
           class="<%= uri.startsWith("/worker/projects") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="briefcase" class="w-4 h-4"></i>
            <span>Projects</span>
        </a>

        <a href="<%= basePath %>/worker/worklog"
              data-sidebar-link
           class="<%= uri.startsWith("/worker/worklog") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="clipboard-list" class="w-4 h-4"></i>
            <span>Work Log</span>
        </a>

        <a href="<%= basePath %>/worker/payslip"
              data-sidebar-link
           class="<%= uri.startsWith("/worker/payslip") ? activeNavClass : inactiveNavClass %>">

            <i data-lucide="wallet" class="w-4 h-4"></i>
            <span>Payslips</span>
        </a>

        <% } %>

    </nav>
</aside>

<!-- Lucide Icons -->
<script src="https://unpkg.com/lucide@latest"></script>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }

    (function () {
        var links = Array.prototype.slice.call(document.querySelectorAll('[data-sidebar-link]'));

        if (!links.length) {
            return;
        }

        var activeClass = '<%= activeNavClass %>';
        var inactiveClass = '<%= inactiveNavClass %>';
        var storageKey = 'buildtrack.sidebar.activePath';
        var navDelay = 220;

        function getPathFromLink(link) {
            return new URL(link.href, window.location.origin).pathname;
        }

        function getStoredPath() {
            try {
                return window.localStorage.getItem(storageKey);
            } catch (error) {
                return null;
            }
        }

        function setStoredPath(pathname) {
            try {
                window.localStorage.setItem(storageKey, pathname);
            } catch (error) {
                // Ignore storage failures and fall back to the server-rendered state.
            }
        }

        function setActiveLink(activeLink) {
            var activePath = getPathFromLink(activeLink);

            setStoredPath(activePath);

            links.forEach(function (link) {
                var isActive = link === activeLink;

                link.className = isActive ? activeClass : inactiveClass;

                if (isActive) {
                    link.setAttribute('aria-current', 'page');
                } else {
                    link.removeAttribute('aria-current');
                }
            });
        }

        function syncActiveLink() {
            var storedPath = getStoredPath();
            var currentPath = window.location.pathname;
            var activeLink = null;

            if (storedPath) {
                activeLink = links.find(function (link) {
                    return getPathFromLink(link) === storedPath;
                }) || null;
            }

            if (!activeLink) {
                activeLink = links.find(function (link) {
                    return getPathFromLink(link) === currentPath;
                }) || null;
            }

            if (activeLink) {
                setActiveLink(activeLink);
            }
        }

        syncActiveLink();

        links.forEach(function (link) {
            link.addEventListener('click', function (event) {
                var isModifiedClick = event.metaKey || event.ctrlKey || event.shiftKey || event.altKey || event.button !== 0;

                if (isModifiedClick) {
                    return;
                }

                event.preventDefault();
                setActiveLink(link);

                window.setTimeout(function () {
                    window.location.href = link.href;
                }, navDelay);
            });
        });
    })();
</script>