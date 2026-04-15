<div class="client-card search-item bg-white border border-slate-200 rounded-xl p-5 shadow-sm hover:shadow-md transition-all duration-300">
    <div class="flex items-center gap-4">
        <img src="${param.image}" alt="${param.name}"
             class="w-16 h-16 rounded-full object-cover border border-slate-200">

        <div class="flex-1 min-w-0">
            <h3 class="text-base font-semibold text-slate-900">
                ${param.name}
            </h3>

            <p class="text-sm text-slate-500 break-words">
                ${param.email}
            </p>
        </div>
    </div>

    <div class="my-4 border-t border-slate-100"></div>

    <div class="space-y-3 text-sm text-slate-600">

        <div class="flex items-start gap-2">
            <i data-lucide="phone" class="w-4 h-4 text-slate-400 mt-0.5"></i>
            <span class="break-all">${param.phone}</span>
        </div>

        <!-- Projects -->
        <div class="flex items-center gap-2 font-medium text-slate-700">
            <i data-lucide="folder" class="w-4 h-4 text-orange-500"></i>
            <span>${param.projectCount} Projects</span>
        </div>

    </div>

    <div class="mt-5 flex gap-2">
        <a href="${param.viewLink}"
           class="flex-1 text-center rounded-lg border border-slate-300 px-4 py-2 text-sm font-medium text-slate-700 hover:bg-slate-50 transition">
            View
        </a>

        <a href="${param.editLink}"
           class="flex-1 text-center rounded-lg bg-orange-500 px-4 py-2 text-sm font-medium text-white hover:bg-orange-600 transition">
            Edit
        </a>
    </div>
</div>