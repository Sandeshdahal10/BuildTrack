<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/16/2026
  Time: 8:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            ${fn:toLowerCase(param.status) == 'approved' || fn:toLowerCase(param.status) == 'active'
                ? 'bg-green-100 text-green-700'
                : 'bg-red-100 text-red-600'}" title="Status: ${param.status}">
            ${param.status}
        </span>

        <div class="flex items-center gap-2">

            <a href="${pageContext.request.contextPath}/admin/workers/form?mode=view&id=${param.id}"
               class="text-center rounded-lg text-gray-600 px-4 py-2 text-sm font-medium  hover:bg-gray-50 transition">
                View
            </a>

            <a href="${pageContext.request.contextPath}/admin/workers/form?mode=edit&id=${param.id}"
               class="text-center rounded-lg bg-orange-500 px-4 py-2 text-sm font-medium text-white hover:bg-orange-600 transition">
                Edit
            </a>

            <c:choose>
                <c:when test="${fn:toLowerCase(param.status) == 'deactivated'}">
                    <a href="${pageContext.request.contextPath}/admin/workers?action=activate&id=${param.id}"
                       class="text-xs px-3 py-1.5 bg-green-50 text-green-600 border border-green-200 rounded hover:bg-green-100">
                        Activate
                    </a>
                </c:when>
                <c:when test="${fn:toLowerCase(param.status) == 'pending'}">
                    <a href="${pageContext.request.contextPath}/admin/workers?action=activate&id=${param.id}"
                       class="text-xs px-3 py-1.5 bg-blue-50 text-blue-600 border border-blue-200 rounded hover:bg-blue-100">
                        Approve
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/admin/workers?action=deactivate&id=${param.id}"
                       class="text-xs px-3 py-1.5 bg-red-50 text-red-600 border border-red-200 rounded hover:bg-red-100">
                        Deactivate
                    </a>
                </c:otherwise>
            </c:choose>

        </div>

    </div>
</div>
</body>
</html>
