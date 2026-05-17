<tr class="hover:bg-slate-50 transition border-b border-slate-100">
    <td class="p-4 text-slate-500 text-sm">${param.date}</td>
    <td class="p-4 font-medium text-slate-800 text-sm">${param.project}</td>
    <td class="p-4">
        <span class="px-2.5 py-1 rounded-full text-xs font-bold ${param.categoryStyle}">
            ${param.category}
        </span>
    </td>
    <td class="p-4 text-slate-600 text-sm">${param.description}</td>
    <td class="p-4 text-right font-bold text-slate-800 text-sm">${param.amount}</td>
    <td class="p-4 text-center">
        <div class="flex items-center justify-center gap-2">
            <a href="${param.editLink}" class="text-center rounded-lg bg-orange-500 px-4 py-2 text-sm font-medium text-white hover:bg-orange-600 transition">
                Edit
            </a>
            <button class="text-center rounded-lg bg-red-500 px-4 py-2 text-sm font-medium text-white hover:bg-red-600 transition">
Delete
            </button>
        </div>
    </td>
</tr>
