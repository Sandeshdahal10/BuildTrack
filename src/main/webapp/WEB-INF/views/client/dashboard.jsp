<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "sag";
    String basePath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Client Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 bg-white text-slate-900">
<div class="grid min-h-screen w-full grid-cols-[214px_minmax(0,1fr)] max-[1100px]:grid-cols-1">
    <aside class="flex flex-col border-r border-slate-200 bg-[#062a63] text-[#e8f0ff]">
        <div class="flex items-center gap-2.5 border-b border-white/15 px-3.5 py-3.5 font-bold text-white">
            <div class="grid h-6 w-6 place-items-center rounded-lg bg-gradient-to-br from-amber-300 to-orange-500 shadow-[0_3px_10px_rgba(246,165,35,0.35)]">
                <svg viewBox="0 0 24 24" class="h-3.5 w-3.5 stroke-[#1f2e4d]" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="14" width="6" height="6" rx="1"></rect>
                </svg>
            </div>
            <span class="text-[22px] leading-none">BuildTrack</span>
        </div>

        <nav class="grid gap-1 p-2.5">
            <a class="flex items-center gap-2.5 rounded-lg border border-amber-300/45 bg-amber-400/20 px-2.5 py-2 text-[13px] text-amber-200" href="<%= basePath %>/client/dashboard">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="14" width="6" height="6" rx="1"></rect>
                </svg>
                <span>Dashboard</span>
            </a>
            <a class="flex items-center gap-2.5 rounded-lg border border-transparent px-2.5 py-2 text-[13px] text-[#cfe0ff] hover:bg-white/10 hover:text-white" href="<%= basePath %>/client/project">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M3 7h6l2 2h10v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7z"></path>
                    <path d="M3 7a2 2 0 0 1 2-2h4l2 2"></path>
                </svg>
                <span>My Projects</span>
            </a>
            <a class="flex items-center gap-2.5 rounded-lg border border-transparent px-2.5 py-2 text-[13px] text-[#cfe0ff] hover:bg-white/10 hover:text-white" href="<%= basePath %>/client/budget">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M12 3v18"></path>
                    <path d="M16 7.5c0-1.7-1.8-3-4-3s-4 1.3-4 3 1.5 2.5 4 3 4 1.3 4 3-1.8 3-4 3-4-1.3-4-3"></path>
                </svg>
                <span>Budget</span>
            </a>
            <a class="flex items-center gap-2.5 rounded-lg border border-transparent px-2.5 py-2 text-[13px] text-[#cfe0ff] hover:bg-white/10 hover:text-white" href="#">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <circle cx="12" cy="8" r="3.5"></circle>
                    <path d="M5 20c.8-3.5 3.5-5.5 7-5.5s6.2 2 7 5.5"></path>
                </svg>
                <span>Profile</span>
            </a>
        </nav>

        <div class="mt-auto border-t border-white/20 p-2.5">
            <nav class="grid gap-1">
                <a class="flex items-center gap-2.5 rounded-lg border border-transparent px-2.5 py-2 text-[13px] text-[#cfe0ff] hover:bg-white/10 hover:text-white" href="<%= basePath %>/logout">
                    <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                        <path d="M16 17l5-5-5-5"></path>
                        <path d="M21 12H9"></path>
                    </svg>
                    <span>Logout</span>
                </a>
            </nav>
        </div>
    </aside>

    <main class="bg-white px-5 pb-7 pt-4">
        <div class="mb-3 flex items-center justify-between text-[11px] text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>Thursday, April 16, 2026</div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                <input class="min-w-[205px] rounded-md border border-slate-200 bg-white px-2.5 py-1.5 text-xs text-slate-900 outline-none max-[760px]:min-w-0 max-[760px]:flex-1" type="text" placeholder="Search..." aria-label="Search">
                <button class="relative grid h-7 w-7 place-items-center rounded-full border border-slate-200 bg-white p-0" type="button" aria-label="Notifications">
                    <svg viewBox="0 0 24 24" class="h-3.5 w-3.5 stroke-slate-900" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5"></path>
                        <path d="M9 17a3 3 0 0 0 6 0"></path>
                    </svg>
                    <span class="absolute -right-0.5 -top-0.5 min-w-[14px] rounded-full border border-white bg-amber-500 px-0.5 text-center text-[9px] font-bold leading-3 text-slate-800">1</span>
                </button>
                <div class="flex items-center gap-1.5 rounded-full border border-slate-200 bg-white px-2 py-1">
                    <div class="grid h-6 w-6 place-items-center rounded-full bg-amber-300 text-[11px] font-bold text-slate-700"><%= displayName.substring(0, 1).toUpperCase() %></div>
                    <span class="text-xs text-slate-900"><%= displayName %></span>
                </div>
            </div>
        </div>

        <section class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_16px_30px_rgba(15,23,42,0.12)]">
            <h1 class="m-0 text-[34px] font-bold leading-none">Welcome, <%= displayName %></h1>
            <p class="mt-1 text-xs text-slate-600">Stay updated on your construction projects.</p>
        </section>

        <section class="mt-3.5 grid grid-cols-2 gap-3.5 max-[760px]:grid-cols-1">
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_16px_30px_rgba(15,23,42,0.12)]">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-600">Active Projects</p>
                <p class="mb-0 mt-1 text-4xl font-bold leading-none">2</p>
                <p class="m-0 text-[11px] text-slate-500">Both on track</p>
            </article>
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_16px_30px_rgba(15,23,42,0.12)]">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-600">Budget Spent</p>
                <p class="mb-0 mt-1 text-[40px] font-bold leading-none">&#8377;48.4L / &#8377;82.0L</p>
                <p class="m-0 text-[11px] text-slate-500">59% utilized</p>
            </article>
        </section>

        <section class="mt-3.5 rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_16px_30px_rgba(15,23,42,0.12)]">
            <h2 class="mb-3.5 mt-0 text-base font-bold">Your Projects</h2>

            <div>
                <div class="mb-2 flex items-center justify-between">
                    <div>
                        <p class="m-0 text-sm font-semibold">Skyline Tower Complex</p>
                        <p class="mt-0.5 text-[11px] text-slate-600">12 workers assigned</p>
                    </div>
                    <span class="rounded-full border border-amber-300/60 bg-amber-50 px-2.5 py-0.5 text-[10px] font-bold text-amber-700">In Progress</span>
                </div>
                <div class="mb-1.5 h-2 w-full overflow-hidden rounded-full bg-slate-300/40"><div class="h-full w-[68%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-400"></div></div>
                <div class="flex justify-between text-[10px] text-slate-500">
                    <span>Budget: &#8377;50.0L &nbsp;&nbsp; Spent: &#8377;34.0L</span>
                    <span>68%</span>
                </div>
            </div>

            <div class="mt-4 border-t border-slate-200 pt-4">
                <div class="mb-2 flex items-center justify-between">
                    <div>
                        <p class="m-0 text-sm font-semibold">Green Valley Residency</p>
                        <p class="mt-0.5 text-[11px] text-slate-600">8 workers assigned</p>
                    </div>
                    <span class="rounded-full border border-amber-300/60 bg-amber-50 px-2.5 py-0.5 text-[10px] font-bold text-amber-700">In Progress</span>
                </div>
                <div class="mb-1.5 h-2 w-full overflow-hidden rounded-full bg-slate-300/40"><div class="h-full w-[45%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-400"></div></div>
                <div class="flex justify-between text-[10px] text-slate-500">
                    <span>Budget: &#8377;32.0L &nbsp;&nbsp; Spent: &#8377;14.4L</span>
                    <span>45%</span>
                </div>
            </div>
        </section>

        <section class="mt-3.5 rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-[0_10px_24px_rgba(15,23,42,0.08)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_16px_30px_rgba(15,23,42,0.12)]">
            <h2 class="mb-3.5 mt-0 text-base font-bold">Recent Updates</h2>
            <ul class="m-0 grid list-none gap-4 p-0">
                <li class="grid grid-cols-[18px_minmax(0,1fr)] gap-2.5">
                    <span class="mt-[3px] h-3 w-3 rounded-full border border-slate-300 bg-teal-400"></span>
                    <div>
                        <p class="m-0 text-[13px]">Skyline Tower reached 68% completion milestone</p>
                        <p class="mt-0.5 text-[10px] text-slate-500">2 hours ago</p>
                    </div>
                </li>
                <li class="grid grid-cols-[18px_minmax(0,1fr)] gap-2.5">
                    <span class="mt-[3px] h-3 w-3 rounded-full border border-slate-300 bg-slate-400"></span>
                    <div>
                        <p class="m-0 text-[13px]">Monthly progress report for January is ready</p>
                        <p class="mt-0.5 text-[10px] text-slate-500">1 day ago</p>
                    </div>
                </li>
                <li class="grid grid-cols-[18px_minmax(0,1fr)] gap-2.5">
                    <span class="mt-[3px] h-3 w-3 rounded-full border border-slate-300 bg-amber-600"></span>
                    <div>
                        <p class="m-0 text-[13px]">Budget review meeting scheduled for Feb 5</p>
                        <p class="mt-0.5 text-[10px] text-slate-500">2 days ago</p>
                    </div>
                </li>
                <li class="grid grid-cols-[18px_minmax(0,1fr)] gap-2.5">
                    <span class="mt-[3px] h-3 w-3 rounded-full border border-slate-300 bg-slate-400"></span>
                    <div>
                        <p class="m-0 text-[13px]">Green Valley exterior work started</p>
                        <p class="mt-0.5 text-[10px] text-slate-500">3 days ago</p>
                    </div>
                </li>
            </ul>
        </section>
    </main>
</div>
</body>
</html>
