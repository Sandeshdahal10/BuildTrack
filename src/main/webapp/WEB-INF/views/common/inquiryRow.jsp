

<div class="bg-white border border-slate-200 rounded-xl p-4 shadow-sm hover:shadow-sm transition flex flex-col md:flex-row md:items-center justify-between gap-4">

    <div class="flex items-start gap-4">
        <div class="w-10 h-10 rounded-full bg-slate-100 flex items-center justify-center text-slate-500 flex-shrink-0">
            <i data-lucide="user" class="w-5 h-5"></i>
        </div>
        <div>
            <h4 class="font-semibold text-slate-800 text-sm">${param.subject}</h4>
            <p class="text-xs text-slate-500 mt-0.5">
                From: ${param.client} • Project: ${param.project}
            </p>
            <p class="text-xs text-slate-400 mt-1">
                Received: ${param.date}
            </p>
        </div>
    </div>

    <form action="updateInquiryStatus" method="post" class="flex items-center gap-3">

        <input type="hidden" name="inquiryId" value="${param.id}" />

        <select name="status"
                class="px-2.5 py-1 rounded-full text-xs font-bold border
            ${param.status == 'Resolved' ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700'}">

            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>
                Pending
            </option>

            <option value="Resolved" ${param.status == 'Resolved' ? 'selected' : ''}>
                Resolved
            </option>

        </select>

        <a href="${param.replyLink}"
           class="text-sm font-semibold text-blue-500 hover:text-blue-700 transition">
            Reply
        </a>
    </form>

</div>