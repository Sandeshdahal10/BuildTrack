<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-4 mb-6">
                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Total Workers" />
                    <jsp:param name="value" value="${empty userStats ? 0 : userStats.totalWorkers}" />
                    <jsp:param name="icon" value="users" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-slate-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-slate-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Active" />
                    <jsp:param name="value" value="${empty userStats ? 0 : userStats.totalWorkers}" />
                    <jsp:param name="icon" value="user-check" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-green-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-green-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="On Leave" />
                    <jsp:param name="value" value="0" />
                    <jsp:param name="icon" value="pause-circle" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-amber-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-amber-600" />
                </jsp:include>

                <jsp:include page="../common/statsCard.jsp">
                    <jsp:param name="title" value="Deactivated" />
                    <jsp:param name="value" value="0" />
                    <jsp:param name="icon" value="user-x" />
                    <jsp:param name="iconWrapClass" value="p-3 rounded-lg bg-red-100" />
                    <jsp:param name="iconClass" value="w-5 h-5 text-red-600" />
                </jsp:include>
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
    <c:forEach var="worker" items="${workers}">
        <jsp:include page="/WEB-INF/views/common/workerCard.jsp">
            <jsp:param name="id" value="${worker.id}"/>
            <jsp:param name="name" value="${worker.fullName}"/>
            <jsp:param name="initials" value="${fn:substring(worker.fullName, 0, 1)}"/>
            <jsp:param name="role" value="${worker.roleDisplayName}"/>
            <jsp:param name="project" value="Unassigned"/>
            <jsp:param name="projectCount" value="0"/>
            <jsp:param name="attendance" value="0"/>
            <jsp:param name="status" value="${worker.status}"/>
        </jsp:include>
    </c:forEach>
</div>

            <%-- Empty state --%>
            <div id="workerEmpty" style="display:none;margin-top:12px;border:1px dashed lightsteelblue;border-radius:12px;background:white;padding:32px;text-align:center;">
                <p style="font-size:15px;font-weight:600;color:slategray;margin:0;">No workers found</p>
                <p style="font-size:13px;color:darkgray;margin:6px 0 0;">Try a different name, role, or status filter.</p>
            </div>

            <p id="workerSummary" class="mt-4 text-sm text-slate-500">Showing ${empty workers ? 0 : workers.size()} workers</p>

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
        if (summary) {
            summary.textContent = 'Showing ' + visible + ' of ' + rows.length + ' workers';
        }
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