<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
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

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #007BFF;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Your Order Has Been Placed Successfully</h1>
        <p>Thank you for your purchase!</p>
        <p>Please wait for a moment while we send your order confirmation email to the provided email address.</p>
        <a href="index.html">Go back to Home</a>
    </div>
    
    <%
        // Retrieve other form parameters
        int pid = Integer.parseInt(request.getParameter("product_id"));
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String zipcode = request.getParameter("zipcode");
        String email = request.getParameter("email");
        String paymentMethod = request.getParameter("paymentMethod");
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            // Your database connection parameters
            String jdbcUrl = "jdbc:mysql://localhost:3306/reselling";
            String dbUser = "root";
            String dbPassword = "";
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            
            if (pid != -1) {
                // Now, insert data into the CheckoutData table with the fetched product_id
                String insertQuery = "INSERT INTO CheckoutData (product_id, full_name, address, city, zipcode, email, payment_method) VALUES (?, ?, ?, ?, ?, ?, ?)";
                preparedStatement = connection.prepareStatement(insertQuery);
                
                // Set the parameter values
                preparedStatement.setInt(1, pid);
                preparedStatement.setString(2, fullname);
                preparedStatement.setString(3, address);
                preparedStatement.setString(4, city);
                preparedStatement.setString(5, zipcode);
                preparedStatement.setString(6, email);
                preparedStatement.setString(7, paymentMethod);
                
                // Execute the SQL query to insert data
                int rowsAffected = preparedStatement.executeUpdate();
                
                if (rowsAffected > 0) {
                //	response.sendRedirect("OrderConfirm2.jsp");
    %>
    <script>
        // Redirect to the home page after displaying the success message
        setTimeout(function () {
            window.location.href = "OrderConfirm2.jsp";
        }, 1000); // Redirect after 1 seconds
    </script>
    <%
                }
            } else {
    %>
    <p>Product not found.</p>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error occurred while inserting data: " + e.getMessage() + "</p>");
        } finally {
            if (preparedStatement != null) preparedStatement.close();
            if (connection != null) connection.close();
        }
    %>
</body>
</html>
