<%--
    File: documentCard.jsp
    Description: Card for displaying client uploaded documents.
--%>
<div class="bg-white border border-slate-200 rounded-xl p-4 shadow-sm hover:shadow-md transition group">
    <div class="flex items-start gap-3">
        <div class="p-2 bg-blue-100 rounded-lg text-blue-600">
            <i data-lucide="file-text" class="w-6 h-6"></i>
        </div>
        <div class="flex-1 overflow-hidden">
            <h4 class="font-semibold text-slate-800 text-sm truncate">${param.fileName}</h4>
            <p class="text-xs text-slate-500 mt-0.5">Uploaded by: ${param.uploadedBy}</p>
            <p class="text-xs text-slate-400">${param.date}</p>
        </div>
    </div>
    <div class="mt-3 flex gap-2">
        <button class="flex-1 text-center text-xs bg-slate-100 text-slate-600 py-1.5 rounded-lg hover:bg-slate-200 transition">
            View
        </button>
        <button class="flex-1 text-center text-xs bg-orange-50 text-orange-600 py-1.5 rounded-lg hover:bg-orange-100 transition">
            Download
        </button>
    </div>
</div>