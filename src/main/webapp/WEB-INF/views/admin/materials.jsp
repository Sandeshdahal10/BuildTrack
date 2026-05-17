<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="com.buildtrack.model.Material" %>
<%@ page import="com.buildtrack.model.MaterialUsage" %>
<%!
    private String money(BigDecimal value) {
        if (value == null) {
            return "NPR 0.00";
        }
        return "NPR " + value.setScale(2, RoundingMode.HALF_UP).toPlainString();
    }
%>
<%
    List<Material> materials = (List<Material>) request.getAttribute("materials");
    if (materials == null) {
        materials = Collections.emptyList();
    }

    Map<String, Integer> materialStats = (Map<String, Integer>) request.getAttribute("materialStats");
    if (materialStats == null) {
        materialStats = Collections.emptyMap();
    }

    int totalItems = materialStats.getOrDefault("totalMaterials", materials.size());
    int lowStockCount = request.getAttribute("lowStockCount") instanceof Integer
            ? (Integer) request.getAttribute("lowStockCount")
            : materialStats.getOrDefault("lowStockCount", 0);

    BigDecimal totalStockValue = request.getAttribute("totalStockValue") instanceof BigDecimal
            ? (BigDecimal) request.getAttribute("totalStockValue")
            : BigDecimal.ZERO;
    BigDecimal usedThisMonth = request.getAttribute("usedThisMonth") instanceof BigDecimal
            ? (BigDecimal) request.getAttribute("usedThisMonth")
            : BigDecimal.ZERO;

    String monthLabel = request.getAttribute("monthLabel") instanceof String
            ? ((String) request.getAttribute("monthLabel"))
            : "THIS MONTH";

    List<MaterialUsage> usageList = (List<MaterialUsage>) request.getAttribute("usageList");
    List<MaterialUsage> recentUsage = (List<MaterialUsage>) request.getAttribute("recentUsage");
    if (recentUsage == null) {
        recentUsage = Collections.emptyList();
    }
    List<MaterialUsage> usageToRender = (usageList != null && !usageList.isEmpty()) ? usageList : recentUsage;

    Object projectId = request.getAttribute("projectId");
    String usageTitle = projectId != null ? "Usage Log (Project #" + projectId + ")" : "Recent Usage Logs";
