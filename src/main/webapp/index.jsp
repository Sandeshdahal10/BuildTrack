<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack - Construction Management</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 text-slate-900 font-sans antialiased overflow-x-hidden">
    <!-- Navbar -->
    <nav class="absolute w-full z-20 top-0 left-0 bg-white/80 backdrop-blur-md border-b border-slate-100">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-20 items-center">
                <div class="flex-shrink-0 flex items-center">
                    <div class="bg-[#ea580c] rounded-xl p-2 mr-3 flex items-center justify-center shadow-md">
                        <i class="fa-solid fa-compass-drafting text-white text-xl"></i>
                    </div>
                    <span class="font-extrabold text-2xl text-[#ea580c] tracking-tight">BuildTrack</span>
                </div>
                <div>
                   <a href="${pageContext.request.contextPath}/login" class="text-slate-600 hover:text-[#ea580c] font-semibold px-4 py-2 transition-colors">Log in <span aria-hidden="true">&rarr;</span></a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="relative bg-white pt-20 pb-16 min-h-screen flex flex-col lg:flex-row items-center lg:pt-0 lg:pb-0">
        <div class="max-w-7xl mx-auto w-full flex-grow flex flex-col justify-center">
            <div class="relative z-10 pb-8 bg-white sm:pb-16 md:pb-20 lg:max-w-2xl lg:w-full lg:pb-28 xl:pb-32 px-4 sm:px-6 lg:px-8 xl:pr-12 pt-10">
                <!-- Background decor for large screens -->
                <div class="hidden lg:block absolute inset-y-0 right-0 w-24 bg-gradient-to-l from-transparent to-white z-10 transform translate-x-12"></div>
                
                <main class="mt-10 mx-auto max-w-7xl sm:mt-12 md:mt-16 lg:mt-20 xl:mt-28">
                    <div class="sm:text-center lg:text-left">
                        <span class="px-4 py-1.5 rounded-full text-xs font-bold text-orange-800 bg-orange-100 mb-6 inline-block tracking-widest uppercase shadow-sm">
                            Welcome to BuildTrack
                        </span>
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
                                    <i class="fa-solid fa-user-plus mr-2"></i> Register Account
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
        
        <!-- Image Side -->
        <div class="lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2 w-full h-80 sm:h-96 lg:h-full mt-10 lg:mt-0">
            <div class="h-full w-full relative">
                <!-- Nice overlay gradient -->
                <div class="absolute inset-0 bg-[#ea580c]/10 mix-blend-multiply z-10"></div>
                <img class="h-full w-full object-cover object-center shadow-2xl lg:shadow-none" src="assets/image/Buildtrack picture.jpg" alt="Construction site with blueprints, helmet, and tools">
            </div>
        </div>
    </div>

    <!-- Features Section -->
    <section class="py-20 bg-white">
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
                         <i class="fa-solid fa-chart-gantt text-[#ea580c] text-xl"></i>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Project Management</h3>
                     <p class="text-slate-600">Plan, track, and manage multiple construction projects from a single intuitive dashboard.</p>
                 </div>

                 <!-- Feature 2 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <i class="fa-solid fa-people-group text-[#ea580c] text-xl"></i>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Workforce Management</h3>
                     <p class="text-slate-600">Efficiently manage workers, track attendance, assign tasks, and monitor productivity.</p>
                 </div>

                 <!-- Feature 3 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <i class="fa-solid fa-box text-[#ea580c] text-xl"></i>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Material Tracking</h3>
                     <p class="text-slate-600">Keep detailed records of materials, inventory management, and supplier information.</p>
                 </div>

                 <!-- Feature 4 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <i class="fa-solid fa-receipt text-[#ea580c] text-xl"></i>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Budget & Expense Tracking</h3>
                     <p class="text-slate-600">Monitor project budgets, track expenses, and maintain financial control across all projects.</p>
                 </div>

                 <!-- Feature 5 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <i class="fa-solid fa-handshake text-[#ea580c] text-xl"></i>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Client Collaboration</h3>
                     <p class="text-slate-600">Seamless communication and project updates with clients in real-time.</p>
                 </div>

                 <!-- Feature 6 -->
                 <div class="p-8 rounded-xl border border-slate-100 hover:border-orange-300 hover:shadow-lg transition-all duration-300 bg-gradient-to-br from-white to-slate-50">
                     <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center mb-4">
                         <i class="fa-solid fa-chart-line text-[#ea580c] text-xl"></i>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Advanced Reports</h3>
                     <p class="text-slate-600">Generate comprehensive analytics and reports to make data-driven decisions.</p>
                 </div>
             </div>
         </div>
     </section>

     <!-- Our Services Section -->
     <section class="py-20 bg-gradient-to-br from-orange-50 to-white">
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
                 <div class="flex gap-4">
                     <div class="flex-shrink-0">
                         <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white">
                             <i class="fa-solid fa-calendar-check"></i>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Project Planning & Scheduling</h3>
                         <p class="text-slate-600">Create detailed project timelines, set milestones, and manage critical paths with precision.</p>
                     </div>
                 </div>

                 <!-- Service 2 -->
                 <div class="flex gap-4">
                     <div class="flex-shrink-0">
                         <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white">
                             <i class="fa-solid fa-hard-hat"></i>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Labor & Site Management</h3>
                         <p class="text-slate-600">Optimize workforce scheduling, track daily attendance, and manage site operations efficiently.</p>
                     </div>
                 </div>

                 <!-- Service 3 -->
                 <div class="flex gap-4">
                     <div class="flex-shrink-0">
                         <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white">
                             <i class="fa-solid fa-warehouse"></i>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Inventory & Logistics</h3>
                         <p class="text-slate-600">Manage material orders, track deliveries, and maintain optimal stock levels on site.</p>
                     </div>
                 </div>

                 <!-- Service 4 -->
                 <div class="flex gap-4">
                     <div class="flex-shrink-0">
                         <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white">
                             <i class="fa-solid fa-coins"></i>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Financial Management</h3>
                         <p class="text-slate-600">Monitor budgets, track expenses, generate invoices, and maintain financial transparency.</p>
                     </div>
                 </div>

                 <!-- Service 5 -->
                 <div class="flex gap-4">
                     <div class="flex-shrink-0">
                         <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white">
                             <i class="fa-solid fa-file-contract"></i>
                         </div>
                     </div>
                     <div class="pt-1">
                         <h3 class="text-lg font-semibold text-slate-900 mb-2">Payroll & HR Management</h3>
                         <p class="text-slate-600">Process salaries, manage payroll deductions, and maintain employee records seamlessly.</p>
                     </div>
                 </div>

                 <!-- Service 6 -->
                 <div class="flex gap-4">
                     <div class="flex-shrink-0">
                         <div class="flex items-center justify-center h-12 w-12 rounded-md bg-[#ea580c] text-white">
                             <i class="fa-solid fa-headset"></i>
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
     <section class="py-20 bg-white">
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
                 <div class="text-center relative">
                     <div class="mb-4">
                         <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold">
                             1
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Create Account</h3>
                     <p class="text-slate-600">Sign up for your BuildTrack account in just a few minutes and get instant access to all features.</p>
                 </div>

                 <!-- Step 2 -->
                 <div class="text-center relative">
                     <div class="mb-4">
                         <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold">
                             2
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Set Up Projects</h3>
                     <p class="text-slate-600">Create your construction projects, define teams, set budgets, and establish project milestones.</p>
                 </div>

                 <!-- Step 3 -->
                 <div class="text-center relative">
                     <div class="mb-4">
                         <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold">
                             3
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Manage & Execute</h3>
                     <p class="text-slate-600">Assign tasks, track workforce, manage materials, and monitor project progress in real-time.</p>
                 </div>

                 <!-- Step 4 -->
                 <div class="text-center relative">
                     <div class="mb-4">
                         <div class="inline-flex items-center justify-center h-16 w-16 rounded-full bg-[#ea580c] text-white text-2xl font-bold">
                             4
                         </div>
                     </div>
                     <h3 class="text-xl font-semibold text-slate-900 mb-2">Analyze & Report</h3>
                     <p class="text-slate-600">Review detailed reports, analyze project performance, and optimize future project planning.</p>
                 </div>
             </div>
         </div>
     </section>

     <!-- Schedule a Demo Section -->
     <section class="py-20 bg-gradient-to-r from-[#ea580c] to-orange-600 text-white">
         <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
             <h2 class="text-4xl sm:text-5xl font-bold mb-4">
                 Ready to Transform Your Construction Business?
             </h2>
             <p class="text-lg text-orange-100 mb-8 max-w-2xl mx-auto">
                 Schedule a personalized demo with our experts to see how BuildTrack can revolutionize your project management workflow.
             </p>

             <div class="flex flex-col sm:flex-row gap-4 justify-center mb-12">
                 <a href="${pageContext.request.contextPath}/schedule-demo.jsp" class="inline-flex items-center justify-center px-8 py-4 border border-white text-base font-semibold rounded-lg text-[#ea580c] bg-white hover:bg-orange-50 transition-all duration-200 transform hover:-translate-y-0.5 shadow-lg">
                     <i class="fa-solid fa-calendar mr-2"></i> Schedule Demo
                 </a>
                 <a href="${pageContext.request.contextPath}/register" class="inline-flex items-center justify-center px-8 py-4 border-2 border-white text-base font-semibold rounded-lg text-white hover:bg-white/10 transition-all duration-200 transform hover:-translate-y-0.5">
                     <i class="fa-solid fa-user-plus mr-2"></i> Get Started Free
                 </a>
             </div>

             <!-- Demo Details Grid -->
             <div class="grid md:grid-cols-3 gap-8 mt-16 pt-12 border-t border-white/20">
                 <div>
                     <div class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-white/20 text-white mb-4">
                         <i class="fa-solid fa-clock"></i>
                     </div>
                     <h3 class="font-semibold text-lg mb-1">30 Minutes</h3>
                     <p class="text-orange-100 text-sm">Quick overview of key features</p>
                 </div>
                 <div>
                     <div class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-white/20 text-white mb-4">
                         <i class="fa-solid fa-user-tie"></i>
                     </div>
                     <h3 class="font-semibold text-lg mb-1">Expert Guide</h3>
                     <p class="text-orange-100 text-sm">Dedicated product specialist</p>
                 </div>
                 <div>
                     <div class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-white/20 text-white mb-4">
                         <i class="fa-solid fa-check-circle"></i>
                     </div>
                     <h3 class="font-semibold text-lg mb-1">Free Trial</h3>
                     <p class="text-orange-100 text-sm">No credit card required</p>
                 </div>
             </div>
         </div>
     </section>
</body>
</html>