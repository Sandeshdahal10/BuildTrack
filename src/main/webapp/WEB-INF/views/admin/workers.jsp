<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Workers - BuildTrack</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="h-screen overflow-hidden bg-slate-50 text-slate-900">

<div style="display:flex;height:100vh;">

    <div style="width:224px;flex-shrink:0;position:fixed;top:0;bottom:0;left:0;z-index:30;">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div style="margin-left:224px;flex:1;display:flex;flex-direction:column;overflow-y:auto;height:100vh;">

        <div style="position:sticky;top:0;z-index:20;">
            <jsp:include page="../common/adminTopbar.jsp" />
        </div>

        <main style="flex:1;padding:32px;">

            <%-- Header --%>
            <div class="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                <div>
                    <h1 class="text-2xl font-bold text-slate-800">Workers</h1>
                    <p class="mt-1 text-slate-500">Manage worker accounts, assignments, and performance across projects.</p>
                </div>
                <a href="<%= request.getContextPath() %>/admin/workers/form?mode=create" class="inline-flex items-center gap-2 self-start rounded-lg bg-orange-500 px-5 py-2.5 text-sm font-semibold text-white transition hover:bg-orange-600 sm:self-auto">
                    <i data-lucide="plus" class="h-4 w-4"></i>
                    Add Worker
                </a>
            </div>

            <%-- Stat cards --%>
            <div style="display:flex;gap:12px;flex-wrap:wrap;margin-bottom:24px;">

                <div style="flex:1;min-width:150px;background:white;border:1px solid lavender;border-radius:12px;padding:18px 20px;">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div>
                            <p style="margin:0;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:.05em;color:slategray;">Total Workers</p>
                            <p style="margin:8px 0 0;font-size:28px;font-weight:700;color:darkslategray;">6</p>
                        </div>
                        <span style="width:40px;height:40px;border-radius:8px;background:floralwhite;border:1px solid peachpuff;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <svg style="width:16px;height:16px;" fill="none" stroke="orangered" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8z"/></svg>
                        </span>
                    </div>
                </div>

                <div style="flex:1;min-width:150px;background:white;border:1px solid lavender;border-radius:12px;padding:18px 20px;">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div>
                            <p style="margin:0;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:.05em;color:slategray;">Active</p>
                            <p style="margin:8px 0 0;font-size:28px;font-weight:700;color:darkslategray;">4</p>
                        </div>
                        <span style="width:40px;height:40px;border-radius:8px;background:honeydew;border:1px solid palegreen;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <svg style="width:16px;height:16px;" fill="none" stroke="seagreen" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
                        </span>
                    </div>
                </div>

                <div style="flex:1;min-width:150px;background:white;border:1px solid lavender;border-radius:12px;padding:18px 20px;">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div>
                            <p style="margin:0;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:.05em;color:slategray;">On Leave</p>
                            <p style="margin:8px 0 0;font-size:28px;font-weight:700;color:darkslategray;">1</p>
                        </div>
                        <span style="width:40px;height:40px;border-radius:8px;background:lightyellow;border:1px solid khaki;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <svg style="width:16px;height:16px;" fill="none" stroke="darkgoldenrod" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="10" y1="15" x2="10" y2="9"/><line x1="14" y1="15" x2="14" y2="9"/></svg>
                        </span>
                    </div>
                </div>

                <div style="flex:1;min-width:150px;background:white;border:1px solid lavender;border-radius:12px;padding:18px 20px;">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div>
                            <p style="margin:0;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:.05em;color:slategray;">Deactivated</p>
                            <p style="margin:8px 0 0;font-size:28px;font-weight:700;color:darkslategray;">1</p>
                        </div>
                        <span style="width:40px;height:40px;border-radius:8px;background:lavenderblush;border:1px solid mistyrose;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                            <svg style="width:16px;height:16px;" fill="none" stroke="crimson" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
                        </span>
                    </div>
                </div>

            </div>

            <%-- Search & Filter --%>
            <div style="background:white;border:1px solid lavender;border-radius:16px;padding:16px 20px;margin-bottom:24px;">
                <div style="display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;">
                    <div style="position:relative;flex:1;min-width:200px;max-width:400px;">
                        <svg style="position:absolute;left:10px;top:50%;transform:translateY(-50%);width:14px;height:14px;" fill="none" stroke="darkgray" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-4.35-4.35"/></svg>
                        <input id="workerSearch" type="text" placeholder="Search by name, role or project..." style="width:100%;padding:8px 12px 8px 32px;border:1px solid lavender;border-radius:8px;font-size:13px;color:darkslategray;outline:none;box-sizing:border-box;" />
                    </div>
                    <div style="display:flex;flex-wrap:wrap;gap:6px;">
                        <button data-filter="all"         class="wflt" style="background:darkorange;color:white;border:1px solid darkorange;border-radius:9999px;padding:5px 14px;font-size:12px;font-weight:700;cursor:pointer;">All</button>
                        <button data-filter="active"      class="wflt" style="background:white;color:slategray;border:1px solid lavender;border-radius:9999px;padding:5px 14px;font-size:12px;font-weight:700;cursor:pointer;">Active</button>
                        <button data-filter="on leave"    class="wflt" style="background:white;color:slategray;border:1px solid lavender;border-radius:9999px;padding:5px 14px;font-size:12px;font-weight:700;cursor:pointer;">On Leave</button>
                        <button data-filter="deactivated" class="wflt" style="background:white;color:slategray;border:1px solid lavender;border-radius:9999px;padding:5px 14px;font-size:12px;font-weight:700;cursor:pointer;">Deactivated</button>
                    </div>
                </div>
            </div>

