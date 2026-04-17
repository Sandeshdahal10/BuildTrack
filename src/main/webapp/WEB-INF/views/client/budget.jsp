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
    String basePath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Budget</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 min-h-screen bg-white text-slate-900">
<div class="grid min-h-screen w-full grid-cols-[220px_minmax(0,1fr)] max-[1100px]:grid-cols-1">
    <aside class="flex min-h-screen flex-col border-r border-white/10 bg-[#041433] text-[#d9e7ff]">
        <div class="flex items-center gap-2.5 border-b border-white/10 px-4 py-4 font-semibold text-white">
            <div class="grid h-8 w-8 place-items-center rounded-lg bg-gradient-to-br from-amber-300 to-orange-500 shadow-[0_4px_14px_rgba(246,165,35,0.4)]">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-[#1f2e4d]" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M3 21h18"></path>
                    <path d="M5 21V8l7-5 7 5v13"></path>
                    <path d="M9 12h6"></path>
                </svg>
            </div>
            <span class="text-[30px] leading-none">BuildTrack</span>
        </div>

        <nav class="grid gap-1 p-3">
            <a class="flex items-center gap-2.5 rounded-xl border border-transparent px-3 py-2.5 text-sm text-[#c8dcff] hover:bg-white/10 hover:text-white" href="<%= basePath %>/client/dashboard">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="14" width="6" height="6" rx="1"></rect>
                </svg>
                <span>Dashboard</span>
            </a>
            <a class="flex items-center gap-2.5 rounded-xl border border-transparent px-3 py-2.5 text-sm text-[#c8dcff] hover:bg-white/10 hover:text-white" href="<%= basePath %>/client/project">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M3 7h6l2 2h10v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7z"></path>
                    <path d="M3 7a2 2 0 0 1 2-2h4l2 2"></path>
                </svg>
                <span>My Projects</span>
            </a>
            <a class="flex items-center gap-2.5 rounded-xl border border-amber-300/45 bg-amber-400/20 px-3 py-2.5 text-sm font-semibold text-amber-200" href="<%= basePath %>/client/budget">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M12 3v18"></path>
                    <path d="M16 7.5c0-1.7-1.8-3-4-3s-4 1.3-4 3 1.5 2.5 4 3 4 1.3 4 3-1.8 3-4 3-4-1.3-4-3"></path>
                </svg>
                <span>Budget</span>
            </a>
            <a class="flex items-center gap-2.5 rounded-xl border border-transparent px-3 py-2.5 text-sm text-[#c8dcff] hover:bg-white/10 hover:text-white" href="#">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <circle cx="12" cy="8" r="3.5"></circle>
                    <path d="M5 20c.8-3.5 3.5-5.5 7-5.5s6.2 2 7 5.5"></path>
                </svg>
                <span>Profile</span>
            </a>
        </nav>

        <div class="mt-auto border-t border-white/10 p-3">
            <a class="flex items-center gap-2.5 rounded-xl border border-transparent px-3 py-2.5 text-sm text-[#c8dcff] hover:bg-white/10 hover:text-white" href="<%= basePath %>/logout">
                <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-current" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                    <path d="M16 17l5-5-5-5"></path>
                    <path d="M21 12H9"></path>
                </svg>
                <span>Logout</span>
            </a>
        </div>
    </aside>

    <main class="min-h-screen bg-white px-5 pb-7 pt-4">
        <div class="mb-4 flex items-center justify-between text-xs text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>
                <p class="m-0">Friday, April 17, 2026</p>
                <p class="m-0 text-[11px]">07:13 PM</p>
            </div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                <input class="min-w-[220px] rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs text-slate-900 placeholder:text-slate-400 outline-none max-[760px]:min-w-0 max-[760px]:flex-1" type="text" placeholder="Search..." aria-label="Search">
                <button class="relative grid h-9 w-9 place-items-center rounded-full border border-slate-200 bg-white p-0" type="button" aria-label="Notifications">
                    <svg viewBox="0 0 24 24" class="h-4 w-4 stroke-slate-900" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5"></path>
                        <path d="M9 17a3 3 0 0 0 6 0"></path>
                    </svg>
                    <span class="absolute -right-0.5 -top-0.5 min-w-[16px] rounded-full border border-white bg-amber-500 px-0.5 text-center text-[9px] font-bold leading-3 text-[#111827]">3</span>
                </button>
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
            <h1 class="m-0 text-5xl font-bold leading-tight text-slate-900 max-[760px]:text-4xl">Budget</h1>
            <p class="mt-1 text-lg text-slate-600">Track project expenditures and budgets</p>
        </section>

        <section class="grid grid-cols-4 gap-4 max-[1200px]:grid-cols-2 max-[640px]:grid-cols-1">
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_18px_30px_rgba(15,23,42,0.2)]">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Total Budget</p>
                <p class="mb-0 mt-1 text-4xl font-bold leading-none text-amber-600">&#8377;82.0L</p>
            </article>
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_18px_30px_rgba(15,23,42,0.2)]">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Total Spent</p>
                <p class="mb-0 mt-1 text-4xl font-bold leading-none">&#8377;48.4L</p>
            </article>
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_18px_30px_rgba(15,23,42,0.2)]">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Remaining</p>
                <p class="mb-0 mt-1 text-4xl font-bold leading-none text-teal-600">&#8377;33.6L</p>
            </article>
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_18px_30px_rgba(15,23,42,0.2)]">
                <p class="m-0 text-[11px] uppercase tracking-wide text-slate-500">Utilization</p>
                <p class="mb-0 mt-1 text-4xl font-bold leading-none">59%</p>
            </article>
        </section>

        <section class="mt-4 rounded-2xl border border-slate-200 bg-white px-5 py-4 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_18px_30px_rgba(15,23,42,0.2)]">
            <h2 class="mb-4 mt-0 text-lg font-bold">Budget vs Expenditure</h2>

            <div>
                <div class="mb-1 flex items-center justify-between text-sm">
                    <span class="font-semibold">Skyline Tower Complex</span>
                    <span class="text-slate-500">&#8377;34.0L / &#8377;50.0L</span>
                </div>
                <div class="h-3 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[68%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-500"></div></div>
                <p class="mt-1 text-xs text-slate-500">68% utilized</p>
            </div>

            <div class="mt-4">
                <div class="mb-1 flex items-center justify-between text-sm">
                    <span class="font-semibold">Green Valley Residency</span>
                    <span class="text-slate-500">&#8377;14.4L / &#8377;32.0L</span>
                </div>
                <div class="h-3 w-full overflow-hidden rounded-full bg-slate-200"><div class="h-full w-[45%] rounded-full bg-gradient-to-r from-amber-400 via-yellow-300 to-teal-500"></div></div>
                <p class="mt-1 text-xs text-slate-500">45% utilized</p>
            </div>
        </section>

        <section class="mt-4 grid grid-cols-2 gap-4 max-[1200px]:grid-cols-1">
            <article class="rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_18px_30px_rgba(15,23,42,0.2)]">
                <h2 class="mb-4 mt-0 text-lg font-bold">Cost Distribution</h2>
                <div class="flex min-h-[300px] flex-col items-center justify-center">
                    <div class="relative h-44 w-44 rounded-full" style="background: conic-gradient(#f59e0b 0deg 162deg, #14b8a6 162deg 284deg, #3b82f6 284deg 338deg, #8b5cf6 338deg 360deg);">
                        <div class="absolute left-1/2 top-1/2 h-24 w-24 -translate-x-1/2 -translate-y-1/2 rounded-full bg-white"></div>
                    </div>
                    <div class="mt-5 flex flex-wrap justify-center gap-3 text-xs text-slate-600">
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-amber-500"></span>Labour</span>
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-teal-500"></span>Material</span>
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-blue-500"></span>Equipment</span>
                        <span class="inline-flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-full bg-violet-500"></span>Miscellaneous</span>
                    </div>
                </div>
            </article>

            <article class="rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_12px_24px_rgba(15,23,42,0.12)] transition duration-200 hover:-translate-y-1 hover:shadow-[0_18px_30px_rgba(15,23,42,0.2)]">
                <h2 class="mb-4 mt-0 text-lg font-bold">Material Cost Breakdown</h2>
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse text-sm">
                        <thead>
                        <tr class="border-b border-slate-200 text-left text-xs uppercase tracking-wide text-slate-500">
                            <th class="px-2 py-2">Material</th>
                            <th class="px-2 py-2">Quantity</th>
                            <th class="px-2 py-2">Cost</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="border-b border-slate-100 hover:bg-slate-50"><td class="px-2 py-2">Cement</td><td class="px-2 py-2">1,200 bags</td><td class="px-2 py-2 font-semibold">&#8377;4,56,000</td></tr>
                        <tr class="border-b border-slate-100 hover:bg-slate-50"><td class="px-2 py-2">Iron Rods</td><td class="px-2 py-2">5,000 kg</td><td class="px-2 py-2 font-semibold">&#8377;2,75,000</td></tr>
                        <tr class="border-b border-slate-100 hover:bg-slate-50"><td class="px-2 py-2">Sand</td><td class="px-2 py-2">30 cu.m</td><td class="px-2 py-2 font-semibold">&#8377;36,000</td></tr>
                        <tr class="border-b border-slate-100 hover:bg-slate-50"><td class="px-2 py-2">Bricks</td><td class="px-2 py-2">25,000 pcs</td><td class="px-2 py-2 font-semibold">&#8377;2,00,000</td></tr>
                        <tr class="border-b border-slate-100 hover:bg-slate-50"><td class="px-2 py-2">Steel Pipes</td><td class="px-2 py-2">80 pcs</td><td class="px-2 py-2 font-semibold">&#8377;6,800</td></tr>
                        <tr class="border-b border-slate-100 hover:bg-slate-50"><td class="px-2 py-2">Paint</td><td class="px-2 py-2">25 cans</td><td class="px-2 py-2 font-semibold">&#8377;70,000</td></tr>
                        <tr class="hover:bg-slate-50"><td class="px-2 py-2">Electrical Wire</td><td class="px-2 py-2">2,000 m</td><td class="px-2 py-2 font-semibold">&#8377;30,000</td></tr>
                        </tbody>
                    </table>
                </div>
            </article>
        </section>
    </main>
</div>
</body>
</html>
