<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Material Management - BuildTrack</title>
    <style>
    </style>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen flex">
    <div class="fixed inset-y-0 left-0 w-56 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-56 flex flex-1 flex-col overflow-y-auto">

        <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
            <jsp:include page="../common/adminTopbar.jsp" />
        </div>

        <main class="flex-1 p-6">

            <div class="flex items-center justify-between mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Material Management</h1>
                    <p class="text-slate-500 mt-1">Manage inventory, stock, and usage logs.</p>
                </div>
                <div class="flex gap-3">
                    <a id="logUsageBtn" href="<%= request.getContextPath() %>/admin/materials?action=log-form" onclick="window.location.href='<%= request.getContextPath() %>/admin/materials?action=log-form'; return false;" class="flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                        <i data-lucide="clipboard-list" class="h-4 w-4"></i>
                        Log Usage
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/materials?action=new" class="flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">
                        <i data-lucide="plus" class="h-4 w-4"></i>
                        Add Material
                    </a>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Items" />
                     <jsp:param name="value" value="32" />
                    <jsp:param name="icon" value="boxes" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Low Stock Alerts" />
                    <jsp:param name="value" value="5" />
                    <jsp:param name="icon" value="triangle-alert" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Stock Value" />
                    <jsp:param name="value" value="Rs 16.8L" />
                    <jsp:param name="icon" value="badge-indian-rupee" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Used This Month" />
                    <jsp:param name="value" value="Rs 3.4L" />
                    <jsp:param name="icon" value="trending-down" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                </jsp:include>
            </div>

            <!-- Main Content Grid -->
            <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">

                <!-- Left Column: Material Catalogue (2/3 width) -->
                <div class="xl:col-span-2 space-y-4">
                    <div class="bg-white border border-slate-200 rounded-xl p-4 shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <h2 class="font-bold text-slate-800">Material Catalogue</h2>
                            <input type="text" placeholder="Search materials..." class="rounded-lg border border-slate-300 px-3 py-1.5 text-sm outline-none focus:border-orange-300">
                        </div>

                        <!-- Material List -->
                        <div class="space-y-3">

                            <jsp:include page="../common/materialCard.jsp">
                                <jsp:param name="name" value="Cement (PPC)" />
                                <jsp:param name="unit" value="Bags (50kg)" />
                                <jsp:param name="stock" value="150" />
                                <jsp:param name="price" value="Rs 450" />
                                <jsp:param name="totalValue" value="Rs 67,500" />
                                <jsp:param name="status" value="In Stock" />
                                <jsp:param name="icon" value="package" />
                                <jsp:param name="editLink" value="${pageContext.request.contextPath}/admin/materials?action=new" />
                            </jsp:include>
                            <jsp:include page="../common/materialCard.jsp">
                                <jsp:param name="name" value="Iron Rods (TMT)" />
                                <jsp:param name="unit" value="Quintals" />
                                <jsp:param name="stock" value="5" />
                                <jsp:param name="price" value="Rs 7,200" />
                                <jsp:param name="totalValue" value="Rs 36,000" />
                                <jsp:param name="status" value="Low Stock" />
                                <jsp:param name="icon" value="align-justify" />
                                <jsp:param name="iconBg" value="bg-slate-200" />
                                <jsp:param name="editLink" value="${pageContext.request.contextPath}/admin/materials?action=new" />
                            </jsp:include>


                        </div>
                    </div>
                </div>

                <!-- Right Column: Usage Log (1/3 width) -->
                <div class="xl:col-span-1">
                    <div class="bg-white border border-slate-200 rounded-xl p-4 shadow-sm h-full">
                        <h2 class="font-bold text-slate-800 mb-4">Recent Usage Logs</h2>

                        <div class="space-y-4">
                            <jsp:include page="../common/usageLogCard.jsp">
                                <jsp:param name="materialName" value="Cement" />
                                <jsp:param name="projectName" value="Skyline Tower" />
                                <jsp:param name="quantity" value="-50 Bags" />
                                <jsp:param name="admin" value="Rahul" />
                                <jsp:param name="date" value="Today, 10:30 AM" />
                                <jsp:param name="cost" value="Rs 22,500" />
                                <jsp:param name="borderAccent" value="border-orange-400" />
                            </jsp:include>

                            <jsp:include page="../common/usageLogCard.jsp">
                                <jsp:param name="materialName" value="Iron Rods" />
                                <jsp:param name="projectName" value="River Bridge" />
                                <jsp:param name="quantity" value="-2 Quintal" />
                                <jsp:param name="admin" value="Amit" />
                                <jsp:param name="date" value="Yesterday" />
                                <jsp:param name="cost" value="Rs 14,400" />
                                <jsp:param name="borderAccent" value="border-blue-400" />
                            </jsp:include>
                        </div>

                        <button class="w-full mt-4 text-center text-sm font-semibold text-orange-600 hover:text-orange-700">
                            View All History →
                        </button>
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>

<script>
    function toggleModal(id) {
        const modal = document.getElementById(id);
        if (modal.classList.contains('hidden')) {
            modal.classList.remove('hidden');
            modal.classList.add('flex');
        } else {
            modal.classList.add('hidden');
            modal.classList.remove('flex');
        }
    }
    lucide.createIcons();
</script>

</body>
</html>