<div id="workerList" class="flex flex-col gap-3">

    <!-- Rajan -->
    <jsp:include page="/WEB-INF/views/common/workerCard.jsp">
        <jsp:param name="id" value="1"/>
        <jsp:param name="name" value="Rajan Thapa"/>
        <jsp:param name="initials" value="RT"/>
        <jsp:param name="role" value="Mason"/>
        <jsp:param name="project" value="Skyline Tower Complex"/>
        <jsp:param name="projectCount" value="4"/>
        <jsp:param name="attendance" value="92"/>
        <jsp:param name="status" value="active"/>
    </jsp:include>

    <!-- Sunita -->
    <jsp:include page="/WEB-INF/views/common/workerCard.jsp">
        <jsp:param name="id" value="2"/>
        <jsp:param name="name" value="Sunita Rai"/>
        <jsp:param name="initials" value="SR"/>
        <jsp:param name="role" value="Electrician"/>
        <jsp:param name="project" value="Green Valley Residency"/>
        <jsp:param name="projectCount" value="2"/>
        <jsp:param name="attendance" value="88"/>
        <jsp:param name="status" value="active"/>
    </jsp:include>

    <!-- Dipesh (on leave) -->
    <jsp:include page="/WEB-INF/views/common/workerCard.jsp">
        <jsp:param name="id" value="5"/>
        <jsp:param name="name" value="Dipesh Shrestha"/>
        <jsp:param name="initials" value="DS"/>
        <jsp:param name="role" value="Carpenter"/>
        <jsp:param name="project" value="Sunrise School Block A"/>
        <jsp:param name="projectCount" value="2"/>
        <jsp:param name="attendance" value="74"/>
        <jsp:param name="status" value="on leave"/>
    </jsp:include>

</div>

            <%-- Empty state --%>
            <div id="workerEmpty" style="display:none;margin-top:12px;border:1px dashed lightsteelblue;border-radius:12px;background:white;padding:32px;text-align:center;">
                <p style="font-size:15px;font-weight:600;color:slategray;margin:0;">No workers found</p>
                <p style="font-size:13px;color:darkgray;margin:6px 0 0;">Try a different name, role, or status filter.</p>
            </div>

        </main>
    </div>
</div>

<script>
    lucide.createIcons();

    var rows = document.querySelectorAll('#workerList > div');
    var summary = document.getElementById('workerSummary');
    var empty = document.getElementById('workerEmpty');
    var activeF = 'all';

    function paintAttendanceBars() {
        rows.forEach(function(r) {
            var labels = r.querySelectorAll('p');
            labels.forEach(function(lbl) {
                if (lbl.textContent.trim().toLowerCase() !== 'attendance') {
                    return;
                }

                var valueEl = lbl.nextElementSibling;
                if (!valueEl || valueEl.dataset.progressReady === '1') {
                    return;
                }

                var pct = parseInt(valueEl.textContent, 10);
                if (isNaN(pct)) {
                    pct = 0;
                }

                var track = document.createElement('div');
                track.style.width = '72px';
                track.style.height = '6px';
                track.style.borderRadius = '9999px';
                track.style.background = '#ffedd5';
                track.style.marginTop = '6px';

                var fill = document.createElement('div');
                fill.style.width = Math.max(0, Math.min(100, pct)) + '%';
                fill.style.height = '100%';
                fill.style.borderRadius = '9999px';
                fill.style.background = '#f97316';

                track.appendChild(fill);
                valueEl.insertAdjacentElement('afterend', track);
                valueEl.dataset.progressReady = '1';
            });
        });
    }

    function applyFilters() {
        var term = document.getElementById('workerSearch').value.toLowerCase().trim();
        var visible = 0;
        rows.forEach(function(r) {
            var show = (activeF === 'all' || r.dataset.status === activeF)
                    && (term === '' || r.dataset.name.includes(term) || r.dataset.role.includes(term) || r.dataset.project.includes(term));
            r.style.display = show ? '' : 'none';
            if (show) visible++;
        });
        summary.textContent = 'Showing ' + visible + ' of ' + rows.length + ' workers';
        empty.style.display = visible === 0 ? '' : 'none';
    }

    document.getElementById('workerSearch').addEventListener('input', applyFilters);

    document.querySelectorAll('.wflt').forEach(function(btn) {
        btn.addEventListener('click', function() {
            activeF = btn.dataset.filter;
            document.querySelectorAll('.wflt').forEach(function(b) {
                var on = b === btn;
                b.style.background = on ? 'darkorange' : 'white';
                b.style.color      = on ? 'white'      : 'slategray';
                b.style.border     = on ? '1px solid darkorange' : '1px solid lavender';
            });
            applyFilters();
        });
    });

    paintAttendanceBars();
</script>

</body>
</html>