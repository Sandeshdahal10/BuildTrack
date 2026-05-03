package com.buildtrack.listener;

import com.buildtrack.model.User;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
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

    /**
     * Invoked when a new session is created.
     *
     * @param se session event
     */
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int count = activeSessions.incrementAndGet();
        HttpSession session = se.getSession();
        System.out.println("[Session] Created: " + session.getId()
                + " | Total active sessions: " + count);
    }

    /**
     * Invoked when a session is destroyed.
     *
     * @param se session event
     */
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
     *
     * @return current active session count
     */
    public static int getActiveSessionCount() {
        return activeSessions.get();
    }
}