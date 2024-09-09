<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Query</title>
    <link rel="stylesheet" href="./css/contact.css">
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>
    <!-- Header Section -->
    <header>
        <div class="container">
            <%@ include file="navbar.jsp" %>
        </div>
    </header>

    <!-- Main Content Section -->
    <main>
        <div class="container">
            <form action="QueryServlet" method="post" class="query-form">
                <h2>SUBMIT YOUR QUERY</h2>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                
                <label for="query">Query:</label>
                <textarea id="query" name="query" rows="5" required></textarea>
                
                <button type="submit">Submit</button>
            </form>
            
            <!-- Contact Details Section -->
            <section class="contact-details">
                <h2>Contact Us</h2>
                <p><strong>Phone:</strong> +123 456 7890</p>
                <p><strong>Email:</strong> contact@abcrestaurant.com</p>
                <p><strong>Address:</strong> 123 Gourmet Street, Food City, FC 12345</p>
                <p><strong>Follow Us</strong></p>
                <ul class="social-media">
                    <li><a href="https://facebook.com/abcrestaurant" target="_blank">Facebook</a></li>
                    <li><a href="https://twitter.com/abcrestaurant" target="_blank">Twitter</a></li>
                    <li><a href="https://instagram.com/abcrestaurant" target="_blank">Instagram</a></li>
                </ul>
            </section>
        </div>
    </main>

    <!-- Footer Section -->
    <footer>
        <div class="container">
            <p>&copy; 2024 ABC Restaurant. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
