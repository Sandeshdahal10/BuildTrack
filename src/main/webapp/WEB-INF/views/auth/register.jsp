<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%
    List<String> errors = (List<String>) request.getAttribute("errors");
    String fullName = (String) request.getAttribute("fullName");
    String email = (String) request.getAttribute("email");
    String phone = (String) request.getAttribute("phone");
    String role = (String) request.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack - Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 min-h-screen bg-white px-4 py-4 text-slate-900 sm:px-6 sm:py-6 flex items-center justify-center">
<main class="grid w-full max-w-[1020px] grid-cols-1 overflow-hidden rounded-2xl border border-slate-100 bg-white shadow-[0_18px_42px_rgba(15,23,42,0.18)] md:grid-cols-[1fr_1.2fr]">
    <section class="border-b border-slate-100 bg-gradient-to-br from-orange-50 to-white px-[22px] py-[22px] md:border-b-0 md:border-r md:px-[30px] md:py-9">
        <div class="mb-4">
            <img src="<%= request.getContextPath() %>/assets/image/BuildTrackLogo.png" alt="BuildTrack" class="h-14 object-contain" />
        </div>
        <h1 class="m-0 text-[32px] font-bold leading-tight text-orange-700">The Digital Monument to Project Management.</h1>
        <p class="my-4 text-[15px] leading-relaxed text-slate-600">Precision, structural integrity, and layered complexity. Register to access the master architect's dashboard.</p>
        <span class="mt-[18px] inline-block rounded-full border border-orange-100 bg-orange-50 px-[14px] py-2 text-[13px] font-bold text-orange-900">Join 1,000+ project leads</span>
    </section>

    <section class="px-[    2px] py-[22px] sm:p-[30px]">
        <h2 class="m-0 text-[28px] font-semibold text-slate-900">Create Account</h2>
        <p class="mb-4 mt-2 text-sm text-slate-500">Please fill in your details to start your project journey.</p>

        <% if (errors != null && !errors.isEmpty()) { %>
        <div class="mb-[14px] rounded-[10px] border border-red-300 bg-red-50 px-3 py-2.5 text-sm text-red-800">
            <ul class="m-0 list-disc pl-[18px]">
                <% for (String err : errors) { %>
                <li><%= err %></li>
                <% } %>
            </ul>
        </div>
        <% } %>

        <form class="mt-1" method="post" action="<%= request.getContextPath() %>/register">
            <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="fullName">Full Name</label>
            <div class="relative mb-3">
                <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                    <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                        <path d="M12 12a5 5 0 1 0-5-5 5 5 0 0 0 5 5zm0 2c-4.97 0-9 2.24-9 5v1h18v-1c0-2.76-4.03-5-9-5z"/>
                    </svg>
                </span>
                <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-orange-700 focus:bg-slate-200 focus:ring-4 focus:ring-orange-200" type="text" id="fullName" name="fullName"
                       placeholder="Enter Your Full Name"
                       value="<%= fullName == null ? "" : fullName %>" required>
            </div>

            <div class="grid grid-cols-1 gap-0 sm:gap-3 md:grid-cols-2">
                <div>
                    <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="email">Email</label>
                    <div class="relative mb-3">
                        <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                            <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                                <path d="M2 6a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v.35l-10 6.25L2 6.35V6zm0 2.7V18a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V8.7l-9.47 5.92a1 1 0 0 1-1.06 0L2 8.7z"/>
                            </svg>
                        </span>
                        <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-orange-700 focus:bg-slate-200 focus:ring-4 focus:ring-orange-200" type="email" id="email" name="email"
                               placeholder="Enter your Email Address"
                               value="<%= email == null ? "" : email %>" required>
                    </div>
                </div>
                <div>
                    <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="phone">Phone Number</label>
                    <div class="relative mb-3">
                        <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                            <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                                <path d="M6.62 10.79a15.46 15.46 0 0 0 6.59 6.59l2.2-2.2a1 1 0 0 1 1.02-.24 11.68 11.68 0 0 0 3.67.59 1 1 0 0 1 1 1V20a1 1 0 0 1-1 1A17 17 0 0 1 3 4a1 1 0 0 1 1-1h3.47a1 1 0 0 1 1 1 11.68 11.68 0 0 0 .59 3.67 1 1 0 0 1-.24 1.02l-2.2 2.1z"/>
                            </svg>
                        </span>
                        <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-orange-700 focus:bg-slate-200 focus:ring-4 focus:ring-orange-200" type="tel" id="phone" name="phone"
                               placeholder="+977 0123456789"
                               value="<%= phone == null ? "" : phone %>" required>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 gap-0 sm:gap-3 md:grid-cols-2">
                <div>
                    <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="dob">DOB</label>
                    <div class="relative mb-3">
                        <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                            <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                                <path d="M7 2h2v2h6V2h2v2h2a2 2 0 0 1 2 2v13a3 3 0 0 1-3 3H6a3 3 0 0 1-3-3V6a2 2 0 0 1 2-2h2V2zm12 8H5v9a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-9z"/>
                            </svg>
                        </span>
                        <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-3 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-orange-700 focus:bg-slate-200 focus:ring-4 focus:ring-orange-200" type="text" id="dob" name="dob" placeholder="mm/dd/yyyy">
                    </div>
                </div>
                <div>
                    <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="role">Role Selection</label>
                    <div class="relative mb-3">
                        <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                            <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                                <path d="M19 4h-3.18C15.4 2.84 14.3 2 13 2h-2c-1.3 0-2.4.84-2.82 2H5a2 2 0 0 0-2 2v2h18V6a2 2 0 0 0-2-2zm-8-1h2a1 1 0 0 1 1 1h-4a1 1 0 0 1 1-1zm10 7H3v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V10z"/>
                            </svg>
                        </span>
                        <select class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-3 text-sm text-slate-900 outline-none focus:border-orange-700 focus:bg-slate-200 focus:ring-4 focus:ring-orange-200" id="role" name="role" required>
                            <option value="">Select Role</option>
                            <option value="CLIENT" <%= "CLIENT".equalsIgnoreCase(role) ? "selected" : "" %>>Client</option>
                            <option value="WORKER" <%= "WORKER".equalsIgnoreCase(role) ? "selected" : "" %>>Worker</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 gap-0 sm:gap-3 md:grid-cols-2">
                <div>
                    <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="password">Password</label>
                    <div class="relative mb-3">
                        <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                            <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                                <path d="M17 8h-1V6a4 4 0 0 0-8 0v2H7a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-9a2 2 0 0 0-2-2zm-7-2a2 2 0 1 1 4 0v2h-4V6zm2 10a2 2 0 0 1-1-3.73V11h2v1.27A2 2 0 0 1 12 16z"/>
                            </svg>
                        </span>
                        <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-12 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-orange-700 focus:bg-slate-200 focus:ring-4 focus:ring-orange-200" type="password" id="password" name="password"
                               placeholder="Enter password" required>
                        <button type="button" id="togglePassword" aria-label="Show password"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-700">
                            <svg id="iconEyePassword" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                            <svg id="iconEyeOffPassword" class="hidden h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M17.94 17.94A10.94 10.94 0 0 1 12 19c-7 0-11-7-11-7a21.77 21.77 0 0 1 5.06-5.94"></path>
                                <path d="M1 1l22 22"></path>
                                <path d="M9.9 4.24A9.77 9.77 0 0 1 12 4c7 0 11 7 11 7a21.82 21.82 0 0 1-4.87 5.94"></path>
                                <path d="M14.12 14.12A3 3 0 0 1 9.88 9.88"></path>
                            </svg>
                        </button>
                    </div>
                </div>
                <div>
                    <label class="mb-1.5 block text-sm font-semibold text-slate-800" for="confirmPassword">Confirm Password</label>
                    <div class="relative mb-3">
                        <span class="pointer-events-none absolute left-3 top-1/2 h-[18px] w-[18px] -translate-y-1/2 text-slate-500" aria-hidden="true">
                            <svg class="h-full w-full fill-current" viewBox="0 0 24 24">
                                <path d="M17 8h-1V6a4 4 0 0 0-8 0v2H7a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-9a2 2 0 0 0-2-2zm-7-2a2 2 0 1 1 4 0v2h-4V6zm1.29 8.29 1.12 1.12 2.3-2.3 1.02 1.02-3.32 3.32a1 1 0 0 1-1.41 0l-1.83-1.83 1.12-1.33z"/>
                            </svg>
                        </span>
                        <input class="h-11 w-full rounded-[10px] border border-slate-300 bg-slate-100 pl-10 pr-12 text-sm text-slate-900 outline-none placeholder:text-slate-500 focus:border-orange-700 focus:bg-slate-200 focus:ring-4 focus:ring-orange-200" type="password" id="confirmPassword" name="confirmPassword"
                               placeholder="Confirm password" required>
                        <button type="button" id="toggleConfirmPassword" aria-label="Show password"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-700">
                            <svg id="iconEyeConfirm" class="h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7-11-7-11-7z"></path>
                                <circle cx="12" cy="12" r="3"></circle>
                            </svg>
                            <svg id="iconEyeOffConfirm" class="hidden h-5 w-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M17.94 17.94A10.94 10.94 0 0 1 12 19c-7 0-11-7-11-7a21.77 21.77 0 0 1 5.06-5.94"></path>
                                <path d="M1 1l22 22"></path>
                                <path d="M9.9 4.24A9.77 9.77 0 0 1 12 4c7 0 11 7 11 7a21.82 21.82 0 0 1-4.87 5.94"></path>
                                <path d="M14.12 14.12A3 3 0 0 1 9.88 9.88"></path>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>

            <button class="mt-2 h-[46px] w-full cursor-pointer rounded-[10px] bg-orange-700 text-[15px] font-bold text-white transition-colors hover:bg-orange-800" type="submit">Complete Registration</button>
        </form>

        <p class="mt-[14px] border-l-[3px] border-orange-700 pl-[10px] text-[13px] leading-relaxed text-slate-500">!Your registration will be reviewed by Admin. Access to the BuildTrack platform will be granted upon verification of your credentials.</p>

        <p class="mt-[14px] text-sm text-slate-600">
            Already have an account?
            <a class="font-semibold text-orange-700 no-underline hover:underline" href="<%= request.getContextPath() %>/login">Log in</a>
        </p>
    </section>
</main>
<script>
    (function () {
        function wireToggle(toggleId, inputId, eyeId, eyeOffId) {
            var toggle = document.getElementById(toggleId);
            var input = document.getElementById(inputId);
            var eye = document.getElementById(eyeId);
            var eyeOff = document.getElementById(eyeOffId);

            if (!toggle || !input || !eye || !eyeOff) {
                return;
            }

            toggle.addEventListener("click", function () {
                var isPassword = input.type === "password";
                input.type = isPassword ? "text" : "password";
                toggle.setAttribute("aria-label", isPassword ? "Hide password" : "Show password");
                eye.classList.toggle("hidden", isPassword);
                eyeOff.classList.toggle("hidden", !isPassword);
            });
        }

        wireToggle("togglePassword", "password", "iconEyePassword", "iconEyeOffPassword");
        wireToggle("toggleConfirmPassword", "confirmPassword", "iconEyeConfirm", "iconEyeOffConfirm");
    })();
</script>
</body>
</html>
