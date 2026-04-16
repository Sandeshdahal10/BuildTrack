<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "sag";
    String basePath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Client Dashboard</title>
    <style>
        :root {
            --surface-1: #ffffff;
            --surface-2: #ffffff;
            --surface-3: #ffffff;
            --line: rgba(15, 23, 42, 0.12);
            --text-main: #0f172a;
            --text-soft: #475569;
            --accent: #f6a523;
            --accent-2: #27c9b5;
            --warn: #c59312;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #ffffff;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-main);
            padding: 0;
        }

        .dashboard-shell {
            display: grid;
            grid-template-columns: 214px minmax(0, 1fr);
            min-height: 100vh;
            width: 100%;
            background: #ffffff;
            border-radius: 0;
            overflow: hidden;
            border: none;
        }

        .sidebar {
            border-right: 1px solid var(--line);
            display: flex;
            flex-direction: column;
            background: #062a63;
            color: #e8f0ff;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 14px;
            border-bottom: 1px solid var(--line);
            font-weight: 700;
            color: #ffffff;
        }

        .brand-title {
            font-size: 22px;
            line-height: 1;
            letter-spacing: 0.1px;
        }

        .logo-dot {
            width: 26px;
            height: 26px;
            border-radius: 8px;
            display: grid;
            place-items: center;
            background: linear-gradient(140deg, #ffbe35, #f29a10);
            color: #18284e;
            box-shadow: 0 3px 10px rgba(246, 165, 35, 0.35);
        }

        .logo-dot svg {
            width: 15px;
            height: 15px;
            stroke: #1f2e4d;
            stroke-width: 2;
            fill: none;
            stroke-linecap: round;
            stroke-linejoin: round;
        }

        .nav {
            padding: 10px;
            display: grid;
            gap: 4px;
        }

        .nav a {
            text-decoration: none;
            color: #cfe0ff;
            font-size: 13px;
            border-radius: 8px;
            padding: 9px 11px;
            display: flex;
            gap: 9px;
            align-items: center;
            border: 1px solid transparent;
        }

        .nav a svg {
            width: 16px;
            height: 16px;
            stroke: currentColor;
            stroke-width: 2;
            fill: none;
            stroke-linecap: round;
            stroke-linejoin: round;
            flex: 0 0 auto;
        }

        .nav a.active {
            color: #ffd58a;
            background: rgba(246, 165, 35, 0.22);
            border-color: rgba(246, 165, 35, 0.46);
        }

        .nav a:hover {
            background: rgba(255, 255, 255, 0.12);
            color: #ffffff;
        }

        .logout {
            margin-top: auto;
            border-top: 1px solid rgba(207, 224, 255, 0.22);
            padding: 12px 10px;
        }

        .main {
            /*background-image:*/
            /*        linear-gradient(rgba(15, 23, 42, 0.04) 1px, transparent 1px),*/
            /*        linear-gradient(90deg, rgba(15, 23, 42, 0.04) 1px, transparent 1px);*/
            background-size: 44px 44px;
            padding: 16px 20px 28px;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            /*gap: 12px;*/
            margin-bottom: 12px;
            color: var(--text-soft);
            font-size: 11px;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 9px;
        }

        .search {
            border: 1px solid var(--line);
            background: #ffffff;
            color: #0f172a;
            border-radius: 7px;
            padding: 7px 10px;
            min-width: 205px;
            font-size: 12px;
            outline: none;
        }

        .notify-btn {
            width: 28px;
            height: 28px;
            border-radius: 999px;
            border: 1px solid var(--line);
            display: grid;
            place-items: center;
            color: #0f172a;
            background: #ffffff;
            position: relative;
            padding: 0;
            cursor: pointer;
        }

        .notify-btn svg {
            width: 14px;
            height: 14px;
            stroke: #0f172a;
            stroke-width: 2;
            fill: none;
            stroke-linecap: round;
            stroke-linejoin: round;
        }

        .notify-badge {
            position: absolute;
            top: -3px;
            right: -2px;
            min-width: 14px;
            height: 14px;
            padding: 0 3px;
            border-radius: 999px;
            background: #f59e0b;
            color: #1f2937;
            border: 1px solid #ffffff;
            font-size: 9px;
            font-weight: 700;
            line-height: 12px;
            text-align: center;
        }

        .user {
            display: flex;
            align-items: center;
            gap: 7px;
            border: 1px solid var(--line);
            border-radius: 999px;
            padding: 3px 8px 3px 4px;
            background: #ffffff;
        }

        .avatar {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            background: #f0c463;
            color: #2a3556;
            font-size: 11px;
            font-weight: 700;
        }

        .card {
            border: 1px solid var(--line);
            background: #ffffff;
            border-radius: 14px;
            padding: 18px 20px;
            box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
            transition: transform 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease;
        }

        .card:hover {
            transform: translateY(-3px);
            border-color: rgba(15, 23, 42, 0.2);
            box-shadow: 0 16px 30px rgba(15, 23, 42, 0.12);
        }

        .card:focus-within {
            border-color: rgba(246, 165, 35, 0.45);
        }

        .welcome h1 {
            margin: 0;
            font-size: 34px;
            font-weight: 700;
        }

        .welcome p {
            margin: 4px 0 0;
            color: var(--text-soft);
            font-size: 12px;
        }

        .stats {
            margin-top: 14px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
        }

        .stat-title {
            margin: 0;
            font-size: 11px;
            letter-spacing: 0.4px;
            color: var(--text-soft);
            text-transform: uppercase;
        }

        .stat-value {
            margin: 5px 0 2px;
            font-size: 36px;
            font-weight: 700;
            line-height: 1;
        }

        .stat-sub {
            margin: 0;
            color: #64748b;
            font-size: 11px;
        }

        .projects,
        .updates {
            margin-top: 14px;
        }

        .section-title {
            margin: 0 0 14px;
            font-size: 16px;
            font-weight: 700;
        }

        .project-row {
            border-top: 1px solid var(--line);
            padding-top: 16px;
            margin-top: 16px;
        }

        .project-row:first-of-type {
            border-top: none;
            padding-top: 0;
            margin-top: 0;
        }

        .project-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 7px;
        }

        .project-name {
            margin: 0;
            font-size: 14px;
            font-weight: 600;
        }

        .project-sub {
            margin: 2px 0 0;
            color: var(--text-soft);
            font-size: 11px;
        }

        .badge {
            font-size: 10px;
            font-weight: 700;
            color: #9a5a00;
            border: 1px solid rgba(246, 165, 35, 0.38);
            background: #fff7ed;
            border-radius: 999px;
            padding: 3px 9px;
            white-space: nowrap;
        }

        .bar {
            width: 100%;
            height: 8px;
            border-radius: 999px;
            background: rgba(148, 163, 184, 0.28);
            overflow: hidden;
            margin: 8px 0 7px;
        }

        .bar > div {
            height: 100%;
            border-radius: inherit;
            background: linear-gradient(90deg, var(--accent) 0%, #dac870 56%, var(--accent-2) 100%);
        }

        .bar-68 {
            width: 68%;
        }

        .bar-45 {
            width: 45%;
        }

        .project-meta {
            display: flex;
            justify-content: space-between;
            color: #64748b;
            font-size: 10px;
        }

        .timeline {
            margin: 0;
            padding: 0;
            list-style: none;
            display: grid;
            gap: 16px;
        }

        .timeline li {
            display: grid;
            grid-template-columns: 18px minmax(0, 1fr);
            gap: 10px;
            align-items: start;
        }

        .dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-top: 3px;
            border: 1px solid rgba(15, 23, 42, 0.2);
            background: #94a3b8;
        }

        .dot.teal {
            background: #2dbeb3;
        }

        .dot.yellow {
            background: var(--warn);
        }

        .update-title {
            margin: 0;
            font-size: 13px;
        }

        .update-time {
            margin: 2px 0 0;
            color: #64748b;
            font-size: 10px;
        }

        @media (max-width: 1100px) {
            .dashboard-shell {
                grid-template-columns: 1fr;
            }

            .sidebar {
                min-height: auto;
            }

            .logout {
                margin-top: 0;
            }
        }

        @media (max-width: 760px) {
            .stats {
                grid-template-columns: 1fr;
            }

            .topbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .topbar-right {
                width: 100%;
                flex-wrap: wrap;
            }

            .search {
                min-width: 0;
                flex: 1;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            .card {
                transition: none;
            }

            .card:hover {
                transform: none;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-shell">
    <aside class="sidebar">
        <div class="brand">
            <div class="logo-dot" aria-hidden="true">
                <svg viewBox="0 0 24 24" role="img" aria-label="BuildTrack logo">
                    <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="14" width="6" height="6" rx="1"></rect>
                </svg>
            </div>
            <span class="brand-title">BuildTrack</span>
        </div>

        <nav class="nav">
            <a class="active" href="<%= basePath %>/client/dashboard">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <rect x="4" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="4" width="6" height="6" rx="1"></rect>
                    <rect x="4" y="14" width="6" height="6" rx="1"></rect>
                    <rect x="14" y="14" width="6" height="6" rx="1"></rect>
                </svg>
                <span>Dashboard</span>
            </a>
            <a href="<%= basePath %>/client/project">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M3 7h6l2 2h10v8a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7z"></path>
                    <path d="M3 7a2 2 0 0 1 2-2h4l2 2"></path>
                </svg>
                <span>My Projects</span>
            </a>
            <a href="<%= basePath %>/client/budget">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <path d="M12 3v18"></path>
                    <path d="M16 7.5c0-1.7-1.8-3-4-3s-4 1.3-4 3 1.5 2.5 4 3 4 1.3 4 3-1.8 3-4 3-4-1.3-4-3"></path>
                </svg>
                <span>Budget</span>
            </a>
            <a href="#">
                <svg viewBox="0 0 24 24" aria-hidden="true">
                    <circle cx="12" cy="8" r="3.5"></circle>
                    <path d="M5 20c.8-3.5 3.5-5.5 7-5.5s6.2 2 7 5.5"></path>
                </svg>
                <span>Profile</span>
            </a>
        </nav>

        <div class="logout">
            <nav class="nav" style="padding:0;">
                <a href="<%= basePath %>/logout">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                        <path d="M16 17l5-5-5-5"></path>
                        <path d="M21 12H9"></path>
                    </svg>
                    <span>Logout</span>
                </a>
            </nav>
        </div>
    </aside>

    <main class="main">
        <div class="topbar">
            <div>Thursday, April 16, 2026</div>
            <div class="topbar-right">
                <input class="search" type="text" placeholder="Search..." aria-label="Search">
                <button class="notify-btn" type="button" aria-label="Notifications">
                    <svg viewBox="0 0 24 24" aria-hidden="true">
                        <path d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 0 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5"></path>
                        <path d="M9 17a3 3 0 0 0 6 0"></path>
                    </svg>
                    <span class="notify-badge">1</span>
                </button>
                <div class="user">
                    <div class="avatar"><%= displayName.substring(0, 1).toUpperCase() %></div>
                    <span style="font-size:12px;"><%= displayName %></span>
                </div>
            </div>
        </div>

        <section class="card welcome">
            <h1>Welcome, <%= displayName %></h1>
            <p>Stay updated on your construction projects.</p>
        </section>

        <section class="stats">
            <article class="card">
                <p class="stat-title">Active Projects</p>
                <p class="stat-value">2</p>
                <p class="stat-sub">Both on track</p>
            </article>

            <article class="card">
                <p class="stat-title">Budget Spent</p>
                <p class="stat-value" style="font-size:40px;">&#8377;48.4L / &#8377;82.0L</p>
                <p class="stat-sub">59% utilized</p>
            </article>
        </section>

        <section class="projects card">
            <h2 class="section-title">Your Projects</h2>

            <div class="project-row">
                <div class="project-head">
                    <div>
                        <p class="project-name">Skyline Tower Complex</p>
                        <p class="project-sub">12 workers assigned</p>
                    </div>
                    <span class="badge">In Progress</span>
                </div>
                <div class="bar"><div class="bar-68"></div></div>
                <div class="project-meta">
                    <span>Budget: &#8377;50.0L &nbsp;&nbsp; Spent: &#8377;34.0L</span>
                    <span>68%</span>
                </div>
            </div>

            <div class="project-row">
                <div class="project-head">
                    <div>
                        <p class="project-name">Green Valley Residency</p>
                        <p class="project-sub">8 workers assigned</p>
                    </div>
                    <span class="badge">In Progress</span>
                </div>
                <div class="bar"><div class="bar-45"></div></div>
                <div class="project-meta">
                    <span>Budget: &#8377;32.0L &nbsp;&nbsp; Spent: &#8377;14.4L</span>
                    <span>45%</span>
                </div>
            </div>
        </section>

        <section class="updates card">
            <h2 class="section-title">Recent Updates</h2>
            <ul class="timeline">
                <li>
                    <span class="dot teal"></span>
                    <div>
                        <p class="update-title">Skyline Tower reached 68% completion milestone</p>
                        <p class="update-time">2 hours ago</p>
                    </div>
                </li>
                <li>
                    <span class="dot"></span>
                    <div>
                        <p class="update-title">Monthly progress report for January is ready</p>
                        <p class="update-time">1 day ago</p>
                    </div>
                </li>
                <li>
                    <span class="dot yellow"></span>
                    <div>
                        <p class="update-title">Budget review meeting scheduled for Feb 5</p>
                        <p class="update-time">2 days ago</p>
                    </div>
                </li>
                <li>
                    <span class="dot"></span>
                    <div>
                        <p class="update-title">Green Valley exterior work started</p>
                        <p class="update-time">3 days ago</p>
                    </div>
                </li>
            </ul>
        </section>
    </main>
</div>
</body>
</html>
