package com.buildtrack.controller.admin;

import java.io.IOException;
import java.util.List;

import com.buildtrack.model.Material;
import com.buildtrack.model.MaterialUsage;
import com.buildtrack.service.admin.MaterialService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Material management — CRUD for materials + logging material usage per
 * project.
 * Usage logging is TRANSACTIONAL (inserts usage record AND deducts stock).
 *
 * GET /admin/materials → list all materials
 * GET /admin/materials?action=new → new material form
 * GET /admin/materials?action=edit&id=X → edit material form
 * GET /admin/materials?action=usage&pid=X → view usage for a project
 * POST /admin/materials?action=create → create material
 * POST /admin/materials?action=update → update material
 * POST /admin/materials?action=delete&id=X → delete material
 * POST /admin/materials?action=log-usage → log material usage for a project
 */
@WebServlet("/admin/materials")
public class MaterialController extends HttpServlet {

    private final MaterialService materialService = new MaterialService();

    // ==================== GET ====================

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String normalizedAction = action == null ? null : action.trim().toLowerCase();

        if (normalizedAction == null || normalizedAction.isBlank()) {
            // ---------- List all materials ----------
            List<Material> materials = materialService.getAllMaterials();
            request.setAttribute("materials", materials);
            request.setAttribute("materialStats", materialService.getMaterialStats());
            request.setAttribute("lowStockCount", materialService.getLowStockMaterials().size());
            request.setAttribute("totalStockValue", materialService.getTotalStockValue());
            request.setAttribute("usedThisMonth", materialService.getUsedCostThisMonth());
            request.setAttribute("monthLabel", materialService.getCurrentMonthLabel());
            request.setAttribute("recentUsage", materialService.getRecentUsage(6));
            request.getRequestDispatcher("/WEB-INF/views/admin/materials.jsp")
                    .forward(request, response);
            return;
        }

        switch (normalizedAction) {

            // ---------- New material form ----------
            case "new" -> {
                request.getRequestDispatcher("/WEB-INF/views/form/materialForm.jsp")
                        .forward(request, response);
            }

            // ---------- Edit material form ----------
            case "edit" -> {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isBlank()) {
                    try {
                        int id = Integer.parseInt(idParam);
                        Material m = materialService.getMaterialById(id);
                        if (m != null) {
                            request.setAttribute("material", m);
                        }
                    } catch (NumberFormatException ignored) {
                        // Fallback to empty form when id is invalid.
                    }
                }
                request.getRequestDispatcher("/WEB-INF/views/form/materialForm.jsp")
                        .forward(request, response);
            }

            // ---------- View usage for a project ----------
            case "usage" -> {
                int projectId = Integer.parseInt(request.getParameter("pid"));
                List<MaterialUsage> usageList = materialService.getUsageByProject(projectId);
                List<MaterialUsage> summary = materialService.getUsageSummaryByProject(projectId);
                request.setAttribute("usageList", usageList);
                request.setAttribute("usageSummary", summary);
                request.setAttribute("totalCost", materialService.getTotalCostByProject(projectId));
                request.setAttribute("projectId", projectId);
                // Also pass all materials for the "log usage" dropdown
                request.setAttribute("materials", materialService.getAllMaterials());
                request.setAttribute("materialStats", materialService.getMaterialStats());
                request.setAttribute("lowStockCount", materialService.getLowStockMaterials().size());
                request.setAttribute("totalStockValue", materialService.getTotalStockValue());
                request.setAttribute("usedThisMonth", materialService.getUsedCostThisMonth());
                request.setAttribute("monthLabel", materialService.getCurrentMonthLabel());
                request.getRequestDispatcher("/WEB-INF/views/admin/materials.jsp")
                        .forward(request, response);
            }

            // ---------- Log usage form ----------
            case "log-form", "logform", "log_usage", "logusage" -> {
                request.setAttribute("materials", materialService.getAllMaterials());
                request.getRequestDispatcher("/WEB-INF/views/form/logUsageForm.jsp")
                        .forward(request, response);
            }

