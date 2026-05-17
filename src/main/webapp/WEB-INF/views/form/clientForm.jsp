<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    com.buildtrack.model.User client = (com.buildtrack.model.User) request.getAttribute("client");

    String mode = (String) request.getAttribute("formMode");
    if (mode == null || mode.trim().isEmpty()) {
        mode = "create";
    }

    String clientId = (String) request.getAttribute("clientId");
    if (clientId == null || clientId.trim().isEmpty()) {
        clientId = request.getParameter("id");
    }

    boolean editMode = "edit".equalsIgnoreCase(mode);
    boolean viewMode = "view".equalsIgnoreCase(mode);
    String pageTitle = viewMode ? "Client Details" : (editMode ? "Edit Client" : "Add Client");
    String submitLabel = editMode ? "Update Client" : "Create Client";

    String fullNameValue = request.getParameter("fullName");
    if ((fullNameValue == null || fullNameValue.isBlank()) && client != null && client.getFullName() != null) {
        fullNameValue = client.getFullName();
    }
    if (fullNameValue == null) fullNameValue = "";

    String emailValue = request.getParameter("email");
    if ((emailValue == null || emailValue.isBlank()) && client != null && client.getEmail() != null) {
        emailValue = client.getEmail();
    }
    if (emailValue == null) emailValue = "";

    String phoneValue = request.getParameter("phone");
    if ((phoneValue == null || phoneValue.isBlank()) && client != null && client.getPhone() != null) {
        phoneValue = client.getPhone();
    }
    if (phoneValue == null) phoneValue = "";

    String lockFields = viewMode ? "readonly" : "";
    String disableInputs = viewMode ? "disabled" : "";
    boolean isPending = client != null && "PENDING".equalsIgnoreCase(client.getStatus());
%>
<html>
<head>
    <title><%= pageTitle %> - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
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
                        <h1 class="text-3xl font-bold tracking-tight text-slate-900"><%= pageTitle %></h1>
                        <p class="mt-2 text-base text-slate-600">
                            <%= viewMode
                                    ? "Review client details."
                                    : (editMode ? "Update client details and project preferences." : "Create a new client profile for your projects.") %>
                        </p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/clients" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                        <i data-lucide="arrow-left" class="h-4 w-4"></i>
                        Back to Clients
                    </a>
                </div>
            </section>

            <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <form method="post" action="${pageContext.request.contextPath}/admin/clients" class="space-y-6">
                    <input type="hidden" name="mode" value="<%= editMode ? "edit" : "create" %>" />
                    <input type="hidden" name="id" value="<%= clientId == null ? "" : clientId %>" />

                    <div class="grid grid-cols-1 gap-5 md:grid-cols-2">
                        <div class="md:col-span-2 border-l-4 border-orange-500 pl-4">
                            <label for="fullName" class="mb-2 block text-sm font-semibold text-slate-700">Full Name</label>
                            <input id="fullName" name="fullName" type="text" required value="<%= fullNameValue %>" placeholder="Enter client name" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label for="email" class="mb-2 block text-sm font-semibold text-slate-700">Email Address</label>
                            <input id="email" name="email" type="email" required value="<%= emailValue %>" placeholder="client@example.com" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label for="phone" class="mb-2 block text-sm font-semibold text-slate-700">Phone Number</label>
                            <input id="phone" name="phone" type="text" required value="<%= phoneValue %>" placeholder="+44 7xxx xxx xxx" <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label for="projectCount" class="mb-2 block text-sm font-semibold text-slate-700">Project Count</label>
                            <input id="projectCount" name="projectCount" type="number" min="0" value="0" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>

                        <div>
                            <label for="progress" class="mb-2 block text-sm font-semibold text-slate-700">Progress (%)</label>
                            <input id="progress" name="progress" type="number" min="0" max="100" value="0" <%= disableInputs %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>" />
                        </div>
                    </div>

                    <div>
                        <label for="notes" class="mb-2 block text-sm font-semibold text-slate-700">Notes</label>
                        <textarea id="notes" name="notes" rows="4" placeholder="Add any client-specific notes..." <%= lockFields %> class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm outline-none transition focus:border-orange-300 focus:ring-2 focus:ring-orange-200 <%= viewMode ? "bg-slate-100" : "" %>"></textarea>
                    </div>

                    <div class="flex flex-wrap items-center gap-3 border-t border-slate-200 pt-4">
                        <% if (viewMode) { %>
                            <% if (isPending) { %>
                                <form method="post" action="${pageContext.request.contextPath}/admin/users" class="inline-flex">
                                    <input type="hidden" name="action" value="approve" />
                                    <input type="hidden" name="id" value="<%= clientId == null ? "" : clientId %>" />
                                    <input type="hidden" name="from" value="clients" />
                                    <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-green-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-green-600">
                                        <i data-lucide="check" class="h-4 w-4"></i>
                                        Approve Client
                                    </button>
                                </form>
                                <form method="post" action="${pageContext.request.contextPath}/admin/users" class="inline-flex">
                                    <input type="hidden" name="action" value="deactivate" />
                                    <input type="hidden" name="id" value="<%= clientId == null ? "" : clientId %>" />
                                    <input type="hidden" name="from" value="clients" />
                                    <button type="submit" class="inline-flex items-center gap-2 rounded-lg border border-red-300 bg-white px-4 py-2 text-sm font-semibold text-red-600 transition hover:bg-red-50">
                                        <i data-lucide="x" class="h-4 w-4"></i>
                                        Deny Approval
                                    </button>
                                </form>
                            <% } %>
                            <a href="${pageContext.request.contextPath}/admin/clients/<%= clientId == null ? "" : clientId %>/edit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                                <i data-lucide="pencil" class="h-4 w-4"></i>
                                Edit Client
                            </a>
                        <% } else { %>
                            <button type="submit" class="inline-flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white transition hover:bg-orange-600">
                                <i data-lucide="save" class="h-4 w-4"></i>
                                <%= submitLabel %>
                            </button>
                            <% if (editMode && !isPending) { %>
                                <button type="submit" form="removeClientForm" class="inline-flex items-center gap-2 rounded-lg border border-red-300 bg-white px-4 py-2 text-sm font-semibold text-red-600 transition hover:bg-red-50">
                                    <i data-lucide="trash-2" class="h-4 w-4"></i>
                                    Remove Client
                                </button>
                            <% } %>
                            <button type="reset" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                                <i data-lucide="rotate-ccw" class="h-4 w-4"></i>
                                Reset
                            </button>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/admin/clients" class="inline-flex items-center gap-2 rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 transition hover:bg-slate-100">
                            <i data-lucide="x" class="h-4 w-4"></i>
                            Cancel
                        </a>
                    </div>
                </form>
                <% if (editMode && !isPending) { %>
                    <form id="removeClientForm" method="post" action="${pageContext.request.contextPath}/admin/users" class="hidden">
                        <input type="hidden" name="action" value="deactivate" />
                        <input type="hidden" name="id" value="<%= clientId == null ? "" : clientId %>" />
                        <input type="hidden" name="from" value="clients" />
                    </form>
                <% } %>
            </section>
        </main>
    </div>
</div>

<script>
    lucide.createIcons();
</script>
</body>
</html>
