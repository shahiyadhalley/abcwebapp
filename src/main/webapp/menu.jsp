<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.abcwebapp.DatabaseConnection" %>
<%@ page import="com.example.abcwebapp.Models.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Restaurant - Menu</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/menu.css">
</head>
<body>

    <!-- Header Section -->
    <header>
        <div class="container">
            <%@ include file="navbar.jsp" %>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container">
        <div class="menu-grid">
            <%
                List<Product> products = new ArrayList<Product>();
                Connection connection = null;
                PreparedStatement statement = null;
                ResultSet resultSet = null;

                try {
                    connection = DatabaseConnection.getConnection();
                    String query = "SELECT * FROM products";
                    statement = connection.prepareStatement(query);
                    resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        Product product = new Product();
                        product.setId(resultSet.getInt("id"));
                        product.setName(resultSet.getString("name"));
                        product.setDescription(resultSet.getString("description"));
                        product.setPrice(resultSet.getDouble("price"));
                        product.setImageUrl(resultSet.getString("image_url"));
                        products.add(product);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                if (!products.isEmpty()) {
                    for (Product product : products) {
            %>
                <div class="menu-item">
                    <img src="<%= request.getContextPath() %>/assets/<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
                    <div class="content">
                        <h3><%= product.getName() %></h3>
                        <p class="description"><%= product.getDescription() %></p>
                        <p class="price">$<%= product.getPrice() %></p>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <p>No products available.</p>
            <%
                }
            %>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <p>&copy; 2024 ABC Restaurant. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>
