<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/16/2026
  Time: 8:54 AM
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
<div 
    class="bg-white border border-gray-200 border-l-4 border-orange-500 rounded-xl p-4 flex justify-between items-center flex-wrap gap-4"
    
    data-status="${param.status}"
    data-name="${param.name}"
    data-role="${param.role}"
    data-project="${param.project}"
>

    <div class="flex items-center gap-3 min-w-[220px]">

        <div class="w-10 h-10 flex items-center justify-center rounded-full bg-orange-100 text-orange-700 font-semibold">
            ${param.initials}
        </div>

        <div>
            <p class="text-sm font-semibold text-gray-800">
                ${param.name}
            </p>

            <div class="flex items-center gap-2 mt-1 text-xs text-gray-500 flex-wrap">
                <span class="bg-gray-100 px-2 py-0.5 rounded">
                    ${param.role}
                </span>

                <span>
                    ${param.project}
                </span>
            </div>
        </div>
    </div>


    <div class="flex items-center gap-6 flex-wrap">

        <div class="text-center">
            <p class="text-[10px] uppercase text-gray-400">Projects</p>
            <p class="text-sm font-semibold text-gray-800">
                ${param.projectCount}
            </p>
        </div>

        <div class="text-center">
            <p class="text-[10px] uppercase text-gray-400">Attendance</p>
            <p class="text-sm font-semibold text-green-600">
                ${param.attendance}%
            </p>
        </div>

        <span class="text-xs font-semibold px-3 py-1 rounded-full
            ${param.status == 'Active' 
                ? 'bg-green-100 text-green-700' 
                : 'bg-red-100 text-red-600'}">
            ${param.status}
        </span>

        <div class="flex items-center gap-2">

            <a href="${pageContext.request.contextPath}/admin/workers/form?mode=view&id=${param.id}"
               class="text-xs px-3 py-1.5 border rounded text-gray-600 hover:bg-gray-50">
                View
            </a>

            <a href="${pageContext.request.contextPath}/admin/workers/form?mode=edit&id=${param.id}"
               class="text-xs px-3 py-1.5 bg-orange-500 text-white rounded hover:bg-orange-600">
                Edit
            </a>

            <a href="${pageContext.request.contextPath}/admin/workers?action=deactivate&id=${param.id}"
               class="text-xs px-3 py-1.5 bg-red-50 text-red-600 border border-red-200 rounded hover:bg-red-100">
                Deactivate
            </a>

        </div>

    </div>
</div>
</body>
</html>
