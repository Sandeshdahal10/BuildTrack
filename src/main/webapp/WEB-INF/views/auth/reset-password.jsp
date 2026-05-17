<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .strength-bar {
            flex: 1;
            background: rgb(229, 231, 235);
            border-radius: 2px;
            transition: background 0.3s ease;
            height: 3px;
        }

        .strength-bar.weak {
            background: rgb(239, 68, 68);
        }

        .strength-bar.medium {
            background: rgb(251, 146, 60);
        }

        .strength-bar.strong {
            background: rgb(34, 197, 94);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-100 to-gray-300 min-h-screen flex flex-col p-5">
    <div class="text-center mb-10 mt-5">
        <div>
            <img src="${pageContext.request.contextPath}/assets/image/BuildTrackLogo.png" alt="BuildTrack" class="mx-auto h-14 object-contain" />
        </div>
        <div class="w-20 h-1 bg-gradient-to-r from-orange-500 to-orange-300 mx-auto mt-3 rounded"></div>
    </div>

    <div class="max-w-lg mx-auto bg-white rounded-lg p-12 shadow-sm">
        <h1 class="text-2xl text-slate-800 mb-2 font-semibold">Reset Password</h1>
        <p class="text-slate-500 text-sm mb-8 leading-relaxed">Define your new architectural access credentials.</p>

        <%
            java.util.List<String> errors = (java.util.List<String>) request.getAttribute("errors");
            String tokenError = (String) request.getAttribute("tokenError");
            String validToken = (String) request.getAttribute("validToken");
        %>

        <% if (tokenError != null && !tokenError.trim().isEmpty()) { %>
        <div class="bg-red-50 border-l-4 border-red-600 p-4 mb-5 rounded text-red-700 text-sm">
            This password reset link is invalid or has expired. Please request a new one.
        </div>
        <% } %>

        <% if (errors != null && !errors.isEmpty()) { %>
        <div class="bg-red-50 border-l-4 border-red-600 p-4 mb-5 rounded text-red-700 text-sm">
            <ul class="ml-5 list-disc">
            <% for (String error : errors) { %>
                <li><%= error %></li>
            <% } %>
            </ul>
        </div>
        <% } %>

        <form id="resetPasswordForm" method="POST" action="${pageContext.request.contextPath}/reset-password">
            <input type="hidden" name="token" value="<%= validToken != null ? validToken : "" %>">

            <div class="mb-6">
                <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2">New Password</label>
                <div class="relative flex items-center">
                    <input
                        type="password"
                        id="newPassword"
                        name="newPassword"
                        class="w-full px-4 py-3 bg-gray-100 rounded text-sm text-gray-800 transition-colors duration-300 focus:bg-gray-200 focus:outline-none placeholder-gray-400"
                        placeholder="••••••••••••"
                        required
                        minlength="8"
                    >
                </div>
                <div class="password-strength flex gap-1 mt-2" id="strengthMeter">
                    <div class="strength-bar"></div>
                    <div class="strength-bar"></div>
                    <div class="strength-bar"></div>
                </div>
                <p class="text-xs text-gray-500 mt-2 leading-relaxed">Min. 8 characters including symbols.</p>
            </div>

            <!-- Confirm Password Field -->
            <div class="mb-6">
                <label class="block text-xs font-semibold text-gray-500 uppercase tracking-wide mb-2">Confirm New Password</label>
                <div class="relative flex items-center">
                    <input
                        type="password"
                        id="confirmPassword"
                        name="confirmPassword"
                        class="w-full px-4 py-3 bg-gray-100 rounded text-sm text-gray-800 transition-colors duration-300 focus:bg-gray-200 focus:outline-none placeholder-gray-400"
                        placeholder="••••••••••••"
                        required
                        minlength="8"
                    >
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="w-full mt-3 px-5 py-3 bg-orange-500 text-white rounded text-sm font-semibold cursor-pointer transition-all duration-200 flex items-center justify-center gap-2 hover:-translate-y-0.5 hover:shadow-lg hover:bg-orange-600 active:translate-y-0">
                Update Password
                <span class="text-base">→</span>
            </button>

            <!-- Footer Links -->
            <div class="flex justify-start items-center mt-6 pt-5 border-t border-gray-200">
                <a href="${pageContext.request.contextPath}/login" class="text-orange-500 no-underline text-xs font-medium flex items-center gap-1 transition-colors duration-300 hover:text-orange-700">
                    ← BACK TO LOGIN
                </a>
            </div>
        </form>
    </div>

    <script>
        // Toggle password visibility
        function togglePasswordVisibility(fieldId) {
            const field = document.getElementById(fieldId);
            if (field.type === 'password') {
                field.type = 'text';
            } else {
                field.type = 'password';
            }
        }

        // Password strength meter
        const newPasswordInput = document.getElementById('newPassword');
        const strengthMeter = document.getElementById('strengthMeter');

        newPasswordInput.addEventListener('input', function() {
            const password = this.value;
            const strength = calculatePasswordStrength(password);
            updateStrengthMeter(strength);
        });

        function calculatePasswordStrength(password) {
            let strength = 0;

            if (password.length >= 8) strength++;
            if (password.length >= 12) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/\d/.test(password)) strength++;
            if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)) strength++;

            return Math.min(strength, 3);
        }

        function updateStrengthMeter(strength) {
            const bars = strengthMeter.querySelectorAll('.strength-bar');
            bars.forEach((bar, index) => {
                bar.classList.remove('weak', 'medium', 'strong');
                if (index < strength) {
                    if (strength === 1) {
                        bar.classList.add('weak');
                    } else if (strength === 2) {
                        bar.classList.add('medium');
                    } else {
                        bar.classList.add('strong');
                    }
                }
            });
        }

        // Form validation
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
                return false;
            }

            if (newPassword.length < 8) {
                e.preventDefault();
                alert('Password must be at least 8 characters long!');
                return false;
            }

            if (!/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(newPassword)) {
                e.preventDefault();
                alert('Password must include at least one symbol!');
                return false;
            }
        });
    </script>
</body>
</html>
