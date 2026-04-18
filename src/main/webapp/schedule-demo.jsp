<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    boolean submitted = "POST".equalsIgnoreCase(request.getMethod());
    String fullName = request.getParameter("fullName") == null ? "" : request.getParameter("fullName");
    String company = request.getParameter("company") == null ? "" : request.getParameter("company");
    String email = request.getParameter("email") == null ? "" : request.getParameter("email");
    String phone = request.getParameter("phone") == null ? "" : request.getParameter("phone");
    String demoDate = request.getParameter("demoDate") == null ? "" : request.getParameter("demoDate");
    String demoTime = request.getParameter("demoTime") == null ? "" : request.getParameter("demoTime");
    String message = request.getParameter("message") == null ? "" : request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack - Schedule Demo</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 min-h-screen bg-white px-4 py-6 text-slate-900 sm:px-6 flex items-center justify-center">
<main class="w-full max-w-[560px] rounded-2xl bg-white p-6 shadow-[0_20px_40px_rgba(0,0,0,0.25)] sm:p-7">
    <section class="mb-6 text-center">
        <div class="mx-auto mb-3 flex h-[76px] w-[76px] items-center justify-center rounded-full bg-gradient-to-br from-blue-600 to-sky-500 text-[26px] font-bold tracking-[1px] text-white">BT</div>
        <h1 class="m-0 text-[28px] font-bold text-orange-700">BuildTrack</h1>
        <p class="mt-1.5 text-sm text-slate-600">Advanced Construction Project Management</p>
    </section>

    <h2 class="m-0 text-2xl font-semibold text-slate-900">Schedule a Demo</h2>
    <p class="mb-[18px] mt-2 text-sm text-slate-500">Fill the details below and we will confirm your demo slot.</p>

    <% if (submitted) { %>
    <div class="mb-3 rounded-[10px] border border-green-300 bg-green-50 px-3 py-2.5 text-sm text-green-800">Thanks. Your demo request is submitted. Our team will contact you soon.</div>
    <% } %>

    <form class="mt-2" method="post" action="<%= request.getContextPath() %>/schedule-demo.jsp">
        <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="fullName">Full Name</label>
        <input class="mb-[14px] h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 px-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="text" id="fullName" name="fullName" placeholder="Enter your full name" value="<%= fullName %>" required>

        <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="company">Company</label>
        <input class="mb-[14px] h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 px-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="text" id="company" name="company" placeholder="Enter company name" value="<%= company %>" required>

        <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="email">Work Email</label>
        <input class="mb-[14px] h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 px-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="email" id="email" name="email" placeholder="Enter your work email" value="<%= email %>" required>

        <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="phone">Phone Number</label>
        <input class="mb-[14px] h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 px-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="tel" id="phone" name="phone" placeholder="+977 98XXXXXXXX" value="<%= phone %>" required>

        <div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
            <div>
                <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="demoDate">Preferred Date</label>
                <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 px-3 text-sm text-slate-900 outline-none focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="date" id="demoDate" name="demoDate" value="<%= demoDate %>" required>
            </div>
            <div>
                <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="demoTime">Preferred Time</label>
                <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 px-3 text-sm text-slate-900 outline-none focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" type="time" id="demoTime" name="demoTime" value="<%= demoTime %>" required>
            </div>
        </div>

        <label class="mb-1.5 mt-[14px] block text-sm font-semibold text-slate-800" for="message">What should we cover in the demo?</label>
        <textarea class="min-h-[100px] w-full rounded-[10px] border border-slate-300 bg-slate-100 px-3 py-2.5 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-blue-600 focus:bg-slate-200 focus:ring-4 focus:ring-blue-200" id="message" name="message" placeholder="Tell us your goals and current process."><%= message %></textarea>

        <button class="mt-4 h-[46px] w-full cursor-pointer rounded-[10px] bg-orange-700 text-[15px] font-bold text-white transition-colors hover:bg-orange-800" type="submit">Request Demo</button>
    </form>

    <p class="mb-1 mt-4 text-center text-sm text-slate-600">
        Already have an account?
        <a class="font-semibold text-orange-700 no-underline hover:underline" href="<%= request.getContextPath() %>/login">Log in</a>
    </p>
    <p class="mt-2 text-center text-sm text-slate-600">
        <a class="font-semibold text-orange-700 no-underline hover:underline" href="<%= request.getContextPath() %>/">Back to Home</a>
    </p>
</main>
</body>
</html>

