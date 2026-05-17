<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.Material" %>
<%@ page import="com.buildtrack.model.Project" %>
<%@ page import="java.util.List" %>
<%
    Material material = (Material) request.getAttribute("material");
    String idAttr = (String) request.getAttribute("id");
    boolean editMode = material != null || (idAttr != null && !idAttr.isBlank());

    List<Project> projects = (List<Project>) request.getAttribute("projects");
    if (projects == null) {
        projects = java.util.Collections.emptyList();
    }

    Integer materialId = material != null ? material.getId() : null;
    if (materialId == null && idAttr != null && !idAttr.isBlank()) {
        materialId = Integer.parseInt(idAttr);
    }

    String projectIdValue = request.getAttribute("projectId") != null
        ? (String) request.getAttribute("projectId")
        : (material != null && material.getProjectId() != null ? String.valueOf(material.getProjectId()) : "");

    String nameValue = request.getAttribute("name") != null
        ? (String) request.getAttribute("name")
        : (material != null && material.getName() != null ? material.getName() : "");
    String unitValue = request.getAttribute("unit") != null
        ? (String) request.getAttribute("unit")
        : (material != null && material.getUnit() != null ? material.getUnit() : "");
    String unitPriceValue = request.getAttribute("unitPrice") != null
        ? (String) request.getAttribute("unitPrice")
        : (material != null && material.getUnitPrice() != null ? material.getUnitPrice().toPlainString() : "");
    String totalStockValue = request.getAttribute("totalStock") != null
        ? (String) request.getAttribute("totalStock")
        : (material != null && material.getTotalStock() != null ? material.getTotalStock().toPlainString() : "");
    String lowStockValue = request.getAttribute("lowStockThreshold") != null
        ? (String) request.getAttribute("lowStockThreshold")
        : (material != null && material.getLowStockThreshold() != null ? material.getLowStockThreshold().toPlainString() : "");
    String descriptionValue = request.getAttribute("description") != null
        ? (String) request.getAttribute("description")
        : (material != null && material.getDescription() != null ? material.getDescription() : "");

    List<String> errors = (List<String>) request.getAttribute("errors");
%>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title><%= editMode ? "Edit Material" : "Add Material" %> - BuildTrack</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-slate-200 bg-white">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-y-auto w-full max-w-full">
        <div class="sticky top-0 z-20">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 p-4 sm:p-6 lg:p-8">
            <section class="rounded-2xl border border-slate-200 bg-white px-6 py-6 shadow-sm">
                <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
                    <div>
                        <h1 class="text-3xl font-bold tracking-tight text-slate-900"><%= editMode ? "Edit Material" : "Add Material" %></h1>
                        <p class="mt-2 text-base text-slate-600"><%= editMode ? "Update material details in your inventory catalog." : "Create a new material item for stock tracking and usage records." %></p>
                    </div>
                    <a href="<%= request.getContextPath() %>/admin/materials" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                        <i data-lucide="arrow-left" class="h-4 w-4"></i>
                        Back to Materials
                    </a>
                </div>
            </section>

            <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <% if (errors != null && !errors.isEmpty()) { %>
                <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-700">
                    <ul class="list-disc pl-5 space-y-1">
                        <% for (String error : errors) { %>
                        <li><%= error %></li>
                        <% } %>
                    </ul>
                </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/admin/materials?action=<%= editMode ? "update" : "create" %>" method="POST" class="space-y-6">
                    <% if (editMode && materialId != null) { %>
                    <input type="hidden" name="id" value="<%= materialId %>" />
                    <% } %>

                    <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                        <div class="md:col-span-2">
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Project <span class="text-slate-400 font-normal">(Optional - select to link to a project)</span></label>
                            <select name="projectId"
                                    class="w-full rounded-lg border border-slate-300 bg-white px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200">
                                <option value="">General Inventory (No Project)</option>
                                <% for (Project p : projects) { %>
                                <option value="<%= p.getId() %>" <%= String.valueOf(p.getId()).equals(projectIdValue) ? "selected" : "" %>>
                                    <%= p.getTitle() %> (ID: <%= p.getId() %>)
                                </option>
                                <% } %>
                            </select>
                        </div>

                        <div class="md:col-span-2">
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Material Name <span class="text-red-500">*</span></label>
                            <input type="text" name="name" placeholder="e.g., Cement (OPC 53)"
                                   value="<%= nameValue %>"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Unit of Measurement <span class="text-red-500">*</span></label>
                            <select name="unit"
                                    class="w-full rounded-lg border border-slate-300 bg-white px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200">
                                <option value="">Select Unit</option>
                                <option value="kg" <%= "kg".equalsIgnoreCase(unitValue) ? "selected" : "" %>>kg</option>
                                <option value="bag" <%= "bag".equalsIgnoreCase(unitValue) ? "selected" : "" %>>bag</option>
                                <option value="piece" <%= "piece".equalsIgnoreCase(unitValue) ? "selected" : "" %>>piece</option>
                                <option value="m3" <%= "m3".equalsIgnoreCase(unitValue) ? "selected" : "" %>>m3</option>
                                <option value="litre" <%= "litre".equalsIgnoreCase(unitValue) ? "selected" : "" %>>litre</option>
                                <option value="ton" <%= "ton".equalsIgnoreCase(unitValue) ? "selected" : "" %>>ton</option>
                            </select>
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Unit Price <span class="text-red-500">*</span></label>
                            <input type="number" name="unitPrice" placeholder="0.00" step="0.01"
                                   value="<%= unitPriceValue %>"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Initial Stock Quantity <span class="text-red-500">*</span></label>
                            <input type="number" name="totalStock" placeholder="0" step="0.01"
                                   value="<%= totalStockValue %>"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Low Stock Alert Level</label>
                            <input type="number" name="lowStockThreshold" placeholder="e.g., 10" step="0.01"
                                   value="<%= lowStockValue %>"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200" />
                            <p class="mt-1 text-xs text-slate-400">Set threshold to receive low-stock alerts.</p>
                        </div>

                        <div class="md:col-span-2">
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Description / Notes</label>
                            <textarea name="description" rows="4" placeholder="Add specific details (brand, grade, color, etc.)..."
                                      class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200"><%= descriptionValue %></textarea>
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-3 border-t border-slate-200 pt-4">
                        <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                            <i data-lucide="save" class="h-4 w-4"></i>
                            <%= editMode ? "Update Material" : "Save Material" %>
                        </button>
                        <a href="<%= request.getContextPath() %>/admin/materials" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                            <i data-lucide="x" class="h-4 w-4"></i>
                            Cancel
                        </a>
                    </div>
                </form>
            </section>
        </main>
    </div>
</div>

<script> lucide.createIcons(); </script>
</body>
</html>