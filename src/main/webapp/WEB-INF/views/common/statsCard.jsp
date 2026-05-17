<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String title = request.getParameter("title");
    String value = request.getParameter("value");
    String subtitle = request.getParameter("subtitle");
    String icon = request.getParameter("icon");

    // customizable colors (with defaults)
    String bgClass = request.getParameter("bgClass") != null ? request.getParameter("bgClass") : "bg-white";
    String iconWrapClass = request.getParameter("iconWrapClass");
    if (iconWrapClass == null || iconWrapClass.trim().isEmpty()) {
        iconWrapClass = request.getParameter("iconBgClass");
    }
    if (iconWrapClass == null || iconWrapClass.trim().isEmpty()) {
        iconWrapClass = "p-3 rounded-lg bg-slate-100";
    }

    String iconClass = request.getParameter("iconClass");
    if (iconClass == null || iconClass.trim().isEmpty()) {
        iconClass = request.getParameter("iconColorClass");
    }
    if (iconClass == null || iconClass.trim().isEmpty()) {
        iconClass = "w-5 h-5 text-slate-600";
    }
%>

<div class="<%= bgClass %> border border-slate-200 rounded-xl p-5 shadow-sm">
    <div class="flex items-center justify-between">

        <div>
            <p class="text-xs font-semibold uppercase text-slate-400">
                <%= title != null ? title : "" %>
            </p>

            <p class="text-2xl font-bold text-slate-800 mt-1">
                <%= value != null ? value : "" %>
            </p>

            <% if (subtitle != null && !subtitle.isEmpty()) { %>
            <p class="mt-2 text-xs text-slate-500">
                <%= subtitle %>
            </p>
            <% } %>
        </div>

        <% if (icon != null && !icon.isEmpty()) { %>
        <div class="<%= iconWrapClass %>">
            <i data-lucide="<%= icon %>" class="<%= iconClass %>"></i>
        </div>
        <% } %>

    </div>
</div>
