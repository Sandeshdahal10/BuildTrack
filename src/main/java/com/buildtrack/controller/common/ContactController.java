package com.buildtrack.controller.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Public Contact page.
 *
 * GET  /contact -> renders contact form
 * POST /contact -> basic server-side validation and shows success message
 */
@WebServlet("/contact")
public class ContactController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/common/contact.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = trim(request.getParameter("name"));
        String contact = trim(request.getParameter("contact"));
        String email = trim(request.getParameter("email"));
        String country = trim(request.getParameter("country"));

        boolean hasErrors = false;

        if (name == null || name.isEmpty()) {
            request.setAttribute("nameError", "Name is required.");
            hasErrors = true;
        }
        if (contact == null || contact.isEmpty()) {
            request.setAttribute("contactError", "Contact number is required.");
            hasErrors = true;
        }
        if (email == null || email.isEmpty()) {
            request.setAttribute("emailError", "Email is required.");
            hasErrors = true;
        }
        if (country == null || country.isEmpty()) {
            request.setAttribute("countryError", "Country is required.");
            hasErrors = true;
        }

        // Preserve entered values
        request.setAttribute("name", name);
        request.setAttribute("contact", contact);
        request.setAttribute("email", email);
        request.setAttribute("country", country);

        if (hasErrors) {
            request.getRequestDispatcher("/WEB-INF/views/common/contact.jsp")
                    .forward(request, response);
            return;
        }

        // In a real SaaS, you'd store to DB or send to a support inbox.
        request.setAttribute("successMessage", "Thanks — we’ve received your message. Our team will contact you shortly.");
        request.getRequestDispatcher("/WEB-INF/views/common/contact.jsp")
                .forward(request, response);
    }

    private String trim(String v) {
        return v == null ? null : v.trim();
    }
}

