package com.buildtrack.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.buildtrack.dao.client.ClientDao;

import java.math.BigDecimal;

import java.io.IOException;

@WebServlet("/client/budget")
public class BudgetController extends HttpServlet {

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
		ClientDao dao = new ClientDao();
		BigDecimal totalBudget = dao.totalBudgetForClient(userId);
		request.setAttribute("totalBudget", totalBudget);

		request.getRequestDispatcher("/WEB-INF/views/client/budget.jsp")
				.forward(request, response);
	}
}
