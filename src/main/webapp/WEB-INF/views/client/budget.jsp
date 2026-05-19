<%--
  Created by IntelliJ IDEA.
  User: sande
  Date: 4/12/2026
  Time: 8:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // Compute dynamic CSS conic-gradient based on database cost distribution values
    java.util.Map<?, ?> budgetSummaryMap = (java.util.Map<?, ?>) request.getAttribute("budgetSummary");
    String conicGradientStr = "conic-gradient(#cbd5e1 0deg 360deg)";
    if (budgetSummaryMap != null && budgetSummaryMap.get("budgetDistribution") != null) {
        java.util.List<java.util.Map<String, Object>> distribution = 
            (java.util.List<java.util.Map<String, Object>>) budgetSummaryMap.get("budgetDistribution");
        if (distribution != null && !distribution.isEmpty()) {
            StringBuilder sb = new StringBuilder("conic-gradient(");
            double currentAngle = 0;
            for (int i = 0; i < distribution.size(); i++) {
                java.util.Map<String, Object> segment = distribution.get(i);
                Number percentNum = (Number) segment.get("percent");
                double percent = percentNum != null ? percentNum.doubleValue() : 0;
                double segmentAngle = percent * 3.6;
                String color = (String) segment.get("color");
                
                double nextAngle = currentAngle + segmentAngle;
                if (i == distribution.size() - 1) {
                    nextAngle = 360.0;
                }
                
                sb.append(color).append(" ").append(String.format(java.util.Locale.US, "%.1f", currentAngle)).append("deg ")
                  .append(String.format(java.util.Locale.US, "%.1f", nextAngle)).append("deg");
                
                if (i < distribution.size() - 1) {
                    sb.append(", ");
                }
                currentAngle = nextAngle;
            }
            sb.append(")");
            conicGradientStr = sb.toString();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Budget</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 text-slate-800 antialiased">
<div class="h-screen overflow-hidden">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div class="ml-0 md:ml-56 flex h-screen min-w-0 flex-1 flex-col overflow-hidden">
        <div class="sticky top-0 z-20 shrink-0">
            <jsp:include page="../common/Topbar.jsp" />
        </div>

        <main class="flex-1 overflow-y-auto px-6 py-6">
            <section class="budget-search-item mb-6" data-search="budget track expenditures">
                <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                        <h1 class="text-2xl font-bold text-slate-800">Budget Overview</h1>
                        <p class="mt-1 text-slate-500">Track project expenditures and budgets.</p>
                    </div>
                </div>
            </section>

            <section class="mt-3.5 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3.5">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Budget" />
                    <jsp:param name="value" value="NPR ${budgetSummary.totalBudget}" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Spent" />
                    <jsp:param name="value" value="NPR ${budgetSummary.totalSpent}" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Remaining" />
                    <jsp:param name="value" value="NPR ${budgetSummary.remainingBudget}" />
                </jsp:include>
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Utilization" />
                    <jsp:param name="value" value="${budgetSummary.utilizationPercent}%" />
                </jsp:include>
            </section>

            <section class="budget-search-item mt-4 rounded-2xl border border-slate-200 bg-white px-5 py-5 text-slate-900 shadow-[0_10px_24px_rgba(15,23,42,0.04)]" data-search="budget vs expenditure <c:forEach var='p' items='${budgetSummary.budgetProjects}'><c:out value='${p.title}'/> </c:forEach>">
                <h2 class="mb-4 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                    <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
                    Budget vs Expenditure
                </h2>

                <c:if test="${empty budgetSummary.budgetProjects}">
                    <p class="text-xs text-slate-400 py-6 text-center">No projects assigned to you yet.</p>
                </c:if>
                <c:forEach var="p" items="${budgetSummary.budgetProjects}" varStatus="loop">
                    <div class="${loop.index > 0 ? 'mt-6 border-t border-slate-100 pt-5' : ''}">
                        <div class="mb-2 flex items-center justify-between text-xs flex-wrap gap-2">
                            <span class="font-bold text-slate-800 text-sm">${p.title}</span>
                            <span class="text-slate-500 font-bold">
                                NPR <fmt:formatNumber value="${p.spent}" type="number" maxFractionDigits="0"/>
                                / NPR <fmt:formatNumber value="${p.budget}" type="number" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div class="h-2.5 w-full overflow-hidden rounded-full bg-slate-100 shadow-inner">
                            <div class="h-full rounded-full bg-gradient-to-r from-amber-400 via-amber-300 to-emerald-500 transition-all duration-500" style="width: ${p.usagePercent > 100 ? 100 : p.usagePercent}%"></div>
                        </div>
                        <div class="mt-2 flex items-center justify-between text-xs">
                            <span class="text-slate-400 font-semibold"><fmt:formatNumber value="${p.usagePercent}" maxFractionDigits="1"/>% utilized</span>
                            <span class="font-bold text-[9px] uppercase tracking-wider px-2.5 py-0.5 rounded-full ${p.statusClass}">${p.status}</span>
                        </div>
                    </div>
                </c:forEach>
            </section>

            <section class="mt-4 grid grid-cols-1 xl:grid-cols-2 gap-4">
                <article class="budget-search-item rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_10px_24px_rgba(15,23,42,0.04)]" data-search="cost distribution <c:forEach var='seg' items='${budgetSummary.budgetDistribution}'><c:out value='${seg.label}'/> </c:forEach>">
                    <h2 class="mb-4 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                        <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M21.21 15.89A10 10 0 1 1 8 2.83M22 12A10 10 0 0 0 12 2v10z"></path></svg>
                        Cost Distribution
                    </h2>
                    <div class="flex min-h-[280px] flex-col items-center justify-center">
                        <div class="relative h-44 w-44 rounded-full shadow-inner border border-slate-100 flex items-center justify-center transition duration-300 hover:scale-105" style="background: <%= conicGradientStr %>;">
                            <div class="absolute h-28 w-28 rounded-full bg-white flex flex-col items-center justify-center shadow-md border border-slate-100/40">
                                <span class="text-[9px] text-slate-400 font-extrabold uppercase tracking-widest">Total Spent</span>
                                <span class="text-sm font-black text-slate-800 mt-0.5">NPR <fmt:formatNumber value="${budgetSummary.totalSpent}" type="number" maxFractionDigits="0"/></span>
                            </div>
                        </div>
                        <div class="mt-6 flex flex-wrap justify-center gap-x-4 gap-y-2 text-[11px] text-slate-600 max-w-sm">
                            <c:forEach var="seg" items="${budgetSummary.budgetDistribution}">
                                <span class="inline-flex items-center gap-1.5 font-bold">
                                    <span class="h-2.5 w-2.5 rounded-full" style="background-color: ${seg.color}"></span>
                                    ${seg.label} (<fmt:formatNumber value="${seg.percent}" maxFractionDigits="1"/>%)
                                </span>
                            </c:forEach>
                            <c:if test="${empty budgetSummary.budgetDistribution}">
                                <span class="text-slate-400 text-xs py-4">No data logged yet.</span>
                            </c:if>
                        </div>
                    </div>
                </article>

                <article class="budget-search-item rounded-2xl border border-slate-200 bg-white p-5 text-slate-900 shadow-[0_10px_24px_rgba(15,23,42,0.04)]" data-search="material cost breakdown <c:forEach var='item' items='${budgetSummary.materialBreakdown}'><c:out value='${item.materialName}'/> </c:forEach>">
                    <h2 class="mb-4 mt-0 text-base font-bold text-slate-800 flex items-center gap-1.5">
                        <svg viewBox="0 0 24 24" class="w-4 h-4 text-orange-500" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2M12 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8z"></path></svg>
                        Material Cost Breakdown
                    </h2>
                    <div class="overflow-x-auto max-h-[300px] overflow-y-auto pr-1">
                        <table class="w-full border-collapse text-xs">
                            <thead>
                            <tr class="border-b border-slate-200 text-left text-[10px] font-bold uppercase tracking-wider text-slate-400 sticky top-0 bg-white z-10">
                                <th class="px-2 py-2 pb-3">Material</th>
                                <th class="px-2 py-2 pb-3">Quantity</th>
                                <th class="px-2 py-2 pb-3 text-right">Cost</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${budgetSummary.materialBreakdown}">
                                <tr class="border-b border-slate-100 hover:bg-slate-50/50 transition">
                                    <td class="px-2 py-2.5 font-bold text-slate-800 text-sm">${item.materialName}</td>
                                    <td class="px-2 py-2.5 font-bold text-slate-400">
                                        <fmt:formatNumber value="${item.quantityUsed}" type="number" maxFractionDigits="2"/> ${item.materialUnit}
                                    </td>
                                    <td class="px-2 py-2.5 font-black text-slate-800 text-right">
                                        NPR <fmt:formatNumber value="${item.totalCost}" type="number" groupingUsed="true" maxFractionDigits="0"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty budgetSummary.materialBreakdown}">
                                <tr>
                                    <td colspan="3" class="text-xs text-slate-400 text-center py-10">No material usage logged yet.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </article>
            </section>
            <p id="emptySearchState" class="mt-4 hidden rounded-xl border border-slate-200 bg-white px-4 py-3 text-sm text-slate-600">No budget results matched your search.</p>
        </main>
    </div>
</div>
</body>
</html>
