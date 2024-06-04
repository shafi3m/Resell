<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Reviews</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
            padding: 0;
        }

        .container {
            max-width: 800px;
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

        .review {
            border: 1px solid #ccc;
            padding: 20px;
            margin: 20px 0;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        .review p {
            margin: 0;
        }

        .review .timestamp {
            font-size: 12px;
            color: #777;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Product Reviews</h1>

        <!-- Review Submission Form -->
        <form action="reviews2.jsp" method="post">
            <label for="username">Your Name:</label>
            <input type="text" id="username" name="username" required><br><br>
            <label for="reviewText">Your Review:</label>
            <textarea id="reviewText" name="reviewText" rows="4" required></textarea><br><br>
            <input type="submit" value="Submit Review">
        </form>

        <hr>

        <!-- Display Existing Reviews -->
        <h2>Existing Reviews:</h2>
        <%
            // Database connection parameters
            String jdbcUrl = "jdbc:mysql://localhost:3306/reselling";
            String dbUser = "root";
            String dbPassword = "";

            // Establish a database connection
            Connection connection = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                statement = connection.createStatement();

                // SQL query to retrieve existing reviews
                String selectQuery = "SELECT * FROM reviews ORDER BY timestamp DESC";
                resultSet = statement.executeQuery(selectQuery);

                while (resultSet.next()) {
                    String username = resultSet.getString("username");
                    String reviewText = resultSet.getString("review_text");
                    Timestamp timestamp = resultSet.getTimestamp("timestamp");
                    
                    // Format the timestamp using SimpleDateFormat
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String formattedTimestamp = dateFormat.format(timestamp);

                    // Display each review
        %>
                    <div class="review">
                        <p><strong><%= username %></strong></p>
                        <p><%= reviewText %></p>
                        <p class="timestamp"><%= formattedTimestamp %></p>
                    </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            }
        %>
    </div>
</body>
</html>
