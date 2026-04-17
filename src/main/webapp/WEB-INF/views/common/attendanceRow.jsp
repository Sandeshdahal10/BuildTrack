<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/17/2026
  Time: 7:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%-- JSTL Taglib --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="flex items-center justify-between p-4 bg-white border border-slate-200 rounded-xl hover:shadow-sm transition">

    <div class="flex items-center gap-4">
        <img src="${param.image}" alt="${param.name}" class="w-10 h-10 rounded-full object-cover border border-slate-100">
        <div>
            <h4 class="text-sm font-bold text-slate-800">${param.name}</h4>
            <p class="text-xs text-slate-500">${param.role} • ${param.project}</p>
        </div>
    </div>

    <div class="flex items-center gap-3">

        <!-- Status Dropdown -->
        <select name="status" class="text-sm border border-slate-300 rounded-lg px-3 py-1.5 outline-none focus:border-orange-400 bg-white cursor-pointer">

            <option value="present"
                    <c:if test="${param.status == 'present'}">selected</c:if>>
                Present
            </option>

            <option value="absent"
                    <c:if test="${param.status == 'absent'}">selected</c:if>>
                Absent
            </option>

            <option value="half-day"
                    <c:if test="${param.status == 'half-day'}">selected</c:if>>
                Half Day
            </option>

        </select>

        <!-- Status Indicator -->
        <span class="hidden md:block w-2.5 h-2.5 rounded-full
            <c:choose>
                <c:when test="${param.status == 'present'}">bg-green-500</c:when>
                <c:when test="${param.status == 'absent'}">bg-red-500</c:when>
                <c:when test="${param.status == 'half-day'}">bg-yellow-400</c:when>
                <c:otherwise>bg-gray-300</c:otherwise>
            </c:choose>
        ">
        </span>

    </div>
</div>
</body>
</html>
