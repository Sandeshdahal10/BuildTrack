<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/15/2026
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
<article class="project-card fade-up rounded-xl p-5 bg-white border border-slate-200 shadow-sm hover:shadow-md transition-all duration-300">

    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">

        <div class="flex-1">

            <div class="flex items-center gap-2 mb-1">
                <h3 class="font-bold text-slate-800">
                    ${param.title}
                </h3>

                <span class="text-xs font-bold rounded-full px-2 py-0.5 bg-slate-100 text-slate-700">
                    ${param.status}
                </span>
            </div>

            <p class="text-sm text-slate-500 mb-3">
                Client: ${param.client}
            </p>

            <div class="flex flex-wrap gap-4 text-xs text-slate-500 mb-4">

                <span class="flex items-center gap-1">
                    <i data-lucide="calendar" class="w-3 h-3"></i>
                    ${param.startDate} - ${param.endDate}
                </span>

                <span class="flex items-center gap-1">
                    <i data-lucide="users" class="w-3 h-3"></i>
                    ${param.workers} Workers
                </span>

                <span class="flex items-center gap-1">
                    <i data-lucide="wallet" class="w-3 h-3"></i>
                    ${param.budget}
                </span>

            </div>

            <div class="w-full">

                <div class="flex justify-between text-xs mb-1">
                    <span class="text-slate-500">Progress</span>
                    <span class="font-bold text-orange-600">${param.progress}%</span>
                </div>

                <div class="h-2 rounded-full bg-slate-100 overflow-hidden">
                    <div class="h-2 rounded-full bg-orange-500"
                         style="width: ${param.progress}%"></div>
                </div>

            </div>

        </div>

        <div class="flex gap-2">
            <a href="${param.viewLink}"
               class="text-center rounded-lg text-gray-600 px-4 py-2 text-sm font-medium  hover:bg-gray-50 transition">
                View
            </a>

            <a href="${param.editLink}"
               class="text-center rounded-lg bg-orange-500 px-4 py-2 text-sm font-medium text-white hover:bg-orange-600 transition">
                Edit
            </a>
        </div>

    </div>

</article>
</body>
</html>
