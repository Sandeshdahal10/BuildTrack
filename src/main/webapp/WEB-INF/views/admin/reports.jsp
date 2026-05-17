<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.Project" %>
<%@ page import="com.buildtrack.model.Inquiry" %>
<%@ page import="com.buildtrack.model.MaterialUsage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    java.math.BigDecimal totalBudgetVal = (java.math.BigDecimal) request.getAttribute("totalBudget");
    java.math.BigDecimal totalExpensesVal = (java.math.BigDecimal) request.getAttribute("totalExpenses");
    String formattedTotalBudget = "NPR 0";
    String formattedTotalExpenses = "NPR 0";
    
    if (totalBudgetVal != null) {
        if (totalBudgetVal.compareTo(java.math.BigDecimal.valueOf(100000)) >= 0) {
            formattedTotalBudget = "NPR " + String.format("%.2f", totalBudgetVal.doubleValue() / 100000.0) + "L";
        } else {
            formattedTotalBudget = "NPR " + totalBudgetVal.toString();
        }
    }
    if (totalExpensesVal != null) {
        if (totalExpensesVal.compareTo(java.math.BigDecimal.valueOf(100000)) >= 0) {
            formattedTotalExpenses = "NPR " + String.format("%.2f", totalExpensesVal.doubleValue() / 100000.0) + "L";
        } else {
            formattedTotalExpenses = "NPR " + totalExpensesVal.toString();
        }
    }
