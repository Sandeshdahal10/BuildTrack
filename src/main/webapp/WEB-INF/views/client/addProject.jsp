<%--
  Client: Add New Project Form
  User: BuildTrack Development
  Date: May 17, 2026
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buildtrack.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    User user = (User) session.getAttribute("user");
    String displayName = (user != null && user.getFullName() != null && !user.getFullName().trim().isEmpty())
            ? user.getFullName()
            : "Client";
    
    @SuppressWarnings("unchecked")
    List<String> formErrors = (List<String>) session.getAttribute("formErrors");
    
    @SuppressWarnings("unchecked")
    Map<String, String> formData = (Map<String, String>) session.getAttribute("formData");
    
    // Clear session attributes after reading them
    session.removeAttribute("formErrors");
    session.removeAttribute("formData");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuildTrack | Add New Project</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="m-0 min-h-screen bg-white text-slate-900">
<div class="h-screen flex font-semibold">
    <div id="sidebar-container" class="fixed inset-y-0 left-0 z-50 w-56 transform -translate-x-full transition-transform duration-300 md:translate-x-0 border-r border-blue-900/60 bg-[#0b1f4d]">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <main class="ml-0 md:ml-56 overflow-hidden flex-1 overflow-y-auto bg-white px-5 pb-7 pt-4">
        <!-- Header -->
        <div class="mb-4 flex items-center justify-between text-xs text-slate-600 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-2.5">
            <div>
                <p class="m-0">Today</p>
                <p class="m-0 text-[11px]">May 17, 2026</p>
            </div>
            <div class="flex items-center gap-2.5 max-[760px]:w-full max-[760px]:flex-wrap">
                <div class="relative">
                    <button id="userMenuButton" class="flex items-center gap-2 rounded-full border border-slate-200 bg-white px-2.5 py-1.5 text-left" type="button" aria-haspopup="true" aria-expanded="false">
                        <div class="grid h-7 w-7 place-items-center rounded-full bg-amber-300 text-xs font-bold text-slate-800"><%= displayName.substring(0, 1).toUpperCase() %></div>
                        <div>
                            <p class="m-0 text-sm font-semibold text-slate-900"><%= displayName %></p>
                            <p class="m-0 text-[11px] text-slate-500">Client</p>
                        </div>
                        <svg class="ml-1 h-4 w-4 text-slate-500" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 11.188l3.71-3.956a.75.75 0 111.08 1.04l-4.24 4.52a.75.75 0 01-1.08 0l-4.24-4.52a.75.75 0 01.02-1.06z" clip-rule="evenodd"></path>
                        </svg>
                    </button>
                    <div id="userMenu" class="absolute right-0 mt-2 hidden w-40 overflow-hidden rounded-xl border border-slate-200 bg-white text-xs shadow-lg">
                        <a href="<%= request.getContextPath() %>/client/profile" class="flex items-center gap-2 px-3 py-2 text-slate-700 hover:bg-slate-50">Profile</a>
                        <a href="<%= request.getContextPath() %>/logout" class="flex items-center gap-2 px-3 py-2 text-rose-600 hover:bg-rose-50">Log Out</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Page Title -->
        <section class="mb-6 border-b border-slate-200 pb-4">
            <a href="<%= request.getContextPath() %>/client/project" class="mb-3 inline-flex items-center gap-2 text-sm text-slate-600 hover:text-slate-900">
                <svg class="h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M15 19l-7-7 7-7"></path>
                </svg>
                Back to Projects
            </a>
            <h1 class="m-0 text-4xl font-semibold leading-tight text-slate-900">Add New Project</h1>
            <p class="mt-1 text-lg text-slate-600">Create a new construction project and upload documents</p>
        </section>

        <!-- Error Messages -->
        <% if (formErrors != null && !formErrors.isEmpty()) { %>
            <div class="mb-6 rounded-lg border border-rose-300 bg-rose-50 p-4">
                <div class="flex items-start gap-3">
                    <svg class="mt-0.5 h-5 w-5 text-rose-600" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                    </svg>
                    <div>
                        <h3 class="m-0 font-semibold text-rose-900">Please fix the following errors:</h3>
                        <ul class="mt-2 list-inside space-y-1 text-sm text-rose-800">
                            <% for (String error : formErrors) { %>
                                <li>• <%= error %></li>
                            <% } %>
                        </ul>
                    </div>
                </div>
            </div>
        <% } %>

        <!-- Form -->
        <form method="POST" action="<%= request.getContextPath() %>/client/addProject" enctype="multipart/form-data" class="max-w-3xl">
            <!-- Project Title -->
            <div class="mb-6">
                <label for="title" class="mb-1 block text-sm font-semibold text-slate-700">Project Title <span class="text-rose-600">*</span></label>
                <input
                    type="text"
                    id="title"
                    name="title"
                    maxlength="100"
                    required
                    placeholder="e.g., Skyline Tower Complex"
                    value="<%= (formData != null && formData.get("title") != null) ? formData.get("title") : "" %>"
                    class="w-full rounded-lg border border-slate-300 px-4 py-2 text-slate-900 placeholder:text-slate-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                />
                <p class="mt-1 text-xs text-slate-500">Maximum 100 characters</p>
            </div>

            <!-- Project Description -->
            <div class="mb-6">
                <label for="description" class="mb-1 block text-sm font-semibold text-slate-700">Description <span class="text-rose-600">*</span></label>
                <textarea
                    id="description"
                    name="description"
                    maxlength="500"
                    required
                    rows="4"
                    placeholder="Provide a detailed description of the project..."
                    class="w-full rounded-lg border border-slate-300 px-4 py-2 text-slate-900 placeholder:text-slate-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                ><%= (formData != null && formData.get("description") != null) ? formData.get("description") : "" %></textarea>
                <p class="mt-1 text-xs text-slate-500">Maximum 500 characters</p>
            </div>

            <!-- Budget -->
            <div class="mb-6">
                <label for="budget" class="mb-1 block text-sm font-semibold text-slate-700">Budget (NPR) <span class="text-rose-600">*</span></label>
                <input
                    type="number"
                    id="budget"
                    name="budget"
                    min="0"
                    step="0.01"
                    required
                    placeholder="e.g., 5000000"
                    value="<%= (formData != null && formData.get("budget") != null) ? formData.get("budget") : "" %>"
                    class="w-full rounded-lg border border-slate-300 px-4 py-2 text-slate-900 placeholder:text-slate-400 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                />
                <p class="mt-1 text-xs text-slate-500">Enter amount in NPR</p>
            </div>

            <!-- Dates Row -->
            <div class="mb-6 grid grid-cols-2 gap-4 max-[600px]:grid-cols-1">
                <!-- Start Date -->
                <div>
                    <label for="startDate" class="mb-1 block text-sm font-semibold text-slate-700">Start Date <span class="text-rose-600">*</span></label>
                    <input
                        type="date"
                        id="startDate"
                        name="startDate"
                        required
                        value="<%= (formData != null && formData.get("startDate") != null) ? formData.get("startDate") : "" %>"
                        class="w-full rounded-lg border border-slate-300 px-4 py-2 text-slate-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                    />
                </div>

                <!-- End Date -->
                <div>
                    <label for="endDate" class="mb-1 block text-sm font-semibold text-slate-700">End Date <span class="text-rose-600">*</span></label>
                    <input
                        type="date"
                        id="endDate"
                        name="endDate"
                        required
                        value="<%= (formData != null && formData.get("endDate") != null) ? formData.get("endDate") : "" %>"
                        class="w-full rounded-lg border border-slate-300 px-4 py-2 text-slate-900 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                    />
                </div>
            </div>

            <!-- Status (Forced to Planned for Admin Approval) -->
            <div class="mb-6">
                <input type="hidden" name="status" value="PLANNED">
                <label class="mb-1 block text-sm font-semibold text-slate-700">Project Status</label>
                <div class="w-full rounded-lg border border-slate-300 bg-slate-50 px-4 py-2 text-slate-500">
                    Pending Approval (Planned)
                </div>
            </div>

            <!-- Document Upload -->
            <div class="mb-8">
                <label for="document" class="mb-1 block text-sm font-semibold text-slate-700">Project Document (Optional)</label>
                <div class="rounded-lg border-2 border-dashed border-slate-300 p-6 text-center hover:border-slate-400" id="uploadAreaContainer">
                    <input
                        type="file"
                        id="document"
                        name="document"
                        accept=".pdf,.doc,.docx,.jpg,.jpeg,.png"
                        class="hidden"
                        aria-label="Upload project document"
                    />
                    
                    <!-- Default upload prompt -->
                    <div id="uploadDefaultPrompt">
                        <svg class="mx-auto mb-2 h-8 w-8 text-slate-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4"></path>
                            <polyline points="17 8 12 3 7 8"></polyline>
                            <line x1="12" y1="3" x2="12" y2="15"></line>
                        </svg>
                        <label for="document" class="cursor-pointer">
                            <span class="font-semibold text-blue-600 hover:text-blue-700">Click to upload</span>
                            <span class="text-slate-600"> or drag and drop</span>
                        </label>
                        <p class="mt-1 text-xs text-slate-500">
                            PDF, DOC, DOCX, JPG, PNG • Max 5 MB
                        </p>
                    </div>
                    
                    <!-- File selected preview card -->
                    <div id="uploadSelectedCard" class="hidden max-w-md mx-auto mt-2 flex items-center justify-between border border-slate-200 bg-slate-50 rounded-xl p-4 text-left">
                        <div class="flex items-center gap-3 min-w-0 flex-1">
                            <div id="filePreviewBadge" class="w-10 h-10 rounded-lg bg-blue-100 text-blue-600 flex items-center justify-center font-bold text-xs uppercase shrink-0">
                                PDF
                            </div>
                            <div class="min-w-0 flex-1">
                                <p id="selectedFileName" class="text-sm font-semibold text-slate-800 truncate" title=""></p>
                                <p id="selectedFileInfo" class="text-xs text-slate-500"></p>
                            </div>
                        </div>
                        <button type="button" id="clearFileSelectionBtn" class="text-slate-400 hover:text-rose-600 transition p-2 shrink-0" title="Remove document">
                            <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="18" y1="6" x2="6" y2="18"></line>
                                <line x1="6" y1="6" x2="18" y2="18"></line>
                            </svg>
                        </button>
                    </div>
                </div>
            </div>

            <!-- Form Buttons -->
            <div class="flex gap-4">
                <button
                    type="submit"
                    class="rounded-lg bg-blue-600 px-6 py-2 font-semibold text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
                >
                    Create Project
                </button>
                <a
                    href="<%= request.getContextPath() %>/client/project"
                    class="rounded-lg border border-slate-300 px-6 py-2 font-semibold text-slate-700 hover:bg-slate-50 focus:outline-none focus:ring-2 focus:ring-slate-300 focus:ring-offset-2"
                >
                    Cancel
                </a>
            </div>
        </form>
    </main>
