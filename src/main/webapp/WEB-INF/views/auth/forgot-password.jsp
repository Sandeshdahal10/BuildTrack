<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 1:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Forgot Password</title>
    <style>
        :root {
            --bg: #edf1f5;
            --card: #ffffff;
            --text: #1f2937;
            --muted: #667085;
            --line: #e5e7eb;
            --brand: #e65101;
            --brand-dark: #bf510c;
            --input-bg: #f3f5f7;
            --success-bg: #ecfdf3;
            --success-text: #067647;
            --error-bg: #fef3f2;
            --error-text: #b42318;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 90vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(circle at 80% 50%, #f7f9fb 0%, transparent 34%), var(--bg);
            color: var(--text);
            display: grid;
            place-items: center;
            padding: 40px;
        }

        .auth-shell {
            width: 100%;
            max-width: 520px;
            padding: 0 12px;
        }

        .brand {
            text-align: center;
            margin-bottom: 20px;
        }

        .brand h1 {
            margin: 0;
            color: var(--brand);
            font-size: 48px;
            line-height: 1;
            letter-spacing: 0.2px;
            font-weight: 800;
        }

        .brand-line {
            width: 52px;
            height: 3px;
            background: var(--brand);
            margin: 14px auto 0;
        }

        .panel {
            background: linear-gradient(90deg, var(--card) 0%, var(--card) 78%, #f2f6f9 100%);
            border-left: 3px solid var(--brand);
            padding: 28px 24px 28px 34px;
            box-shadow: 0 10px 36px rgba(15, 23, 42, 0.08);
            margin: 0 auto;
            /*max-width: 56px;*/
        }

        h2 {
            margin: 0;
            font-size: 30px;
            font-weight: 600;
            letter-spacing: 0.2px;
        }

        .description {
            margin: 12px 0 20px;
            color: var(--muted);
            font-size: 15px;
            line-height: 1.5;
            max-width: 100%;
        }

        .page{
            padding: 60px 80px;
        }

        .message {
            border-radius: 8px;
            padding: 10px 12px;
            margin-bottom: 14px;
            font-size: 14px;
        }

        .message.success {
            background: var(--success-bg);
            color: var(--success-text);
        }

        .message.error {
            background: var(--error-bg);
            color: var(--error-text);
        }

        .field-label {
            display: block;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #7b6d59;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .email-input {
            width: 100%;
            border: 1px solid transparent;
            background: var(--input-bg);
            border-radius: 6px;
            padding: 12px;
            font-size: 14px;
            color: #374151;
            outline: none;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .email-input::placeholder {
            color: #b9bdc3;
        }

        .email-input:focus {
            border-color: #E65101;
            box-shadow: 0 0 0 4px rgba(230, 81, 1, 0.16);
        }

        .submit-btn {
            margin-top: 14px;
            width: 100%;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 15px;
            font-weight: 700;
            color: #ffffff;
            background: linear-gradient(90deg, #BF360C 0%, #E65101 100%);
            box-shadow: 0 7px 20px rgba(230, 81, 1, 0.28);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .submit-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 24px rgba(230, 81, 1, 0.33);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .return-link {
            text-align: center;
            margin-top: 20px;
        }

        .return-link a {
            color: var(--brand-dark);
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 13px;
            font-weight: 700;
        }

        .return-link a:hover {
            text-decoration: underline;
        }

        .footer {
            margin-top: 16px;
            color: #7e8188;
            text-transform: uppercase;
            font-size: 12px;
            letter-spacing: 0.8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
        }

        .status {
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .status-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #12b76a;
            display: inline-block;
        }

        @media (max-width: 1200px) {
            .brand h1 {
                font-size: 34px;
            }

            h2 {
                font-size: 28px;
            }

            .description,
            .message,
            .email-input {
                font-size: 14px;
            }

            .field-label {
                font-size: 12px;
            }

            .submit-btn {
                font-size: 14px;
            }

            .return-link a {
                font-size: 12px;
            }

            .footer {
                font-size: 11px;
            }
        }

        @media (max-width: 768px) {
            .panel {
                padding: 24px 16px 22px 24px;
            }

            .description {
                margin-bottom: 24px;
            }

            .footer {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<%
    String successMessage = (String) request.getAttribute("success");
    String errorMessage = (String) request.getAttribute("error");
%>
<main class="auth-shell">
    <section class="brand">
        <h1>BuildTrack</h1>
        <div class="brand-line"></div>
    </section>

    <section class="panel" aria-labelledby="forgot-title">
        <h2 id="forgot-title">Forgot Password</h2>
        <p class="description">
            Provide the email address associated with your account to receive instructions for resetting your password.
        </p>

        <% if (successMessage != null && !successMessage.trim().isEmpty()) { %>
        <div class="message success" role="status"><%= successMessage %></div>
        <% } %>

        <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
        <div class="message error" role="alert"><%= errorMessage %></div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/forgot-password">
            <label class="field-label" for="email">Email Address</label>
            <input
                    class="email-input"
                    id="email"
                    name="email"
                    type="email"
                    autocomplete="email"
                    required
                    placeholder="e.g. site.manager@buildtrack.com"
            >
            <button class="submit-btn" type="submit">Send Reset Link &rarr;</button>
        </form>

        <div class="return-link">
            <a href="${pageContext.request.contextPath}/login">&larr; Return to Login</a>
        </div>
    </section>

    <div class="footer">
        <div class="status"><span class="status-dot" aria-hidden="true"></span><span>Systems Operational</span></div>
        <span>v2.4.0-ERO</span>
    </div>
</main>
</body>
</html>
