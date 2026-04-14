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
        .card {
            width: 100%;
            max-width: 1020px;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
            border: 1px solid #f1f5f9;
            overflow: hidden;
            display: grid;
            grid-template-columns: 1fr 1.2fr;
        }
        .left-panel {
            padding: 36px 30px;
            background: linear-gradient(160deg, #fffaf5 0%, #ffffff 100%);
            border-right: 1px solid #f3f4f6;
        }
        .left-panel h1 {
            margin: 0;
            color: #E65101;
            line-height: 1.25;
            font-size: 32px;
        }
        .left-panel p {
            margin: 16px 0;
            color: #475569;
            font-size: 15px;
            line-height: 1.55;
        }
        .stat {
            margin-top: 18px;
            display: inline-block;
            border: 1px solid #ffedd5;
            background: #fff7ed;
            color: #9a3412;
            border-radius: 999px;
            padding: 8px 14px;
            font-size: 13px;
            font-weight: 700;
        }
        .right-panel {
            padding: 30px;
        }
        h2 {
            margin: 0;
            color: #0f172a;
            font-size: 28px;
        }
        .subtitle {
            margin: 8px 0 16px;
            color: #64748b;
            font-size: 14px;
        }
        .alert {
            border-radius: 10px;
            padding: 10px 12px;
            margin-bottom: 14px;
            background: #fef2f2;
            color: #991b1b;
            border: 1px solid #fca5a5;
            font-size: 14px;
        }
        .alert ul {
            margin: 0;
            padding-left: 18px;
        }
        form { margin-top: 4px; }
        .label {
            margin-bottom: 6px;
            font-size: 14px;
            color: #1f2937;
            font-weight: 600;
            display: block;
        }
        .field {
            width: 100%;
            height: 44px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            padding: 0 12px;
            font-size: 14px;
            margin-bottom: 12px;
            outline: none;
            background: #ffffff;
        }
        .field:focus {
            border-color: #E65101;
            box-shadow: 0 0 0 3px rgba(230, 81, 1, 0.16);
        }
        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .submit-btn {
            margin-top: 8px;
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
        .notice {
            margin-top: 14px;
            font-size: 13px;
            color: #64748b;
            line-height: 1.5;
            border-left: 3px solid #E65101;
            padding-left: 10px;
        }
        .login-link {
            margin-top: 14px;
            font-size: 14px;
            color: #475569;
        }
        .login-link a {
            color: #E65101;
            text-decoration: none;
            font-weight: 600;
        }
        .login-link a:hover { text-decoration: underline; }
        @media (max-width: 920px) {
            .card {
                grid-template-columns: 1fr;
            }
            .left-panel {
                border-right: none;
                border-bottom: 1px solid #f3f4f6;
            }
        }
        @media (max-width: 640px) {
            body { padding: 16px; }
            .left-panel, .right-panel { padding: 22px; }
            .grid-2 { grid-template-columns: 1fr; gap: 0; }
        }
    </style>
</head>
<body>
<main class="card">
    <section class="left-panel">
        <h1>The Digital Monument to Project Management.</h1>
        <p>Precision, structural integrity, and layered complexity. Register to access the master architect's dashboard.</p>
        <span class="stat">Join 1,000+ project leads</span>
    </section>

    <section class="right-panel">
        <h2>Create Account</h2>
        <p class="subtitle">Please fill in your details to start your project journey.</p>

        <% if (errors != null && !errors.isEmpty()) { %>
        <div class="alert">
            <ul>
                <% for (String err : errors) { %>
                <li><%= err %></li>
                <% } %>
            </ul>
        </div>
        <% } %>

        <form method="post" action="<%= request.getContextPath() %>/register">
            <label class="label" for="fullName">First Name</label>
            <input class="field" type="text" id="fullName" name="fullName"
                   placeholder="Enter first name"
                   value="<%= fullName == null ? "" : fullName %>" required>

            <div class="grid-2">
                <div>
                    <label class="label" for="email">Email</label>
                    <input class="field" type="email" id="email" name="email"
                           placeholder="name@company.com"
                           value="<%= email == null ? "" : email %>" required>
                </div>
                <div>
                    <label class="label" for="phone">Phone Number</label>
                    <input class="field" type="tel" id="phone" name="phone"
                           placeholder="+1 555 123 4567"
                           value="<%= phone == null ? "" : phone %>" required>
                </div>
            </div>

            <div class="grid-2">
                <div>
                    <label class="label" for="dob">DOB</label>
                    <input class="field" type="text" id="dob" name="dob" placeholder="mm/dd/yyyy">
                </div>
                <div>
                    <label class="label" for="role">Role Selection</label>
                    <select class="field" id="role" name="role" required>
                        <option value="">Select Role</option>
                        <option value="CLIENT" <%= "CLIENT".equalsIgnoreCase(role) ? "selected" : "" %>>Client</option>
                        <option value="WORKER" <%= "WORKER".equalsIgnoreCase(role) ? "selected" : "" %>>Worker</option>
                    </select>
                </div>
            </div>

            <div class="grid-2">
                <div>
                    <label class="label" for="password">Password</label>
                    <input class="field" type="password" id="password" name="password"
                           placeholder="Enter password" required>
                </div>
                <div>
                    <label class="label" for="confirmPassword">Confirm Password</label>
                    <input class="field" type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Confirm password" required>
                </div>
            </div>

            <button class="submit-btn" type="submit">Complete Registration -&gt;</button>
        </form>

        <p class="notice">!Your registration will be reviewed by Admin. Access to the BuildTrack platform will be granted upon verification of your credentials.</p>

        <p class="login-link">
            Already have an account?
            <a href="<%= request.getContextPath() %>/login">Log in</a>
        </p>
    </section>
</main>
</body>
</html>
