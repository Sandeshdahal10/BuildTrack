<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.buildtrack.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Worker";
    String basePath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Payslips</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">
<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">
    <!-- Sidebar -->
    <jsp:include page="../common/sidebar.jsp" />

    <!-- Main Content -->
    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden bg-slate-50">
        <!-- Navbar -->
        <div class="w-full shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <!-- CONTENT -->
        <div class="px-8 py-6 overflow-y-auto grow">
            <!-- Title Section -->
            <section class="mb-6">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Payslips</h1>
                        <p class="mt-1 text-slate-500">View your salary slips and earnings.</p>
                    </div>
                </div>
            </section>

            <!-- Payslip List -->
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${empty payslips}">
                        <div class="rounded-2xl border border-slate-200 bg-white p-8 text-center shadow-sm">
                            <p class="text-slate-500 font-medium">No payslips available yet.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="ps" items="${payslips}">
                            <article class="rounded-2xl border border-slate-200 bg-white px-6 py-5 shadow-sm hover:shadow-md transition-all duration-200 hover:-translate-y-0.5 group">
                                <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                                    <div class="flex items-center gap-4">
                                        <div class="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center text-blue-600 group-hover:bg-blue-100 transition-colors">
                                            <i data-lucide="file-text" class="w-6 h-6"></i>
                                        </div>
                                        <div>
                                            <h3 class="text-lg font-bold text-slate-900">${ps.monthYearDisplay} Payslip</h3>
                                            <p class="text-sm font-medium text-slate-500">Status: <span class="${ps.status == 'PAID' ? 'text-green-600' : 'text-amber-600'} font-bold">${ps.status}</span></p>
                                        </div>
                                    </div>
                                    <div class="flex items-center justify-between sm:flex-col sm:items-end gap-2 sm:gap-1">
                                        <p class="text-xl font-bold text-slate-900">NPR ${ps.totalSalary}</p>
                                        <c:if test="${ps.status == 'PAID'}">
                                            <a href="${pageContext.request.contextPath}/worker/payslip/download?id=${ps.payrollId}" class="inline-flex items-center gap-1.5 text-amber-600 text-sm font-bold hover:text-amber-700 hover:underline">
                                                <i data-lucide="download" class="w-4 h-4"></i> Download PDF
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>

<script>
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
</script>
</body>
</html>