            default ->
                response.sendRedirect(request.getContextPath() + "/admin/materials");
        }
    }

    // ==================== POST ====================

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/materials");
            return;
        }

        switch (action) {

            // ---------- Create material ----------
            case "create" -> {
                List<String> errors = materialService.createMaterial(
                        request.getParameter("name"),
                        request.getParameter("unit"),
                        request.getParameter("unitPrice"),
                        request.getParameter("totalStock"),
                        request.getParameter("lowStockThreshold"),
                        request.getParameter("description"));
                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    preserveMaterialForm(request);
                    request.getRequestDispatcher("/WEB-INF/views/form/materialForm.jsp")
                            .forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/materials?created=true");
                }
            }

            // ---------- Update material ----------
            case "update" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                List<String> errors = materialService.updateMaterial(
                        id,
                        request.getParameter("name"),
                        request.getParameter("unit"),
                        request.getParameter("unitPrice"),
                        request.getParameter("totalStock"),
                        request.getParameter("lowStockThreshold"),
                        request.getParameter("description"));
                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    request.setAttribute("id", String.valueOf(id));
                    preserveMaterialForm(request);
                    request.getRequestDispatcher("/WEB-INF/views/form/materialForm.jsp")
                            .forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath()
                            + "/admin/materials?updated=true");
                }
            }

            // ---------- Delete material ----------
            case "delete" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                List<String> errors = materialService.deleteMaterial(id);
                if (!errors.isEmpty()) {
                    request.getSession().setAttribute("errors", errors);
                } else {
                    request.getSession().setAttribute("success",
                            "Material deleted successfully.");
                }
                response.sendRedirect(request.getContextPath() + "/admin/materials");
            }

            // ---------- Log material usage (transactional) ----------
            case "log-usage" -> {
                int adminId = (int) request.getSession().getAttribute("userId");

                String projectIdParam = request.getParameter("projectId");
                List<String> errors = materialService.logUsage(
                        Integer.parseInt(request.getParameter("materialId")),
                        Integer.parseInt(projectIdParam),
                        request.getParameter("quantity"),
                        request.getParameter("usageDate"),
                        adminId,
                        request.getParameter("notes"));

                if (!errors.isEmpty()) {
                    request.setAttribute("errors", errors);
                    request.setAttribute("projectId", projectIdParam);
                    request.setAttribute("materialId", request.getParameter("materialId"));
                    request.setAttribute("quantity", request.getParameter("quantity"));
                    request.setAttribute("usageDate", request.getParameter("usageDate"));
                    request.setAttribute("notes", request.getParameter("notes"));
                    request.setAttribute("materials", materialService.getAllMaterials());
                    request.getRequestDispatcher("/WEB-INF/views/form/logUsageForm.jsp")
                            .forward(request, response);
                } else {
                    request.getSession().setAttribute("success",
                            "Material usage logged successfully. Stock has been deducted.");
                    // Redirect back to the usage view for this project
                    int projectId = Integer.parseInt(projectIdParam);
                    response.sendRedirect(request.getContextPath()
                            + "/admin/materials?action=usage&pid=" + projectId);
                }
            }

            default ->
                response.sendRedirect(request.getContextPath() + "/admin/materials");
        }
    }

    // ==================== Helper ====================

    private void preserveMaterialForm(HttpServletRequest request) {
        request.setAttribute("name", request.getParameter("name"));
        request.setAttribute("unit", request.getParameter("unit"));
        request.setAttribute("unitPrice", request.getParameter("unitPrice"));
        request.setAttribute("totalStock", request.getParameter("totalStock"));
        request.setAttribute("lowStockThreshold", request.getParameter("lowStockThreshold"));
        request.setAttribute("description", request.getParameter("description"));
    }
}