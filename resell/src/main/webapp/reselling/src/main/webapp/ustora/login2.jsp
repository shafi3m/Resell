<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
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

        .message {
            text-align: center;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 3px.
        }

        h2 {
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .text-center {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Display the success message here -->
        <div class="message">
            Successfully registered!<br><br>
            Your User-ID is:  <%= getLatestUidFromDatabase() %>
            
            
        </div>

        <h2>Login</h2>
        <form action="index.html" method="POST">
            <label for="username">User ID</label>
            <input type="text" id="username" name="username" value="<%= getLatestUidFromDatabase() %>" readonly>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <input type="submit" value="Login">
        </form>

        <p class="text-center">
            Don't have an account? <a href="signup.html">Sign up</a>
        </p>
    </div>

    <%!
    // Define a method to retrieve the latest User ID from the database
    private String getLatestUidFromDatabase() {
        try {
            // Connect to the database and retrieve the latest User ID
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/reselling", "root", "");
            
            // Use the SQL query to fetch the latest User ID
            PreparedStatement statement = connection.prepareStatement("SELECT uid FROM user ORDER BY uid DESC LIMIT 1");
            
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return resultSet.getString("uid");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Return a default value if User ID couldn't be retrieved
        return "DefaultUserID";
    }
    %>
</body>
</html>
