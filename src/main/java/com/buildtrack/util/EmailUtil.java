package com.buildtrack.util;



import java.io.InputStream;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {
    private static String SMTP_HOST;
    private static String SMTP_PORT;
    private static String SMTP_USERNAME;
    private static String SMTP_PASSWORD;
    private static String SMTP_FROM;

    private static boolean initialized = false;

    private static synchronized void init(){
        if(initialized) return;
        try(InputStream is = EmailUtil.class.getClassLoader().getResourceAsStream("application.properties")){
            if(is==null){
                System.err.println("[EmailUtil] application.properties not found.");
                initialized = true;
                return;
            }
            Properties props = new Properties();
            props.load(is);
            SMTP_HOST = props.getProperty("smtp.host");
            SMTP_PORT = props.getProperty("smtp.port");
            SMTP_USERNAME = props.getProperty("smtp.username");
            SMTP_PASSWORD = props.getProperty("smtp.password");
            SMTP_FROM = props.getProperty("smtp.from");
        } catch (Exception e) {
            System.err.println("[EmailUtil] Error loading SMTP config:" + e.getMessage());
        }
        initialized = true;
    }
    /**
     * Sends a password reset email to the given address.
     *
     * @param toEmail    the recipient's email address
     * @param resetLink  the full URL with the reset token
     * @return true if the email was sent successfully, false otherwise
     */
    public static boolean sendPasswordResetEmail(String toEmail, String resetLink){
        init();
        if(SMTP_HOST == null || SMTP_USERNAME == null){
            System.err.println("[EmailUtil] SMTP is not configured.");
            return false;
        }
        try {
            // Configure SMTP properties
            Properties mailProps = new Properties();
            mailProps.put("mail.smtp.auth", "true");
            mailProps.put("mail.smtp.starttls.enable", "true");
            mailProps.put("mail.smtp.host", SMTP_HOST);
            mailProps.put("mail.smtp.port", SMTP_PORT);
            mailProps.put("mail.smtp.ssl.trust", SMTP_HOST);

            // Create session with authentication
            Session session = Session.getInstance(mailProps, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
                }
            });
            // Build the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SMTP_FROM));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));
            message.setSubject("BuildTrack — Password Reset Request");

            String htmlContent = buildResetEmailHtml(resetLink);
            message.setContent(htmlContent, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("[EmailUtil] Password reset email sent to: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("[EmailUtil] Failed to send email: " + e.getMessage());
            return false;
        }
    }
    /**
     * Builds the HTML content for the password reset email.
     */
    private static String buildResetEmailHtml(String resetLink) {
        return "<!DOCTYPE html>"
                + "<html><head><meta charset='UTF-8'></head><body style='font-family:Arial,sans-serif;"
                + "background:#f5f5f5;padding:40px 20px;'>"
                + "<div style='max-width:600px;margin:0 auto;background:#ffffff;border-radius:12px;"
                + "overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.1);'>"
                // Header
                + "<div style='background:#d97706;padding:30px;text-align:center;'>"
                + "<h1 style='color:#ffffff;margin:0;font-size:28px;'>BuildTrack</h1>"
                + "<p style='color:#fef3c7;margin:8px 0 0;font-size:14px;'>Construction Management System</p>"
                + "</div>"
                // Body
                + "<div style='padding:30px;'>"
                + "<h2 style='color:#1f2937;margin-top:0;'>Password Reset Request</h2>"
                + "<p style='color:#4b5563;line-height:1.6;'>"
                + "We received a request to reset your password. Click the button below to proceed."
                + " This link will expire in 30 minutes.</p>"
                + "<div style='text-align:center;margin:30px 0;'>"
                + "<a href='" + resetLink + "' style='display:inline-block;background:#d97706;"
                + "color:#ffffff;padding:14px 32px;border-radius:8px;text-decoration:none;"
                + "font-weight:600;font-size:16px;'>Reset Password</a>"
                + "</div>"
                + "<p style='color:#6b7280;font-size:13px;'>"
                + "If you did not request a password reset, you can safely ignore this email."
                + " Your password will remain unchanged.</p>"
                + "<p style='color:#9ca3af;font-size:12px;margin-top:20px;'>"
                + "If the button doesn't work, copy and paste this link into your browser:<br/>"
                + "<a href='" + resetLink + "' style='color:#d97706;word-break:break-all;'>"
                + resetLink + "</a></p>"
                + "</div>"
                // Footer
                + "<div style='background:#f9fafb;padding:20px 30px;text-align:center;"
                + "border-top:1px solid #e5e7eb;'>"
                + "<p style='color:#9ca3af;font-size:12px;margin:0;'>"
                + "&copy; 2026 BuildTrack. All rights reserved.</p>"
                + "</div>"
                + "</div></body></html>";
    }
}
