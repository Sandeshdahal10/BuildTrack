<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%
    List<String> errors = (List<String>) request.getAttribute("errors");
    String preservedEmail = (String) request.getAttribute("email");
    String authWarning = null;
    if (session != null) {
        authWarning = (String) session.getAttribute("authWarning");
        if (authWarning != null) {
            session.removeAttribute("authWarning");
        }
    }

    boolean registered = "true".equals(request.getParameter("registered"));
    boolean resetSuccess = "true".equals(request.getParameter("resetSuccess"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack - Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 min-h-screen bg-white px-4 py-6 text-slate-900 sm:px-6 flex items-center justify-center">
<main class="w-full max-w-[560px] rounded-2xl bg-white p-6 shadow-[0_20px_40px_rgba(0,0,0,0.25)] sm:p-7">
    <section class="mb-6 text-center">
        <div class="mx-auto mb-3 flex h-[76px] w-[76px] items-center justify-center rounded-full bg-white">
            <img src="<%= request.getContextPath() %>/assets/image/BuildTrackLogo.png" alt="BuildTrack" class="h-[72px] w-[72px] object-contain" />
        </div>
        <h1 class="m-0 text-[28px] font-bold text-orange-700">BuildTrack</h1>
        <p class="mt-1.5 text-sm text-slate-600">Advanced Construction Project Management</p>
    </section>

    <h2 class="m-0 text-2xl font-semibold text-slate-900">Welcome Back</h2>
    <p class="mb-[18px] mt-2 text-sm text-slate-500">Enter your credentials to access your site dashboard.</p>

    <% if (authWarning != null) { %>
    <div class="mb-3 rounded-[10px] border border-orange-300 bg-orange-50 px-3 py-2.5 text-sm text-orange-900"><%= authWarning %></div>
    <% } %>

    <% if (registered) { %>
    <div class="mb-3 rounded-[10px] border border-green-300 bg-green-50 px-3 py-2.5 text-sm text-green-800">Registration successful. You can now sign in.</div>
    <% } %>

    <% if (resetSuccess) { %>
    <div class="mb-3 rounded-[10px] border border-green-300 bg-green-50 px-3 py-2.5 text-sm text-green-800">Password reset successful. Please sign in with your new password.</div>
    <% } %>

    <% if (errors != null && !errors.isEmpty()) { %>
    <div class="mb-3 rounded-[10px] border border-red-300 bg-red-50 px-3 py-2.5 text-sm text-red-800">
        <ul class="m-0 list-disc pl-[18px]">
            <% for (String err : errors) { %>
            <li><%= err %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <form class="mt-2" method="post" action="<%= request.getContextPath() %>/login">
        <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="email">Email Address</label>
        <div class="relative mb-[14px]">
            <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                    <path d="M2 6a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v.35l-10 6.25L2 6.35V6zm0 2.7V18a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V8.7l-9.47 5.92a1 1 0 0 1-1.06 0L2 8.7z"/>
                </svg>
            </span>
            <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="email" id="email" name="email"
                   placeholder="Enter your Email Address"
                   value="<%= preservedEmail == null ? "" : preservedEmail %>" required>
        </div>

        <div class="mb-1.5 flex items-center justify-between text-sm font-semibold text-slate-800">
            <label for="password">Password</label>
            <a class="text-sm font-semibold text-orange-700 no-underline hover:underline" href="<%= request.getContextPath() %>/forgot-password">Forgot Password?</a>
        </div>
        <div class="relative mb-[14px]">
            <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                    <path d="M17 8h-1V6a4 4 0 0 0-8 0v2H7a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-9a2 2 0 0 0-2-2zm-7-2a2 2 0 1 1 4 0v2h-4V6zm2 10a2 2 0 0 1-1-3.73V11h2v1.27A2 2 0 0 1 12 16z"/>
                </svg>
            </span>
            <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="password" id="password" name="password"
                   placeholder="Enter your password" required>
        </div>

        <label class="mb-4 mt-1 flex items-center gap-2 text-sm text-slate-700" for="rememberMe">
            <input type="checkbox" id="rememberMe" name="rememberMe">
            Keep me logged in on this device
        </label>

        <button class="h-[46px] w-full cursor-pointer rounded-[10px] bg-orange-700 text-[15px] font-bold text-white transition-colors hover:bg-orange-800" type="submit">Sign in to Dashboard</button>
    </form>

    <p class="mb-[18px] mt-4 text-center text-sm text-slate-600">
        New to BuildTrack?
        <a class="font-semibold text-orange-700 no-underline hover:underline" href="<%= request.getContextPath() %>/register">Register Account</a>
    </p>




</main>
</body>
</html>

