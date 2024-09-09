<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Restaurant - Services</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/services.css">
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
        <section class="service-types">
            <h2>Our Services</h2>
            <div class="service-grid">
                <div class="service-item">
                    <div class="service-bg dine-in"><img src="<%= request.getContextPath() %>/assets/images/dinein.jpg"></div>
                    <h3>Dine-In</h3>
                    <p>Enjoy our comfortable and ambient dine-in experience with a wide selection of dishes.</p>
                </div>
                <div class="service-item">
                    <div class="service-bg take-out"><img src="<%= request.getContextPath() %>/assets/images/takeaway.jpg"></div>
                    <h3>Take-Away</h3>
                    <p>Order ahead and pick up your meal at your convenience with our easy take-out service.</p>
                </div>
                <div class="service-item">
                    <div class="service-bg delivery"><img src="<%= request.getContextPath() %>/assets/images/delivery.jpg"></div>
                    <h3>Delivery</h3>
                    <p>Get your favorite dishes delivered straight to your door with our efficient delivery service.</p>
                </div>
                <div class="service-item">
                    <div class="service-bg catering"><img src="<%= request.getContextPath() %>/assets/images/catering.jpg"></div>
                    <h3>Catering</h3>
                    <p>We offer catering services for your events, with customizable menus to suit your needs.</p>
                </div>
            </div>
        </section>

        <section class="special-facilities">
            <h2>Special Facilities</h2>
            <div class="facility-grid">
                <div class="facility-item">
                    <div class="facility-bg private-dining"><img src="<%= request.getContextPath() %>/assets/images/privatedinein.jpg"></div>
                    <h3>Private Dining</h3>
                    <p>Experience exclusive private dining for special occasions in our elegant rooms.</p>
                </div>
                <div class="facility-item">
                    <div class="facility-bg event-hosting"><img src="<%= request.getContextPath() %>/assets/images/event.jpg"></div>
                    <h3>Event Hosting</h3>
                    <p>Host your events with us! We provide full-service event planning and catering.</p>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <p>&copy; 2024 ABC Restaurant. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>
