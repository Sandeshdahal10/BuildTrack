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
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #ffffff;
            color: #111827;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }
        .page {
            width: 100%;
            max-width: 560px;
            background: #ffffff;
            border-radius: 16px;
            padding: 28px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }
        .brand {
            text-align: center;
            margin-bottom: 24px;
        }
        .logo {
            width: 76px;
            height: 76px;
            margin: 0 auto 12px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb, #0ea5e9);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 26px;
            letter-spacing: 1px;
        }
        .brand h1 {
            margin: 0;
            font-size: 28px;
            color: #E65101;
        }
        .brand p {
            margin: 6px 0 0;
            color: #475569;
            font-size: 14px;
        }
        h2 {
            margin: 0;
            font-size: 24px;
            color: #0f172a;
        }
        .subtitle {
            margin: 8px 0 18px;
            color: #64748b;
            font-size: 14px;
        }
        .alert {
            border-radius: 10px;
            padding: 10px 12px;
            margin-bottom: 12px;
            font-size: 14px;
        }
        .alert-warning { background: #fff7ed; color: #9a3412; border: 1px solid #fdba74; }
        .alert-success { background: #ecfdf5; color: #166534; border: 1px solid #86efac; }
        .alert-error { background: #fef2f2; color: #991b1b; border: 1px solid #fca5a5; }
        .alert ul {
            margin: 0;
            padding-left: 18px;
        }
        form { margin-top: 8px; }
        .label-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 6px;
            font-size: 14px;
            color: #1f2937;
            font-weight: 600;
        }
        a {
            color: #1d4ed8;
            text-decoration: none;
        }
        a:hover { text-decoration: underline; }
        .accent-link { color: #E65101; }
        .field {
            width: 100%;
            height: 44px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            padding: 0 12px;
            font-size: 14px;
            margin-bottom: 14px;
            outline: none;
        }
        .field:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .checkbox-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 4px 0 16px;
            font-size: 14px;
            color: #334155;
        }
        .submit-btn {
            width: 100%;
            border: none;
            border-radius: 10px;
            background: #E65101;
            color: #ffffff;
            font-weight: 700;
            height: 46px;
            font-size: 15px;
            cursor: pointer;
        }
        .submit-btn:hover { background: #d84315; }
        .register {
            margin: 16px 0 18px;
            text-align: center;
            font-size: 14px;
            color: #475569;
        }
        .feature-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .feature {
            border: 1px solid #dbeafe;
            background: #f8fbff;
            border-radius: 10px;
            padding: 12px;
        }
        .feature-title {
            margin: 0;
            color: #0f172a;
            font-size: 14px;
            font-weight: 700;
        }
        .feature-text {
            margin: 6px 0 0;
            color: #475569;
            font-size: 13px;
        }
        .footer-links {
            margin-top: 18px;
            text-align: center;
            font-size: 13px;
            color: #64748b;
        }
        .footer-links a { margin: 0 8px; }
        @media (max-width: 600px) {
            .page { padding: 22px; }
            .feature-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<main class="page">
    <section class="brand">
        <div class="logo">BT</div>
        <h1>BuildTrack</h1>
        <p>Advanced Construction Project Management</p>
    </section>

    <h2>Welcome Back</h2>
    <p class="subtitle">Enter your credentials to access your site dashboard.</p>

    <% if (authWarning != null) { %>
    <div class="alert alert-warning"><%= authWarning %></div>
    <% } %>

    <% if (registered) { %>
    <div class="alert alert-success">Registration successful. You can now sign in.</div>
    <% } %>

    <% if (resetSuccess) { %>
    <div class="alert alert-success">Password reset successful. Please sign in with your new password.</div>
    <% } %>

    <% if (errors != null && !errors.isEmpty()) { %>
    <div class="alert alert-error">
        <ul>
            <% for (String err : errors) { %>
            <li><%= err %></li>
            <% } %>
        </ul>
    </div>
    <% } %>

    <form method="post" action="<%= request.getContextPath() %>/login">
        <label class="label-row" for="email">Email Address</label>
        <input class="field" type="email" id="email" name="email"
               placeholder="name@company.com"
               value="<%= preservedEmail == null ? "" : preservedEmail %>" required>

        <div class="label-row">
            <label for="password">Password</label>
            <a class="accent-link" href="<%= request.getContextPath() %>/forgot-password">Forgot?</a>
        </div>
        <input class="field" type="password" id="password" name="password"
               placeholder="Enter your password" required>

        <label class="checkbox-row" for="rememberMe">
            <input type="checkbox" id="rememberMe" name="rememberMe">
            Keep me logged in on this device
        </label>

        <button class="submit-btn" type="submit">Sign in to Dashboard -&gt;</button>
    </form>

    <p class="register">
        New to BuildTrack?
        <a class="accent-link" href="<%= request.getContextPath() %>/register">Register Account</a>
    </p>

    <section class="feature-grid">
        <article class="feature">
            <p class="feature-title">SECURE ACCESS</p>
            <p class="feature-text">256-bit AES Encryption</p>
        </article>
        <article class="feature">
            <p class="feature-title">LIVE SYNC</p>
            <p class="feature-text">Real-time Site Updates</p>
        </article>
    </section>

    <footer class="footer-links">
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
        <a href="#">Contact Support</a>
    </footer>
</main>
</body>
</html>

