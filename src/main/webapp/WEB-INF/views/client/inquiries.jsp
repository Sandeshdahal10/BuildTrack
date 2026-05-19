<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Client Inquiries</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 text-slate-800 antialiased">
<div class="h-screen overflow-hidden">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-hidden">
        <div class="sticky top-0 z-20 shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 overflow-y-auto px-6 py-6">
            <!-- Page Header -->
            <section class="mb-6">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Support Inquiries</h1>
                        <p class="mt-1 text-slate-500">Ask questions, request modifications, or submit feedback regarding your ongoing construction projects.</p>
                    </div>
                </div>
            </section>

            <!-- Feedback Messages -->
            <c:if test="${not empty successMessage}">
                <div class="mb-4 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700 flex items-center gap-2">
                    <i data-lucide="check-circle" class="w-5 h-5 shrink-0 text-emerald-600"></i>
                    <span>${successMessage}</span>
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="mb-4 rounded-xl border border-rose-200 bg-rose-50 px-4 py-3 text-sm text-rose-700 flex items-center gap-2">
                    <i data-lucide="alert-circle" class="w-5 h-5 shrink-0 text-rose-600"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <!-- Two Column Content Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start flex-1 min-h-0">
                <!-- Left: Past inquiries list (7 cols) -->
                <div class="lg:col-span-7 flex flex-col gap-4 max-h-[calc(100vh-250px)] overflow-y-auto pr-1">
                    <h2 class="text-lg font-bold text-slate-700 flex items-center gap-2 mb-1">
                        <i data-lucide="history" class="w-4 h-4 text-slate-500"></i> My Inquiry History
                    </h2>

                    <c:if test="${empty inquiries}">
                        <div class="rounded-2xl border border-dashed border-slate-200 bg-white p-8 text-center">
                            <div class="mx-auto w-12 h-12 rounded-full bg-slate-100 flex items-center justify-center mb-3">
                                <i data-lucide="message-square" class="w-6 h-6 text-slate-400"></i>
                            </div>
                            <h3 class="text-sm font-semibold text-slate-700">No Inquiries Found</h3>
                            <p class="text-xs text-slate-500 mt-1 max-w-sm mx-auto">Submit a new inquiry using the form on the right to get support from our admins.</p>
                        </div>
                    </c:if>

                    <c:forEach var="inq" items="${inquiries}">
                        <div class="rounded-xl border border-slate-200 bg-white p-4 shadow-[0_2px_8px_rgba(15,23,42,0.02)] hover:shadow-md transition">
                            <div class="flex items-center justify-between gap-3 mb-2 flex-wrap">
                                <div>
                                    <span class="text-[11px] font-bold text-orange-600 uppercase bg-orange-50 px-2 py-0.5 rounded-full">${inq.projectTitle}</span>
                                    <h3 class="text-base font-bold text-slate-800 mt-1">${inq.subject}</h3>
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${inq.status == 'RESOLVED' || inq.status == 'COMPLETED'}">
                                            <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-emerald-50 px-2.5 py-1 text-emerald-700 border border-emerald-200">
                                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Completed
                                            </span>
                                        </c:when>
                                        <c:when test="${inq.status == 'IN_PROGRESS'}">
                                            <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-blue-50 px-2.5 py-1 text-blue-700 border border-blue-200">
                                                <span class="w-1.5 h-1.5 rounded-full bg-blue-500 animate-pulse"></span> In Progress
                                            </span>
                                        </c:when>
                                        <c:when test="${inq.status == 'PENDING'}">
                                            <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-amber-50 px-2.5 py-1 text-amber-700 border border-amber-200">
                                                <span class="w-1.5 h-1.5 rounded-full bg-amber-500 animate-pulse"></span> Pending
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-slate-50 px-2.5 py-1 text-slate-600 border border-slate-200">
                                                ${inq.status}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <p class="text-xs text-slate-600 bg-slate-50/50 rounded-lg p-3 border border-slate-100 font-medium whitespace-pre-line leading-relaxed">${inq.message}</p>

                            <div class="mt-2.5 flex items-center justify-between text-[10px] text-slate-400">
                                <span class="flex items-center gap-1"><i data-lucide="clock" class="w-3 h-3"></i> Submitted on ${inq.createdAt}</span>
                            </div>

                            <!-- Admin Reply Card -->
                            <c:if test="${not empty inq.adminReply}">
                                <div class="mt-3.5 rounded-xl border border-blue-100 bg-blue-50/60 p-3 shadow-inner">
                                    <div class="flex items-center gap-1.5 text-xs font-bold text-blue-800 mb-1">
                                        <i data-lucide="shield-check" class="w-4 h-4 text-blue-600"></i>
                                        <span>Administrator Response</span>
                                    </div>
                                    <p class="text-xs text-slate-700 leading-relaxed pl-1 whitespace-pre-line font-medium">${inq.adminReply}</p>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>

                <!-- Right: Submit Inquiry Form (5 cols) -->
                <div class="lg:col-span-5 bg-white rounded-2xl border border-slate-200 p-5 shadow-[0_12px_32px_rgba(15,23,42,0.04)]">
                    <h2 class="text-lg font-bold text-slate-800 flex items-center gap-2 mb-4">
                        <i data-lucide="help-circle" class="w-5 h-5 text-orange-500"></i> Submit New Inquiry
                    </h2>

                    <form method="POST" action="<%= request.getContextPath() %>/client/inquiries" class="space-y-4">
                        <div>
                            <label for="projectId" class="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Select Project <span class="text-rose-500">*</span></label>
                            <select id="projectId" name="projectId" required class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-700 outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition">
                                <option value="">-- Choose a project --</option>
                                <c:forEach var="p" items="${projects}">
                                    <option value="${p.id}">${p.title}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label for="subject" class="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Subject / Topic <span class="text-rose-500">*</span></label>
                            <input type="text" id="subject" name="subject" required placeholder="e.g. Budget variance, timeline delay request"
                                   class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-800 outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition" />
                        </div>

                        <div>
                            <label for="message" class="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Detailed Message <span class="text-rose-500">*</span></label>
                            <textarea id="message" name="message" required rows="6" placeholder="Describe your question, request, or issue in detail..."
                                      class="w-full rounded-lg border border-slate-200 bg-white px-3 py-2 text-xs font-semibold text-slate-800 outline-none focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition"></textarea>
                        </div>

                        <button type="submit" class="w-full inline-flex items-center justify-center gap-2 rounded-lg bg-orange-500 hover:bg-orange-600 px-4 py-2.5 font-bold text-xs text-white shadow-md hover:shadow-lg transition">
                            <i data-lucide="send" class="w-4 h-4"></i> Submit Inquiry
                        </button>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    (function () {
        lucide.createIcons();
    })();
</script>
</body>
</html>
