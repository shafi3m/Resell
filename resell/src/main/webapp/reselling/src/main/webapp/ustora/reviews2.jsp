<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Review</title>
</head>
<body>
    <%
        // Database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/reselling";
        String dbUser = "root";
        String dbPassword = "";

        // Retrieve form data
        String username = request.getParameter("username");
        String reviewText = request.getParameter("reviewText");

        // Validate form data (you can add more validation as needed)
        if (username == null || username.isEmpty() || reviewText == null || reviewText.isEmpty()) {
    %>
            <h1>Invalid input. Please provide both your name and review text.</h1>
    <%
        } else {
            // Establish a database connection
            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // SQL query to insert the review into the database
                String insertQuery = "INSERT INTO reviews (username, review_text, timestamp) VALUES (?, ?, NOW())";
                preparedStatement = connection.prepareStatement(insertQuery);
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, reviewText);

                // Execute the SQL query to insert the review
                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                	response.sendRedirect("reviews.jsp");
    %>
                       
                   
    <%
                } else {
    %>
                    <h1>Failed to submit the review.</h1>
    <%
                }
            } catch (Exception e) {
                e.printStackTrace();
    %>
                <h1>Error submitting the review: <%= e.getMessage() %></h1>
    <%
            } finally {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            }
        }
    %>
</body>
</html>
