<div class="flex flex-col md:flex-row md:items-center justify-between p-4 bg-white border border-slate-200 rounded-xl gap-4">

    <div class="flex items-center gap-4 min-w-[220px]">
        <img src="${param.image}" alt="${param.name}" class="w-10 h-10 rounded-full object-cover">
        <div>
            <h4 class="text-sm font-bold text-slate-800">${param.name}</h4>
            <p class="text-xs text-slate-500">${param.role}</p>
        </div>
    </div>

    <div class="flex items-center gap-6 text-sm flex-1 justify-start md:justify-center">
        <div class="text-center">
            <p class="text-xs text-slate-400">Days Worked</p>
            <p class="font-bold text-slate-700">${param.daysWorked}</p>
        </div>
        <div class="text-center border-l border-slate-100 pl-6">
            <p class="text-xs text-slate-400">Daily Rate</p>
            <p class="font-bold text-slate-700">${param.dailyRate}</p>
        </div>
        <div class="text-center border-l border-slate-100 pl-6">
            <p class="text-xs text-slate-400">Gross Pay</p>
            <p class="font-bold text-orange-600">${param.grossPay}</p>
        </div>
    </div>

    <div class="flex items-center gap-3">
        <span class="px-3 py-1 rounded-full text-xs font-bold ${param.statusStyle}">
            ${param.status}
        </span>

        <a href="${param.payslipLink}" class="p-2 rounded-lg border border-slate-200 text-slate-500 hover:bg-slate-50 hover:text-slate-700 transition" title="Download Payslip">
            <i data-lucide="file-text" class="w-4 h-4"></i>
        </a>

        <a href="${param.payLink}" class="p-2 rounded-lg bg-green-500 text-white hover:bg-green-600 transition ${param.payBtnDisabled}" title="Process Payment">
            <i data-lucide="check-circle" class="w-4 h-4"></i>
        </a>
    </div>
</div>