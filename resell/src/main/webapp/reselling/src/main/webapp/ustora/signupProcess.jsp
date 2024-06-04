<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Signup Processing</title>
</head>
<body>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/reselling";
    String username = "root";
    String password = "";

    java.util.Date jdate = new java.util.Date();
    java.sql.Date mysqldate = new java.sql.Date(jdate.getTime());
    // Form data
   // String useridStr = request.getParameter("userid");
   // int userid = Integer.parseInt(useridStr); // Convert to int
    String name = request.getParameter("name");
    String createPassword = request.getParameter("createPassword");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a database connection
        Connection conn = DriverManager.getConnection(url, username, password);

        // SQL query to insert user registration data
        String sql = "INSERT INTO user ( name, mobile, email, password, date) VALUES ( ?, ?, ?, ?, ?)";

        // Create a prepared statement
        PreparedStatement preparedStatement = conn.prepareStatement(sql);

        // Set parameters
        
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, mobile);
        preparedStatement.setString(3, email);
        preparedStatement.setString(4, createPassword);
        preparedStatement.setDate(5, mysqldate);

        // Execute the query
        int rowsAffected = preparedStatement.executeUpdate();

        // Check if the data was inserted successfully
        if (rowsAffected > 0) {
            out.println("<h1>Registration successful!</h1>");

            // Redirect to the login page after a successful registration
            response.sendRedirect("login2.jsp");
        } else {
            out.println("<h1>Registration failed.</h1>");
        }

        // Close the database connection
        conn.close();
    } catch (Exception e) {
        out.println("<h1>Registration failed. Error: " + e.getMessage() + "</h1>");
    }
%>
</body>
</html>
