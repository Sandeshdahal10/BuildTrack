<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${project.title} - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 antialiased selection:bg-blue-200 selection:text-blue-900">

<div class="flex min-h-screen w-full flex-col lg:flex-row relative overflow-hidden">
    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Content Area -->
    <main class="flex-1 flex flex-col relative z-10 h-screen overflow-hidden bg-slate-50/50">
        <!-- Top Bar -->
        <div class="px-8 pt-6 pb-2 shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <!-- CONTENT -->
        <div class="px-8 py-6 overflow-y-auto grow">
            <div class="max-w-4xl mx-auto pb-12">
                <!-- Back Button -->
                <div class="mb-4">
                    <a href="${pageContext.request.contextPath}/worker/projects" class="inline-flex items-center gap-2 text-sm font-semibold text-blue-600 hover:text-blue-700 transition">
                        <i data-lucide="arrow-left" class="w-4 h-4"></i> Back to Projects
                    </a>
                </div>

                <!-- Project Detail Header -->
                <div class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm mb-6">
                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div>
                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold ${project.statusBadgeClass}">
                                ${project.statusDisplayName}
                            </span>
                            <h1 class="text-3xl font-extrabold tracking-tight text-slate-900 mt-2">${project.title}</h1>
                            <p class="text-sm text-slate-500 font-medium mt-1">Client: <span class="text-slate-800 font-bold">${empty project.clientName ? 'Unassigned' : project.clientName}</span></p>
                        </div>
                        <div class="text-left md:text-right shrink-0">
                            <p class="text-xs text-slate-400 font-semibold uppercase">Total Budget</p>
                            <p class="text-2xl font-black text-slate-900 mt-1">NPR ${project.totalBudget}</p>
                        </div>
                    </div>
                </div>

                <!-- Info Grid -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <!-- Start Date Card -->
                    <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm flex items-center gap-4">
                        <div class="w-10 h-10 rounded-lg bg-green-50 text-green-600 flex items-center justify-center shrink-0">
                            <i data-lucide="calendar" class="w-5 h-5"></i>
                        </div>
                        <div>
                            <p class="text-xs text-slate-400 font-semibold uppercase">Start Date</p>
                            <p class="text-sm font-bold text-slate-800 mt-0.5">${project.startDate}</p>
                        </div>
                    </div>

                    <!-- End Date Card -->
                    <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm flex items-center gap-4">
                        <div class="w-10 h-10 rounded-lg bg-rose-50 text-rose-600 flex items-center justify-center shrink-0">
                            <i data-lucide="calendar-check" class="w-5 h-5"></i>
                        </div>
                        <div>
                            <p class="text-xs text-slate-400 font-semibold uppercase">Estimated End Date</p>
                            <p class="text-sm font-bold text-slate-800 mt-0.5">${empty project.endDate ? '-' : project.endDate}</p>
                        </div>
                    </div>

                    <!-- Team Count Card -->
                    <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm flex items-center gap-4">
                        <div class="w-10 h-10 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center shrink-0">
                            <i data-lucide="users" class="w-5 h-5"></i>
                        </div>
                        <div>
                            <p class="text-xs text-slate-400 font-semibold uppercase">Team Size</p>
                            <p class="text-sm font-bold text-slate-800 mt-0.5">${project.assignedWorkerCount} Workers Assigned</p>
                        </div>
                    </div>
                </div>

                <!-- Description & Details Section -->
                <div class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm mb-6">
                    <h3 class="text-lg font-bold text-slate-800 mb-3">Project Description</h3>
                    <p class="text-slate-600 text-sm leading-relaxed whitespace-pre-wrap">${empty project.description ? 'No project description provided.' : project.description}</p>
                </div>

                <!-- Colleagues / Colleagues on Project -->
                <div class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm mb-6">
                    <h3 class="text-lg font-bold text-slate-800 mb-4">Assigned Team Members</h3>
                    <div class="divide-y divide-slate-100">
                        <c:choose>
                            <c:when test="${empty assignedWorkers}">
                                <p class="text-slate-400 text-sm py-2">No other workers assigned yet.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="aw" items="${assignedWorkers}">
                                    <div class="py-3 flex items-center justify-between">
                                        <div class="flex items-center gap-3">
                                            <div class="w-8 h-8 rounded-full bg-slate-100 text-slate-600 flex items-center justify-center font-bold text-xs uppercase">
                                                ${empty aw.user.fullName ? 'W' : fn:substring(aw.user.fullName, 0, 1)}
                                            </div>
                                            <div>
                                                <p class="text-sm font-semibold text-slate-800">${aw.user.fullName}</p>
                                                <p class="text-xs text-slate-500">${aw.assignedRole}</p>
                                            </div>
                                        </div>
                                        <div class="text-right text-xs text-slate-400 font-medium">
                                            Assigned: ${aw.assignedDate}
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Shared Documents -->
                <div class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h3 class="text-lg font-bold text-slate-800 mb-4">Project Documents</h3>
                    <div class="space-y-3">
                        <c:choose>
                            <c:when test="${empty projectDocuments}">
                                <div class="text-center py-6 text-slate-400 text-sm">
                                    <i data-lucide="file" class="w-8 h-8 mx-auto mb-2 text-slate-300"></i>
                                    No documents shared yet.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="doc" items="${projectDocuments}">
                                    <div class="flex items-center justify-between border border-slate-100 rounded-xl p-3 bg-slate-50/50 hover:bg-slate-50 transition">
                                        <div class="flex items-center gap-3 min-w-0">
                                            <div class="w-10 h-10 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center shrink-0 font-black text-xs uppercase">
                                                ${doc.fileType}
                                            </div>
                                            <div class="min-w-0">
                                                <p class="text-sm font-semibold text-slate-800 truncate" title="${doc.fileName}">${doc.fileName}</p>
                                                <p class="text-xs text-slate-400">
                                                    <fmt:formatNumber type="number" maxFractionDigits="2" value="${doc.fileSize / 1048576.0}" /> MB
                                                </p>
                                            </div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/uploads/${doc.filePath}" target="_blank" class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-white border border-slate-200 hover:border-slate-300 text-slate-700 text-xs font-semibold shadow-sm transition">
                                            <i data-lucide="eye" class="w-3.5 h-3.5"></i> View
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

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
