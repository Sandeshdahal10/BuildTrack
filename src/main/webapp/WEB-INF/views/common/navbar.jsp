<nav class="absolute w-full z-20 top-0 left-0 bg-white/80 backdrop-blur-md border-b border-slate-100">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between h-20 items-center">
      <a href="${pageContext.request.contextPath}/" class="flex-shrink-0 flex items-center hover:opacity-80 transition-opacity">
        <div class="bg-white rounded-xl p-2 mr-3 h-10 w-10 flex items-center justify-center shadow-md ring-1 ring-slate-100">
          <img src="${pageContext.request.contextPath}/assets/image/BuildTrackLogo.png" alt="BuildTrack" class="h-9 w-9 object-contain" />
        </div>
        <span class="font-extrabold text-2xl text-[#ea580c] tracking-tight">BuildTrack</span>
      </a>
      <div class="hidden md:flex items-center gap-8 flex-1 justify-center">
         <a href="${pageContext.request.contextPath}/" class="text-slate-600 hover:text-[#ea580c] font-semibold px-3 py-2 transition-colors">Home</a>
         <a href="${pageContext.request.contextPath}/about" class="text-slate-600 hover:text-[#ea580c] font-semibold px-3 py-2 transition-colors">About Us</a>
         <a href="${pageContext.request.contextPath}/contact" class="text-slate-600 hover:text-[#ea580c] font-semibold px-3 py-2 transition-colors">Contact Us</a>
      </div>
      <div class="hidden md:flex items-center gap-2">
         <a href="${pageContext.request.contextPath}/login" class="inline-flex items-center justify-center bg-[#ea580c] text-white font-semibold text-base px-6 py-2.5 rounded-lg shadow-md hover:bg-[#c2410c] hover:shadow-lg transition-all duration-200 transform hover:-translate-y-0.5">Log in</a>
      </div>
    </div>
  </div>
</nav>