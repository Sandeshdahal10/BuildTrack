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

/**
 * Client budget dashboard controller.
 */
@WebServlet("/client/budget")
public class BudgetController extends HttpServlet {

	private final ClientService clientService = new ClientService();

	/**
	 * Renders the budget summary for the logged-in client.
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
		request.setAttribute("client", client);
		request.setAttribute("displayName",
				client != null && client.getFullName() != null && !client.getFullName().trim().isEmpty()
						? client.getFullName().trim()
						: "Client");
		java.util.Map<String, Object> budgetOverview = clientService.getBudgetOverview(userId);
		request.setAttribute("budgetOverview", budgetOverview);
		request.setAttribute("budgetSummary", budgetOverview);

		request.getRequestDispatcher("/WEB-INF/views/client/budget.jsp")
				.forward(request, response);
	}
}
