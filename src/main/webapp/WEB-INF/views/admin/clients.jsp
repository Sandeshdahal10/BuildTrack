<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/15/2026
  Time: 5:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Clients - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">
<div class="h-screen">
    <div class="fixed inset-y-0 left-0 z-30 w-56">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-y-auto">
        <div class="sticky top-0 z-20">
            <jsp:include page="../common/adminTopbar.jsp" />
        </div>

        <main class="flex-1 p-4 sm:p-6 lg:p-8">
            <section>
                <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Clients</h1>
                        <p class="mt-1 text-slate-500">Manage and track all your construction clients.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/clients/form" class="inline-flex items-center gap-2 self-start rounded-lg bg-orange-500 px-5 py-2.5 text-sm font-semibold text-white transition hover:bg-orange-600 sm:self-auto">
                        <i data-lucide="plus" class="h-4 w-4"></i>
                        Add Client
                    </a>
                </div>

                <div class="mb-6 grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-4">
                    <jsp:include page="../common/statsCard.jsp">
                        <jsp:param name="title" value="Total Clients" />
                        <jsp:param name="value" value="${empty userStats ? 0 : userStats.totalClients}" />
                        <jsp:param name="icon" value="user-check" />
                        <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                        <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                    </jsp:include>
                    <jsp:include page="../common/statsCard.jsp">
                        <jsp:param name="title" value="Pending Approvals" />
                        <jsp:param name="value" value="${empty userStats ? 0 : userStats.pendingApprovals}" />
                        <jsp:param name="icon" value="user-plus" />
                        <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-blue-100" />
                        <jsp:param name="iconClass" value="w-5 h-5 text-blue-600" />
                    </jsp:include>
                    <jsp:include page="../common/statsCard.jsp">
                        <jsp:param name="title" value="Approved Workers" />
                        <jsp:param name="value" value="${empty userStats ? 0 : userStats.totalWorkers}" />
                        <jsp:param name="icon" value="star" />
                        <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-amber-100" />
                        <jsp:param name="iconClass" value="w-5 h-5 text-amber-600" />
                    </jsp:include>
                    <jsp:include page="../common/statsCard.jsp">
                        <jsp:param name="title" value="Client Records" />
                        <jsp:param name="value" value="${empty clients ? 0 : clients.size()}" />
                        <jsp:param name="icon" value="user-x" />
                        <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                        <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                    </jsp:include>
                </div>

                <div class="rounded-xl border border-slate-200 bg-white p-3">
                    <div class="flex items-center">

                        <div class="relative w-64">
                            <i data-lucide="search"
                               class="pointer-events-none absolute left-2.5 top-1/2 h-3.5 w-3.5 -translate-y-1/2 text-slate-400"></i>
                            <input type="text"
                                   id="searchBox"
                                   placeholder="Search clients..."
                                   class="w-full rounded-lg border border-slate-300 py-1.5 pl-8 pr-3 text-sm text-slate-800 outline-none focus:border-orange-300" />
                        </div>

                    </div>
                </div>
            </section>
        <section>
            <div class="mt-6 grid grid-cols-1 gap-6 md:grid-cols-2 xl:grid-cols-4">
                <c:forEach var="client" items="${clients}">
                    <c:set var="statusStyle" value="bg-slate-100 text-slate-700" />
                    <c:choose>
                        <c:when test="${client.status == 'APPROVED'}">
                            <c:set var="statusStyle" value="bg-green-100 text-green-700" />
                        </c:when>
                        <c:when test="${client.status == 'PENDING'}">
                            <c:set var="statusStyle" value="bg-blue-100 text-blue-700" />
                        </c:when>
                        <c:when test="${client.status == 'DEACTIVATED'}">
                            <c:set var="statusStyle" value="bg-red-100 text-red-700" />
                        </c:when>
                    </c:choose>
                    <jsp:include page="../common/ClientCard.jsp">
                        <jsp:param name="clientId" value="${client.id}" />
                        <jsp:param name="name" value="${client.fullName}" />
                        <jsp:param name="image" value="https://i.pravatar.cc/150?u=${client.id}" />
                        <jsp:param name="status" value="${client.status}" />
                        <jsp:param name="statusStyle" value="${statusStyle}" />
                        <jsp:param name="email" value="${client.email}" />
                        <jsp:param name="phone" value="${client.phone}" />
                        <jsp:param name="projectCount" value="0" />
                        <jsp:param name="viewLink" value="${pageContext.request.contextPath}/admin/clients/${client.id}" />
                        <jsp:param name="editLink" value="${pageContext.request.contextPath}/admin/clients/${client.id}/edit"/>
                    </jsp:include>
                </c:forEach>
            </div>
        </section>
        </main>
    </div>

    
</div>
<script>
    lucide.createIcons();
</script>
<script>
    document.getElementById("searchBox").addEventListener("keyup", function () {
        let value = this.value.toLowerCase();
        let cards = document.querySelectorAll(".search-item");

        cards.forEach(function (card) {
            let text = card.innerText.toLowerCase();

            if (text.includes(value)) {
                card.style.display = "block";
            } else {
                card.style.display = "none";
            }
        });
    });
</script>
</body>
</html>
