<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 4/16/2026
  Time: 5:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="border-l-4 border-orange-500 bg-slate-50 p-3 rounded-r-lg">
    <div class="flex justify-between items-start">
        <div>
            <p class="font-semibold text-sm text-slate-800">${param.materialName}</p>
            <p class="text-xs text-slate-500">${param.projectName}</p>
        </div>
        <span class="text-xs font-bold text-orange-600">${param.quantity}</span>
    </div>
    <div class="flex items-center gap-2 mt-2 text-xs text-slate-500">
        <span>Admin: ${param.admin}</span>
        <span>•</span>
        <span>${param.date}</span>
    </div>
    <p class="text-xs font-medium text-slate-600 mt-1">Cost: ${param.cost}</p>
</div>
</body>
</html>
