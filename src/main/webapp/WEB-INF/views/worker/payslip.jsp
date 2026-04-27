<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Worker";
    String basePath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Payslips</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-slate-50 text-slate-900">
<div class="grid min-h-screen w-full grid-cols-[214px_minmax(0,1fr)] max-[1100px]:grid-cols-1">
    <!-- Sidebar -->
    <jsp:include page="../common/WorkerSideBar.jsp" />

    <!-- Main Content -->
    <main class="bg-slate-50 px-5 pb-7 pt-4">
        <!-- Navbar -->
        <jsp:include page="../common/adminTopbar.jsp" />

        <!-- Title Section -->
        <section class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm mb-3.5">
            <h1 class="m-0 text-3xl font-bold leading-none">Payslips</h1>
            <p class="mt-1 text-xs text-slate-600">View your salary slips and earnings</p>
        </section>

        <!-- Payslip List -->
        <div class="space-y-2.5">
            <!-- Payslip 1 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-center justify-between">
                    <div>
                        <h3 class="text-base font-semibold text-slate-900">April 2026 Payslip</h3>
                        <p class="text-sm text-slate-600">Salary for April 1-30, 2026</p>
                    </div>
                    <div class="text-right">
                        <p class="text-lg font-bold text-slate-900">Rs. 45,000</p>
                        <a href="#" class="text-amber-600 text-xs font-semibold hover:underline">Download PDF</a>
                    </div>
                </div>
            </article>

            <!-- Payslip 2 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-center justify-between">
                    <div>
                        <h3 class="text-base font-semibold text-slate-900">March 2026 Payslip</h3>
                        <p class="text-sm text-slate-600">Salary for March 1-31, 2026</p>
                    </div>
                    <div class="text-right">
                        <p class="text-lg font-bold text-slate-900">Rs. 42,500</p>
                        <a href="#" class="text-amber-600 text-xs font-semibold hover:underline">Download PDF</a>
                    </div>
                </div>
            </article>

            <!-- Payslip 3 -->
            <article class="rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-sm hover:shadow-md transition-shadow">
                <div class="flex items-center justify-between">
                    <div>
                        <h3 class="text-base font-semibold text-slate-900">February 2026 Payslip</h3>
                        <p class="text-sm text-slate-600">Salary for February 1-28, 2026</p>
                    </div>
                    <div class="text-right">
                        <p class="text-lg font-bold text-slate-900">Rs. 40,000</p>
                        <a href="#" class="text-amber-600 text-xs font-semibold hover:underline">Download PDF</a>
                    </div>
                </div>
            </article>
        </div>
    </main>
</div>

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    lucide.createIcons();
</script>
</body>
</html>
