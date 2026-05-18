<footer class="bg-slate-900 text-slate-200">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div class="flex flex-col md:flex-row md:items-start md:justify-between gap-8">
            <div class="max-w-xl">
                <div class="flex items-center mb-4">
                    <div class="bg-white rounded-xl p-2 mr-3 h-10 w-10 flex items-center justify-center shadow-md ring-1 ring-white/10">
                        <img src="${pageContext.request.contextPath}/assets/image/BuildTrackLogo.png" alt="BuildTrack" class="h-9 w-9 object-contain" />
                    </div>
                    <span class="font-extrabold text-2xl text-white tracking-tight">BuildTrack</span>
                </div>
                <p class="text-slate-300 leading-relaxed">
                    BuildTrack helps construction teams stay organized, track progress with confidence, and deliver quality projects on time.
                </p>
            </div>

            <div class="flex flex-col gap-2 md:items-end text-slate-400">
                <p class="text-sm">Support: <strong class="text-slate-200">support@buildtrack.com</strong></p>
                <p class="text-sm">© <%= java.time.Year.now().getValue() %> BuildTrack. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>
