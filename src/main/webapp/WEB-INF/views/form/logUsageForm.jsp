<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.Material" %>
<%@ page import="java.util.List" %>
<%
    List<Material> materials = (List<Material>) request.getAttribute("materials");
    if (materials == null) {
        materials = java.util.Collections.emptyList();
    }

    String projectIdValue = request.getAttribute("projectId") != null
            ? (String) request.getAttribute("projectId")
            : "";
    String materialIdValue = request.getAttribute("materialId") != null
            ? (String) request.getAttribute("materialId")
            : "";
    String quantityValue = request.getAttribute("quantity") != null
            ? (String) request.getAttribute("quantity")
            : "";
    String usageDateValue = request.getAttribute("usageDate") != null
            ? (String) request.getAttribute("usageDate")
            : "";
    String notesValue = request.getAttribute("notes") != null
            ? (String) request.getAttribute("notes")
            : "";

    List<String> errors = (List<String>) request.getAttribute("errors");
%>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Log Material Usage - BuildTrack</title>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div class="h-screen">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0">
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
                        <h1 class="text-3xl font-bold tracking-tight text-slate-900">Log Material Usage</h1>
                        <p class="mt-2 text-base text-slate-600">Record usage entries to deduct stock and assign project costs.</p>
                    </div>
                    <a href="<%= request.getContextPath() %>/admin/materials" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                        <i data-lucide="arrow-left" class="h-4 w-4"></i>
                        Back to Materials
                    </a>
                </div>
            </section>

            <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm max-w-4xl">
                <% if (errors != null && !errors.isEmpty()) { %>
                <div class="mb-6 rounded-lg border border-red-200 bg-red-50 p-4 text-sm text-red-700">
                    <ul class="list-disc pl-5 space-y-1">
                        <% for (String error : errors) { %>
                        <li><%= error %></li>
                        <% } %>
                    </ul>
                </div>
                <% } %>

                <form action="<%= request.getContextPath() %>/admin/materials?action=log-usage" method="POST" class="space-y-6">

                    <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Project ID <span class="text-red-500">*</span></label>
                            <input type="number" name="projectId" placeholder="e.g., 1"
                                   value="<%= projectIdValue %>"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200" />
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Material <span class="text-red-500">*</span></label>
                            <select name="materialId"
                                    class="w-full rounded-lg border border-slate-300 bg-white px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200">
                                <option value="">Select Material</option>
                                <% for (Material m : materials) { %>
                                <option value="<%= m.getId() %>" <%= String.valueOf(m.getId()).equals(materialIdValue) ? "selected" : "" %>>
                                    <%= m.getName() %> (Stock: <%= m.getTotalStock() != null ? m.getTotalStock().toPlainString() : "0" %> <%= m.getUnit() != null ? m.getUnit() : "" %>)
                                </option>
                                <% } %>
                            </select>
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Quantity Used <span class="text-red-500">*</span></label>
                            <input type="number" name="quantity" placeholder="0" step="0.01"
                                   value="<%= quantityValue %>"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200" />
                            <p class="mt-1 text-xs text-slate-400">This quantity will be deducted from stock.</p>
                        </div>

                        <div>
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Usage Date <span class="text-red-500">*</span></label>
                            <input type="date" name="usageDate"
                                   value="<%= usageDateValue %>"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200" />
                        </div>

                        <div class="md:col-span-2">
                            <label class="mb-2 block text-sm font-semibold text-slate-700">Notes / Remarks</label>
                            <textarea name="notes" rows="3" placeholder="Any specific reason for usage or issue notes..."
                                      class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200"><%= notesValue %></textarea>
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-3 border-t border-slate-200 pt-4">
                        <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                            <i data-lucide="save" class="h-4 w-4"></i>
                            Submit Usage Log
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