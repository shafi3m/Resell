<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            background-color: #3f51b5;
            color: white;
            padding: 20px;
            margin: 0;
        }

        .checkout-container {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        .checkout-header {
            background-color: #3f51b5;
            color: white;
            padding: 20px;
        }

        .checkout-content {
            padding: 20px;
        }

        .product-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .product-details img {
            max-width: 150px;
            max-height: 150px;
            border: 1px solid #ccc;
            padding: 5px;
            border-radius: 4px;
        }

        .product-info {
            flex: 1;
            margin-left: 20px;
        }

        .product-info p {
            margin: 0;
        }

        .billing-address {
            padding: 20px;
        }

        .form-label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .form-field {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        .place-order-button {
            text-align: center;
            margin-top: 20px;
        }

        .place-order-button button {
            padding: 12px 24px;
            background-color: #3f51b5;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .place-order-button button:hover {
            background-color: #303f9f;
        }

        .payment-method {
            padding: 20px;
        }

        .payment-method select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h1>Checkout</h1>
    <div class="checkout-container">
        <div class="checkout-header">
            <h2>Product Details</h2>
        </div>
        <div class="checkout-content">
            <%
            // Retrieve product details from the database based on the product_id
            String jdbcUrl = "jdbc:mysql://localhost:3306/reselling";
            String dbUser = "root";
            String dbPassword = "";
         //   int productId = -1; // Default value if the parameter is not found or invalid
            
            int productId_c = Integer.parseInt(request.getParameter("product_id"));
            
            
            
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                
                String sqlQuery = "SELECT product_id, name, price, image FROM products WHERE product_id = ?";
                preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setInt(1, productId_c);
                resultSet = preparedStatement.executeQuery();
                
                if (resultSet.next()) {
                    int productID = resultSet.getInt("product_id");
                    String productName = resultSet.getString("name");
                    int productPrice = resultSet.getInt("price");
                    Blob imageBlob = resultSet.getBlob("image");
                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                    String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                  
            %>
            <div class="product-details">
                <div>
                    <p><strong>Product ID:</strong> <%= productID %></p>
                </div>
                <img class="product-image" src="data:image/png;base64,<%= imageBase64 %>" alt="Product Image">
                <div class="product-info">
                    <p><strong>Product Name:</strong> <%= productName %></p>
                    <p><strong>Price:</strong> $<%= productPrice %>.00</p>
                </div>
            </div>
            <%
                } else {
            %>
            <p>No product found with the specified ID.</p>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error occurred while fetching product details: " + e.getMessage() + "</p>");
            } finally {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            }
            %>

            <div class="checkout-header">
                <h2>Billing Address</h2>
            </div>
            <div class="checkout-content">
                <!-- Billing address form goes here -->
                <form action="placeOrder.jsp" method="POST">
                
                <div>
    <label class="form-label" for="product_id">Product ID:</label>
    <input class="form-field" type="text" id="product_id" name="product_id" value="<%= productId_c  %>"readonly>
</div>

                    
                    
                    <div>
                        <label class="form-label" for="fullname">Full Name:</label>
                        <input class="form-field" type="text" id="fullname" name="fullname" required>
                    </div>
                    <div>
                        <label class="form-label" for="address">Address:</label>
                        <textarea class="form-field" id="address" name="address" rows="4" required></textarea>
                    </div>
                    <div>
                        <label class="form-label" for="city">City:</label>
                        <input class="form-field" type="text" id="city" name="city" required>
                    </div>
                    <div>
                        <label class="form-label" for="zipcode">Zip Code:</label>
                        <input class="form-field" type="text" id="zipcode" name="zipcode" required>
                    </div>
                    <div>
                        <label class="form-label" for="email">Email:</label>
                        <input class="form-field" type="email" id="email" name="email" required>
                    </div>
                    
                    <div class="checkout-header">
                        <h2>Payment Method</h2>
                    </div>
                    <div class="checkout-content">
                        <div class="payment-method">
                            <label for="paymentMethod">Select Payment Method:</label>
                            <select id="paymentMethod" name="paymentMethod" required>
                                <option value="creditCard">Credit Card</option>
                                <option value="paypal">PayPal</option>
                                <option value="bankTransfer">Bank Transfer</option>
                                <option value="Cash On Delivery">Cash On Delivery</option>
                            </select>
                        </div>
        
                        <div class="place-order-button">
                            <button type="submit">Place Order</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
