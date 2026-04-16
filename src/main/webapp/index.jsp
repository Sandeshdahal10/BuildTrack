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
</body>
</html>