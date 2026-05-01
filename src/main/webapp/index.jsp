<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack - Construction Management</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-slate-900 font-sans antialiased overflow-x-hidden">
    <!-- Navbar -->
    <nav class="absolute w-full z-20 top-0 left-0 bg-white/80 backdrop-blur-md border-b border-slate-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20 items-center">
                <div class="flex-shrink-0 flex items-center">
                    <div class="bg-[#ea580c] rounded-xl p-2 mr-3 h-10 w-10 flex items-center justify-center shadow-md">
                        <span class="text-white text-xs font-bold tracking-wide">BT</span>
                    </div>
                    <span class="font-extrabold text-2xl text-[#ea580c] tracking-tight">BuildTrack</span>
                </div>
                <div class="hidden md:flex items-center gap-2">
                   <a href="#home" class="text-slate-600 hover:text-[#ea580c] font-semibold px-3 py-2 transition-colors">Home</a>
                   <a href="#features" class="text-slate-600 hover:text-[#ea580c] font-semibold px-3 py-2 transition-colors">Features</a>
                   <a href="#services" class="text-slate-600 hover:text-[#ea580c] font-semibold px-3 py-2 transition-colors">Our Services</a>
                   <a href="#how-it-works" class="text-slate-600 hover:text-[#ea580c] font-semibold px-3 py-2 transition-colors">How it Works</a>
                   <a href="${pageContext.request.contextPath}/login" class="inline-flex items-center justify-center bg-[#ea580c] text-white font-semibold text-base px-6 py-2.5 rounded-lg shadow-md hover:bg-[#c2410c] hover:shadow-lg transition-all duration-200 transform hover:-translate-y-0.5">Log in</a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div id="home" class="relative bg-white pt-20 pb-16 min-h-screen flex flex-col lg:flex-row items-center lg:pt-0 lg:pb-0">
        <div class="max-w-7xl mx-auto w-full flex-grow flex flex-col justify-center">
            <div class="relative z-10 pb-8 bg-white sm:pb-16 md:pb-20 lg:max-w-2xl lg:w-full lg:pb-28 xl:pb-32 px-4 sm:px-6 lg:px-8 xl:pr-12 pt-10">
                <!-- Background decor for large screens -->
                <div class="hidden lg:block absolute inset-y-0 right-0 w-24 bg-gradient-to-l from-transparent to-white z-10 transform translate-x-12"></div>
                
                <main class="mt-10 mx-auto max-w-7xl sm:mt-12 md:mt-16 lg:mt-20 xl:mt-28">
                    <div class="sm:text-center lg:text-left">

                        <h1 class="text-4xl tracking-tight font-bold text-slate-900 sm:text-5xl md:text-6xl mt-4 leading-tight">
                            <span class="block">Build with Confidence.</span>
                            <span class="block text-[#ea580c] mt-1">Track with Precision.</span>
                        </h1>
                        <p class="mt-5 text-base text-slate-500 sm:mt-6 sm:text-lg sm:max-w-xl sm:mx-auto md:text-xl lg:mx-0 leading-relaxed">
                            The ultimate construction management platform designed for modern builders. Streamline your workflows, manage workforces efficiently, trace materials, and deliver projects on time and under budget. 
                        </p>
                        <div class="mt-8 sm:mt-10 flex flex-col sm:flex-row sm:justify-center lg:justify-start gap-4">
                            <div class="rounded-md shadow-lg">
                                <a href="${pageContext.request.contextPath}/register" class="w-full flex items-center justify-center px-8 py-4 border border-transparent text-base font-semibold rounded-lg text-white bg-[#ea580c] hover:bg-[#c2410c] md:text-lg transition-all duration-200 transform hover:-translate-y-0.5">
                                    Register Account
                                </a>
                            </div>
                        </div>
                        
                        <!-- Mini Stats/Trust marks -->
                        <div class="mt-10 sm:mt-12 pt-8 border-t border-slate-100 grid grid-cols-2 gap-4 text-center sm:text-left lg:grid-cols-2">
                           <div>
                               <p class="text-2xl font-bold text-slate-900">10k+</p>
                               <p class="text-sm font-medium text-slate-500">Projects Managed</p>
                           </div>
                           <div>
                               <p class="text-2xl font-bold text-slate-900">99.9%</p>
                               <p class="text-sm font-medium text-slate-500">Uptime Reliability</p>
                           </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        
        <!-- Image Slideshow Side -->
        <div class="lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2 w-full h-80 sm:h-96 lg:h-full mt-10 lg:mt-0">
            <div id="heroSlideshow" class="h-full w-full relative overflow-hidden">
                <!-- Nice overlay gradient -->
                <div class="absolute inset-0 bg-[#ea580c]/10 mix-blend-multiply z-10 pointer-events-none"></div>

                <!-- Slides Container -->
                <div id="slidesTrack" class="flex h-full transition-transform duration-700 ease-in-out" style="width: 300%;">
                    <div class="h-full flex-shrink-0" style="width: 33.3333%;">
                        <img class="h-full w-full object-cover object-center" src="assets/image/Buildtrack picture.jpg" alt="BuildTrack construction overview">
                    </div>
                    <div class="h-full flex-shrink-0" style="width: 33.3333%;">
                        <img class="h-full w-full object-cover object-center" src="assets/image/1.jpg" alt="Construction project in progress">
                    </div>
                    <div class="h-full flex-shrink-0" style="width: 33.3333%;">
                        <img class="h-full w-full object-cover object-center" src="assets/image/2.jpg" alt="Construction site management">
                    </div>
                </div>

                <!-- Navigation Dots -->
                <div class="absolute bottom-6 left-1/2 -translate-x-1/2 z-20 flex items-center gap-3">
                    <button onclick="goToSlide(0)" class="slideshow-dot active w-3 h-3 rounded-full bg-white/60 border-2 border-white shadow-md transition-all duration-300 hover:bg-white cursor-pointer" aria-label="Slide 1"></button>
                    <button onclick="goToSlide(1)" class="slideshow-dot w-3 h-3 rounded-full bg-white/60 border-2 border-white shadow-md transition-all duration-300 hover:bg-white cursor-pointer" aria-label="Slide 2"></button>
                    <button onclick="goToSlide(2)" class="slideshow-dot w-3 h-3 rounded-full bg-white/60 border-2 border-white shadow-md transition-all duration-300 hover:bg-white cursor-pointer" aria-label="Slide 3"></button>
                </div>

                <!-- Arrow Navigation -->
                <button onclick="changeSlide(-1)" class="absolute left-3 top-1/2 -translate-y-1/2 z-20 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm border border-white/30 flex items-center justify-center text-white hover:bg-white/40 transition-all duration-300 cursor-pointer shadow-lg" aria-label="Previous slide">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5L8.25 12l7.5-7.5"/></svg>
                </button>
                <button onclick="changeSlide(1)" class="absolute right-3 top-1/2 -translate-y-1/2 z-20 w-10 h-10 rounded-full bg-white/20 backdrop-blur-sm border border-white/30 flex items-center justify-center text-white hover:bg-white/40 transition-all duration-300 cursor-pointer shadow-lg" aria-label="Next slide">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M8.25 4.5l7.5 7.5-7.5 7.5"/></svg>
                </button>
            </div>
        </div>
    </div>

    <!-- Slideshow Styles -->
    <style>
        .slideshow-dot.active {
            background-color: #ea580c !important;
            border-color: #ea580c !important;
            transform: scale(1.35);
            box-shadow: 0 0 10px rgba(234, 88, 12, 0.5);
        }

        /* Reusable hover animation for homepage cards (Services + How it Works) */
        .bt-hover-card {
            transform: translateY(0);
            box-shadow: 0 0 #0000;
            transition: transform 220ms ease, box-shadow 220ms ease, border-color 220ms ease, background-color 220ms ease;
            will-change: transform, box-shadow;
        }

        .bt-hover-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 35px rgba(234, 88, 12, 0.14), 0 8px 14px rgba(15, 23, 42, 0.08);
        }
    </style>

    <!-- Slideshow Script -->
    <script>
        (function() {
            let currentSlide = 0;
            const totalSlides = 3;
            const track = document.getElementById('slidesTrack');
            const dots = document.querySelectorAll('.slideshow-dot');
            let autoPlayInterval;

            function updateSlideshow() {
                track.style.transform = 'translateX(-' + (currentSlide * 33.3333) + '%)';
                dots.forEach(function(dot, i) {
                    dot.classList.toggle('active', i === currentSlide);
                });
            }

            window.goToSlide = function(index) {
                currentSlide = index;
                updateSlideshow();
                resetAutoPlay();
            };

            window.changeSlide = function(direction) {
                currentSlide = (currentSlide + direction + totalSlides) % totalSlides;
                updateSlideshow();
                resetAutoPlay();
            };

            function startAutoPlay() {
                autoPlayInterval = setInterval(function() {
                    currentSlide = (currentSlide + 1) % totalSlides;
                    updateSlideshow();
                }, 5000);
            }

            function resetAutoPlay() {
                clearInterval(autoPlayInterval);
                startAutoPlay();
            }

            // Pause on hover
            var slideshow = document.getElementById('heroSlideshow');
            slideshow.addEventListener('mouseenter', function() {
                clearInterval(autoPlayInterval);
            });
            slideshow.addEventListener('mouseleave', function() {
                startAutoPlay();
            });

            // Touch/swipe support
            var touchStartX = 0;
            var touchEndX = 0;
            slideshow.addEventListener('touchstart', function(e) {
                touchStartX = e.changedTouches[0].screenX;
            }, { passive: true });
            slideshow.addEventListener('touchend', function(e) {
                touchEndX = e.changedTouches[0].screenX;
                var diff = touchStartX - touchEndX;
                if (Math.abs(diff) > 50) {
                    if (diff > 0) {
                        window.changeSlide(1);
                    } else {
                        window.changeSlide(-1);
                    }
                }
            }, { passive: true });

            startAutoPlay();
        })();
    </script>

    <!-- Features Section -->
    <section id="features" class="py-20 bg-white scroll-mt-24">
         <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
             <div class="text-center mb-12">
                 <span class="px-4 py-1.5 rounded-full text-xs font-bold text-orange-800 bg-orange-100 mb-6 inline-block tracking-widest uppercase shadow-sm">
                     Features
                 </span>
                 <h2 class="text-4xl sm:text-5xl font-bold text-slate-900 mt-4 mb-4">
                     Powerful Features for Modern Construction
                 </h2>
                 <p class="text-lg text-slate-600 max-w-3xl mx-auto">
                     Everything you need to manage your construction projects efficiently and effectively.
                 </p>
             </div>

             <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                 <!-- Feature 1 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <span class="text-[#ea580c] text-xs font-bold tracking-wide">PM</span>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Project Management</h3>
                     <p class="text-slate-600">Plan, track, and manage multiple construction projects from a single intuitive dashboard.</p>
                 </div>

                 <!-- Feature 2 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <span class="text-[#ea580c] text-xs font-bold tracking-wide">WM</span>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Workforce Management</h3>
                     <p class="text-slate-600">Efficiently manage workers, track attendance, assign tasks, and monitor productivity.</p>
                 </div>

                 <!-- Feature 3 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <span class="text-[#ea580c] text-xs font-bold tracking-wide">MT</span>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Material Tracking</h3>
                     <p class="text-slate-600">Keep detailed records of materials, inventory management, and supplier information.</p>
                 </div>

                 <!-- Feature 4 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <span class="text-[#ea580c] text-xs font-bold tracking-wide">BE</span>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Budget & Expense Tracking</h3>
                     <p class="text-slate-600">Monitor project budgets, track expenses, and maintain financial control across all projects.</p>
                 </div>

                 <!-- Feature 5 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <span class="text-[#ea580c] text-xs font-bold tracking-wide">CC</span>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Client Collaboration</h3>
                     <p class="text-slate-600">Seamless communication and project updates with clients in real-time.</p>
                 </div>

                 <!-- Feature 6 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <span class="text-[#ea580c] text-xs font-bold tracking-wide">AR</span>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Advanced Reports</h3>
                     <p class="text-slate-600">Generate comprehensive analytics and reports to make data-driven decisions.</p>
                 </div>
             </div>
         </div>
     </section>

     <!-- Our Services Section -->
     <section id="services" class="py-20 bg-gradient-to-br from-orange-50 to-white scroll-mt-24">
         <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
             <div class="text-center mb-12">
                 <span class="px-4 py-1.5 rounded-full text-xs font-bold text-orange-800 bg-orange-100 mb-6 inline-block tracking-widest uppercase shadow-sm">
                     Our Services
                 </span>
                 <h2 class="text-4xl sm:text-5xl font-bold text-slate-900 mt-4 mb-4">
                     Comprehensive Construction Solutions
                 </h2>
                 <p class="text-lg text-slate-600 max-w-3xl mx-auto">
                     We provide end-to-end construction management services tailored to your project needs.
                 </p>
             </div>

                  <div class="grid md:grid-cols-2 gap-8">
                 <!-- Service 1 -->
                   <div class="bt-hover-card group flex gap-4 rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                      <div class="flex-shrink-0">
                          <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                 <rect x="3" y="4" width="18" height="18" rx="2"></rect>
                                 <line x1="16" y1="2" x2="16" y2="6"></line>
                                 <line x1="8" y1="2" x2="8" y2="6"></line>
                                 <line x1="3" y1="10" x2="21" y2="10"></line>
                             </svg>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Project Planning & Scheduling</h3>
                         <p class="text-slate-600">Create detailed project timelines, set milestones, and manage critical paths with precision.</p>
                     </div>
                 </div>

                 <!-- Service 2 -->
                   <div class="bt-hover-card group flex gap-4 rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                      <div class="flex-shrink-0">
                          <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                 <circle cx="9" cy="8" r="3"></circle>
                                 <path d="M3 19c0-3.3 2.7-6 6-6"></path>
                                 <path d="M14 10l2-2 5 5-2 2-5-5z"></path>
                                 <path d="M13 11l-2 2"></path>
                             </svg>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Labor & Site Management</h3>
                         <p class="text-slate-600">Optimize workforce scheduling, track daily attendance, and manage site operations efficiently.</p>
                     </div>
                 </div>

                 <!-- Service 3 -->
                   <div class="bt-hover-card group flex gap-4 rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                      <div class="flex-shrink-0">
                          <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                 <path d="M3 7l9-4 9 4-9 4-9-4z"></path>
                                 <path d="M3 12l9 4 9-4"></path>
                                 <path d="M3 17l9 4 9-4"></path>
                             </svg>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Inventory & Logistics</h3>
                         <p class="text-slate-600">Manage material orders, track deliveries, and maintain optimal stock levels on site.</p>
                     </div>
                 </div>

                 <!-- Service 4 -->
                   <div class="bt-hover-card group flex gap-4 rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                      <div class="flex-shrink-0">
                          <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                 <circle cx="12" cy="12" r="8"></circle>
                                 <line x1="12" y1="8" x2="12" y2="16"></line>
                                 <line x1="8" y1="12" x2="16" y2="12"></line>
                             </svg>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Financial Management</h3>
                         <p class="text-slate-600">Monitor budgets, track expenses, generate invoices, and maintain financial transparency.</p>
                     </div>
                 </div>

                 <!-- Service 5 -->
                   <div class="bt-hover-card group flex gap-4 rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                      <div class="flex-shrink-0">
                          <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                 <rect x="3" y="4" width="18" height="16" rx="2"></rect>
                                 <line x1="7" y1="8" x2="17" y2="8"></line>
                                 <line x1="7" y1="12" x2="12" y2="12"></line>
                                 <circle cx="17" cy="15" r="2"></circle>
                             </svg>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Payroll & HR Management</h3>
                         <p class="text-slate-600">Process salaries, manage payroll deductions, and maintain employee records seamlessly.</p>
                     </div>
                 </div>

                 <!-- Service 6 -->
                   <div class="bt-hover-card group flex gap-4 rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                      <div class="flex-shrink-0">
                          <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                 <path d="M4 12a8 8 0 0 1 8-8h4v6h4v2a8 8 0 0 1-8 8h-1"></path>
                                 <path d="M4 20l5-4"></path>
                             </svg>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">24/7 Customer Support</h3>
                         <p class="text-slate-600">Get dedicated support from our expert team available round the clock for assistance.</p>
                     </div>
                 </div>
             </div>
         </div>
     </section>

     <!-- How It Works Section -->
     <section id="how-it-works" class="py-20 bg-white scroll-mt-24">
         <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
             <div class="text-center mb-16">
                 <span class="px-4 py-1.5 rounded-full text-xs font-bold text-orange-800 bg-orange-100 mb-6 inline-block tracking-widest uppercase shadow-sm">
                     How It Works
                 </span>
                 <h2 class="text-4xl sm:text-5xl font-bold text-slate-900 mt-4 mb-4">
                     Getting Started is Simple
                 </h2>
                 <p class="text-lg text-slate-600 max-w-3xl mx-auto">
                     Follow these easy steps to get your projects on track with BuildTrack.
                 </p>
             </div>

             <div class="grid md:grid-cols-4 gap-8">
                 <!-- Step 1 -->
                   <div class="bt-hover-card group text-center relative rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                     <div class="mb-4">
                          <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             1
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Create Account</h3>
                     <p class="text-slate-600">Sign up for your BuildTrack account in just a few minutes and get instant access to all features.</p>
                 </div>

                 <!-- Step 2 -->
                   <div class="bt-hover-card group text-center relative rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                     <div class="mb-4">
                          <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             2
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Set Up Projects</h3>
                     <p class="text-slate-600">Create your construction projects, define teams, set budgets, and establish project milestones.</p>
                 </div>

                 <!-- Step 3 -->
                   <div class="bt-hover-card group text-center relative rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                     <div class="mb-4">
                          <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             3
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Manage & Execute</h3>
                     <p class="text-slate-600">Assign tasks, track workforce, manage materials, and monitor project progress in real-time.</p>
                 </div>

                 <!-- Step 4 -->
                   <div class="bt-hover-card group text-center relative rounded-xl bg-white/70 ring-1 ring-slate-100 p-6 hover:bg-white hover:ring-orange-200">
                     <div class="mb-4">
                          <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold transition-transform duration-300 ease-out group-hover:scale-110 group-hover:shadow-lg group-hover:shadow-orange-200/50">
                             4
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Analyze & Report</h3>
                     <p class="text-slate-600">Review detailed reports, analyze project performance, and optimize future project planning.</p>
                 </div>
             </div>
         </div>
     </section>

    <!-- Footer -->
    <footer class="bg-slate-900 text-slate-200">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
            <div class="flex flex-col md:flex-row md:items-start md:justify-between gap-8">
                <div class="max-w-xl">
                    <div class="flex items-center mb-4">
                        <div class="bg-[#ea580c] rounded-xl p-2 mr-3 h-10 w-10 flex items-center justify-center shadow-md">
                            <span class="text-white text-xs font-bold tracking-wide">BT</span>
                        </div>
                        <span class="font-extrabold text-2xl text-white tracking-tight">BuildTrack</span>
                    </div>
                    <p class="text-slate-300 leading-relaxed">
                        BuildTrack helps construction teams stay organized, track progress with confidence, and deliver quality projects on time.
                    </p>
                </div>

                <div class="flex flex-col gap-3 md:items-end">
                    <a href="${pageContext.request.contextPath}/about" class="text-slate-200 hover:text-[#ea580c] font-semibold transition-colors">About Us</a>
                    <a href="#" class="text-slate-200 hover:text-[#ea580c] font-semibold transition-colors">Contact Us</a>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>