%>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Material Management - BuildTrack</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen flex">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 w-full max-w-full overflow-hidden flex-1 flex flex-1 flex-col overflow-y-auto">

        <div class="sticky top-0 z-10 border-b border-slate-200 bg-white">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-6">

            <div class="mb-6 flex items-center justify-between">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Material Management</h1>
                    <p class="mt-1 text-slate-500">Manage inventory, stock, and usage logs.</p>
                </div>
                <div class="flex gap-3">
                    <a href="<%= request.getContextPath() %>/admin/materials?action=log-form" class="flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
                        <i data-lucide="clipboard-list" class="h-4 w-4"></i>
                        Log Usage
                    </a>
                    <a href="<%= request.getContextPath() %>/admin/materials?action=new" class="flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600">
                        <i data-lucide="plus" class="h-4 w-4"></i>
                        Add Material
                    </a>
                </div>
            </div>

            <div class="mb-6 grid grid-cols-1 gap-4 md:grid-cols-4">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Items" />
                    <jsp:param name="value" value="<%= String.valueOf(totalItems) %>" />
                    <jsp:param name="icon" value="boxes" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Low Stock Alerts" />
                    <jsp:param name="value" value="<%= String.valueOf(lowStockCount) %>" />
                    <jsp:param name="icon" value="triangle-alert" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Stock Value" />
                    <jsp:param name="value" value="<%= money(totalStockValue) %>" />
                    <jsp:param name="icon" value="badge-indian-rupee" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Used in <%= monthLabel %>" />
                    <jsp:param name="value" value="<%= money(usedThisMonth) %>" />
                    <jsp:param name="icon" value="trending-down" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                </jsp:include>
            </div>

            <div class="grid grid-cols-1 gap-6 xl:grid-cols-3">

                <div class="space-y-4 xl:col-span-2">
                    <div class="rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                        <div class="mb-4 flex items-center justify-between">
                            <h2 class="font-bold text-slate-800">Material Catalogue</h2>
                        </div>

                        <div class="space-y-3">
                            <% if (materials.isEmpty()) { %>
                            <div class="rounded-lg border border-dashed border-slate-300 p-8 text-center text-sm text-slate-500">
                                No materials found. Add your first material to start inventory tracking.
                            </div>
                            <% } %>

                            <% for (Material material : materials) {
                                BigDecimal stock = material.getTotalStock() == null ? BigDecimal.ZERO : material.getTotalStock();
                                BigDecimal unitPrice = material.getUnitPrice() == null ? BigDecimal.ZERO : material.getUnitPrice();
                                BigDecimal itemTotal = stock.multiply(unitPrice);
                                boolean outOfStock = material.isOutOfStock();
                                boolean lowStock = !outOfStock && material.isLowStock();
                                String stockBadgeClass = outOfStock
                                        ? "bg-red-100 text-red-700"
                                        : (lowStock ? "bg-amber-100 text-amber-700" : "bg-emerald-100 text-emerald-700");
                                String stockLabel = outOfStock ? "Out of Stock" : (lowStock ? "Low Stock" : "In Stock");
                            %>
                            <div id="material-card-<%= material.getId() %>" class="rounded-lg border border-slate-200 p-4 transition hover:shadow-sm">
                                <div class="flex flex-col justify-between gap-4 md:flex-row md:items-center">
                                    <div class="min-w-0">
                                        <p class="text-base font-semibold text-slate-800"><%= material.getName() %></p>
                                        <p class="text-xs text-slate-500">Unit: <%= material.getUnit() %></p>
                                    </div>

                                    <div class="grid grid-cols-3 gap-4 text-sm text-slate-700">
                                        <div>
                                            <p class="text-xs text-slate-400">In Stock</p>
                                            <p class="font-bold"><%= stock.toPlainString() %></p>
                                        </div>
                                        <div>
                                            <p class="text-xs text-slate-400">Unit Price</p>
                                            <p class="font-bold"><%= money(unitPrice) %></p>
                                        </div>
                                        <div>
                                            <p class="text-xs text-slate-400">Total Value</p>
                                            <p class="font-bold text-orange-600"><%= money(itemTotal) %></p>
                                        </div>
                                    </div>

                                    <div class="flex items-center gap-2">
                                        <span class="rounded-full px-2.5 py-1 text-xs font-bold <%= stockBadgeClass %>"><%= stockLabel %></span>
                                        <a href="<%= request.getContextPath() %>/admin/materials?action=edit&id=<%= material.getId() %>" class="rounded-lg border border-slate-300 bg-white px-3 py-2 text-xs font-semibold text-slate-700 hover:bg-slate-50">Edit</a>
                                        <button type="button" onclick="openDeleteModal(<%= material.getId() %>)" class="rounded-lg bg-red-500 px-3 py-2 text-xs font-semibold text-white hover:bg-red-600">Delete</button>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="xl:col-span-1">
                    <div class="h-full rounded-xl border border-slate-200 bg-white p-4 shadow-sm">
                        <h2 class="mb-4 font-bold text-slate-800"><%= usageTitle %></h2>

                        <div class="space-y-3">
                            <% if (usageToRender.isEmpty()) { %>
                            <div class="rounded-lg border border-dashed border-slate-300 p-6 text-center text-sm text-slate-500">
                                No usage records found.
                            </div>
                            <% } %>

                            <% for (MaterialUsage usage : usageToRender) {
                                String qty = usage.getQuantityUsed() == null ? "0" : usage.getQuantityUsed().toPlainString();
                                String unit = usage.getMaterialUnit() == null ? "" : usage.getMaterialUnit();
                            %>
                            <div class="rounded-r-lg border-l-4 border-orange-500 bg-slate-50 p-3">
                                <div class="flex items-start justify-between">
                                    <div>
                                        <p class="text-sm font-semibold text-slate-800"><%= usage.getMaterialName() %></p>
                                        <p class="text-xs text-slate-500"><%= usage.getProjectName() %></p>
                                    </div>
                                    <span class="text-xs font-bold text-orange-600">-<%= qty %> <%= unit %></span>
                                </div>
                                <div class="mt-2 flex items-center gap-2 text-xs text-slate-500">
                                    <span>Admin: <%= usage.getRecordedByName() %></span>
                                    <span>•</span>
                                    <span><%= usage.getUsageDate() %></span>
                                </div>
                                <p class="mt-1 text-xs font-medium text-slate-600">Cost: <%= money(usage.getTotalCost()) %></p>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>

<script>
    lucide.createIcons();
</script>
<!-- Delete Modal -->
<div id="deleteModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-slate-900/50 backdrop-blur-sm">
    <div class="relative w-full max-w-sm rounded-xl bg-white p-6 shadow-xl">
        <div class="mb-4 flex items-center justify-center w-12 h-12 rounded-full bg-red-100 mx-auto">
            <i data-lucide="alert-triangle" class="h-6 w-6 text-red-600"></i>
        </div>
        <h3 class="text-lg font-bold text-slate-800 text-center mb-2">Delete Material</h3>
        <p class="text-sm text-slate-500 text-center mb-6">Are you sure you want to delete this material? This action cannot be undone.</p>
        
        <div class="flex gap-3 justify-center">
            <button onclick="closeDeleteModal()" class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">Cancel</button>
            <button id="confirmDeleteBtn" class="rounded-lg bg-red-500 px-4 py-2 text-sm font-semibold text-white hover:bg-red-600">Delete</button>
        </div>
    </div>
</div>

<script>
    let materialIdToDelete = null;

    function openDeleteModal(id) {
        materialIdToDelete = id;
        document.getElementById('deleteModal').classList.remove('hidden');
        document.getElementById('deleteModal').classList.add('flex');
    }

    function closeDeleteModal() {
        materialIdToDelete = null;
        document.getElementById('deleteModal').classList.add('hidden');
        document.getElementById('deleteModal').classList.remove('flex');
    }

    document.getElementById('confirmDeleteBtn').addEventListener('click', async () => {
        if (!materialIdToDelete) return;
        
        const btn = document.getElementById('confirmDeleteBtn');
        const originalText = btn.innerHTML;
        btn.innerHTML = 'Deleting...';
        btn.disabled = true;

        try {
            const formData = new URLSearchParams();
            formData.append('action', 'delete');
            formData.append('id', materialIdToDelete);

            const response = await fetch('<%= request.getContextPath() %>/admin/materials', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData.toString()
            });

            if (response.ok) {
                const html = await response.text();
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                
                // If the element still exists in the refreshed HTML, it means deletion failed
                if (doc.getElementById('material-card-' + materialIdToDelete)) {
                    alert('Failed to delete material. It may have usage records.');
                } else {
                    const card = document.getElementById('material-card-' + materialIdToDelete);
                    if (card) {
                        card.remove();
                    }
                }
                closeDeleteModal();
            } else {
                alert('Failed to delete material. Please try again.');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('An error occurred while deleting the material.');
        } finally {
            btn.innerHTML = originalText;
            btn.disabled = false;
        }
    });
</script>

</body>
</html>