</div>

<script>
    // User menu toggle
    const userMenuButton = document.getElementById('userMenuButton');
    const userMenu = document.getElementById('userMenu');

    if (userMenuButton && userMenu) {
        userMenuButton.addEventListener('click', function () {
            userMenu.classList.toggle('hidden');
        });

        document.addEventListener('click', function (event) {
            if (!userMenuButton.contains(event.target) && !userMenu.contains(event.target)) {
                userMenu.classList.add('hidden');
            }
        });
    }

    // File upload handling
    const documentInput = document.getElementById('document');
    const uploadArea = document.getElementById('uploadAreaContainer');
    const defaultPrompt = document.getElementById('uploadDefaultPrompt');
    const selectedCard = document.getElementById('uploadSelectedCard');
    const fileNameEl = document.getElementById('selectedFileName');
    const fileInfoEl = document.getElementById('selectedFileInfo');
    const filePreviewBadge = document.getElementById('filePreviewBadge');
    const clearFileBtn = document.getElementById('clearFileSelectionBtn');

    if (documentInput && uploadArea) {
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => {
                uploadArea.classList.add('bg-blue-50');
            });
        });

        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, () => {
                uploadArea.classList.remove('bg-blue-50');
            });
        });

        function handleFileDisplay(files) {
            if (files && files.length > 0) {
                const file = files[0];
                const fileName = file.name;
                const fileSize = (file.size / 1024 / 1024).toFixed(2);
                
                // Extract clean extension for the icon badge
                const dotIndex = fileName.lastIndexOf('.');
                let ext = dotIndex !== -1 ? fileName.substring(dotIndex + 1).toUpperCase() : 'FILE';
                if (ext.length > 4) ext = ext.substring(0, 4);
                
                // Map extension to full display type
                let fileTypeDesc = 'Document';
                if (['JPG', 'JPEG', 'PNG', 'GIF'].includes(ext)) {
                    fileTypeDesc = 'Image';
                } else if (ext === 'PDF') {
                    fileTypeDesc = 'PDF Document';
                } else if (['DOC', 'DOCX'].includes(ext)) {
                    fileTypeDesc = 'Word Document';
                }

                fileNameEl.textContent = fileName;
                fileNameEl.title = fileName;
                fileInfoEl.textContent = `${fileSize} MB \xe2\x80\xa2 ${fileTypeDesc}`;
                filePreviewBadge.textContent = ext;

                // Toggle display cards
                defaultPrompt.classList.add('hidden');
                selectedCard.classList.remove('hidden');
            } else {
                fileNameEl.textContent = '';
                fileInfoEl.textContent = '';
                defaultPrompt.classList.remove('hidden');
                selectedCard.classList.add('hidden');
            }
        }

        uploadArea.addEventListener('drop', (e) => {
            const dt = e.dataTransfer;
            const files = dt.files;
            documentInput.files = files;
            handleFileDisplay(files);
        });

        documentInput.addEventListener('change', function () {
            handleFileDisplay(this.files);
        });

        clearFileBtn.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            documentInput.value = ''; // Clear actual input file list
            handleFileDisplay(null);
        });
    }

    // Date validation on client side
    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');

    if (startDateInput && endDateInput) {
        function validateDates() {
            if (startDateInput.value && endDateInput.value) {
                const startDate = new Date(startDateInput.value);
                const endDate = new Date(endDateInput.value);
                if (endDate < startDate) {
                    endDateInput.setCustomValidity('End date must be after or equal to start date.');
                } else {
                    endDateInput.setCustomValidity('');
                }
            }
        }

        startDateInput.addEventListener('change', validateDates);
        endDateInput.addEventListener('change', validateDates);
    }
</script>
</body>
</html>
