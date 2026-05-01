<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        .bt-field {
            transition: box-shadow 200ms ease, border-color 200ms ease, transform 200ms ease;
        }

        .bt-field:focus {
            outline: none;
            border-color: rgba(234, 88, 12, 0.75);
            box-shadow: 0 0 0 4px rgba(234, 88, 12, 0.18);
        }

        .bt-card {
            transform: translateY(0);
            transition: transform 220ms ease, box-shadow 220ms ease;
            will-change: transform, box-shadow;
        }

        .bt-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 35px rgba(234, 88, 12, 0.14), 0 8px 14px rgba(15, 23, 42, 0.08);
        }
    </style>
</head>
<body class="bg-gray-50 text-slate-900 font-sans antialiased">

<nav class="bg-white/80 backdrop-blur-md border-b border-slate-100">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-20 items-center">
            <a href="${pageContext.request.contextPath}/" class="flex items-center">
                <div class="bg-[#ea580c] rounded-xl p-2 mr-3 h-10 w-10 flex items-center justify-center shadow-md">
                    <span class="text-white text-xs font-bold tracking-wide">BT</span>
                </div>
                <span class="font-extrabold text-2xl text-[#ea580c] tracking-tight">BuildTrack</span>
            </a>
            <a href="${pageContext.request.contextPath}/login"
               class="inline-flex items-center justify-center bg-[#ea580c] text-white font-semibold text-base px-6 py-2.5 rounded-lg shadow-md hover:bg-[#c2410c] hover:shadow-lg transition-all duration-200 transform hover:-translate-y-0.5">
                Log in
            </a>
        </div>
    </div>
</nav>

<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-14">
    <div class="max-w-xl mx-auto">
        <header class="mb-8">
            <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2 text-[#ea580c] font-semibold hover:text-[#c2410c] transition-colors">
                <span aria-hidden="true">←</span>
                Back to Home
            </a>
            <p class="text-[#ea580c] font-extrabold text-4xl sm:text-5xl tracking-tight uppercase mt-5">CONTACT US</p>
            <p class="text-slate-600 mt-3">Send your details and we’ll get back to you.</p>
        </header>

        <div class="bt-card bg-white rounded-2xl ring-1 ring-slate-100 shadow-sm p-8">
            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (successMessage != null) { %>
                <div class="mb-6 rounded-xl bg-emerald-50 ring-1 ring-emerald-100 px-4 py-3 text-emerald-800 font-medium">
                    <%= successMessage %>
                </div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/contact" class="space-y-5">

                <div>
                    <label for="name" class="block text-sm font-semibold text-slate-700 mb-1">Name</label>
                    <input id="name" name="name" type="text"
                           value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                           class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900 placeholder-slate-400"
                           placeholder="Your full name" required>
                    <% if (request.getAttribute("nameError") != null) { %>
                        <p class="mt-1 text-sm text-rose-600"><%= request.getAttribute("nameError") %></p>
                    <% } %>
                </div>

                <div>
                    <label for="contact" class="block text-sm font-semibold text-slate-700 mb-1">Contact</label>
                    <input id="contact" name="contact" type="tel"
                           value="<%= request.getAttribute("contact") != null ? request.getAttribute("contact") : "" %>"
                           class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900 placeholder-slate-400"
                           placeholder="Phone number" required>
                    <% if (request.getAttribute("contactError") != null) { %>
                        <p class="mt-1 text-sm text-rose-600"><%= request.getAttribute("contactError") %></p>
                    <% } %>
                </div>

                <div>
                    <label for="email" class="block text-sm font-semibold text-slate-700 mb-1">Email</label>
                    <input id="email" name="email" type="email"
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                           class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900 placeholder-slate-400"
                           placeholder="you@company.com" required>
                    <% if (request.getAttribute("emailError") != null) { %>
                        <p class="mt-1 text-sm text-rose-600"><%= request.getAttribute("emailError") %></p>
                    <% } %>
                </div>

                <div>
                    <label for="country" class="block text-sm font-semibold text-slate-700 mb-1">Country</label>
                    <input id="country" name="country" type="text"
                           value="<%= request.getAttribute("country") != null ? request.getAttribute("country") : "" %>"
                           class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900 placeholder-slate-400"
                           placeholder="Country" required>
                    <% if (request.getAttribute("countryError") != null) { %>
                        <p class="mt-1 text-sm text-rose-600"><%= request.getAttribute("countryError") %></p>
                    <% } %>
                </div>

                <button type="submit"
                        class="w-full inline-flex items-center justify-center bg-[#ea580c] text-white font-semibold text-base px-6 py-3.5 rounded-xl shadow-md hover:bg-[#c2410c] hover:shadow-lg transition-all duration-200 transform hover:-translate-y-0.5">
                    Submit
                </button>
            </form>
        </div>

        <p class="text-xs text-slate-500 text-center mt-6">By submitting, you agree to be contacted by the BuildTrack team.</p>
    </div>
</main>

<footer class="bg-slate-900 text-slate-200 mt-10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <p class="text-slate-300">© ${pageContext.request.serverName} BuildTrack. All rights reserved.</p>
    </div>
</footer>

</body>
</html>

