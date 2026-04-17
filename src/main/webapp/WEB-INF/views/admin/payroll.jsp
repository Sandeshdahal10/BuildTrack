<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>Payroll Management - BuildTrack</title>
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

            <div class=" flex flex-col md:flex-row md:items-center justify-between gap-4 mb-6">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Payroll Management</h1>
                    <p class="text-slate-500 mt-1">Calculate wages and manage payments.</p>
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">

                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">Total Payroll</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">Rs 4.5L</p>
                        </div>
                        <div class="p-3 rounded-lg bg-blue-100">
                            <i data-lucide="wallet" class="w-5 h-5 text-blue-600"></i>
                        </div>
                    </div>
                </div>

                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">Amount Paid</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">Rs 3.2L</p>
                        </div>
                        <div class="p-3 rounded-lg bg-green-100">
                            <i data-lucide="check-circle" class="w-5 h-5 text-green-600"></i>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Pending Amount -->
                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">Pending Amount</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">Rs 1.3L</p>
                        </div>
                        <div class="p-3 rounded-lg bg-orange-100">
                            <i data-lucide="clock" class="w-5 h-5 text-orange-600"></i>
                        </div>
                    </div>
                </div>

                <div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm">
                    <div class="flex items-center justify-between">
                        <div>
                            <p class="text-xs font-semibold uppercase text-slate-400">Workers Paid</p>
                            <p class="text-2xl font-bold text-slate-800 mt-1">38 / 45</p>
                        </div>
                        <div class="p-3 rounded-lg bg-slate-100">
                            <i data-lucide="users" class="w-5 h-5 text-slate-600"></i>
                        </div>
                    </div>
                </div>

            </div>

            <div class="bg-white border border-slate-200 rounded-xl p-4 mb-4 shadow-sm">
                <div class="flex flex-wrap items-center gap-4">
                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Month:</span>
                        <input type="month" value="2025-04" class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-400">
                    </div>

                    <div class="flex items-center gap-2">
                        <span class="text-sm font-medium text-slate-600">Status:</span>
                        <select class="rounded-lg border border-slate-300 p-2 text-sm outline-none focus:border-orange-400 bg-white">
                            <option>All Status</option>
                            <option>Paid</option>
                            <option>Pending</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="bg-slate-100/50 rounded-xl p-4 space-y-3">

                <jsp:include page="../common/payrollRow.jsp">
                    <jsp:param name="name" value="Ramesh Kumar" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=12" />
                    <jsp:param name="role" value="Mason" />
                    <jsp:param name="daysWorked" value="28" />
                    <jsp:param name="dailyRate" value="Rs 700" />
                    <jsp:param name="grossPay" value="Rs 19,600" />
                    <jsp:param name="status" value="Paid" />
                    <jsp:param name="statusStyle" value="bg-green-100 text-green-700" />
                    <jsp:param name="payBtnDisabled" value="opacity-50 pointer-events-none" />
                    <jsp:param name="payslipLink" value="#" />
                    <jsp:param name="payLink" value="#" />
                </jsp:include>

                <!-- Row 2: Pending -->
                <jsp:include page="../common/payrollRow.jsp">
                    <jsp:param name="name" value="Suresh Yadav" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=15" />
                    <jsp:param name="role" value="Laborer" />
                    <jsp:param name="daysWorked" value="26" />
                    <jsp:param name="dailyRate" value="Rs 500" />
                    <jsp:param name="grossPay" value="Rs 13,000" />
                    <jsp:param name="status" value="Pending" />
                    <jsp:param name="statusStyle" value="bg-orange-100 text-orange-700" />
                    <jsp:param name="payBtnDisabled" value="" />
                    <jsp:param name="payslipLink" value="#" />
                    <jsp:param name="payLink" value="#" />
                </jsp:include>

                <!-- Row 3: Pending -->
                <jsp:include page="../common/payrollRow.jsp">
                    <jsp:param name="name" value="Mahesh Singh" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=16" />
                    <jsp:param name="role" value="Carpenter" />
                    <jsp:param name="daysWorked" value="22" />
                    <jsp:param name="dailyRate" value="Rs 800" />
                    <jsp:param name="grossPay" value="Rs 17,600" />
                    <jsp:param name="status" value="Pending" />
                    <jsp:param name="statusStyle" value="bg-orange-100 text-orange-700" />
                    <jsp:param name="payBtnDisabled" value="" />
                    <jsp:param name="payslipLink" value="#" />
                    <jsp:param name="payLink" value="#" />
                </jsp:include>

                <!-- Row 4: Paid -->
                <jsp:include page="../common/payrollRow.jsp">
                    <jsp:param name="name" value="Ganesh Patel" />
                    <jsp:param name="image" value="https://i.pravatar.cc/150?img=17" />
                    <jsp:param name="role" value="Electrician" />
                    <jsp:param name="daysWorked" value="25" />
                    <jsp:param name="dailyRate" value="Rs 900" />
                    <jsp:param name="grossPay" value="Rs 22,500" />
                    <jsp:param name="status" value="Paid" />
                    <jsp:param name="statusStyle" value="bg-green-100 text-green-700" />
                    <jsp:param name="payBtnDisabled" value="opacity-50 pointer-events-none" />
                    <jsp:param name="payslipLink" value="#" />
                    <jsp:param name="payLink" value="#" />
                </jsp:include>

            </div>

        </main>
    </div>
</div>

<script> lucide.createIcons(); </script>
</body>
</html>