package com.buildtrack.controller.client;

import com.buildtrack.model.User;
import com.buildtrack.service.client.ClientService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.Map;

/**
 * Client dashboard controller.
 */
@WebServlet("/client/dashboard")
public class ClientDashboardController extends HttpServlet {

  private final ClientService clientService = new ClientService();

    /**
     * Renders the client dashboard view.
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    Integer userIdObj = (Integer) session.getAttribute("userId");
    if (userIdObj == null) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    int userId = userIdObj;
    User client = clientService.getClientById(userId);
    Map<String, Object> summary = clientService.getDashboardSummary(userId);

    request.setAttribute("client", client);
    request.setAttribute("dashboardSummary", summary);
    request.setAttribute("currentDateLabel",
        LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy", Locale.ENGLISH)));

        request.getRequestDispatcher("/WEB-INF/views/client/dashboard.jsp")
                .forward(request, response);
    }
}
