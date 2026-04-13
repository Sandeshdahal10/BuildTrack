package com.buildtrack.controller.auth;

import com.buildtrack.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles user logout.
 * Invalidates the session and redirects to the login page.
 */
@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            // Log who is logging out
            Object userObj = session.getAttribute("user");
            if (userObj instanceof User) {
                User user = (User) userObj;
                System.out.println("[Logout] User logging out: "
                        + user.getEmail() + " (" + user.getRole() + ")");
            }

            // Invalidate the session (removes all attributes)
            session.invalidate();
        }

        // Redirect to login with a success message using a query parameter
        response.sendRedirect(request.getContextPath()
                + "/login?logout=true");
    }
}