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
                box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.04), 0 8px 10px -6px rgba(15, 23, 42, 0.04);
            }

            .bt-select {
                background-image: none;
                /* keep Tailwind look consistent */
            }
        </style>
    </head>

    <body class="bg-gray-50 text-slate-900 font-sans antialiased">

        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

            <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-28 pb-14">
                <div class="max-w-xl mx-auto">
                    <header class="mb-8">
                        <div class="mb-6">
                            <a href="${pageContext.request.contextPath}/"
                                class="inline-flex items-center gap-2 rounded-full border border-slate-200 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 shadow-sm transition hover:bg-slate-50">
                                <span aria-hidden="true">←</span>
                                Back to Home
                            </a>
                        </div>
                        <p class="text-[#ea580c] font-extrabold text-4xl sm:text-5xl tracking-tight uppercase mt-5">
                            CONTACT US</p>
                        <p class="text-slate-600 mt-3">Send your details and we’ll get back to you.</p>
                    </header>

                    <div class="bt-card bg-white rounded-2xl ring-1 ring-slate-100 shadow-sm p-8">
                        <% String successMessage=(String) request.getAttribute("successMessage"); %>
                            <% if (successMessage !=null) { %>
                                <div
                                    class="mb-6 rounded-xl bg-emerald-50 ring-1 ring-emerald-100 px-4 py-3 text-emerald-800 font-medium">
                                    <%= successMessage %>
                                </div>
                                <% } %>

                                    <form method="post" action="${pageContext.request.contextPath}/contact"
                                        class="space-y-5">

                                        <div>
                                            <label for="name"
                                                class="block text-sm font-semibold text-slate-700 mb-1">Name</label>
                                            <input id="name" name="name" type="text"
                                                value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                                                class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900 placeholder-slate-400"
                                                placeholder="Your full name" required>
                                            <% if (request.getAttribute("nameError") !=null) { %>
                                                <p class="mt-1 text-sm text-rose-600">
                                                    <%= request.getAttribute("nameError") %>
                                                </p>
                                                <% } %>
                                        </div>

                                        <div>
                                            <label for="contact" class="block text-sm font-semibold text-slate-700 mb-1">Phone number</label>
                                            <input id="contact" name="contact" type="tel"
                                                value="<%= request.getAttribute("contact") != null ? request.getAttribute("contact") : "" %>"
                                                class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900 placeholder-slate-400"
                                                placeholder="Phone number" required>
                                            <% if (request.getAttribute("contactError") !=null) { %>
                                                <p class="mt-1 text-sm text-rose-600">
                                                    <%= request.getAttribute("contactError") %>
                                                </p>
                                            <% } %>
                                        </div>

                                        <div>
                                            <label for="email"
                                                class="block text-sm font-semibold text-slate-700 mb-1">Email</label>
                                            <input id="email" name="email" type="email"
                                                value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                                                class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900
                                            placeholder-slate-400" placeholder="email@gmail.com" required>
                                            <% if (request.getAttribute("emailError") !=null) { %>
                                                <p class="mt-1 text-sm text-rose-600">
                                                    <%= request.getAttribute("emailError") %>
                                                </p>
                                            <% } %>
                                        </div>

                                        <div>
                                            <label for="message"
                                                class="block text-sm font-semibold text-slate-700 mb-1">Message</label>
                                            <textarea id="message" name="message" rows="5" required
                                                class="bt-field w-full rounded-xl border border-slate-200 bg-white px-4 py-3 text-slate-900 placeholder-slate-400"
                                                placeholder="Tell us how we can help"></textarea>
                                        </div>

                                        <button type="submit"
                                            class="w-full inline-flex items-center justify-center rounded-xl bg-[#ea580c] px-6 py-3 text-base font-semibold text-white shadow-md transition hover:bg-[#c2410c]">
                                            Send Message
                                        </button>
                                    </form>
                    </div>
                </div>
            </main>

            <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    </body>

    </html>