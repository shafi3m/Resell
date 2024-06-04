<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Properties, javax.mail.*, javax.mail.internet.*, javax.activation.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
</head>
<body>
    <%
    // Get the form data for sending the confirmation email
    String emailTo = request.getParameter("email"); // The customer's email
    String subject = "Order Confirmation"; // Email subject
    String productID = request.getParameter("product_id");
    String fullName = request.getParameter("fullname");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String zipCode = request.getParameter("zipcode");
    String paymentMethod = request.getParameter("paymentMethod");

    // Create the email message content
    String message = "Thank you for your order!\n\nHere are your checkout details:\n\n" +
        "Product ID: " + productID + "\n" +
        "Full Name: " + fullName + "\n" +
        "Address: " + address + "\n" +
        "City: " + city + "\n" +
        "Zip Code: " + zipCode + "\n" +
        "Payment Method: " + paymentMethod;

    // Configure SMTP properties
    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "465"); // Port for SMTP
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

    try {
        // Create a Session with your SMTP server credentials
        Session sesion = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("tejasjavali02@gmail.com", "jina ysgm hztm njzl");
            }
        });

        // Create a message
        Message emailMessage = new MimeMessage(sesion);
        emailMessage.setFrom(new InternetAddress("tejasjavali02@gmail.com"));
        emailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailTo));
        emailMessage.setSubject(subject);
        emailMessage.setText(message);

        // Send the email
        Transport.send(emailMessage);

        // Display a success message
        %>
        <h1>Order Confirmation</h1>
        <div>
            <p>Confirmation email sent successfully!</p>
            <p>Click <a href="index.html">here</a> to go back to the Home page.</p>
        </div>
        <%
    } catch (Exception e) {
        // Log the error and display an error message
        e.printStackTrace();
        %>
        <h1>Error</h1>
        <div>
            <p>There was an error sending the confirmation email. Please try again later.</p>
            <p>Click <a href="index.html">here</a> to go back to the Home page.</p>
        </div>
        <%
    }
    %>
</body>
</html>
