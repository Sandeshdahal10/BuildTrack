<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Reports & Documents - BuildTrack</title>
    <style>.tab-active { border-color: #f97316; color: #f97316; background-color: #fff7ed; }</style>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen flex">
    <div class="fixed inset-y-0 left-0 w-56 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-56 flex flex-1 flex-col overflow-y-auto">

        <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-6">

            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Reports & Insights</h1>
                    <p class="text-slate-500 mt-1">Analyze budget vs actuals, documents, and client inquiries.</p>
                </div>
                <button class="flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                    <i data-lucide="download" class="h-4 w-4"></i>
                    Export PDF
                </button>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Budget" />
                    <jsp:param name="value" value="Rs 60L" />
                    <jsp:param name="icon" value="calculator" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Utilized" />
                    <jsp:param name="value" value="Rs 31.4L" />
                    <jsp:param name="icon" value="trending-up" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Documents" />
                    <jsp:param name="value" value="18 Files" />
                    <jsp:param name="icon" value="folder" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-blue-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-blue-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Pending Requests" />
                    <jsp:param name="value" value="6" />
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

            <div id="content-budget" class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="bg-white rounded-xl border border-slate-200 p-6 shadow-sm">
                    <h3 class="font-bold text-slate-800 mb-4">Budget vs Actual (Skyline Tower)</h3>
                    <div class="space-y-4">
                        <div>
                            <div class="flex justify-between text-xs mb-1 text-slate-600">
                                <span>Material</span>
                                <span class="font-bold">Rs 12L / Rs 15L</span>
                            </div>
                            <div class="w-full bg-slate-100 rounded-full h-2">
                                <div class="bg-orange-500 h-2 rounded-full" style="width: 80%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-xs mb-1 text-slate-600">
                                <span>Labour</span>
                                <span class="font-bold">Rs 5L / Rs 6L</span>
                            </div>
                            <div class="w-full bg-slate-100 rounded-full h-2">
                                <div class="bg-orange-500 h-2 rounded-full" style="width: 83%"></div>
                            </div>
                        </div>
                        <div>
                            <div class="flex justify-between text-xs mb-1 text-red-600">
                                <span>Equipment</span>
                                <span class="font-bold">Rs 2.5L / Rs 1.5L (Over)</span>
                            </div>
                            <div class="w-full bg-slate-100 rounded-full h-2">
                                <div class="bg-orange-500 h-2 rounded-full" style="width: 100%"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-xl border border-slate-200 p-6 shadow-sm">
                    <h3 class="font-bold text-slate-800 mb-4">Material Usage Summary</h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead>
                            <tr class="text-slate-500 text-left border-b">
                                <th class="pb-2">Material</th>
                                <th class="pb-2">Used</th>
                                <th class="pb-2">Cost</th>
                            </tr>
                            </thead>
                            <tbody class="text-slate-700">
                            <tr class="border-b border-slate-50">
                                <td class="py-2">Cement</td>
                                <td>500 Bags</td>
                                <td class="font-medium">Rs 2.25L</td>
                            </tr>
                            <tr class="border-b border-slate-50">
                                <td class="py-2">Steel Rods</td>
                                <td>20 Tons</td>
                                <td class="font-medium">Rs 6.0L</td>
                            </tr>
                            <tr>
                                <td class="py-2">Bricks</td>
                                <td>50,000</td>
                                <td class="font-medium">Rs 4.0L</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div id="content-documents" class="hidden">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

            <div id="content-inquiries" class="hidden space-y-3">
                <c:forEach var="inq" items="${inquiries}">
                    <jsp:include page="../common/inquiryRow.jsp">
                        <jsp:param name="id" value="${inq.id}" />
                        <jsp:param name="subject" value="${inq.subject}" />
                        <jsp:param name="client" value="${inq.clientName}" />
                        <jsp:param name="project" value="${inq.projectTitle}" />
                        <jsp:param name="date" value="${inq.createdAt}" />
                        <jsp:param name="status" value="${inq.status}" />
                        <jsp:param name="statusStyle" value="${inq.status == 'Resolved' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}" />
                        <jsp:param name="replyLink" value="#" />
                    </jsp:include>
                </c:forEach>
                <c:if test="${empty inquiries}">
                    <p class="text-sm text-slate-500">No inquiries found.</p>
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
    lucide.createIcons();
</script>
</body>
</html>