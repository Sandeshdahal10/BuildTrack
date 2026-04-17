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
            <a href="${param.editLink}" class="p-1.5  rounded bg-orange-500 hover:bg-orange-600 text-white  transition">
                Edit
            </a>
            <button class="p-1.5 rounded bg-red-500 hover:bg-red-600 text-white  transition">
Delete
            </button>
        </div>
    </td>
</tr>