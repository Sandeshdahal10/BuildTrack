<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    Integer currentHeaderUserId = null;
    if (session.getAttribute("userId") != null) {
        currentHeaderUserId = (Integer) session.getAttribute("userId");
    } else if (session.getAttribute("user") != null) {
        currentHeaderUserId = ((com.buildtrack.model.User) session.getAttribute("user")).getId();
    }
    java.util.List<com.buildtrack.model.Notification> headerNotifications = new java.util.ArrayList<>();
    int headerUnreadCount = 0;
    if (currentHeaderUserId != null) {
        com.buildtrack.dao.NotificationDao headerNotifDao = new com.buildtrack.dao.NotificationDao();
        headerNotifications = headerNotifDao.getNotificationsByUserId(currentHeaderUserId);
        headerUnreadCount = headerNotifDao.getUnreadCount(currentHeaderUserId);
    }
%>

  <%-- Created by IntelliJ IDEA. User: sande Date: 4/12/2026 Time: 8:48 AM To change this template use File | Settings |
    File Templates. --%>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>

    <header class="w-full bg-white border-b border-slate-200 relative z-40">
      <div class="mx-auto flex h-20 w-full items-center justify-between gap-4 px-4 sm:px-6 lg:px-8">

        <!-- Hamburger menu for mobile -->
        <button id="mobile-menu-btn" type="button" class="md:hidden inline-flex items-center justify-center p-2 rounded-md text-slate-400 hover:text-slate-500 hover:bg-slate-100 focus:outline-none">
          <i data-lucide="menu" class="h-6 w-6"></i>
        </button>

        <div class="hidden min-w-0 md:flex items-center gap-3">
          <div class="hidden min-w-0 md:block">
            <p class="text-xl font-semibold text-black" id="topbar-date">Monday, April 13, 2026</p>
            <p class="mt-2 text-sm font-medium  text-black" id="topbar-time">08:48 AM</p>
          </div>
        </div>

        <div class="ml-auto flex items-center gap-3 sm:gap-4">

          <div class="relative hidden sm:block">
            <i data-lucide="search"
              class="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"></i>
            <input type="text" placeholder="Search..."
              class="h-11 w-56 rounded-xl border border-slate-300 bg-white pl-10 pr-4 text-sm text-slate-900 placeholder:text-slate-500 outline-none transition focus:border-amber-400/60 focus:ring-2 focus:ring-amber-400/20 lg:w-72" />
          </div>

          <div class="relative">
            <button type="button" id="topbarNotificationButton"
              class="relative inline-flex h-11 w-11 items-center justify-center rounded-xl border border-slate-300 bg-white text-slate-600 transition hover:border-slate-400 hover:text-slate-900"
              aria-label="Notifications" aria-expanded="false" aria-controls="topbarNotificationMenu">
              <i data-lucide="bell" class="h-4 w-4"></i>
              <span id="topbarNotificationBadge" class="absolute -right-0.5 -top-0.5 min-w-[16px] rounded-full border border-white bg-amber-500 px-0.5 text-center text-[9px] font-bold leading-3 text-slate-800 <%= headerUnreadCount == 0 ? "hidden" : "" %>"><%= headerUnreadCount %></span>
            </button>
            
            <div id="topbarNotificationMenu" class="absolute right-0 top-13 z-50 hidden w-72 rounded-xl border border-slate-200 bg-white p-3 shadow-lg">
              <div class="mb-2 flex items-center justify-between">
                <p class="m-0 text-sm font-semibold text-slate-900">Notifications</p>
                <button id="topbarMarkAllReadButton" class="text-xs font-semibold text-amber-600 <%= headerUnreadCount == 0 ? "hidden" : "" %>" type="button">Mark all read</button>
              </div>
              <ul class="m-0 list-none space-y-2 p-0 text-xs text-slate-600 max-h-60 overflow-y-auto">
                <% if (headerNotifications.isEmpty()) { %>
                  <li class="rounded-lg bg-slate-50 px-2.5 py-2 text-center text-slate-400">No new notifications.</li>
                <% } else { %>
                  <% for (com.buildtrack.model.Notification n : headerNotifications) { %>
                    <li class="rounded-lg <%= n.isRead() ? "bg-slate-50 text-slate-500" : "bg-amber-50/70 text-slate-800 font-medium" %> px-2.5 py-2 border-b border-slate-100 last:border-b-0"><%= n.getMessage() %></li>
                  <% } %>
                <% } %>
              </ul>
            </div>
          </div>

          <div class="relative z-50">
            <button type="button" id="user-menu-button" aria-haspopup="true" aria-expanded="false"
              class="inline-flex h-11 items-center gap-2 rounded-xl border border-slate-300 bg-slate-100 px-3 text-left transition hover:border-slate-400">
              <div class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-amber-300/80 text-slate-900">
                <i data-lucide="user" class="h-4 w-4"></i>
              </div>
              <div class="hidden leading-tight sm:block">
                <p class="text-sm font-semibold text-slate-800">
                  <c:choose>
                    <c:when test="${not empty sessionScope.user.fullName}">
                      <c:out value="${sessionScope.user.fullName}" />
                    </c:when>
                    <c:otherwise>System Administrator</c:otherwise>
                  </c:choose>
                </p>
                <p class="text-xs text-slate-500">
                  <c:choose>
                    <c:when test="${not empty sessionScope.user.role}">
                      <c:out value="${sessionScope.user.role}" />
                    </c:when>
                    <c:otherwise>Admin</c:otherwise>
                  </c:choose>
                </p>
              </div>
              <i data-lucide="chevron-down" class="ml-1 hidden h-4 w-4 text-slate-500 sm:block"></i>
            </button>

            <div id="user-menu-dropdown" class="absolute right-0 mt-2 hidden w-48 overflow-hidden rounded-xl border border-slate-200 bg-white shadow-lg z-50">
              <c:choose>
                <c:when test="${sessionScope.user.role == 'WORKER'}">
                  <a href="<%= request.getContextPath() %>/worker/profile"
                    class="flex items-center gap-2 px-4 py-2.5 text-sm text-slate-700 hover:bg-slate-50">
                    <i data-lucide="user" class="h-4 w-4 text-slate-500"></i>
                    Profile
                  </a>
                </c:when>
                <c:when test="${sessionScope.user.role == 'ADMIN'}">
                  <a href="<%= request.getContextPath() %>/admin/profile"
                    class="flex items-center gap-2 px-4 py-2.5 text-sm text-slate-700 hover:bg-slate-50">
                    <i data-lucide="user" class="h-4 w-4 text-slate-500"></i>
                    Profile
                  </a>
                </c:when>
                <c:when test="${sessionScope.user.role == 'CLIENT'}">
                  <a href="<%= request.getContextPath() %>/client/profile"
                    class="flex items-center gap-2 px-4 py-2.5 text-sm text-slate-700 hover:bg-slate-50">
                    <i data-lucide="user" class="h-4 w-4 text-slate-500"></i>
                    Profile
                  </a>
                </c:when>
              </c:choose>
              <a href="<%= request.getContextPath() %>/logout"
                class="flex items-center gap-2 px-4 py-2.5 text-sm text-rose-600 hover:bg-rose-50">
                <i data-lucide="log-out" class="h-4 w-4"></i>
                Log Out
              </a>
            </div>
          </div>
        </div>
      </div>
    </header>

    <script>
      lucide.createIcons();

      // Keep date/time in sync with user locale while preserving the screenshot format.
      (function updateTopbarClock() {
        var dateNode = document.getElementById("topbar-date");
        var timeNode = document.getElementById("topbar-time");

        if (!dateNode || !timeNode) {
          return;
        }

        function renderClock() {
          var now = new Date();
          dateNode.textContent = now.toLocaleDateString("en-GB", {
            weekday: "long",
            month: "long",
            day: "numeric",
            year: "numeric"
          });
          timeNode.textContent = now.toLocaleTimeString("en-GB", {
            hour: "2-digit",
            minute: "2-digit",
            hour12: true
          });
        }

        renderClock();
        setInterval(renderClock, 60000);
      })();

      (function initUserMenu() {
        var button = document.getElementById("user-menu-button");
        var menu = document.getElementById("user-menu-dropdown");

        if (!button || !menu) {
          return;
        }

        function closeMenu() {
          menu.classList.add("hidden");
          button.setAttribute("aria-expanded", "false");
        }

        button.addEventListener("click", function (event) {
          event.stopPropagation();
          var isHidden = menu.classList.contains("hidden");
          if (isHidden) {
            menu.classList.remove("hidden");
            button.setAttribute("aria-expanded", "true");
          } else {
            closeMenu();
          }
        });

        document.addEventListener("click", function (event) {
          if (!menu.classList.contains("hidden") && !menu.contains(event.target) && !button.contains(event.target)) {
            closeMenu();
          }
        });

        document.addEventListener("keydown", function (event) {
          if (event.key === "Escape") {
            closeMenu();
          }
        });
      })();

      (function initTopbarNotifications() {
        var button = document.getElementById("topbarNotificationButton");
        var menu = document.getElementById("topbarNotificationMenu");
        var badge = document.getElementById("topbarNotificationBadge");
        var markReadBtn = document.getElementById("topbarMarkAllReadButton");

        if (!button || !menu) return;

        function closeMenu() {
          menu.classList.add("hidden");
          button.setAttribute("aria-expanded", "false");
        }

        button.addEventListener("click", function (event) {
          event.stopPropagation();
          var isHidden = menu.classList.contains("hidden");
          if (isHidden) {
            menu.classList.remove("hidden");
            button.setAttribute("aria-expanded", "true");
          } else {
            closeMenu();
          }
        });

        document.addEventListener("click", function (event) {
          if (!menu.classList.contains("hidden") && !menu.contains(event.target) && !button.contains(event.target)) {
            closeMenu();
          }
        });

        document.addEventListener("keydown", function (event) {
          if (event.key === "Escape") {
            closeMenu();
          }
        });

        if (markReadBtn && badge) {
          markReadBtn.addEventListener("click", function () {
            fetch('<%= request.getContextPath() %>/notifications/mark-read', { method: 'POST' })
              .then(response => {
                badge.classList.add("hidden");
                markReadBtn.textContent = "All caught up";
                markReadBtn.disabled = true;
                document.querySelectorAll("#topbarNotificationMenu li").forEach(li => {
                  li.className = "rounded-lg bg-slate-50 text-slate-500 px-2.5 py-2 border-b border-slate-100 last:border-b-0";
                });
              });
          });
        }
      })();

      // Mobile sidebar toggle logic
      document.addEventListener("DOMContentLoaded", function() {
        var mobileBtn = document.getElementById("mobile-menu-btn");
        var sidebarContainer = document.getElementById("sidebar-container");
        
        if (mobileBtn) {
          mobileBtn.addEventListener("click", function() {
            if (sidebarContainer) {
              sidebarContainer.classList.toggle("-translate-x-full");
            } else if (typeof toggleSidebar === 'function') {
              toggleSidebar();
            }
          });
        }
      });
    </script>