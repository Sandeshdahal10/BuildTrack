<%-- Created by IntelliJ IDEA. User: sande Date: 4/12/2026 Time: 8:38 AM To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="com.buildtrack.model.User" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <% User user=(User) session.getAttribute("user"); String displayName=(user !=null && user.getFullName()
                    !=null && !user.getFullName().trim().isEmpty()) ? user.getFullName() : "Client" ; String
                    successMessage=(String) session.getAttribute("successMessage");
                    session.removeAttribute("successMessage"); %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>BuildTrack | My Projects</title>
                        <script src="https://cdn.tailwindcss.com"></script>
                    </head>

                    <body class="m-0 min-h-screen bg-white text-slate-900">
                        <div class="h-screen flex font-semibold">
                            <div id="sidebar-container"
                                class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
                                <jsp:include page="../common/clientsidebar.jsp" />
                            </div>

                            <main
                                class="ml-0 md:ml-56 w-full max-w-full overflow-hidden flex-1 flex-1 overflow-y-auto bg-white px-5 pb-7 pt-4">
                                <div
                                    class="mb-4 flex items-center justify-between text-xs text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
                                    <div>
                                        <p class="m-0">Friday, April 17, 2026</p>
                                        <p class="m-0 text-[11px]">07:13 PM</p>
                                    </div>
                                    <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                                        <input id="projectSearchInput"
                                            class="min-w-[220px] rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs text-slate-900 placeholder:text-slate-400 outline-none max-[760px]:min-w-0 max-[760px]:flex-1"
                                            type="text" placeholder="Search projects..." aria-label="Search projects">
                                        <div class="relative">
                                            <button id="notificationButton"
                                                class="relative grid h-9 w-9 place-items-center rounded-full border border-slate-200 bg-white p-0"
                                                type="button" aria-label="Notifications" aria-expanded="false"
                                                aria-controls="notificationMenu">
                                                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-slate-900" fill="none"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                                                    aria-hidden="true">
                                                    <path
                                                        d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5">
                                                    </path>
                                                    <path d="M9 17a3 3 0 0 0 6 0"></path>
                                                </svg>
                                                <span id="notificationBadge"
                                                    class="absolute -right-0.5 -top-0.5 min-w-[16px] rounded-full border border-white bg-amber-500 px-0.5 text-center text-[9px] font-bold leading-3 text-[#111827]">3</span>
                                            </button>
                                            <div id="notificationMenu"
                                                class="absolute right-0 top-11 z-20 hidden w-72 rounded-xl border border-slate-200 bg-white p-3 shadow-lg">
                                                <div class="mb-2 flex items-center justify-between">
                                                    <p class="m-0 text-sm font-semibold text-slate-900">Notifications
                                                    </p>
                                                    <button id="markAllReadButton"
                                                        class="text-xs font-semibold text-amber-600" type="button">Mark
                                                        all read</button>
                                                </div>
                                                <ul class="m-0 list-none space-y-2 p-0 text-xs text-slate-600">
                                                    <li class="rounded-lg bg-slate-50 px-2.5 py-2">Skyline Tower reached
                                                        68% completion.</li>
                                                    <li class="rounded-lg bg-slate-50 px-2.5 py-2">Green Valley material
                                                        invoice approved.</li>
                                                    <li class="rounded-lg bg-slate-50 px-2.5 py-2">Client meeting
                                                        scheduled for Thursday.</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="relative">
                                            <button id="userMenuButton"
                                                class="flex items-center gap-2 rounded-full border border-slate-200 bg-white px-2.5 py-1.5 text-left"
                                                type="button" aria-haspopup="true" aria-expanded="false">
                                                <div
                                                    class="grid h-7 w-7 place-items-center rounded-full bg-amber-300 text-xs font-bold text-slate-800">
                                                    <%= displayName.substring(0, 1).toUpperCase() %>
                                                </div>
                                                <div>
                                                    <p class="m-0 text-sm font-semibold text-slate-900">
                                                        <%= displayName %>
                                                    </p>
                                                    <p class="m-0 text-[11px] text-slate-500">Client</p>
                                                </div>
                                                <svg class="ml-1 h-4 w-4 text-slate-500" viewBox="0 0 20 20"
                                                    fill="currentColor" aria-hidden="true">
                                                    <path fill-rule="evenodd"
                                                        d="M5.23 7.21a.75.75 0 011.06.02L10 11.188l3.71-3.956a.75.75 0 111.08 1.04l-4.24 4.52a.75.75 0 01-1.08 0l-4.24-4.52a.75.75 0 01.02-1.06z"
                                                        clip-rule="evenodd"></path>
                                                </svg>
                                            </button>
                                            <div id="userMenu"
                                                class="absolute right-0 mt-2 hidden w-40 overflow-hidden rounded-xl border border-slate-200 bg-white text-xs shadow-lg">
                                                <a href="<%= request.getContextPath() %>/client/profile"
                                                    class="flex items-center gap-2 px-3 py-2 text-slate-700 hover:bg-slate-50">Profile</a>
                                                <a href="<%= request.getContextPath() %>/logout"
                                                    class="flex items-center gap-2 px-3 py-2 text-rose-600 hover:bg-rose-50">Log
                                                    Out</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <section class="mb-4 border-b border-slate-200 pb-4">
                                    <div
                                        class="mb-3 flex items-center justify-between max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-3">
                                        <div>
                                            <h1
                                                class="m-0 text-5xl font-semibold leading-tight text-slate-900 max-[760px]:text-4xl">
                                                My Projects</h1>
                                            <p class="mt-1 text-lg text-slate-600">Detailed view of your construction
                                                projects</p>
                                        </div>
                                        <a href="<%= request.getContextPath() %>/client/addProject"
                                            class="inline-flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 font-semibold text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition duration-200">
                                            <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                                <path fill-rule="evenodd"
                                                    d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z"
                                                    clip-rule="evenodd"></path>
                                            </svg>
                                            <span>Add New Project</span>
                                        </a>
                                    </div>
                                </section>

                                <% if (successMessage !=null && !successMessage.trim().isEmpty()) { %>
                                    <div id="successAlert"
                                        class="mb-6 rounded-lg border border-green-300 bg-green-50 p-4">
                                        <div class="flex items-start gap-3">
                                            <svg class="mt-0.5 h-5 w-5 text-green-600" viewBox="0 0 20 20"
                                                fill="currentColor">
                                                <path fill-rule="evenodd"
                                                    d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                                                    clip-rule="evenodd"></path>
                                            </svg>
                                            <div>
                                                <h3 class="m-0 font-semibold text-green-900">Success!</h3>
                                                <p class="mt-1 text-sm text-green-800">
                                                    <%= successMessage %>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <% } %>

                                        <c:if test="${not empty selectedProject}">
                                            <section
                                                class="mb-8 rounded-2xl border border-slate-200 bg-slate-50 p-6 shadow-inner">
                                                <div class="flex justify-between items-start mb-4">
                                                    <div>
                                                        <h2 class="text-2xl font-bold text-slate-900">Project Details:
                                                            ${selectedProject.title}</h2>
                                                        <p class="text-sm text-slate-600 mt-1">Status: <span class="font-semibold text-amber-700"><c:choose><c:when test="${selectedProject.status == 'PLANNED'}">Admin Approval Required</c:when><c:otherwise>${selectedProject.statusDisplayName}</c:otherwise></c:choose></span></p>
                                                    </div>
                                                    <div class="flex gap-2">
                                                        <button type="button"
                                                            onclick="document.getElementById('editProjectModal').classList.remove('hidden')"
                                                            class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600 transition">
                                                            <i data-lucide="edit-3" class="h-4 w-4"></i> Edit Project
                                                        </button>
                                                    </div>
                                                </div>

                                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
                                                    <div
                                                        class="bg-white p-4 rounded-xl border border-slate-200 shadow-sm">
                                                        <h3
                                                            class="text-sm font-bold text-slate-500 uppercase tracking-wider mb-3">
                                                            Timeline</h3>
                                                        <p class="text-slate-800"><span
                                                                class="font-semibold">Start:</span>
                                                            ${selectedProject.startDate}</p>
                                                        <p class="text-slate-800"><span
                                                                class="font-semibold">End:</span> ${empty
                                                            selectedProject.endDate ? 'TBD' : selectedProject.endDate}
                                                        </p>
                                                    </div>
                                                    <div
                                                        class="bg-white p-4 rounded-xl border border-slate-200 shadow-sm">
                                                        <h3
                                                            class="text-sm font-bold text-slate-500 uppercase tracking-wider mb-3">
                                                            Financials</h3>
                                                        <p class="text-slate-800"><span
                                                                class="font-semibold">Budget:</span> NPR
                                                            ${selectedProject.totalBudget}</p>
                                                    </div>
                                                    <div
                                                        class="md:col-span-2 bg-white p-4 rounded-xl border border-slate-200 shadow-sm">
                                                        <h3
                                                            class="text-sm font-bold text-slate-500 uppercase tracking-wider mb-3">
                                                            Description</h3>
                                                        <p class="text-slate-800">${selectedProject.description}</p>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Edit Project Modal -->
                                            <div id="editProjectModal"
                                                class="fixed inset-0 z-50 hidden overflow-y-auto bg-slate-900/50 p-4 sm:p-6 md:p-20">
                                                <div class="mx-auto max-w-2xl rounded-2xl bg-white p-6 shadow-2xl">
                                                    <div class="flex items-center justify-between mb-4">
                                                        <h3 class="text-lg font-bold text-slate-900">Request Project
                                                            Update</h3>
                                                        <button type="button"
                                                            onclick="document.getElementById('editProjectModal').classList.add('hidden')"
                                                            class="text-slate-400 hover:text-slate-500">
                                                            <i data-lucide="x" class="h-6 w-6"></i>
                                                        </button>
                                                    </div>
                                                    <p class="text-sm text-slate-600 mb-6">Modifying the project will
                                                        revert its status to <span class="font-bold">PLANNED</span> to
                                                        require Admin approval.</p>

                                                    <form action="<%= request.getContextPath() %>/client/project/update"
                                                        method="POST" class="space-y-4">
                                                        <input type="hidden" name="id" value="${selectedProject.id}">

                                                        <div>
                                                            <label
                                                                class="block text-sm font-semibold text-slate-700">Start
                                                                Date</label>
                                                            <input type="date" name="startDate"
                                                                value="${selectedProject.startDate}"
                                                                class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm outline-none focus:border-orange-500"
                                                                ${selectedProject.status !='PLANNED'
                                                                ? 'readonly title=\"Cannot edit start date after project is planned\"'
                                                                : '' }>
                                                        </div>

                                                        <div>
                                                            <label
                                                                class="block text-sm font-semibold text-slate-700">End
                                                                Date</label>
                                                            <input type="date" name="endDate"
                                                                value="${selectedProject.endDate}"
                                                                class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm outline-none focus:border-orange-500">
                                                        </div>

                                                        <div>
                                                            <label
                                                                class="block text-sm font-semibold text-slate-700">Budget
                                                                (NPR)</label>
                                                            <input type="number" name="totalBudget"
                                                                value="${selectedProject.totalBudget}"
                                                                class="mt-1 w-full rounded-lg border border-slate-300 px-3 py-2 text-sm outline-none focus:border-orange-500">
                                                        </div>

                                                        <div
                                                            class="flex justify-between items-center mt-6 pt-4 border-t border-slate-200">
                                                            <button type="submit" name="actionType" value="delete"
                                                                class="text-rose-600 hover:bg-rose-50 px-4 py-2 rounded-lg text-sm font-semibold transition"
                                                                onclick="return confirm('Are you sure you want to request deletion of this project?')">Delete
                                                                Project</button>
                                                            <div class="flex gap-2">
                                                                <button type="button"
                                                                    onclick="document.getElementById('editProjectModal').classList.add('hidden')"
                                                                    class="px-4 py-2 text-sm font-semibold text-slate-600 hover:bg-slate-100 rounded-lg">Cancel</button>
                                                                <button type="submit" name="actionType" value="update"
                                                                    class="px-4 py-2 text-sm font-semibold text-white bg-orange-500 hover:bg-orange-600 rounded-lg">Submit
                                                                    Changes</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </c:if>

                                        <section id="projectList" class="grid gap-4">
                                            <c:forEach var="p" items="${projects}">
                                                <c:set var="statusLabel" value="${p.statusDisplayName}" />
                                                <c:if test="${p.status == 'PLANNED'}">
                                                    <c:set var="statusLabel" value="Admin Approval Required" />
                                                </c:if>
                                                <c:set var="progress" value="0" />
                                                <c:choose>
                                                    <c:when test="${p.status == 'COMPLETED'}">
                                                        <c:set var="progress" value="100" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'IN_PROGRESS'}">
                                                        <c:set var="progress" value="60" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'APPROVED'}">
                                                        <c:set var="progress" value="20" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'ON_HOLD'}">
                                                        <c:set var="progress" value="30" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'PLANNED'}">
                                                        <c:set var="progress" value="10" />
                                                    </c:when>
                                                </c:choose>

                                                <c:set var="badgeClass" value="border-slate-300 bg-slate-100 text-slate-700" />
                                                <c:choose>
                                                    <c:when test="${p.status == 'PLANNED'}">
                                                        <c:set var="badgeClass" value="border-blue-300 bg-blue-100 text-blue-700" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'APPROVED'}">
                                                        <c:set var="badgeClass" value="border-green-300 bg-green-100 text-green-700" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'DENIED'}">
                                                        <c:set var="badgeClass" value="border-red-300 bg-red-100 text-red-700" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'IN_PROGRESS'}">
                                                        <c:set var="badgeClass" value="border-amber-300 bg-amber-100 text-amber-700" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'COMPLETED'}">
                                                        <c:set var="badgeClass" value="border-teal-300 bg-teal-100 text-teal-700" />
                                                    </c:when>
                                                    <c:when test="${p.status == 'ON_HOLD'}">
                                                        <c:set var="badgeClass" value="border-rose-300 bg-rose-100 text-rose-700" />
                                                    </c:when>
                                                </c:choose>

                                                <article
                                                    class="project-card rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_16px_28px_rgba(15,23,42,0.15)] transition duration-200"
                                                    data-search="${p.title} ${p.status} ${p.startDate}">
                                                    <div class="mb-3 flex flex-wrap items-center justify-between gap-2">
                                                        <div class="flex items-center gap-2">
                                                            <h2 class="m-0 text-[34px] font-semibold leading-none">
                                                                ${p.title}</h2>
                                                            <span
                                                                class="rounded-full border ${badgeClass} px-3 py-1 text-xs font-bold">${statusLabel}</span>
                                                        </div>
                                                    </div>
                                                    <p class="m-0 text-sm text-slate-600">${p.description}</p>
                                                    <div
                                                        class="mt-3 flex flex-wrap items-center gap-5 text-sm text-slate-500">
                                                        <span>${p.startDate} - ${empty p.endDate ? 'TBD' :
                                                            p.endDate}</span>
                                                        <span>NPR ${p.totalBudget}</span>
                                                    </div>

                                                    <div class="mt-4">
                                                        <div class="mb-1 flex items-center justify-between text-sm">
                                                            <span class="text-slate-600">Completion</span>
                                                            <span
                                                                class="font-semibold text-amber-600">${progress}%</span>
                                                        </div>
                                                        <div
                                                            class="h-3 w-full overflow-hidden rounded-full bg-slate-200">
                                                            <div class="h-full rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-500"
                                                                style="width: ${progress}%"></div>
                                                        </div>
                                                    </div>

                                                    <a href="<%= request.getContextPath() %>/client/project?id=${p.id}"
                                                        class="mt-4 inline-flex items-center gap-1 text-sm font-semibold text-amber-600 hover:text-amber-700">
                                                        <span>View Details</span>
                                                    </a>
                                                </article>
                                            </c:forEach>
                                            <c:if test="${empty projects}">
                                                <p class="text-slate-500">You have no projects yet.</p>
                                            </c:if>
                                        </section>

                                        <p id="emptySearchState"
                                            class="mt-4 hidden rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-600">
                                            No projects matched your search.</p>
                            </main>
                        </div>
                        <script>
                            (function () {
                                var searchInput = document.getElementById("projectSearchInput");
                                var cards = Array.prototype.slice.call(document.querySelectorAll(".project-card"));
                                var emptyState = document.getElementById("emptySearchState");

                                function filterProjects() {
                                    var query = (searchInput.value || "").toLowerCase().trim();
                                    var visible = 0;

                                    cards.forEach(function (card) {
                                        var searchable = (card.getAttribute("data-search") || "").toLowerCase();
                                        var isMatch = query === "" || searchable.indexOf(query) !== -1;
                                        card.classList.toggle("hidden", !isMatch);
                                        if (isMatch) {
                                            visible += 1;
                                        }
                                    });

                                    emptyState.classList.toggle("hidden", visible !== 0);
                                }

                                if (searchInput) {
                                    searchInput.addEventListener("input", filterProjects);
                                }

                                var notificationButton = document.getElementById("notificationButton");
                                var notificationMenu = document.getElementById("notificationMenu");
                                var notificationBadge = document.getElementById("notificationBadge");
                                var markAllReadButton = document.getElementById("markAllReadButton");

                                function closeNotifications() {
                                    notificationMenu.classList.add("hidden");
                                    notificationButton.setAttribute("aria-expanded", "false");
                                }

                                if (notificationButton && notificationMenu) {
                                    notificationButton.addEventListener("click", function (event) {
                                        event.stopPropagation();
                                        notificationMenu.classList.toggle("hidden");
                                        notificationButton.setAttribute("aria-expanded", notificationMenu.classList.contains("hidden") ? "false" : "true");
                                    });

                                    document.addEventListener("click", function (event) {
                                        if (!notificationMenu.contains(event.target) && event.target !== notificationButton) {
                                            closeNotifications();
                                        }
                                    });

                                    document.addEventListener("keydown", function (event) {
                                        if (event.key === "Escape") {
                                            closeNotifications();
                                        }
                                    });
                                }

                                if (markAllReadButton && notificationBadge) {
                                    markAllReadButton.addEventListener("click", function () {
                                        notificationBadge.classList.add("hidden");
                                        markAllReadButton.textContent = "All caught up";
                                        markAllReadButton.disabled = true;
                                    });
                                }

                                var userMenuButton = document.getElementById("userMenuButton");
                                var userMenu = document.getElementById("userMenu");

                                function closeUserMenu() {
                                    userMenu.classList.add("hidden");
                                    userMenuButton.setAttribute("aria-expanded", "false");
                                }

                                if (userMenuButton && userMenu) {
                                    userMenuButton.addEventListener("click", function (event) {
                                        event.stopPropagation();
                                        userMenu.classList.toggle("hidden");
                                        userMenuButton.setAttribute("aria-expanded", userMenu.classList.contains("hidden") ? "false" : "true");
                                    });

                                    document.addEventListener("click", function (event) {
                                        if (!userMenu.contains(event.target) && event.target !== userMenuButton) {
                                            closeUserMenu();
                                        }
                                    });

                                    document.addEventListener("keydown", function (event) {
                                        if (event.key === "Escape") {
                                            closeUserMenu();
                                        }
                                    });
                                }
                            })();
                        </script>
                    </body>

                    </html>