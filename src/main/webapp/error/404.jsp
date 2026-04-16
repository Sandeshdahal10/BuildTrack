<%--
  Created by IntelliJ IDEA.
  User: karki
  Date: 4/14/2026
  Time: 6:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: linear-gradient(135deg, #f5f5f5 0%, #e8e8e8 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding: 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            margin-top: 20px;
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #f5a623;
            letter-spacing: 1px;
        }

        .logo-icon {
            font-size: 32px;
            margin-right: 8px;
            display: inline-block;
        }

        .divider {
            width: 80px;
            height: 4px;
            background: linear-gradient(to right, #f5a623, #ffb84d);
            margin: 12px auto;
            border-radius: 2px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            padding: 50px 40px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            text-align: center;
        }

        .error-code {
            font-size: 120px;
            font-weight: 900;
            color: #f5a623;
            margin-bottom: 20px;
            line-height: 1;
            text-shadow: 2px 2px 4px rgba(245, 166, 35, 0.1);
        }

        h1 {
            font-size: 32px;
            color: #2c3e50;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .subtitle {
            color: #7f8c8d;
            font-size: 16px;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .submit-btn {
            width: 100%;
            max-width: 300px;
            padding: 14px 30px;
            background: #f5a623;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(245, 166, 35, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        .button-arrow {
            font-size: 18px;
        }

        .info-box {
            background: #fff8e6;
            border-left: 4px solid #f5a623;
            padding: 20px;
            margin-top: 40px;
            border-radius: 4px;
            display: flex;
            gap: 15px;
        }

        .info-icon {
            font-size: 24px;
            color: #f5a623;
            flex-shrink: 0;
            line-height: 1.4;
        }

        .info-text {
            font-size: 14px;
            color: #2c3e50;
            line-height: 1.6;
            text-align: left;
        }

        @media (max-width: 600px) {
            .container {
                padding: 40px 25px;
            }

            .error-code {
                font-size: 80px;
            }

            h1 {
                font-size: 24px;
            }

            .subtitle {
                font-size: 14px;
            }

            .submit-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <span class="logo-icon">⚙️</span>BuildTrack
        </div>
        <div class="divider"></div>
    </div>

    <div class="container">
        <div class="error-code">404</div>
        <h1>Page Not Found</h1>
        <p class="subtitle">
            The page you are looking for does not exist or may have been moved.
            Don't worry, let's get you back on track.
        </p>

        <a class="submit-btn" href="${pageContext.request.contextPath}/auth/login">
            ← BACK TO LOGIN
            <span class="button-arrow">→</span>
        </a>

        <div class="info-box">
            <div class="info-icon">ℹ️</div>
            <div class="info-text">
                If you believe this is an error, please contact the BuildTrack support team at
                <strong>support@buildtrack.com</strong> with details about the page you were trying to access.
            </div>
        </div>
    </div>
</body>
</html>
