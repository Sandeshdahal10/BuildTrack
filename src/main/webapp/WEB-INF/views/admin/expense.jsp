<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.buildtrack.model.Project" %>
<%@ page import="com.buildtrack.model.Expense" %>
<%
    List<Project> projectsList = (List<Project>) request.getAttribute("projects");
    List<Expense> recentExpensesList = (List<Expense>) request.getAttribute("recentExpenses");
    BigDecimal grandTotal = (BigDecimal) request.getAttribute("grandTotal");
    String displayGrandTotal = (grandTotal != null) ? "NPR " + grandTotal.toString() : "NPR 0";
%>
<html>

    <head>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <title>Expense Management - BuildTrack</title>
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
                            <h1 class="text-2xl font-bold text-slate-800">Expense Management</h1>
                            <p class="text-slate-500 mt-1">Log and track all project expenses.</p>
                        </div>
                        <div class="flex gap-3">
                            <button onclick="openAddModal()"
                                class="flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600 shadow-sm">
                                <i data-lucide="plus-circle" class="h-4 w-4"></i>
                                Log Expense
                            </button>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                        <jsp:include page="../common/statsCard.jsp">
                            <jsp:param name="title" value="Total Expenses" />
                            <jsp:param name="value" value="<%= displayGrandTotal %>" />
                            <jsp:param name="icon" value="trending-down" />
                            <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                            <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                        </jsp:include>
                        <jsp:include page="../common/statsCard.jsp">
                            <jsp:param name="title" value="Material Costs" />
                            <jsp:param name="value" value="NPR 15.8L" />
                            <jsp:param name="icon" value="package" />
                            <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-orange-100" />
                            <jsp:param name="iconClass" value="w-5 h-5 text-orange-600" />
                        </jsp:include>
                        <jsp:include page="../common/statsCard.jsp">
                            <jsp:param name="title" value="Labour Costs" />
                            <jsp:param name="value" value="NPR 10.6L" />
                            <jsp:param name="icon" value="users" />
                            <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-blue-100" />
                            <jsp:param name="iconClass" value="w-5 h-5 text-blue-600" />
                        </jsp:include>
                        <jsp:include page="../common/statsCard.jsp">
                            <jsp:param name="title" value="Misc / Equip" />
                            <jsp:param name="value" value="NPR 5.0L" />
                            <jsp:param name="icon" value="briefcase" />
                            <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-purple-100" />
                            <jsp:param name="iconClass" value="w-5 h-5 text-purple-600" />
                        </jsp:include>
                    </div>

                    <div
                        class="bg-white border border-slate-200 rounded-xl p-4 mb-4 shadow-sm flex flex-wrap gap-3 items-center">
                        <select
                            class="rounded-lg border border-slate-300 p-2 text-sm bg-white outline-none focus:border-orange-300">
                            <option value="">All Projects</option>
                            <% if (projectsList != null) { %>
                                <% for (Project p : projectsList) { %>
                                    <option value="<%= p.getId() %>"><%= p.getTitle() %></option>
                                <% } %>
                            <% } %>
                        </select>
                        <select
                            class="rounded-lg border border-slate-300 p-2 text-sm bg-white outline-none focus:border-orange-300">
                            <option>All Categories</option>
                        </select>
                        <input type="date"
                            class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-300">
                    </div>

                    <div class="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
                        <table class="w-full">
                            <thead class="bg-slate-50 border-b border-slate-200">
                                <tr>
                                    <th class="text-left p-4 font-semibold text-slate-600 text-xs">Date</th>
                                    <th class="text-left p-4 font-semibold text-slate-600 text-xs">Project</th>
                                    <th class="text-left p-4 font-semibold text-slate-600 text-xs">Category</th>
                                    <th class="text-left p-4 font-semibold text-slate-600 text-xs">Description</th>
                                    <th class="text-right p-4 font-semibold text-slate-600 text-xs">Amount</th>
                                    <th class="text-center p-4 font-semibold text-slate-600 text-xs">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (recentExpensesList != null && !recentExpensesList.isEmpty()) { %>
                                    <% for (Expense exp : recentExpensesList) { %>
                                        <jsp:include page="../common/expensRow.jsp">
                                            <jsp:param name="id" value="<%= exp.getId() %>" />
                                            <jsp:param name="projectId" value="<%= exp.getProjectId() %>" />
                                            <jsp:param name="date" value="<%= exp.getExpenseDate() != null ? exp.getExpenseDate().toString() : \"-\" %>" />
                                            <jsp:param name="project" value="<%= exp.getProjectName() != null ? exp.getProjectName() : \"-\" %>" />
                                            <jsp:param name="category" value="<%= exp.getCategory() != null ? exp.getCategory() : \"Other\" %>" />
                                            <jsp:param name="categoryStyle" value="<%= exp.getCategoryBadgeClass() %>" />
                                            <jsp:param name="description" value="<%= exp.getDescription() != null ? exp.getDescription() : \"-\" %>" />
                                            <jsp:param name="amount" value="<%= \"NPR \" + (exp.getAmount() != null ? exp.getAmount().toString() : \"0\") %>" />
                                            <jsp:param name="amountRaw" value="<%= exp.getAmount() != null ? exp.getAmount().toString() : \"\" %>" />
                                        </jsp:include>
                                    <% } %>
                                <% } else { %>
                                    <tr>
                                        <td colspan="6" class="p-4 text-center text-slate-500 text-sm">No expenses logged yet.</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                </main>
            </div>
        </div>

        <div id="expenseModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-black/50">
            <div class="bg-white rounded-2xl shadow-xl w-full max-w-md p-6 m-4">
                <div class="flex items-center justify-between mb-4">
                    <h3 id="modalTitle" class="text-lg font-bold text-slate-900">Log Expense</h3>
                    <button onclick="toggleModal('expenseModal')" class="text-slate-400 hover:text-slate-600"><i
                            data-lucide="x" class="w-5 h-5"></i></button>
                </div>
                <form id="expenseForm" method="POST" action="<%= request.getContextPath() %>/admin/expenses?action=create" class="space-y-4">
                    <input type="hidden" id="expenseId" name="id" value="">
                    <div>
                        <label class="text-sm font-medium text-slate-700">Project <span class="text-rose-500">*</span></label>
                        <select id="projectIdSelect" name="projectId" required
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300 bg-white">
                            <% if (projectsList != null && !projectsList.isEmpty()) { %>
                                <% for (Project p : projectsList) { %>
                                    <option value="<%= p.getId() %>"><%= p.getTitle() %></option>
                                <% } %>
                            <% } else { %>
                                <option value="">No Active Projects Found</option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700">Category <span class="text-rose-500">*</span></label>
                        <select id="categorySelect" name="category" required
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300 bg-white">
                            <option value="Material">Material</option>
                            <option value="Labour">Labour</option>
                            <option value="Equipment">Equipment</option>
                            <option value="Rent">Rent</option>
                            <option value="Transport">Transport</option>
                            <option value="Utilities">Utilities</option>
                            <option value="Permits">Permits</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700">Amount (NPR) <span class="text-rose-500">*</span></label>
                        <input type="number" id="amountInput" name="amount" min="0.01" step="0.01" required
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300">
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700">Expense Date <span class="text-rose-500">*</span></label>
                        <input type="date" id="dateInput" name="expenseDate" required
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300">
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700">Description <span class="text-rose-500">*</span></label>
                        <textarea id="descInput" name="description" rows="2" required
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300"></textarea>
                    </div>
                    <div class="flex gap-3 pt-2">
                        <button type="button" onclick="toggleModal('expenseModal')"
                            class="flex-1 rounded-lg border border-slate-300 py-2.5 text-sm font-semibold text-slate-700">Cancel</button>
                        <button type="submit"
                            class="flex-1 rounded-lg bg-orange-500 py-2.5 text-sm font-semibold text-white hover:bg-orange-600">Save</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function toggleModal(id) {
                const modal = document.getElementById(id);
                modal.classList.toggle('hidden');
                modal.classList.toggle('flex');
            }

            function openAddModal() {
                document.getElementById('expenseId').value = '';
                document.getElementById('projectIdSelect').selectedIndex = 0;
                document.getElementById('categorySelect').selectedIndex = 0;
                document.getElementById('amountInput').value = '';
                document.getElementById('dateInput').value = '';
                document.getElementById('descInput').value = '';

                document.getElementById('modalTitle').innerText = 'Log Expense';
                document.getElementById('expenseForm').action = '<%= request.getContextPath() %>/admin/expenses?action=create';

                const modal = document.getElementById('expenseModal');
                modal.classList.remove('hidden');
                modal.classList.add('flex');
            }

            function openEditModal(button) {
                const id = button.getAttribute('data-id');
                const projectId = button.getAttribute('data-project-id');
                const category = button.getAttribute('data-category');
                const amount = button.getAttribute('data-amount');
                const date = button.getAttribute('data-date');
                const desc = button.getAttribute('data-desc');

                document.getElementById('expenseId').value = id;
                document.getElementById('projectIdSelect').value = projectId;
                document.getElementById('categorySelect').value = category;
                document.getElementById('amountInput').value = amount;
                document.getElementById('dateInput').value = date;
                document.getElementById('descInput').value = desc;

                document.getElementById('modalTitle').innerText = 'Edit Expense';
                document.getElementById('expenseForm').action = '<%= request.getContextPath() %>/admin/expenses?action=update';

                const modal = document.getElementById('expenseModal');
                modal.classList.remove('hidden');
                modal.classList.add('flex');
            }

            lucide.createIcons();
        </script>
    </body>

    </html>
