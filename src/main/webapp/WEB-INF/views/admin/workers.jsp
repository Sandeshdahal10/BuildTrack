<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Workers - BuildTrack</title>
</head>
<body style="margin:0;padding:0;background:whitesmoke;font-family:sans-serif;color:darkslategray;height:100vh;overflow:hidden;">

<div style="display:flex;height:100vh;">

    <div style="width:224px;flex-shrink:0;position:fixed;inset-y:0;left:0;z-index:30;">
        <jsp:include page="../common/sidebar.jsp" />
    </div>

    <div style="margin-left:224px;flex:1;display:flex;flex-direction:column;overflow-y:auto;height:100vh;">

        <div style="position:sticky;top:0;z-index:20;">
            <jsp:include page="../common/adminTopbar.jsp" />
        </div>

        <main style="flex:1;padding:32px;">

            <%-- Header --%>
            <div style="background:white;border:1px solid lavender;border-radius:16px;padding:24px 28px;margin-bottom:24px;">
                <div style="display:flex;flex-wrap:wrap;justify-content:space-between;align-items:flex-start;gap:16px;">
                    <div>
                        <h1 style="font-size:28px;font-weight:700;color:darkslategray;margin:0;">Workers</h1>
                        <p style="margin:8px 0 4px;color:slategray;font-size:14px;">Manage worker accounts, assignments, and performance across projects.</p>
                    </div>
                    <div style="display:flex;gap:10px;flex-wrap:wrap;align-items:center;">
                        <a href="<%= request.getContextPath() %>/admin/workers/form?mode=create" style="display:inline-flex;align-items:center;gap:6px;background:darkorange;border:none;padding:10px 16px;border-radius:8px;font-size:13px;font-weight:600;color:white;text-decoration:none;">
                            <svg style="width:14px;height:14px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                            Add Worker
                        </a>
                    </div>
                </div>
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

            <%-- Worker list --%>
            <div id="workerList" style="display:flex;flex-direction:column;gap:10px;">

                <%-- ============ ACTIVE WORKER TEMPLATE ============ --%>

                <%-- Rajan Thapa — Active --%>
                <div data-status="active" data-name="rajan thapa" data-role="mason" data-project="skyline tower complex"
                     style="background:white;border:1px solid gainsboro;border-left:4px solid darkorange;border-radius:14px;padding:16px 20px;display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;">
                    <div style="display:flex;align-items:center;gap:14px;flex:1;min-width:220px;">
                        <div style="width:44px;height:44px;border-radius:50%;background:floralwhite;color:chocolate;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;flex-shrink:0;">RT</div>
                        <div>
                            <p style="font-weight:700;font-size:15px;color:darkslategray;margin:0;">Rajan Thapa</p>
                            <div style="display:flex;align-items:center;gap:8px;margin-top:4px;flex-wrap:wrap;">
                                <span style="background:ghostwhite;color:slategray;border-radius:6px;padding:2px 8px;font-size:12px;">Mason</span>
                                <span style="display:inline-flex;align-items:center;gap:4px;color:slategray;font-size:12px;">
                                    <svg style="width:12px;height:12px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h4l2 2h8a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/></svg>
                                    Skyline Tower Complex
                                </span>
                            </div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:20px;flex-wrap:wrap;">
                        <div style="text-align:center;">
                            <p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Projects</p>
                            <p style="font-size:16px;font-weight:700;color:darkslategray;margin:2px 0 0;">4</p>
                        </div>
                        <div style="text-align:center;">
                            <p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Attendance</p>
                            <p style="font-size:16px;font-weight:700;color:seagreen;margin:2px 0 0;">92%</p>
                        </div>
                        <span style="background:honeydew;color:forestgreen;border:1px solid lightgreen;border-radius:9999px;padding:3px 11px;font-size:12px;font-weight:700;">Active</span>
                        <div style="display:flex;gap:6px;">
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=view&id=1" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid lightsteelblue;background:white;color:darkslategray;text-decoration:none;">
                                <svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>View
                            </a>
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=edit&id=1" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid darkorange;background:darkorange;color:white;text-decoration:none;">
                                <svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>Edit
                            </a>
                            <a href="<%= request.getContextPath() %>/admin/workers?action=deactivate&id=1" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid mistyrose;background:lavenderblush;color:firebrick;text-decoration:none;">
                                <svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>Deactivate
                            </a>
                        </div>
                    </div>
                </div>

                <%-- Sunita Rai — Active --%>
                <div data-status="active" data-name="sunita rai" data-role="electrician" data-project="green valley residency"
                     style="background:white;border:1px solid gainsboro;border-left:4px solid darkorange;border-radius:14px;padding:16px 20px;display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;">
                    <div style="display:flex;align-items:center;gap:14px;flex:1;min-width:220px;">
                        <div style="width:44px;height:44px;border-radius:50%;background:aliceblue;color:royalblue;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;flex-shrink:0;">SR</div>
                        <div>
                            <p style="font-weight:700;font-size:15px;color:darkslategray;margin:0;">Sunita Rai</p>
                            <div style="display:flex;align-items:center;gap:8px;margin-top:4px;flex-wrap:wrap;">
                                <span style="background:ghostwhite;color:slategray;border-radius:6px;padding:2px 8px;font-size:12px;">Electrician</span>
                                <span style="display:inline-flex;align-items:center;gap:4px;color:slategray;font-size:12px;"><svg style="width:12px;height:12px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h4l2 2h8a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/></svg>Green Valley Residency</span>
                            </div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:20px;flex-wrap:wrap;">
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Projects</p><p style="font-size:16px;font-weight:700;color:darkslategray;margin:2px 0 0;">2</p></div>
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Attendance</p><p style="font-size:16px;font-weight:700;color:seagreen;margin:2px 0 0;">88%</p></div>
                        <span style="background:honeydew;color:forestgreen;border:1px solid lightgreen;border-radius:9999px;padding:3px 11px;font-size:12px;font-weight:700;">Active</span>
                        <div style="display:flex;gap:6px;">
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=view&id=2" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid lightsteelblue;background:white;color:darkslategray;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>View</a>
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=edit&id=2" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid darkorange;background:darkorange;color:white;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>Edit</a>
                            <a href="<%= request.getContextPath() %>/admin/workers?action=deactivate&id=2" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid mistyrose;background:lavenderblush;color:firebrick;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>Deactivate</a>
                        </div>
                    </div>
                </div>

                <%-- Bikash Tamang — Active --%>
                <div data-status="active" data-name="bikash tamang" data-role="plumber" data-project="river bridge construction"
                     style="background:white;border:1px solid gainsboro;border-left:4px solid darkorange;border-radius:14px;padding:16px 20px;display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;">
                    <div style="display:flex;align-items:center;gap:14px;flex:1;min-width:220px;">
                        <div style="width:44px;height:44px;border-radius:50%;background:honeydew;color:forestgreen;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;flex-shrink:0;">BT</div>
                        <div>
                            <p style="font-weight:700;font-size:15px;color:darkslategray;margin:0;">Bikash Tamang</p>
                            <div style="display:flex;align-items:center;gap:8px;margin-top:4px;flex-wrap:wrap;">
                                <span style="background:ghostwhite;color:slategray;border-radius:6px;padding:2px 8px;font-size:12px;">Plumber</span>
                                <span style="display:inline-flex;align-items:center;gap:4px;color:slategray;font-size:12px;"><svg style="width:12px;height:12px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h4l2 2h8a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/></svg>River Bridge Construction</span>
                            </div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:20px;flex-wrap:wrap;">
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Projects</p><p style="font-size:16px;font-weight:700;color:darkslategray;margin:2px 0 0;">3</p></div>
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Attendance</p><p style="font-size:16px;font-weight:700;color:seagreen;margin:2px 0 0;">95%</p></div>
                        <span style="background:honeydew;color:forestgreen;border:1px solid lightgreen;border-radius:9999px;padding:3px 11px;font-size:12px;font-weight:700;">Active</span>
                        <div style="display:flex;gap:6px;">
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=view&id=3" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid lightsteelblue;background:white;color:darkslategray;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>View</a>
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=edit&id=3" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid darkorange;background:darkorange;color:white;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>Edit</a>
                            <a href="<%= request.getContextPath() %>/admin/workers?action=deactivate&id=3" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid mistyrose;background:lavenderblush;color:firebrick;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>Deactivate</a>
                        </div>
                    </div>
                </div>

                <%-- Manisha Karki — Active --%>
                <div data-status="active" data-name="manisha karki" data-role="site supervisor" data-project="shopping mall renovation"
                     style="background:white;border:1px solid gainsboro;border-left:4px solid darkorange;border-radius:14px;padding:16px 20px;display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;">
                    <div style="display:flex;align-items:center;gap:14px;flex:1;min-width:220px;">
                        <div style="width:44px;height:44px;border-radius:50%;background:lavenderblush;color:darkorchid;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;flex-shrink:0;">MK</div>
                        <div>
                            <p style="font-weight:700;font-size:15px;color:darkslategray;margin:0;">Manisha Karki</p>
                            <div style="display:flex;align-items:center;gap:8px;margin-top:4px;flex-wrap:wrap;">
                                <span style="background:ghostwhite;color:slategray;border-radius:6px;padding:2px 8px;font-size:12px;">Site Supervisor</span>
                                <span style="display:inline-flex;align-items:center;gap:4px;color:slategray;font-size:12px;"><svg style="width:12px;height:12px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h4l2 2h8a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/></svg>Shopping Mall Renovation</span>
                            </div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:20px;flex-wrap:wrap;">
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Projects</p><p style="font-size:16px;font-weight:700;color:darkslategray;margin:2px 0 0;">5</p></div>
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Attendance</p><p style="font-size:16px;font-weight:700;color:seagreen;margin:2px 0 0;">97%</p></div>
                        <span style="background:honeydew;color:forestgreen;border:1px solid lightgreen;border-radius:9999px;padding:3px 11px;font-size:12px;font-weight:700;">Active</span>
                        <div style="display:flex;gap:6px;">
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=view&id=4" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid lightsteelblue;background:white;color:darkslategray;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>View</a>
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=edit&id=4" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid darkorange;background:darkorange;color:white;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>Edit</a>
                            <a href="<%= request.getContextPath() %>/admin/workers?action=deactivate&id=4" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid mistyrose;background:lavenderblush;color:firebrick;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>Deactivate</a>
                        </div>
                    </div>
                </div>

                <%-- Dipesh Shrestha — On Leave --%>
                <div data-status="on leave" data-name="dipesh shrestha" data-role="carpenter" data-project="sunrise school block a"
                     style="background:white;border:1px solid gainsboro;border-left:4px solid darkorange;border-radius:14px;padding:16px 20px;display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;">
                    <div style="display:flex;align-items:center;gap:14px;flex:1;min-width:220px;">
                        <div style="width:44px;height:44px;border-radius:50%;background:lightyellow;color:saddlebrown;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;flex-shrink:0;">DS</div>
                        <div>
                            <p style="font-weight:700;font-size:15px;color:darkslategray;margin:0;">Dipesh Shrestha</p>
                            <div style="display:flex;align-items:center;gap:8px;margin-top:4px;flex-wrap:wrap;">
                                <span style="background:ghostwhite;color:slategray;border-radius:6px;padding:2px 8px;font-size:12px;">Carpenter</span>
                                <span style="display:inline-flex;align-items:center;gap:4px;color:slategray;font-size:12px;"><svg style="width:12px;height:12px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h4l2 2h8a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/></svg>Sunrise School Block A</span>
                            </div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:20px;flex-wrap:wrap;">
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Projects</p><p style="font-size:16px;font-weight:700;color:darkslategray;margin:2px 0 0;">2</p></div>
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Attendance</p><p style="font-size:16px;font-weight:700;color:darkgoldenrod;margin:2px 0 0;">74%</p></div>
                        <span style="background:lightyellow;color:saddlebrown;border:1px solid gold;border-radius:9999px;padding:3px 11px;font-size:12px;font-weight:700;">On Leave</span>
                        <div style="display:flex;gap:6px;">
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=view&id=5" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid lightsteelblue;background:white;color:darkslategray;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>View</a>
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=edit&id=5" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid darkorange;background:darkorange;color:white;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/></svg>Edit</a>
                            <a href="<%= request.getContextPath() %>/admin/workers?action=reapprove&id=5" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid gold;background:lightyellow;color:saddlebrown;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>Re-approve</a>
                        </div>
                    </div>
                </div>

                <%-- Anil Gurung — Deactivated --%>
                <div data-status="deactivated" data-name="anil gurung" data-role="welder" data-project="industrial warehouse expansion"
                     style="background:white;border:1px solid gainsboro;border-left:4px solid darkorange;border-radius:14px;padding:16px 20px;display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;opacity:0.7;">
                    <div style="display:flex;align-items:center;gap:14px;flex:1;min-width:220px;">
                        <div style="width:44px;height:44px;border-radius:50%;background:ghostwhite;color:slategray;display:flex;align-items:center;justify-content:center;font-size:15px;font-weight:700;flex-shrink:0;">AG</div>
                        <div>
                            <p style="font-weight:700;font-size:15px;color:darkgray;margin:0;">Anil Gurung</p>
                            <div style="display:flex;align-items:center;gap:8px;margin-top:4px;flex-wrap:wrap;">
                                <span style="background:ghostwhite;color:darkgray;border-radius:6px;padding:2px 8px;font-size:12px;">Welder</span>
                                <span style="display:inline-flex;align-items:center;gap:4px;color:darkgray;font-size:12px;"><svg style="width:12px;height:12px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 7a2 2 0 012-2h4l2 2h8a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V7z"/></svg>Industrial Warehouse Expansion</span>
                            </div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:20px;flex-wrap:wrap;">
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Projects</p><p style="font-size:16px;font-weight:700;color:darkgray;margin:2px 0 0;">1</p></div>
                        <div style="text-align:center;"><p style="font-size:11px;color:darkgray;font-weight:600;text-transform:uppercase;letter-spacing:.04em;margin:0;">Attendance</p><p style="font-size:16px;font-weight:700;color:darkgray;margin:2px 0 0;">61%</p></div>
                        <span style="background:ghostwhite;color:slategray;border:1px solid lightsteelblue;border-radius:9999px;padding:3px 11px;font-size:12px;font-weight:700;">Deactivated</span>
                        <div style="display:flex;gap:6px;">
                            <a href="<%= request.getContextPath() %>/admin/workers/form?mode=view&id=6" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid lightsteelblue;background:white;color:darkslategray;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/><path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/></svg>View</a>
                            <a href="<%= request.getContextPath() %>/admin/workers?action=reactivate&id=6" style="display:inline-flex;align-items:center;gap:5px;padding:6px 14px;border-radius:8px;font-size:12px;font-weight:600;border:1px solid palegreen;background:honeydew;color:forestgreen;text-decoration:none;"><svg style="width:13px;height:13px;" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>Reactivate</a>
                        </div>
                    </div>
                </div>

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