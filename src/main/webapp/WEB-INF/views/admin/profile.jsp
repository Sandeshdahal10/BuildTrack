<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Administrator";
    String displayEmail = (user != null && user.getEmail() != null && !user.getEmail().trim().isEmpty())
            ? user.getEmail()
            : "-";
    String displayRole = (user != null && user.getRole() != null)
            ? user.getRole().toString()
            : "ADMIN";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Admin Profile</title>
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
                <h1 class="text-2xl font-bold tracking-tight text-slate-900">Profile</h1>
                <p class="mt-2 text-sm text-slate-600">Admin account details</p>
            </section>

            <section class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <div class="flex items-center gap-4">
                    <div class="flex h-14 w-14 items-center justify-center rounded-full bg-amber-300 text-lg font-bold text-slate-900">
                        <%= displayName.substring(0, 1).toUpperCase() %>
                    </div>
                    <div>
                        <p class="text-lg font-semibold text-slate-900"><%= displayName %></p>
                        <p class="text-sm text-slate-500"><%= displayRole %></p>
                    </div>
                </div>

                <div class="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2">
                    <div class="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3">
                        <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Email</p>
                        <p class="mt-1 text-sm font-semibold text-slate-800"><%= displayEmail %></p>
                    </div>
                    <div class="rounded-xl border border-slate-200 bg-slate-50 px-4 py-3">
                        <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Role</p>
                        <p class="mt-1 text-sm font-semibold text-slate-800"><%= displayRole %></p>
                    </div>
                </div>

                <div class="mt-6 flex justify-end">
                    <a href="<%= request.getContextPath() %>/logout"
                       class="inline-flex items-center gap-2 rounded-lg border border-rose-200 bg-rose-50 px-4 py-2 text-sm font-semibold text-rose-700 hover:bg-rose-100">
                        <i data-lucide="log-out" class="h-4 w-4"></i>
                        Log Out
                    </a>
                </div>
            </section>
        </main>
    </div>
</div>
<script>
    lucide.createIcons();
</script>
</body>
</html>

