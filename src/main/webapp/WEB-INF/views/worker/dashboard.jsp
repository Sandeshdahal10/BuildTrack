<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Worker Dashboard - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .pulse-dot {
            animation: pulse 2s infinite;
        }
        .card-animate {
            animation: slideUp 0.5s ease-out;
        }
        .sidebar-wrapper {
            display: flex;
            flex-direction: column;
            height: 100%;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 text-gray-800">
    <div class="flex h-screen">
        <!-- Sidebar -->
        <aside class="w-56 flex flex-col bg-gradient-to-b from-slate-900 via-slate-800 to-slate-900 text-white shadow-2xl border-r border-slate-700 h-full relative">
            <div class="p-6 flex-1 overflow-y-auto">
                <!-- Logo -->
                <div class="flex items-center mb-10 text-sm font-bold tracking-wide">
                    <div class="w-9 h-9 bg-orange-600 rounded-md flex items-center justify-center mr-3 font-bold">A</div>
                    <div class="flex flex-col leading-tight">
                        <div class="text-sm">BUILDTRACK</div>
                        <div class="text-xs text-gray-500 mt-0.5">PROJECT MGMT</div>
                    </div>
                </div>

                <!-- Navigation Menu -->
                <ul class="space-y-2">
                    <li>
                        <a href="#" class="flex items-center px-4 py-3 text-gray-400 hover:bg-orange-600 hover:bg-opacity-10 hover:text-orange-600 rounded-lg transition-all text-sm active">
                            <span class="w-5 h-5 mr-3 flex items-center justify-center">■</span>
                            Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center px-4 py-3 text-gray-400 hover:bg-orange-600 hover:bg-opacity-10 hover:text-orange-600 rounded-lg transition-all text-sm">
                            <span class="w-5 h-5 mr-3 flex items-center justify-center">■</span>
                            My Projects
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center px-4 py-3 text-gray-400 hover:bg-orange-600 hover:bg-opacity-10 hover:text-orange-600 rounded-lg transition-all text-sm">
                            <span class="w-5 h-5 mr-3 flex items-center justify-center">■</span>
                            Mark Attendance
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center px-4 py-3 text-gray-400 hover:bg-orange-600 hover:bg-opacity-10 hover:text-orange-600 rounded-lg transition-all text-sm">
                            <span class="w-5 h-5 mr-3 flex items-center justify-center">■</span>
                            Work Log
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center px-4 py-3 text-gray-400 hover:bg-orange-600 hover:bg-opacity-10 hover:text-orange-600 rounded-lg transition-all text-sm">
                            <span class="w-5 h-5 mr-3 flex items-center justify-center">■</span>
                            My Payslip
                        </a>
                    </li>
                    <li>
                        <a href="#" class="flex items-center px-4 py-3 text-gray-400 hover:bg-orange-600 hover:bg-opacity-10 hover:text-orange-600 rounded-lg transition-all text-sm">
                            <span class="w-5 h-5 mr-3 flex items-center justify-center">■</span>
                            Profile
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Upgrade Button at Bottom -->
            <div class="p-6 w-full absolute left-0 bottom-0">
                <button class="w-full flex items-center justify-center gap-2 bg-orange-600 hover:bg-orange-700 text-white py-3 rounded-lg font-semibold text-base shadow-lg transition-all duration-200">
                    <span class="inline-flex items-center justify-center w-5 h-5 bg-white bg-opacity-20 rounded mr-2">
                        <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                    </span>
                    Upgrade Plan
                </button>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="flex-1 flex flex-col overflow-auto">
            <!-- Header -->
            <header class="bg-white px-10 py-5 flex justify-between items-center border-b border-gray-200 shadow-sm">
                <h1 class="text-2xl font-semibold text-gray-900">Worker Dashboard</h1>
                <div class="flex items-center gap-5">
                    <div class="flex items-center gap-2 text-sm font-semibold text-orange-600">
                        <span class="w-2 h-2 bg-orange-600 rounded-full pulse-dot"></span>
                        On-Site
                    </div>
                    <div class="w-10 h-10 bg-gradient-to-br from-orange-600 to-orange-500 rounded-full flex items-center justify-center text-white font-bold text-sm cursor-pointer">JD</div>
                </div>
            </header>

            <!-- Content Area -->
            <div class="flex-1 p-10 overflow-y-auto">
                <!-- Top Grid -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-8">
                    <!-- Current Assignment Card -->
                    <div class="lg:col-span-2 bg-gradient-to-br from-blue-900 to-blue-800 text-white p-10 rounded-2xl shadow-lg">
                        <div class="text-xs tracking-widest font-semibold text-gray-400 mb-4">CURRENT ASSIGNMENT</div>
                        <div class="text-4xl font-bold leading-tight mb-6">Skyline Heights Tower<br>Section B - Level 12</div>

                        <div class="flex flex-col sm:flex-row gap-8 mb-6">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-orange-600 bg-opacity-20 rounded-lg flex items-center justify-center text-orange-400 font-bold text-sm">W</div>
                                <div>
                                    <div class="text-xs text-gray-400">Role</div>
                                    <div class="text-white font-semibold text-sm">Senior Welder</div>
                                </div>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 bg-orange-600 bg-opacity-20 rounded-lg flex items-center justify-center text-orange-400 font-bold text-sm">C</div>
                                <div>
                                    <div class="text-xs text-gray-400">Shift</div>
                                    <div class="text-white font-semibold text-sm">08:00 - 17:00</div>
                                </div>
                            </div>
                        </div>

                        <div class="flex items-center gap-2 mb-6">
                            <div class="w-9 h-9 rounded-full bg-gradient-to-br from-orange-600 to-orange-500 flex items-center justify-center text-white font-bold text-xs border-2 border-blue-800 -mr-3">AK</div>
                            <div class="w-9 h-9 rounded-full bg-gradient-to-br from-orange-600 to-orange-500 flex items-center justify-center text-white font-bold text-xs border-2 border-blue-800 -mr-3">MJ</div>
                            <div class="w-9 h-9 rounded-full bg-gradient-to-br from-orange-600 to-orange-500 flex items-center justify-center text-white font-bold text-xs border-2 border-blue-800 -mr-3">SH</div>
                            <div class="w-9 h-9 rounded-full bg-orange-600 bg-opacity-30 flex items-center justify-center text-orange-400 font-bold text-xs ml-2">+2</div>
                        </div>

                        <div class="flex justify-end">
                            <button class="bg-white text-gray-900 px-5 py-2.5 rounded-lg font-semibold text-sm hover:shadow-lg hover:-translate-y-0.5 transition-all">View Blueprint</button>
                        </div>
                    </div>

                    <!-- Today's Status Card -->
                    <div class="bg-white p-8 rounded-2xl shadow-md">
                        <div class="text-xs font-semibold text-gray-500 uppercase tracking-wide mb-5">Today's Status</div>
                        <div class="text-center">
                            <div class="text-lg font-semibold text-gray-900 mb-1">Punched In</div>
                            <div class="text-xs text-gray-500 mb-5">Checked in at 07:54 AM</div>

                            <div class="w-32 h-32 mx-auto mb-6 flex items-center justify-center relative">
                                <svg class="absolute top-0 left-0" width="128" height="128" viewBox="0 0 40 40">
                                    <circle cx="20" cy="20" r="18" fill="none" stroke="#f0f0f0" stroke-width="4" />
                                    <circle cx="20" cy="20" r="18" fill="none" stroke="#ff6b35" stroke-width="4" stroke-dasharray="113.097" stroke-dashoffset="42.5" stroke-linecap="round" />
                                </svg>
                                <div class="flex flex-col items-center justify-center w-full h-full z-10">
                                    <div class="text-4xl font-bold text-gray-900">6.5</div>
                                    <div class="text-xs text-gray-500 font-semibold mt-0.5">HOURS</div>
                                </div>
                            </div>

                            <button class="w-full bg-orange-100 text-orange-600 py-3 rounded-lg font-semibold text-sm hover:bg-orange-200 transition-all">Punch Out</button>
                        </div>
                    </div>
                </div>

                <!-- Bottom Grid -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- October Summary -->
                    <div class="bg-white p-8 rounded-2xl shadow-md">
                        <div class="flex items-center gap-2 mb-6">
                            <div class="text-base font-semibold text-gray-900">October Summary</div>
                            <div class="w-5 h-5 bg-gray-100 rounded flex items-center justify-center text-xs text-gray-500">C</div>
                        </div>

                        <div class="space-y-5">
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center text-orange-600 font-bold">A</div>
                                <div class="flex-1">
                                    <div class="text-xs text-gray-500 font-semibold">Attendance</div>
                                    <div class="text-sm font-bold text-gray-900">92%</div>
                                    <div class="w-full h-1.5 bg-gray-200 rounded-full overflow-hidden mt-1">
                                        <div class="h-full bg-orange-600" style="width: 92%"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center text-orange-600 font-bold">T</div>
                                <div class="flex-1">
                                    <div class="text-xs text-gray-500 font-semibold">Overtime</div>
                                    <div class="text-sm font-bold text-gray-900">14.5 Hrs</div>
                                </div>
                            </div>

                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center text-orange-600 font-bold text-lg">Rs.</div>
                                <div class="flex-1">
                                    <div class="text-xs text-gray-500 font-semibold">EST. EARNINGS</div>
                                    <div class="text-xl font-bold text-gray-900">Rs.4,280.00</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Work Log -->
                    <div class="lg:col-span-2 bg-white p-8 rounded-2xl shadow-md">
                        <div class="flex justify-between items-center mb-6">
                            <div class="text-base font-semibold text-gray-900">Recent Work Log</div>
                            <a href="#" class="text-orange-600 text-xs font-semibold hover:underline">View All Entries</a>
                        </div>

                        <div class="overflow-x-auto">
                            <table class="w-full text-sm">
                                <thead class="border-b-2 border-gray-100">
                                    <tr>
                                        <th class="text-left py-3 text-xs font-bold text-gray-500 uppercase tracking-wide">Date</th>
                                        <th class="text-left py-3 text-xs font-bold text-gray-500 uppercase tracking-wide">Activity / Task</th>
                                        <th class="text-center py-3 text-xs font-bold text-gray-500 uppercase tracking-wide">Duration</th>
                                        <th class="text-left py-3 text-xs font-bold text-gray-500 uppercase tracking-wide">Status</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-100">
                                    <tr>
                                        <td class="py-4 text-sm font-semibold text-gray-900 whitespace-nowrap">Oct 24, 2023</td>
                                        <td class="py-4 text-sm text-gray-600">
                                            <div class="flex items-center gap-2">
                                                <div class="w-6 h-6 bg-orange-100 rounded flex items-center justify-center text-orange-600 font-bold text-xs">W</div>
                                                Structural welding - Support Beams
                                            </div>
                                        </td>
                                        <td class="py-4 text-sm text-gray-600 text-center">8h 15m</td>
                                        <td class="py-4"><span class="inline-block px-3 py-1 bg-orange-100 text-orange-600 rounded text-xs font-semibold">Approved</span></td>
                                    </tr>
                                    <tr>
                                        <td class="py-4 text-sm font-semibold text-gray-900 whitespace-nowrap">Oct 23, 2023</td>
                                        <td class="py-4 text-sm text-gray-600">
                                            <div class="flex items-center gap-2">
                                                <div class="w-6 h-6 bg-orange-100 rounded flex items-center justify-center text-orange-600 font-bold text-xs">S</div>
                                                Site safety inspection & Prep
                                            </div>
                                        </td>
                                        <td class="py-4 text-sm text-gray-600 text-center">7h 45m</td>
                                        <td class="py-4"><span class="inline-block px-3 py-1 bg-orange-100 text-orange-600 rounded text-xs font-semibold">Approved</span></td>
                                    </tr>
                                    <tr>
                                        <td class="py-4 text-sm font-semibold text-gray-900 whitespace-nowrap">Oct 22, 2023</td>
                                        <td class="py-4 text-sm text-gray-600">
                                            <div class="flex items-center gap-2">
                                                <div class="w-6 h-6 bg-orange-100 rounded flex items-center justify-center text-orange-600 font-bold text-xs">R</div>
                                                Reinforcement joint welding
                                            </div>
                                        </td>
                                        <td class="py-4 text-sm text-gray-600 text-center">9h 30m</td>
                                        <td class="py-4"><span class="inline-block px-3 py-1 bg-gray-100 text-gray-600 rounded text-xs font-semibold">Pending</span></td>
                                    </tr>
                                    <tr>
                                        <td class="py-4 text-sm font-semibold text-gray-900 whitespace-nowrap">Oct 21, 2023</td>
                                        <td class="py-4 text-sm text-gray-600">
                                            <div class="flex items-center gap-2">
                                                <div class="w-6 h-6 bg-orange-100 rounded flex items-center justify-center text-orange-600 font-bold text-xs">P</div>
                                                Plan review & Material sorting
                                            </div>
                                        </td>
                                        <td class="py-4 text-sm text-gray-600 text-center">8h 00m</td>
                                        <td class="py-4"><span class="inline-block px-3 py-1 bg-orange-100 text-orange-600 rounded text-xs font-semibold">Approved</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
