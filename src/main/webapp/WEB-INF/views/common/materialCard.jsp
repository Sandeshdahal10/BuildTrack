    <%--
      Created by IntelliJ IDEA.
      User: Dell
      Date: 4/16/2026
      Time: 4:56 PM
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
    <head>
        <title>Title</title>
    </head>
    <body>
    <div class="border rounded-lg p-4 transition hover:shadow-sm">

        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">

            <!-- Left: Icon & Name -->
            <div class="flex items-center gap-4">
                <div class="w-10 h-10 rounded-lg  flex items-center justify-center ">
                    <i data-lucide="${param.icon}" class="w-5 h-5"></i>
                </div>
                <div>
                    <h3 class="font-semibold text-slate-800">${param.name}</h3>
                    <p class="text-xs text-slate-500">Unit: ${param.unit}</p>
                </div>
            </div>

            <!-- Middle: Stats -->
            <div class="flex items-center gap-6 text-sm">
                <div class="text-center">
                    <p class="text-slate-400 text-xs">In Stock</p>
                    <p class="font-bold ">${param.stock}</p>
                </div>
                <div class="text-center">
                    <p class="text-slate-400 text-xs">Unit Price</p>
                    <p class="font-bold text-slate-800">${param.price}</p>
                </div>
                <div class="text-center">
                    <p class="text-slate-400 text-xs">Total Value</p>
                    <p class="font-bold text-orange-600">${param.totalValue}</p>
                </div>
            </div>

            <!-- Right: Status & Actions -->
            <div class="flex items-center gap-3">
                <span class="px-2.5 py-1 rounded-full text-xs font-bold ">
                    ${param.status}
                </span>
                <a href="${param.editLink}" class="p-2 rounded-lg hover:bg-white text-slate-500 hover:text-slate-800 transition">
                    <i data-lucide="pencil" class="w-4 h-4"></i>
                </a>
            </div>

        </div>
    </div>
    </body>
    </html>
