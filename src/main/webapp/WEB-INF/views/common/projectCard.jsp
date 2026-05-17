<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<article class="project-card fade-up rounded-xl p-5 bg-white border border-slate-200 shadow-sm hover:shadow-md transition-all duration-300 w-full"
         data-title="${fn:toLowerCase(param.title)}"
         data-status="${fn:toLowerCase(param.status)}">

    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 w-full">

        <div class="flex-1 min-w-0">

            <div class="flex flex-wrap items-center gap-2 mb-1.5">
                <h3 class="font-bold text-slate-800 text-lg leading-snug">
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
                <span class="text-xs font-bold rounded-full px-2.5 py-0.5 ${badgeClass}">
                    ${param.status}
                </span>
            </div>

            <p class="text-sm text-slate-500 mb-3 font-medium">
                Client: ${param.client}
            </p>

            <div class="flex flex-wrap gap-x-5 gap-y-2 text-xs text-slate-500 mb-2">

                <span class="flex items-center gap-1.5">
                    <i data-lucide="calendar" class="w-3.5 h-3.5 text-slate-400"></i>
                    ${param.startDate} - ${param.endDate}
                </span>

                <span class="flex items-center gap-1.5">
                    <i data-lucide="users" class="w-3.5 h-3.5 text-slate-400"></i>
                    ${param.workers} Workers
                </span>

                <span class="flex items-center gap-1.5">
                    <i data-lucide="wallet" class="w-3.5 h-3.5 text-slate-400"></i>
                    ${param.budget}
                </span>

            </div>

        </div>

        <div class="flex flex-wrap items-center gap-3 mt-4 md:mt-0 flex-shrink-0">
            <c:if test="${param.statusRaw == 'PLANNED' && fn:contains(param.viewLink, '/admin/')}">
                <form action="${pageContext.request.contextPath}/admin/projects" method="POST" class="m-0">
                    <input type="hidden" name="action" value="approve">
                    <input type="hidden" name="projectId" value="${param.projectId}">
                    <button type="submit" class="text-center rounded-lg bg-green-500 px-4 py-2 text-sm font-semibold text-white hover:bg-green-600 transition shadow-sm">Approve</button>
                </form>
                <form action="${pageContext.request.contextPath}/admin/projects" method="POST" class="m-0">
                    <input type="hidden" name="action" value="deny">
                    <input type="hidden" name="projectId" value="${param.projectId}">
                    <button type="submit" class="text-center rounded-lg bg-red-500 px-4 py-2 text-sm font-semibold text-white hover:bg-red-600 transition shadow-sm">Deny</button>
                </form>
            </c:if>

            <c:if test="${not fn:contains(param.viewLink, '/worker/')}">
                <a href="${param.viewLink}"
                   class="text-center rounded-lg text-slate-600 px-4 py-2 text-sm font-semibold hover:bg-slate-50 transition border border-slate-200 bg-white">
                    View
                </a>
            </c:if>

            <c:if test="${fn:contains(param.editLink, '/admin/')}">
                <a href="${param.editLink}"
                   class="text-center rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600 transition shadow-sm">
                    Edit
                </a>
            </c:if>
        </div>

    </div>

</article>
