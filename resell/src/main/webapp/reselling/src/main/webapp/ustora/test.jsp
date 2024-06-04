<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Properties, javax.mail.Session, javax.mail.Transport, javax.mail.internet.InternetAddress, javax.mail.internet.MimeMessage" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Send Email via SMTP</title>
</head>
<body>
    <h1>Send Email via SMTP</h1>
    
    <%
        // SMTP server settings (for Gmail)
        String host = "smtp.gmail.com";
        String port = "567"; // TLS port
        String username = "tejasjavali02@gmail.com";
        String password = "jina ysgm hztm njzl";

        // Sender and recipient email addresses
        String from = "tejasjavali02@gmail.com";
        String to = "tejasjavali02@gmail.com";

        
        
        // Email content
        String subject = "Test Email from JSP";
        String messageText = "This is a test email sent from a JSP file using SMTP.";

        try {
            // Setup properties for the SMTP session
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);
            

            // Create a Session object with authentication
            Session sesion = Session.getInstance(props, new javax.mail.Authenticator() {
                protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication("tejasjavali02@gmail.com", "jina ysgm hztm njzl");
                }
            });

            // Create a MimeMessage object
            MimeMessage message = new MimeMessage(sesion);

            // Set sender and recipient addresses
            message.setFrom(new InternetAddress(from));
            message.setRecipients(javax.mail.Message.RecipientType.TO, InternetAddress.parse(to));

            // Set email subject and text
            message.setSubject(subject);
            message.setText(messageText);

            // Send the email
            Transport.send(message);

            out.println("<p>Email sent successfully!</p>");
        } catch (Exception e) {
            out.println("<p>Error sending email: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>