<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Client";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | My Projects</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 min-h-screen bg-white text-slate-900">
<div class="grid min-h-screen w-full grid-cols-[224px_minmax(0,1fr)] font-semibold max-[1100px]:grid-cols-1">
    <jsp:include page="../common/clientsidebar.jsp" />

    <main class="min-h-screen bg-white px-5 pb-7 pt-4">
        <div class="mb-4 flex items-center justify-between text-xs text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>
                <p class="m-0">Friday, April 17, 2026</p>
                <p class="m-0 text-[11px]">07:13 PM</p>
            </div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                <input id="projectSearchInput" class="min-w-[220px] rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs text-slate-900 placeholder:text-slate-400 outline-none max-[760px]:min-w-0 max-[760px]:flex-1" type="text" placeholder="Search projects..." aria-label="Search projects">
                <div class="relative">
                <button id="notificationButton" class="relative grid h-9 w-9 place-items-center rounded-full border border-slate-200 bg-white p-0" type="button" aria-label="Notifications" aria-expanded="false" aria-controls="notificationMenu">
                    <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-slate-900" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5"></path>
                        <path d="M9 17a3 3 0 0 0 6 0"></path>
                    </svg>
                    <span id="notificationBadge" class="absolute -right-0.5 -top-0.5 min-w-[16px] rounded-full border border-white bg-amber-500 px-0.5 text-center text-[9px] font-bold leading-3 text-[#111827]">3</span>
                </button>
                <div id="notificationMenu" class="absolute right-0 top-11 z-20 hidden w-72 rounded-xl border border-slate-200 bg-white p-3 shadow-lg">
                    <div class="mb-2 flex items-center justify-between">
                        <p class="m-0 text-sm font-semibold text-slate-900">Notifications</p>
                        <button id="markAllReadButton" class="text-xs font-semibold text-amber-600" type="button">Mark all read</button>
                    </div>
                    <ul class="m-0 list-none space-y-2 p-0 text-xs text-slate-600">
                        <li class="rounded-lg bg-slate-50 px-2.5 py-2">Skyline Tower reached 68% completion.</li>
                        <li class="rounded-lg bg-slate-50 px-2.5 py-2">Green Valley material invoice approved.</li>
                        <li class="rounded-lg bg-slate-50 px-2.5 py-2">Client meeting scheduled for Thursday.</li>
                    </ul>
                </div>
                </div>
                <div class="flex items-center gap-2 rounded-full border border-slate-200 bg-white px-2.5 py-1.5">
                    <div class="grid h-7 w-7 place-items-center rounded-full bg-amber-300 text-xs font-bold text-slate-800"><%= displayName.substring(0, 1).toUpperCase() %></div>
                    <div>
                        <p class="m-0 text-sm font-semibold text-slate-900"><%= displayName %></p>
                        <p class="m-0 text-[11px] text-slate-500">Client</p>
                    </div>
                </div>
            </div>
        </div>

        <section class="mb-4 border-b border-slate-200 pb-4">
            <h1 class="m-0 text-5xl font-semibold leading-tight text-slate-900 max-[760px]:text-4xl">My Projects</h1>
            <p class="mt-1 text-lg text-slate-600">Detailed view of your construction projects</p>
        </section>

        <section id="projectList" class="grid gap-4">
            <article class="project-card rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_16px_28px_rgba(15,23,42,0.15)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_20px_34px_rgba(15,23,42,0.2)]" data-search="skyline tower complex in progress 2025-01-15 2025-12-30 12 workers 50.0l">
                <div class="mb-3 flex flex-wrap items-center justify-between gap-2">
                    <div class="flex items-center gap-2">
                        <h2 class="m-0 text-[34px] font-semibold leading-none">Skyline Tower Complex</h2>
                        <span class="rounded-full border border-amber-300 bg-amber-100 px-3 py-1 text-xs font-bold text-amber-700">In Progress</span>
                    </div>
                </div>
                <p class="m-0 text-sm text-slate-600">A 25-story commercial and residential tower complex in the heart of the city with modern amenities.</p>
                <div class="mt-3 flex flex-wrap items-center gap-5 text-sm text-slate-500">
                    <span>2025-01-15 - 2025-12-30</span>
                    <span>12 workers</span>
                    <span>&#8377;50.0L</span>
                </div>

                <div class="mt-4">
                    <div class="mb-1 flex items-center justify-between text-sm">
                        <span class="text-slate-600">Completion</span>
                        <span class="font-semibold text-amber-600">68%</span>
                    </div>
                    <div class="h-3 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[68%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-500"></div></div>
                </div>

                <div class="mt-4">
                    <p class="mb-1 text-sm text-slate-600">Timeline</p>
                    <div class="h-2 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[68%] rounded-full bg-amber-500"></div></div>
                    <div class="mt-1 flex justify-between text-xs text-slate-500">
                        <span>Start: 2025-01-15</span>
                        <span>End: 2025-12-30</span>
                    </div>
                </div>

                <a href="#" class="mt-4 inline-flex items-center gap-1 text-sm font-semibold text-amber-600 hover:text-amber-700">
                    <span>View Details</span>
                </a>
            </article>

            <article class="project-card rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_16px_28px_rgba(15,23,42,0.15)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_20px_34px_rgba(15,23,42,0.2)]" data-search="green valley residency in progress 2025-02-01 2025-11-15 8 workers 32.0l">
                <div class="mb-3 flex flex-wrap items-center justify-between gap-2">
                    <div class="flex items-center gap-2">
                        <h2 class="m-0 text-[34px] font-semibold leading-none">Green Valley Residency</h2>
                        <span class="rounded-full border border-amber-300 bg-amber-100 px-3 py-1 text-xs font-bold text-amber-700">In Progress</span>
                    </div>
                </div>
                <p class="m-0 text-sm text-slate-600">Premium residential project featuring 40 luxury apartments with green landscaping.</p>
                <div class="mt-3 flex flex-wrap items-center gap-5 text-sm text-slate-500">
                    <span>2025-02-01 - 2025-11-15</span>
                    <span>8 workers</span>
                    <span>&#8377;32.0L</span>
                </div>

                <div class="mt-4">
                    <div class="mb-1 flex items-center justify-between text-sm">
                        <span class="text-slate-600">Completion</span>
                        <span class="font-semibold text-amber-600">45%</span>
                    </div>
                    <div class="h-3 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[45%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-500"></div></div>
                </div>

                <div class="mt-4">
                    <p class="mb-1 text-sm text-slate-600">Timeline</p>
                    <div class="h-2 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[45%] rounded-full bg-amber-500"></div></div>
                    <div class="mt-1 flex justify-between text-xs text-slate-500">
                        <span>Start: 2025-02-01</span>
                        <span>End: 2025-11-15</span>
                    </div>
                </div>

                <a href="#" class="mt-4 inline-flex items-center gap-1 text-sm font-semibold text-amber-600 hover:text-amber-700">
                    <span>View Details</span>
                </a>
            </article>
        </section>

        <p id="emptySearchState" class="mt-4 hidden rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-600">No projects matched your search.</p>
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
    })();
</script>
</body>
</html>
