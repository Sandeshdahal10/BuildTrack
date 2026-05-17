<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/15/2026
  Time: 7:29 PM
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
<article class="project-card fade-up rounded-xl p-5 bg-white border border-slate-200 shadow-sm hover:shadow-md transition-all duration-300"
         data-title="${fn:toLowerCase(param.title)}"
         data-status="${fn:toLowerCase(param.status)}">

    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">

        <div class="flex-1">

            <div class="flex items-center gap-2 mb-1">
                <h3 class="font-bold text-slate-800">
                    ${param.title}
                </h3>

                <c:set var="badgeClass" value="bg-slate-100 text-slate-700" />
                <c:choose>
                    <c:when test="${param.statusRaw == 'PLANNED'}">
                        <c:set var="badgeClass" value="bg-blue-100 text-blue-700" />
                    </c:when>
                    <c:when test="${param.statusRaw == 'APPROVED'}">
                        <c:set var="badgeClass" value="bg-green-100 text-green-700" />
                    </c:when>
                    <c:when test="${param.statusRaw == 'DENIED'}">
                        <c:set var="badgeClass" value="bg-red-100 text-red-700" />
                    </c:when>
                    <c:when test="${param.statusRaw == 'IN_PROGRESS'}">
                        <c:set var="badgeClass" value="bg-amber-100 text-amber-700" />
                    </c:when>
                    <c:when test="${param.statusRaw == 'COMPLETED'}">
                        <c:set var="badgeClass" value="bg-teal-100 text-teal-700" />
                    </c:when>
                    <c:when test="${param.statusRaw == 'ON_HOLD'}">
                        <c:set var="badgeClass" value="bg-rose-100 text-rose-700" />
                    </c:when>
                </c:choose>
                <span class="text-xs font-bold rounded-full px-2 py-0.5 ${badgeClass}">
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



        </div>

        <div class="flex flex-wrap items-center gap-3 mt-4 md:mt-0">
            <c:if test="${param.statusRaw == 'PLANNED' && fn:contains(param.viewLink, '/admin/')}">
                <form action="${pageContext.request.contextPath}/admin/projects" method="POST" class="m-0">
                    <input type="hidden" name="action" value="approve">
                    <input type="hidden" name="projectId" value="${param.projectId}">
                    <button type="submit" class="text-center rounded-lg bg-green-500 px-4 py-2 text-sm font-medium text-white hover:bg-green-600 transition">Approve</button>
                </form>
                <form action="${pageContext.request.contextPath}/admin/projects" method="POST" class="m-0">
                    <input type="hidden" name="action" value="deny">
                    <input type="hidden" name="projectId" value="${param.projectId}">
                    <button type="submit" class="text-center rounded-lg bg-red-500 px-4 py-2 text-sm font-medium text-white hover:bg-red-600 transition">Deny</button>
                </form>
            </c:if>

            <c:if test="${not fn:contains(param.viewLink, '/worker/')}">
                <a href="${param.viewLink}"
                   class="text-center rounded-lg text-gray-600 px-4 py-2 text-sm font-medium hover:bg-gray-50 transition border border-gray-200">
                    View
                </a>
            </c:if>

            <c:if test="${fn:contains(param.editLink, '/admin/')}">
                <a href="${param.editLink}"
                   class="text-center rounded-lg bg-orange-500 px-4 py-2 text-sm font-medium text-white hover:bg-orange-600 transition">
                    Edit
                </a>
            </c:if>
        </div>

    </div>

</article>
</body>
</html>
