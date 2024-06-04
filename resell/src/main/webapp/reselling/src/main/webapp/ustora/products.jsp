<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*, java.sql.*" %>
<%
    FileInputStream fis = null;
    Connection connection = null;
    
    String category = request.getParameter("category");
    String name = request.getParameter("name");
    String yearsParam = request.getParameter("years");
    String priceParam = request.getParameter("price");
    String myloc = request.getParameter("image");
    String uidParam = request.getParameter("uid"); // Add this line

    int years = 0;
    int price = 0;
    int uid = 0; // Add this line

    // Check if yearsParam, priceParam, and uidParam are not null or empty
    if (yearsParam != null && !yearsParam.isEmpty()) {
        years = Integer.parseInt(yearsParam);
    }

    if (priceParam != null && !priceParam.isEmpty()) {
        price = Integer.parseInt(priceParam);
    }

    if (uidParam != null && !uidParam.isEmpty()) {
        uid = Integer.parseInt(uidParam);
    }

    try {
        // Database connection information
        String jdbcUrl = "jdbc:mysql://localhost:3306/reselling";
        String dbUser = "root";
        String dbPassword = "";

        // Establish the database connection
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        // Create a SQL statement
        String sql = "INSERT INTO products (uid, category, name, years, price, image) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, uid);
        preparedStatement.setString(2, category);
        preparedStatement.setString(3, name);
        preparedStatement.setInt(4, years);
        preparedStatement.setInt(5, price);
         // Set the "uid" parameter

        // Set the image as a binary stream
        File image = new File(myloc);
        fis = new FileInputStream(image);
        preparedStatement.setBinaryStream(6, fis, (int) image.length());

        // Debugging: Print SQL query
        //out.println("<p>SQL Query: " + sql + "</p>");

        // Execute the SQL statement
        int rowsAffected = preparedStatement.executeUpdate();

        // Check if the insert was successful
        if (rowsAffected > 0) {
            //out.println("<h2>Data has been successfully inserted!</h2>");
        } else {
            out.println("<h2>Failed to insert data.</h2>");
        }

        // Close the database resources
        preparedStatement.close();
    } catch (ClassNotFoundException e) {
        out.println("<h2>Error: MySQL JDBC driver not found.</h2>");
        e.printStackTrace();
    } catch (SQLException e) {
        out.println("<h2>Error: SQL Exception.</h2>");
        out.println("<p>SQL Error Message: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } catch (IOException e) {
        out.println("<h2>Error: File I/O Exception.</h2>");
        e.printStackTrace();
    } finally {
        // Close the database connection and file input stream
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (fis != null) {
            try {
                fis.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Data Inserted</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        h2 {
            color: #007BFF;
            font-size: 24px;
        }

        p {
            font-size: 18px;
            margin-top: 20px;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007BFF;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Data has been successfully inserted!</h2>
        <p>Your data has been successfully added to the database.</p>
        <a href='index.html'>Go to Home</a>
        <a href='AddProducts.html'>Add More Products</a>
    </div>
</body>
</html>