%>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Reports & Documents - BuildTrack</title>
    <style>.tab-active { border-color: #f97316; color: #f97316; background-color: #fff7ed; }</style>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen flex">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 overflow-hidden flex-1 flex flex-col overflow-y-auto">

        <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-6">

            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800 font-semibold">Reports & Insights</h1>
                    <p class="text-slate-500 mt-1">Analyze budget vs actuals, documents, and client inquiries.</p>
                </div>
                <button class="flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                    <i data-lucide="download" class="h-4 w-4"></i>
                    Export PDF
                </button>
            </div>

            <!-- Dynamic Stats Summary Grid -->
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Budget" />
                    <jsp:param name="value" value="<%= formattedTotalBudget %>" />
                    <jsp:param name="icon" value="calculator" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Utilized Spent" />
                    <jsp:param name="value" value="<%= formattedTotalExpenses %>" />
                    <jsp:param name="icon" value="trending-up" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Documents" />
                    <jsp:param name="value" value="${totalDocuments} Files" />
                    <jsp:param name="icon" value="folder" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-blue-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-blue-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Pending Inquiries" />
                    <jsp:param name="value" value="${pendingInquiries}" />
                    <jsp:param name="icon" value="inbox" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-amber-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-amber-600" />
                </jsp:include>
            </div>

            <div class="flex gap-2 mb-4 border-b border-slate-200 pb-2">
                <button onclick="switchTab('budget')" id="tab-budget" class="tab-active px-4 py-2 text-sm font-semibold rounded-t-lg border-b-2 transition">Budget Reports</button>
                <button onclick="switchTab('documents')" id="tab-documents" class="px-4 py-2 text-sm font-semibold rounded-t-lg text-slate-500 border-b-2 border-transparent transition">Documents</button>
                <button onclick="switchTab('inquiries')" id="tab-inquiries" class="px-4 py-2 text-sm font-semibold rounded-t-lg text-slate-500 border-b-2 border-transparent transition">Inquiries</button>
            </div>

            <!-- Tab: Budget Reports -->
            <div id="content-budget" class="space-y-6">
                <!-- Project Selector & Aggregates -->
                <div class="bg-white border border-slate-200 rounded-xl p-4 shadow-sm flex items-center justify-between gap-4 flex-wrap">
                    <div class="flex items-center gap-3">
                        <span class="text-sm font-bold text-slate-600">Select Project:</span>
                        <form action="<%= request.getContextPath() %>/admin/reports" method="GET" id="projectReportForm" class="m-0 flex items-center gap-3">
                            <select name="pid" onchange="this.form.submit()" class="rounded-lg border border-slate-300 bg-white p-2 text-xs font-bold text-slate-700 outline-none focus:ring-1 focus:ring-orange-500">
                                <c:forEach var="proj" items="${projects}">
                                    <option value="${proj.id}" ${proj.id == projectId ? 'selected' : ''}>${proj.title}</option>
                                </c:forEach>
                            </select>
                        </form>
                    </div>
                    
                    <c:if test="${not empty singleReport}">
                        <div class="flex items-center gap-6 text-xs">
                            <div>
                                <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px]">Project Budget</span>
                                <span class="text-slate-800 font-extrabold text-sm">NPR ${singleReport.budget}</span>
                            </div>
                            <div class="border-l border-slate-200 h-8"></div>
                            <div>
                                <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px]">Actual Spent</span>
                                <span class="text-orange-600 font-extrabold text-sm font-bold">NPR ${singleReport.actualCost}</span>
                            </div>
                            <div class="border-l border-slate-200 h-8"></div>
                            <div>
                                <span class="text-slate-400 font-bold uppercase tracking-wider block text-[10px]">Remaining</span>
                                <span class="text-emerald-600 font-extrabold text-sm">NPR ${singleReport.remaining}</span>
                            </div>
                        </div>
                    </c:if>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Left: Budget Breakdown Progress Bars -->
                    <div class="bg-white rounded-xl border border-slate-200 p-6 shadow-sm">
                        <h3 class="font-bold text-slate-800 mb-4 flex items-center gap-1.5"><i data-lucide="pie-chart" class="w-4 h-4 text-orange-500"></i> Expense Category Breakdown: <span class="text-orange-500">${projectTitle}</span></h3>
                        
                        <div class="space-y-4">
                            <c:set var="budget" value="${singleReport.budget > 0 ? singleReport.budget : 1}" />
                            <c:forEach var="cat" items="${expenseCategories}">
                                <c:set var="pct" value="${(cat.totalCost / budget) * 100}" />
                                <c:if test="${pct > 100}"><c:set var="pct" value="100" /></c:if>
                                <div>
                                    <div class="flex justify-between text-xs mb-1 text-slate-600">
                                        <span class="font-bold text-slate-800">${cat.name} (${cat.type})</span>
                                        <span class="font-extrabold text-slate-700">NPR ${cat.totalCost}</span>
                                    </div>
                                    <div class="w-full bg-slate-100 rounded-full h-2">
                                        <div class="bg-orange-500 h-2 rounded-full" style="width: ${pct}%"></div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty expenseCategories}">
                                <p class="text-xs text-slate-500 text-center py-6">No materials used or expenses logged for this project.</p>
                            </c:if>
                        </div>
                    </div>

                    <!-- Right: Material usage summary -->
                    <div class="bg-white rounded-xl border border-slate-200 p-6 shadow-sm">
                        <h3 class="font-bold text-slate-800 mb-4 flex items-center gap-1.5"><i data-lucide="package" class="w-4 h-4 text-orange-500"></i> Material Usage Detail</h3>
                        <div class="overflow-x-auto">
                            <table class="w-full text-sm">
                                <thead>
                                <tr class="text-slate-500 text-left border-b border-slate-100">
                                    <th class="pb-2 font-bold text-xs">Material</th>
                                    <th class="pb-2 font-bold text-xs">Used</th>
                                    <th class="pb-2 font-bold text-xs text-right">Cost</th>
                                </tr>
                                </thead>
                                <tbody class="text-slate-700">
                                <c:forEach var="item" items="${usageSummary}">
                                    <tr class="border-b border-slate-50 hover:bg-slate-50/50 transition">
                                        <td class="py-2.5 font-bold text-slate-800">${item.materialName}</td>
                                        <td class="py-2.5 text-xs text-slate-500 font-semibold">${item.quantityUsed} ${item.materialUnit}</td>
                                        <td class="py-2.5 font-extrabold text-slate-900 text-right">NPR ${item.totalCost}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty usageSummary}">
                                    <tr>
                                        <td colspan="3" class="text-xs text-slate-400 text-center py-6">No specific material usage logged yet.</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tab: Documents -->
            <div id="content-documents" class="hidden">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <c:forEach var="doc" items="${documents}">
                        <jsp:include page="../common/documentCard..jsp">
                            <jsp:param name="fileName" value="${doc.fileName}" />
                            <jsp:param name="uploadedBy" value="${doc.clientName}" />
                            <jsp:param name="date" value="${doc.uploadedAt}" />
                        </jsp:include>
                    </c:forEach>
                    <c:if test="${empty documents}">
                        <p class="text-sm text-slate-500">No documents found.</p>
                    </c:if>
                </div>
            </div>

            <!-- Tab: Inquiries (Admin CRM reply panel) -->
            <div id="content-inquiries" class="hidden space-y-4">
                <h2 class="text-lg font-bold text-slate-800 flex items-center gap-2 mb-1">
                    <i data-lucide="inbox" class="w-5 h-5 text-orange-500"></i> Client Support Requests
                </h2>
                
                <c:forEach var="inq" items="${inquiries}">
                    <jsp:include page="../common/inquiryRow.jsp">
                        <jsp:param name="id" value="${inq.id}" />
                        <jsp:param name="subject" value="${inq.subject}" />
                        <jsp:param name="client" value="${inq.clientName}" />
                        <jsp:param name="project" value="${inq.projectTitle}" />
                        <jsp:param name="date" value="${inq.createdAt}" />
                        <jsp:param name="status" value="${inq.status}" />
                        <jsp:param name="message" value="${inq.message}" />
                        <jsp:param name="reply" value="${inq.adminReply}" />
                    </jsp:include>
                </c:forEach>
                <c:if test="${empty inquiries}">
                    <div class="rounded-xl border border-dashed border-slate-200 bg-white p-8 text-center">
                        <p class="text-sm text-slate-500">No customer support requests or inquiries logged.</p>
                    </div>
                </c:if>
            </div>

        </main>
    </div>
</div>

<script>
    function switchTab(tabName) {
        document.getElementById('content-budget').classList.add('hidden');
        document.getElementById('content-documents').classList.add('hidden');
        document.getElementById('content-inquiries').classList.add('hidden');

        ['budget', 'documents', 'inquiries'].forEach(t => {
            document.getElementById('tab-' + t).classList.remove('tab-active');
            document.getElementById('tab-' + t).classList.add('text-slate-500', 'border-transparent');
        });

        document.getElementById('content-' + tabName).classList.remove('hidden');
        document.getElementById('tab-' + tabName).classList.add('tab-active');
        document.getElementById('tab-' + tabName).classList.remove('text-slate-500', 'border-transparent');

        lucide.createIcons(); // Re-render icons after switch
    }
    
    // Automatically switch tabs if returning from an inquiry update
    (function() {
        // If we are directed to and want to keep inquiries open
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('tab') === 'inquiries') {
            switchTab('inquiries');
        }
    })();
    
    lucide.createIcons();
</script>
</body>
</html>
