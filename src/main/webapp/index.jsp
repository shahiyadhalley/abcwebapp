<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Restaurant - Home</title>
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
            <img src="<%= request.getContextPath() %>/assets/images/hero.png" alt="Logo" class="hero-img">
            <div class="hero-text">Elevating Dining Experiences with Seamless Digital Connections.</div>

            <div class="features">
                <a href="<%= request.getContextPath() %>/services.jsp" class="feature">
                    <div class="feature-icon"><img src="<%= request.getContextPath() %>/assets/icons/service.png" alt="Logo"></div>
                    <h3>Our Services</h3>
                    <p>Explore our wide range of services including dine-in, delivery, and catering.</p>
                </a>
                <a href="<%= request.getContextPath() %>/menu.jsp" class="feature">
                    <div class="feature-icon"><img src="<%= request.getContextPath() %>/assets/icons/menu.png" alt="Logo"></div>
                    <h3>Menu</h3>
                    <p>Discover our diverse menu featuring a variety of delicious dishes and beverages.</p>
                </a>                
                <a href="<%= request.getContextPath() %>/gallery.jsp" class="feature">
                    <div class="feature-icon"><img src="<%= request.getContextPath() %>/assets/icons/gallery.png" alt="Logo"></div>
                    <h3>Gallery</h3>
                    <p>View our gallery to see the ambiance and dishes we offer.</p>
                </a>
            </div>
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
