<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Properties, javax.mail.Session, javax.mail.Transport, javax.mail.internet.InternetAddress, javax.mail.internet.MimeMessage, java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Email Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }

        h1 {
            text-align: center;
            color: #007BFF;
        }

        p {
            text-align: center;
        }
    </style>
</head>
<body>
<%
    // Database connection parameters
    String jdbcUrl = "jdbc:mysql://localhost:3306/reselling";
    String dbUser = "root";
    String dbPassword = "";

    // Fetch the last entered details from the database
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Establish a database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Query to fetch the last entered details
        String selectQuery = "SELECT product_id, full_name, address, city, zipcode, email, payment_method FROM CheckoutData ORDER BY checkout_id DESC LIMIT 1";
        preparedStatement = connection.prepareStatement(selectQuery);
        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // Retrieve the details from the database
            String fullname = resultSet.getString("full_name");
            String product_id = resultSet.getString("product_id");
            String address = resultSet.getString("address");
            String city = resultSet.getString("city");
            String zipcode = resultSet.getString("zipcode");
            String email = resultSet.getString("email");
            String paymentMethod = resultSet.getString("payment_method");

            // SMTP server settings
            final String smtpHost = "smtp.gmail.com";
            final String smtpPort = "587"; // SMTP port (usually 587 for TLS)
            final String smtpUsername = "tejasjavali02@gmail.com";
            final String smtpPassword = "jina ysgm hztm njzl";

            // Setup properties for the SMTP session
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", smtpHost);
            props.put("mail.smtp.port", smtpPort);

            // Create a Session object with authentication
            Session sesion = Session.getInstance(props, new javax.mail.Authenticator() {
                protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                    return new javax.mail.PasswordAuthentication(smtpUsername, smtpPassword);
                }
            });

            // Create a MimeMessage object
            MimeMessage message = new MimeMessage(sesion);

            // Set sender and recipient addresses
            message.setFrom(new InternetAddress(smtpUsername));
            message.setRecipients(javax.mail.Message.RecipientType.TO, InternetAddress.parse(email));

            // Email content
            message.setSubject("Order Confirmation");
            String emailContent = "Thank you for your purchase!\n\n"
                    + "Order Details:\n"
                    + "Product id: " + product_id + "\n"
                    + "Full Name: " + fullname + "\n"
                    + "Address: " + address + "\n"
                    + "City: " + city + "\n"
                    + "Zipcode: " + zipcode + "\n"
                    + "Payment Method: " + paymentMethod + "\n";
            message.setText(emailContent);

            // Send the email
            Transport.send(message);

            out.println("<div class=\"container\">");
            out.println("<h1>Email confirmation sent successfully!</h1>");
            out.println("<p><a href=\"index.html\">Go back to Home</a></p>");
            out.println("</div>");
        } else {
            out.println("<div class=\"container\">");
            out.println("<h1>No data found in the database.</h1>");
            out.println("<p><a href=\"index.html\">Go back to Home</a></p>");
            out.println("</div>");
        }
    } catch (Exception e) {
        out.println("<div class=\"container\">");
        out.println("<h1>Error sending email confirmation: " + e.getMessage() + "</h1>");
        out.println("<p><a href=\"index.html\">Go back to Home</a></p>");
        out.println("</div>");
        e.printStackTrace();
    } finally {
        // Close the database resources
        if (resultSet != null) resultSet.close();
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
%>
</body>
</html>
