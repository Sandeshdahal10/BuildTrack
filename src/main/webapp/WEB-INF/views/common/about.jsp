<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-slate-900 font-sans antialiased">

<nav class="bg-white/80 backdrop-blur-md border-b border-slate-100">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-20 items-center">
            <a href="${pageContext.request.contextPath}/" class="flex items-center">
                <div class="bg-[#ea580c] rounded-xl p-2 mr-3 h-10 w-10 flex items-center justify-center shadow-md">
                    <span class="text-white text-xs font-bold tracking-wide">BT</span>
                </div>
                <span class="font-extrabold text-2xl text-[#ea580c] tracking-tight">BuildTrack</span>
            </a>
            <a href="${pageContext.request.contextPath}/login"
               class="inline-flex items-center justify-center bg-[#ea580c] text-white font-semibold text-base px-6 py-2.5 rounded-lg shadow-md hover:bg-[#c2410c] hover:shadow-lg transition-all duration-200 transform hover:-translate-y-0.5">
                Log in
            </a>
        </div>
    </div>
</nav>

<main class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-14">
    <header class="mb-10">
        <span class="px-4 py-1.5 rounded-full text-xs font-bold text-orange-800 bg-orange-100 inline-block tracking-widest uppercase shadow-sm">
            About Us
        </span>
        <h1 class="text-4xl sm:text-5xl font-bold text-slate-900 mt-4 leading-tight">Built for construction teams that need clarity.</h1>
        <p class="text-lg text-slate-600 mt-4">BuildTrack is a web-based construction management system designed to bring structure to projects that are usually managed across spreadsheets, chat threads, and disconnected field notes.</p>
    </header>

    <section class="prose prose-slate max-w-none">
        <p>
            Construction operations break down when information lives in too many places: project status is unclear, materials are ordered without visibility, attendance is tracked manually, and financial reporting arrives too late to prevent cost overruns. That leads to avoidable delays, payroll errors, and difficult client conversations because the numbers and the site reality are never aligned.
        </p>
        <p>
            BuildTrack solves these gaps by centralizing execution around role-based access control for Admin, Worker, and Client users. Admins manage projects with clear status tracking, monitor budgets against actual expenses, and maintain reliable material and cost records. Workers can record attendance and work activity consistently, enabling payroll automation that reduces repetitive processing and improves accuracy. Clients get a dedicated dashboard for transparent monitoring, so progress, timeline changes, and cost movement are visible without back-and-forth.
        </p>
        <p>
            Security and reliability are treated as core product requirements, not afterthoughts. BuildTrack uses secure authentication and session management, and its backend follows a structured Java MVC architecture with a database-driven design that keeps data consistent and auditable. The result is a system that improves accountability, reduces manual administration, and gives construction teams the operational clarity needed to deliver on time and under control.
        </p>
    </section>

    <div class="mt-10">
        <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2 text-[#ea580c] font-semibold hover:text-[#c2410c] transition-colors">
            <span aria-hidden="true">←</span>
            Back to Home
        </a>
    </div>
</main>

<footer class="bg-slate-900 text-slate-200 mt-10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <p class="text-slate-300">© ${pageContext.request.serverName} BuildTrack. All rights reserved.</p>
    </div>
</footer>

</body>
</html>

