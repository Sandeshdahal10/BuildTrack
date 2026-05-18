<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        /* Card hover animation (match homepage feel) */
        .bt-card {
            transform: translateY(0);
            transition: transform 220ms ease, box-shadow 220ms ease, border-color 220ms ease;
            will-change: transform, box-shadow;
        }

        .bt-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 35px rgba(15, 23, 42, 0.10);
        }

        .bt-card:hover .bt-card-title {
            letter-spacing: 0.2px;
        }

        .bt-card-title {
            transition: letter-spacing 220ms ease;
        }

        .bt-soft-glow-red:hover {
            box-shadow: 0 18px 35px rgba(220, 38, 38, 0.14), 0 8px 14px rgba(15, 23, 42, 0.08);
        }

        .bt-soft-glow-green:hover {
            box-shadow: 0 18px 35px rgba(22, 163, 74, 0.14), 0 8px 14px rgba(15, 23, 42, 0.08);
        }

        .bt-soft-glow-orange:hover {
            box-shadow: 0 18px 35px rgba(234, 88, 12, 0.16), 0 8px 14px rgba(15, 23, 42, 0.08);
        }
    </style>
</head>
<body class="bg-gray-50 text-slate-900 font-sans antialiased">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-14">
    <div class="mb-8">
        <a href="${pageContext.request.contextPath}/"
           class="inline-flex items-center gap-2 rounded-full bg-white px-5 py-2.5 text-sm font-semibold text-[#ea580c] shadow-md ring-1 ring-slate-200 transition hover:-translate-y-0.5 hover:shadow-lg">
            <span aria-hidden="true">←</span>
            Back to Home
        </a>
    </div>

    <header class="mb-10">
        <p class="text-[#ea580c] font-extrabold text-4xl sm:text-5xl tracking-tight uppercase">
            ABOUT US
        </p>
        <h1 class="text-4xl sm:text-5xl font-bold text-slate-900 mt-4 leading-tight">Built for construction teams that need clarity.</h1>
        <p class="text-lg text-slate-600 mt-4 max-w-3xl">BuildTrack is a web-based construction management system that replaces scattered updates with one source of truth across site, office, and client communication.</p>
    </header>

    <section class="space-y-10">
        <!-- Comparison -->
        <div>
            <div class="flex items-end justify-between gap-6 mb-4">
                <div>
                    <h2 class="text-2xl font-bold text-slate-900">Comparison at a glance</h2>
                    <p class="text-slate-600 mt-1">Clear problems on the left. Clear fixes on the right.</p>
                </div>
                <div class="hidden sm:flex items-center gap-2 text-xs font-semibold text-slate-500">

                </div>
            </div>

            <div class="grid md:grid-cols-2 gap-8">
                <div class="bt-card bt-soft-glow-red rounded-2xl bg-gradient-to-br from-rose-50 to-white ring-1 ring-rose-100 p-7">
                    <div class="flex items-center justify-between">
                        <h3 class="bt-card-title text-xl font-bold text-rose-800">PROBLEMS</h3>

                    </div>
                    <div class="h-px bg-rose-100 my-4"></div>
                    <ul class="mt-2 space-y-2 text-rose-900/90 font-medium">
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-rose-500">•</span><span>Fragmented information</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-rose-500">•</span><span>No real-time cost</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-rose-500">•</span><span>Manual payroll errors</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-rose-500">•</span><span>Stakeholder misalignment</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-rose-500">•</span><span>Low accountability</span></li>
                    </ul>

                </div>

                <div class="bt-card bt-soft-glow-green rounded-2xl bg-gradient-to-br from-emerald-50 to-white ring-1 ring-emerald-100 p-7">
                    <div class="flex items-center justify-between">
                        <h3 class="bt-card-title text-xl font-bold text-emerald-800">BuildTrack Solutions</h3>

                    </div>
                    <div class="h-px bg-emerald-100 my-4"></div>
                    <ul class="mt-2 space-y-2 text-emerald-900/90 font-medium">
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-emerald-600">•</span><span>Centralized workspace</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-emerald-600">•</span><span>Budget vs actual</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-emerald-600">•</span><span>Attendance to payroll</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-emerald-600">•</span><span>Role-based dashboards</span></li>
                        <li class="flex items-start gap-2"><span class="mt-0.5 text-emerald-600">•</span><span>Audit-ready reporting</span></li>
                    </ul>

                </div>
            </div>
        </div>

        <!-- Who it's for -->
        <div class="bt-card bt-soft-glow-orange rounded-2xl bg-white ring-1 ring-slate-100 p-7">
            <h2 class="bt-card-title text-xl font-bold text-slate-900">👥 Who It’s For</h2>
            <div class="h-px bg-slate-100 my-4"></div>
            <div class="grid sm:grid-cols-2 gap-4 text-slate-700">
                <div class="rounded-xl bg-slate-50 ring-1 ring-slate-100 p-4">
                    <p class="font-semibold text-slate-900">Admins</p>
                    <p class="text-sm text-slate-600 mt-1">Projects, budgets, payroll, reporting.</p>
                </div>
                <div class="rounded-xl bg-slate-50 ring-1 ring-slate-100 p-4">
                    <p class="font-semibold text-slate-900">Workers</p>
                    <p class="text-sm text-slate-600 mt-1">Attendance, tasks, daily execution.</p>
                </div>
                <div class="rounded-xl bg-slate-50 ring-1 ring-slate-100 p-4">
                    <p class="font-semibold text-slate-900">Clients</p>
                    <p class="text-sm text-slate-600 mt-1">Progress, transparency, confidence.</p>
                </div>
                <div class="rounded-xl bg-slate-50 ring-1 ring-slate-100 p-4">
                    <p class="font-semibold text-slate-900">Project Teams</p>
                    <p class="text-sm text-slate-600 mt-1">Single source of truth.</p>
                </div>
            </div>
        </div>

        <!-- Visual core features -->
        <div>
            <div class="flex items-end justify-between gap-6 mb-4">
                <div>
                    <h2 class="text-2xl font-bold text-slate-900">Core Features</h2>
                    <p class="text-slate-600 mt-1">Built for day-to-day execution, not demos.</p>
                </div>
            </div>

            <div class="grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
                <div class="bt-card bt-soft-glow-orange rounded-2xl bg-white ring-1 ring-slate-100 p-6">
                    <div class="flex items-center gap-3">
                        <div class="h-11 w-11 rounded-xl bg-orange-100 text-orange-700 flex items-center justify-center text-lg ring-1 ring-orange-200">🔐</div>
                        <div>
                            <p class="bt-card-title font-bold text-slate-900">Role-based access</p>
                            <p class="text-sm text-slate-600">Admin • Worker • Client</p>
                        </div>
                    </div>
                </div>

                <div class="bt-card bt-soft-glow-orange rounded-2xl bg-white ring-1 ring-slate-100 p-6">
                    <div class="flex items-center gap-3">
                        <div class="h-11 w-11 rounded-xl bg-orange-100 text-orange-700 flex items-center justify-center text-lg ring-1 ring-orange-200">📊</div>
                        <div>
                            <p class="bt-card-title font-bold text-slate-900">Project tracking</p>
                            <p class="text-sm text-slate-600">Clear status, fewer surprises</p>
                        </div>
                    </div>
                </div>

                <div class="bt-card bt-soft-glow-orange rounded-2xl bg-white ring-1 ring-slate-100 p-6">
                    <div class="flex items-center gap-3">
                        <div class="h-11 w-11 rounded-xl bg-orange-100 text-orange-700 flex items-center justify-center text-lg ring-1 ring-orange-200">👷</div>
                        <div>
                            <p class="bt-card-title font-bold text-slate-900">Attendance → payroll</p>
                            <p class="text-sm text-slate-600">Automation-ready records</p>
                        </div>
                    </div>
                </div>

                <div class="bt-card bt-soft-glow-orange rounded-2xl bg-white ring-1 ring-slate-100 p-6">
                    <div class="flex items-center gap-3">
                        <div class="h-11 w-11 rounded-xl bg-orange-100 text-orange-700 flex items-center justify-center text-lg ring-1 ring-orange-200">🧾</div>
                        <div>
                            <p class="bt-card-title font-bold text-slate-900">Expenses & materials</p>
                            <p class="text-sm text-slate-600">Track costs as they happen</p>
                        </div>
                    </div>
                </div>

                <div class="bt-card bt-soft-glow-orange rounded-2xl bg-white ring-1 ring-slate-100 p-6">
                    <div class="flex items-center gap-3">
                        <div class="h-11 w-11 rounded-xl bg-orange-100 text-orange-700 flex items-center justify-center text-lg ring-1 ring-orange-200">⚖️</div>
                        <div>
                            <p class="bt-card-title font-bold text-slate-900">Budget vs actual</p>
                            <p class="text-sm text-slate-600">Early warning visibility</p>
                        </div>
                    </div>
                </div>

                <div class="bt-card bt-soft-glow-orange rounded-2xl bg-white ring-1 ring-slate-100 p-6">
                    <div class="flex items-center gap-3">
                        <div class="h-11 w-11 rounded-xl bg-orange-100 text-orange-700 flex items-center justify-center text-lg ring-1 ring-orange-200">🛡️</div>
                        <div>
                            <p class="bt-card-title font-bold text-slate-900">Secure by default</p>
                            <p class="text-sm text-slate-600">Auth, sessions, MVC backend</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>

