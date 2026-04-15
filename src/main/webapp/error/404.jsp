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
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
            color: #111827;
            padding: 24px;
        }

        .page {
            width: 100%;
            max-width: 560px;
            background: #ffffff;
            border-radius: 16px;
            padding: 28px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }

        h1 {
            margin: 0 0 8px;
            color: #0f172a;
            font-size: 28px;
        }

        p {
            margin: 0 0 20px;
            color: #475569;
        }

        .submit-btn {
            display: inline-block;
            min-width: 220px;
            border: none;
            border-radius: 10px;
            background: #E65101;
            color: #ffffff;
            font-weight: 700;
            line-height: 46px;
            height: 46px;
            font-size: 15px;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #d84315;
            text-decoration: none;
        }
    </style>
</head>
<body>
<main class="page">
    <h1>404 - Page Not Found</h1>
    <p>The page you are looking for does not exist.</p>
    <a class="submit-btn" href="login">Go Back</a>
</main>
</body>
</html>
