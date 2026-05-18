<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        /* Modern aesthetic styling */
    </style>
</head>
<body class="bg-slate-50/50 text-slate-900 font-sans antialiased">

<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<main class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 pt-28 pb-20">
    <!-- Back to Home -->
    <div class="mb-10">
        <a href="${pageContext.request.contextPath}/"
           class="inline-flex items-center gap-2 rounded-full bg-white px-5 py-2.5 text-sm font-semibold text-[#ea580c] shadow-md ring-1 ring-slate-200 transition-all hover:bg-slate-50">
            <span aria-hidden="true">←</span>
            Back to Home
        </a>
    </div>

    <div class="space-y-16">
        <!-- Section 1: About BuildTrack -->
        <div class="grid md:grid-cols-2 gap-12 items-center bg-white rounded-[2rem] p-8 md:p-14 shadow-sm border border-slate-100">
            <div class="space-y-6">
                <div>
                    <span class="inline-flex items-center rounded-full border border-slate-200 bg-slate-50 px-4 py-1.5 text-xs font-semibold uppercase tracking-wider text-slate-600">
                        About Us
                    </span>
                </div>
                <h2 class="text-4xl md:text-5xl font-extrabold text-slate-900 tracking-tight leading-tight">
                    About BuildTrack
                </h2>
                <p class="text-base text-slate-600 leading-relaxed">
                    BuildTrack is a web-based construction management system built for modern builders. We empower construction companies, project managers, and onsite workforces to collaborate in real-time, eliminating miscommunication and scattered spreadsheets with one reliable source of truth. With standard-setting tools, our system delivers operational clarity across sites, offices, and client communication.
                </p>
                <div class="flex gap-4 pt-2">
                    <a href="${pageContext.request.contextPath}/register" class="inline-flex items-center justify-center rounded-full bg-[#ea580c] px-6 py-3 text-sm font-bold text-white shadow-md transition hover:bg-[#c2410c] transform hover:-translate-y-0.5">
                        Get Started &rarr;
                    </a>
                    <a href="${pageContext.request.contextPath}/contact" class="inline-flex items-center justify-center rounded-full border border-slate-200 bg-white px-6 py-3 text-sm font-bold text-slate-700 shadow-sm transition hover:bg-slate-50 transform hover:-translate-y-0.5">
                        Contact Us
                    </a>
                </div>
                <div class="border-t border-slate-100 pt-8 grid grid-cols-3 gap-6">
                    <div>
                        <p class="text-3xl font-extrabold text-slate-900">95%</p>
                        <p class="text-xs text-slate-500 mt-1 leading-snug">Complete customer satisfaction</p>
                    </div>
                    <div>
                        <p class="text-3xl font-extrabold text-slate-900">10+</p>
                        <p class="text-xs text-slate-500 mt-1 leading-snug">Years of construction innovation</p>
                    </div>
                    <div>
                        <p class="text-3xl font-extrabold text-slate-900">$10m+</p>
                        <p class="text-xs text-slate-500 mt-1 leading-snug">Project savings enabled</p>
                    </div>
                </div>
            </div>
            <div class="relative">
                <div class="aspect-square w-full overflow-hidden rounded-[2rem] bg-slate-100 shadow-sm border border-slate-100">
                    <img src="${pageContext.request.contextPath}/assets/image/Buildtrack picture.jpg" alt="About BuildTrack" class="h-full w-full object-cover" />
                </div>
            </div>
        </div>

        <!-- Section 2: Features & Services -->
        <div class="grid md:grid-cols-2 gap-12 items-center bg-white rounded-[2rem] p-8 md:p-14 shadow-sm border border-slate-100">
            <div class="relative order-last md:order-first">
                <div class="aspect-square w-full overflow-hidden rounded-[2rem] bg-slate-100 shadow-sm border border-slate-100">
                    <img src="${pageContext.request.contextPath}/assets/image/1.jpg" alt="BuildTrack Features and Services" class="h-full w-full object-cover" />
                </div>
            </div>
            <div class="space-y-6">
                <div>
                    <span class="inline-flex items-center rounded-full border border-slate-200 bg-slate-50 px-4 py-1.5 text-xs font-semibold uppercase tracking-wider text-slate-600">
                        Features & Services
                    </span>
                </div>
                <h2 class="text-4xl md:text-5xl font-extrabold text-slate-900 tracking-tight leading-tight">
                    Unlock our expertise to drive success across sites.
                </h2>
                <p class="text-base text-slate-600 leading-relaxed">
                    Leverage our deep construction industry knowledge and innovative features to accelerate your business growth. Our tailored solutions ensure success across diverse project sites by addressing your unique scheduling, material tracking, and workforce challenges.
                </p>
                
                <div class="grid grid-cols-2 gap-y-4 gap-x-6 pt-4">
                    <div class="flex items-center gap-3">
                        <div class="flex h-5 w-5 items-center justify-center rounded-full bg-orange-100 text-[#ea580c]">
                            <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
                        </div>
                        <span class="text-sm font-semibold text-slate-700">Role-based access</span>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="flex h-5 w-5 items-center justify-center rounded-full bg-orange-100 text-[#ea580c]">
                            <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
                        </div>
                        <span class="text-sm font-semibold text-slate-700">Real-time cost tracking</span>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="flex h-5 w-5 items-center justify-center rounded-full bg-orange-100 text-[#ea580c]">
                            <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
                        </div>
                        <span class="text-sm font-semibold text-slate-700">Attendance & payroll</span>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="flex h-5 w-5 items-center justify-center rounded-full bg-orange-100 text-[#ea580c]">
                            <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
                        </div>
                        <span class="text-sm font-semibold text-slate-700">Auditable reports</span>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="flex h-5 w-5 items-center justify-center rounded-full bg-orange-100 text-[#ea580c]">
                            <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
                        </div>
                        <span class="text-sm font-semibold text-slate-700">Centralized workspace</span>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="flex h-5 w-5 items-center justify-center rounded-full bg-orange-100 text-[#ea580c]">
                            <svg class="h-3 w-3" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5"/></svg>
                        </div>
                        <span class="text-sm font-semibold text-slate-700">Support for long-term growth</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</body>
</html>

