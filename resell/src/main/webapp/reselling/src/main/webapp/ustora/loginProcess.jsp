<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Processing</title>
</head>
<body>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/reselling";
    String username = "root";
    String password = "";

    // Form data
    String inputUsername = request.getParameter("username");
    String inputPassword = request.getParameter("password");

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish a database connection
        Connection conn = DriverManager.getConnection(url, username, password);

        // SQL query to check if the user exists and the password matches
        String sql = "SELECT * FROM user WHERE uid = ? AND password = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(sql);
        preparedStatement.setString(1, inputUsername);
        preparedStatement.setString(2, inputPassword);
        
        // Execute the query
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // User exists and password matches
            out.println("<h1>Login successful!</h1>");
            response.sendRedirect("index.html");
        } else {
            // User not found or password doesn't match
            out.println("<h1>Login failed. Invalid username or password.</h1>");
            response.sendRedirect("login3.html");
            
        }

        // Close the database connection
        conn.close();
    } catch (Exception e) {
        out.println("<h1>Login failed. Error: " + e.getMessage() + "</h1>");
    }
%>
</body>
</html>
