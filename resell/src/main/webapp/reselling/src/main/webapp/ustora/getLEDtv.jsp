<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            background-color: #3498db;
            color: white;
            padding: 20px;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        img {
            max-width: 100px;
            max-height: 100px;
        }

        .buy-now-button {
            text-align: center;
        }

        .buy-now-button a {
            display: inline-block;
            padding: 5px 10px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>Product Details</h1>
    
    <%
    // Set up a database connection (replace with your database details)
    String jdbcUrl = "jdbc:mysql://localhost:3306/reselling";
    String dbUser = "root";
    String dbPassword = "";
    
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        
        // SQL query to retrieve data
        String sqlQuery = "SELECT product_id, name, years, price, image FROM products";
        preparedStatement = connection.prepareStatement(sqlQuery);
        resultSet = preparedStatement.executeQuery();
        
        // Display data in HTML table
        out.println("<table border='1'>");
        out.println("<tr><th>Name</th><th>Years</th><th>Price</th><th>Image</th><th>Buy Now</th></tr>");
        
        while (resultSet.next()) {
            int productId = resultSet.getInt("product_id"); // Get the product ID from the database
            String name = resultSet.getString("name");
            int years = resultSet.getInt("years");
            int price = resultSet.getInt("price");
            // Retrieve the image as bytes from the database
            Blob imageBlob = resultSet.getBlob("image");
            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
            // Encode the image bytes as Base64 for inline display
            String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
            
            out.println("<tr>");
            out.println("<td>" + name + "</td>");
            out.println("<td>" + years + "</td>");
            out.println("<td>$" + price + "</td>");
            out.println("<td><img src='data:image/png;base64," + imageBase64 + "' width='100' height='100' /></td>");
            out.println("<td class='buy-now-button'><a href='checkout.jsp?product_id=" + productId + "'>Buy Now</a></td>");
            out.println("</tr>");
        }
        
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred while fetching data: " + e.getMessage() + "</p>");
    } finally {
        // Close database resources
        if (resultSet != null) resultSet.close();
        if (preparedStatement != null) preparedStatement.close();
        if (connection != null) connection.close();
    }
    %>
</body>
</html>
