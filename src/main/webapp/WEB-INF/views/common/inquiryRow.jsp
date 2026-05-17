<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="bg-white border border-slate-200 rounded-xl p-5 shadow-sm hover:shadow-md transition duration-200 flex flex-col gap-4">
    <!-- Header info -->
    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-3 border-b border-slate-100 pb-3">
        <div class="flex items-start gap-3">
            <div class="w-10 h-10 rounded-full bg-orange-100 text-orange-600 flex items-center justify-center flex-shrink-0">
                <i data-lucide="message-square" class="w-5 h-5"></i>
            </div>
            <div>
                <span class="text-[10px] font-bold text-orange-600 uppercase bg-orange-50 px-2 py-0.5 rounded-full">${param.project}</span>
                <h4 class="font-bold text-slate-800 text-sm mt-1">${param.subject}</h4>
                <p class="text-xs text-slate-500 mt-0.5">
                    From: <span class="font-semibold text-slate-700">${param.client}</span> • <span class="text-slate-400">${param.date}</span>
                </p>
            </div>
        </div>
        
        <div>
            <c:choose>
                <c:when test="${param.status == 'RESOLVED' || param.status == 'Resolved' || param.status == 'COMPLETED' || param.status == 'Completed'}">
                    <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-emerald-50 px-2.5 py-1 text-emerald-700 border border-emerald-200">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span> Completed
                    </span>
                </c:when>
                <c:when test="${param.status == 'IN_PROGRESS' || param.status == 'In Progress' || param.status == 'IN PROGRESS'}">
                    <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-blue-50 px-2.5 py-1 text-blue-700 border border-blue-200">
                        <span class="w-1.5 h-1.5 rounded-full bg-blue-500 animate-pulse"></span> In Progress
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="inline-flex items-center gap-1 text-[10px] font-bold uppercase rounded-full bg-amber-50 px-2.5 py-1 text-amber-700 border border-amber-200">
                        <span class="w-1.5 h-1.5 rounded-full bg-amber-500 animate-pulse"></span> Pending
                    </span>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Client message -->
    <div class="bg-slate-50 rounded-xl p-3.5 border border-slate-100">
        <p class="text-xs text-slate-500 font-semibold uppercase tracking-wider mb-1 text-[10px]">Client's Question:</p>
        <p class="text-xs text-slate-700 font-medium whitespace-pre-line leading-relaxed">${param.message}</p>
    </div>

    <!-- Admin Reply Form -->
    <form action="updateInquiryStatus" method="post" class="space-y-3 m-0">
        <input type="hidden" name="inquiryId" value="${param.id}" />
        
        <div class="flex flex-col gap-1.5">
            <label class="text-[10px] font-bold uppercase tracking-wider text-slate-400">Response / Reply Text</label>
            <textarea name="reply" placeholder="Type your official response to the client..." rows="2" 
                      class="w-full rounded-lg border border-slate-200 px-3 py-2 text-xs font-semibold text-slate-800 outline-none focus:ring-2 focus:ring-orange-500 transition">${param.reply}</textarea>
        </div>

        <div class="flex items-center justify-between gap-3 flex-wrap pt-1.5 border-t border-slate-100">
            <div class="flex items-center gap-2">
                <span class="text-[10px] font-bold uppercase tracking-wider text-slate-400">Mark Status:</span>
                <select name="status" class="rounded-lg border border-slate-200 bg-white px-2.5 py-1 text-xs font-bold text-slate-700 outline-none focus:ring-1 focus:ring-orange-500">
                    <option value="PENDING" ${(param.status == 'PENDING' || param.status == 'Pending') ? 'selected' : ''}>Pending</option>
                    <option value="IN_PROGRESS" ${(param.status == 'IN_PROGRESS' || param.status == 'In Progress' || param.status == 'IN PROGRESS') ? 'selected' : ''}>In Progress</option>
                    <option value="COMPLETED" ${(param.status == 'COMPLETED' || param.status == 'Completed') ? 'selected' : ''}>Completed</option>
                    <option value="RESOLVED" ${(param.status == 'RESOLVED' || param.status == 'Resolved') ? 'selected' : ''}>Resolved</option>
                </select>
            </div>
            
            <button type="submit" class="inline-flex items-center gap-1.5 rounded-lg bg-slate-900 hover:bg-orange-500 px-3.5 py-1.5 text-xs font-bold text-white shadow-sm hover:shadow transition">
                <i data-lucide="check-square" class="w-3.5 h-3.5"></i> Update & Send Response
            </button>
        </div>
    </form>
</div>