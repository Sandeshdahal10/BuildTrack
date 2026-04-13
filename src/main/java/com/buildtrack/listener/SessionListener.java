package com.buildtrack.listener;

import com.buildtrack.model.User;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Session lifecycle listener.
 * Tracks active sessions and logs session creation/destruction events.
 * Useful for monitoring and debugging user activity.
 */
@WebListener
public class SessionListener implements HttpSessionListener {

    /** Thread-safe counter for active sessions. */
    private static final AtomicInteger activeSessions = new AtomicInteger(0);

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int count = activeSessions.incrementAndGet();
        HttpSession session = se.getSession();
        System.out.println("[Session] Created: " + session.getId()
                + " | Total active sessions: " + count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();

        // Log who logged out (if user was in session)
        Object userObj = session.getAttribute("user");
        if (userObj instanceof User) {
            User user = (User) userObj;
            System.out.println("[Session] Destroyed for user: "
                    + user.getEmail() + " (" + user.getRole() + ")");
        } else {
            System.out.println("[Session] Destroyed (no user): " + session.getId());
        }

        int count = activeSessions.decrementAndGet();
        System.out.println("[Session] Total active sessions: " + count);
    }

    /**
     * Returns the current number of active sessions.
     * Can be used in admin dashboard for monitoring.
     */
    public static int getActiveSessionCount() {
        return activeSessions.get();
    }
}