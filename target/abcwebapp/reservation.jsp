<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.example.abcwebapp.DatabaseConnection" %>
<%

    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Restaurant - Reservation</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/reservation.css">
</head>
<body>

    <!-- Header Section -->
    <header>
        <div class="container">
            <%@ include file="navbar.jsp" %>
        </div>
    </header>

    <!-- Payment Popup -->
    <div id="paymentPopup" class="popup">
        <div class="popup-content">
            <h2>Payment Details</h2>
            <form id="paymentForm">
                <div class="form-group">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" id="cardNumber" name="cardNumber" required>
                </div>
                <div class="form-group">
                    <label for="expiryDate">Expiry Date:</label>
                    <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                </div>
                <div class="form-group">
                    <label for="cvv">CVV:</label>
                    <input type="text" id="cvv" name="cvv" required>
                </div>
                <button type="button" id="confirmPaymentBtn">Confirm Payment</button>
                <button type="button" id="cancelPaymentBtn">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Main Content -->
    <main class="container">
        <section class="reservation-form-section">
            <form id="reservationForm" action="ReservationServlet" method="POST" class="reservation-form">
                <h2>MAKE A RESERVATION</h2>
                <div class="form-group">
                    <label for="serviceType">Service Type:</label>
                    <select id="serviceType" name="serviceType" required>
                        <option value="Private Dining">Private Dining</option>
                        <option value="Event Hosting">Event Hosting</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="reservationDate">Date:</label>
                    <input type="date" id="reservationDate" name="reservationDate" required>
                </div>
                <div class="form-group">
                    <label for="reservationTime">Time:</label>
                    <input type="time" id="reservationTime" name="reservationTime" required>
                </div>
                <div class="form-group" id="participantsGroup">
                    <label for="participants">Number of Participants:</label>
                    <input type="number" id="participants" name="participants" min="1" max="100" value="1" required>
                </div>
                <div class="form-group">
                    <label for="customerName">Your Name:</label>
                    <input type="text" id="customerName" name="customerName" required>
                </div>
                <div class="form-group">
                    <label for="contactDetails">Contact Details:</label>
                    <input type="text" id="contactDetails" name="contactDetails" required>
                </div>
                <div class="form-group">
                    <label for="specialRequests">Special Requests:</label>
                    <textarea id="specialRequests" name="specialRequests" rows="4"></textarea>
                </div>
                <!-- Hidden input for payment status -->
                <input type="hidden" id="paymentStatus" name="paymentStatus" value="Pending">
                <button type="button" class="submit-btn" id="reserveBtn">Reserve Now</button>
            </form>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <p>&copy; 2024 ABC Restaurant. All rights reserved.</p>
        </div>
    </footer>

    <%
        String selectedDate = request.getParameter("reservationDate");
        String serviceType = request.getParameter("serviceType");
        boolean isEventExist = false;

        if ("Event Hosting".equals(serviceType) && selectedDate != null) {
            try {
                Connection conn = DatabaseConnection.getConnection();
                String sql = "SELECT COUNT(*) FROM reservations WHERE reservation_date = ? AND service_type = 'Event Hosting'";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, selectedDate);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    int count = rs.getInt(1);
                    if (count > 0) {
                        isEventExist = false;
                    }
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>


    <!-- Script to toggle participants field visibility based on service type -->
    <script>
        document.getElementById('reserveBtn').addEventListener('click', function() {

            var isEventExist = '<%= isEventExist %>' === 'true';

            if (isEventExist) {
                alert('An event is already scheduled for this date. Please choose another date.');
            } else {
                // Show payment popup if no event exists on the selected date
                document.getElementById('paymentPopup').style.display = 'block';
            }
        });
    
        document.getElementById('cancelPaymentBtn').addEventListener('click', function() {
            // Hide payment popup
            document.getElementById('paymentPopup').style.display = 'none';
        });
    
        document.getElementById('confirmPaymentBtn').addEventListener('click', function() {
            // Validate payment details
            var cardNumber = document.getElementById('cardNumber').value;
            var expiryDate = document.getElementById('expiryDate').value;
            var cvv = document.getElementById('cvv').value;
    
            if (validatePayment(cardNumber, expiryDate, cvv)) {
                // If validation is successful, set paymentStatus to "Done"
                document.getElementById('paymentStatus').value = "Done";

                // Hide payment popup and submit the reservation form
                document.getElementById('paymentPopup').style.display = 'none';
                document.getElementById('reservationForm').submit();
            } else {
                alert('Invalid payment details.');
            }
        });
    
        function validatePayment(cardNumber, expiryDate, cvv) {
            // Simple validation logic (expand as needed)
            var cardNumberRegex = /^\d{16}$/;
            var expiryDateRegex = /^(0[1-9]|1[0-2])\/\d{2}$/;
            var cvvRegex = /^\d{3,4}$/;

            if (!cardNumberRegex.test(cardNumber)) {
                alert('Please enter a valid 16-digit card number.');
                return false;
            }
            if (!expiryDateRegex.test(expiryDate)) {
                alert('Please enter a valid expiry date in MM/YY format.');
                return false;
            }
            if (!cvvRegex.test(cvv)) {
                alert('Please enter a valid CVV (3 or 4 digits).');
                return false;
            }
            return true;
        }
    </script>

</body>
</html>
