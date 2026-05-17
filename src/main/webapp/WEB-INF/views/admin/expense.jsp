<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                            <button onclick="toggleModal('expenseModal')"
                                class="flex items-center gap-2 rounded-lg bg-orange-500 px-4 py-2 text-sm font-semibold text-white hover:bg-orange-600 shadow-sm">
                                <i data-lucide="plus-circle" class="h-4 w-4"></i>
                                Log Expense
                            </button>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                        <jsp:include page="../common/statsCard.jsp">
                            <jsp:param name="title" value="Total Expenses" />
                            <jsp:param name="value" value="NPR 31.4L" />
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
                            <option>All Projects</option>
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
                                <jsp:include page="../common/expensRow.jsp">
                                    <jsp:param name="date" value="12 Apr 2025" />
                                    <jsp:param name="project" value="Skyline Tower" />
                                    <jsp:param name="category" value="Material" />
                                    <jsp:param name="categoryStyle" value="bg-orange-100 text-orange-700" />
                                    <jsp:param name="description" value="Cement Purchase (50 Bags)" />
                                    <jsp:param name="amount" value="NPR 22,500" />
                                    <jsp:param name="editLink" value="#" />
                                </jsp:include>

                                <jsp:include page="../common/expensRow.jsp">
                                    <jsp:param name="date" value="11 Apr 2025" />
                                    <jsp:param name="project" value="Green Valley" />
                                    <jsp:param name="category" value="Labour" />
                                    <jsp:param name="categoryStyle" value="bg-blue-100 text-blue-700" />
                                    <jsp:param name="description" value="Weekly Wages Payment" />
                                    <jsp:param name="amount" value="NPR 45,000" />
                                    <jsp:param name="editLink" value="#" />
                                </jsp:include>

                                <jsp:include page="../common/expensRow.jsp">
                                    <jsp:param name="date" value="10 Apr 2025" />
                                    <jsp:param name="project" value="River Bridge" />
                                    <jsp:param name="category" value="Equipment" />
                                    <jsp:param name="categoryStyle" value="bg-purple-100 text-purple-700" />
                                    <jsp:param name="description" value="Crane Rental (2 Days)" />
                                    <jsp:param name="amount" value="NPR 18,000" />
                                    <jsp:param name="editLink" value="#" />
                                </jsp:include>
                            </tbody>
                        </table>
                    </div>

                </main>
            </div>
        </div>

        <div id="expenseModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-black/50">
            <div class="bg-white rounded-2xl shadow-xl w-full max-w-md p-6 m-4">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-lg font-bold text-slate-900">Log Expense</h3>
                    <button onclick="toggleModal('expenseModal')" class="text-slate-400 hover:text-slate-600"><i
                            data-lucide="x" class="w-5 h-5"></i></button>
                </div>
                <form class="space-y-4">
                    <div>
                        <label class="text-sm font-medium text-slate-700">Project</label>
                        <select
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300 bg-white">
                            <option>Skyline Tower</option>
                            <option>Green Valley</option>
                        </select>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700">Category</label>
                        <select
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300 bg-white">
                            <option>Material</option>
                            <option>Labour</option>
                            <option>Equipment</option>
                        </select>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700">Amount (NPR)</label>
                        <input type="number"
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300">
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-700">Description</label>
                        <textarea rows="2"
                            class="w-full mt-1 rounded-lg border border-slate-300 p-2.5 text-sm outline-none focus:border-orange-300"></textarea>
                    </div>
                    <div class="flex gap-3 pt-2">
                        <button type="button" onclick="toggleModal('expenseModal')"
                            class="flex-1 rounded-lg border border-slate-300 py-2.5 text-sm font-semibold text-slate-700">Cancel</button>
                        <button type="submit"
                            class="flex-1 rounded-lg bg-orange-500 py-2.5 text-sm font-semibold text-white">Save</button>
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
            lucide.createIcons();
        </script>
    </body>

    </html>