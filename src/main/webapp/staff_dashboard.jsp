<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.abcwebapp.Models.Reservation" %>
<%@ page import="com.example.abcwebapp.Models.Query" %>
<%@ page import="com.example.abcwebapp.DatabaseConnection" %>
<%

    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Reservation> reservations = new ArrayList<Reservation>();
    List<Query> queries = new ArrayList<Query>();
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        connection = DatabaseConnection.getConnection();

        // Fetch reservations data
        String reservationsSql = "SELECT * FROM reservations";
        statement = connection.prepareStatement(reservationsSql);
        resultSet = statement.executeQuery();

        while (resultSet.next()) {
            Reservation reservation = new Reservation();
            reservation.setId(resultSet.getInt("id"));
            reservation.setUserId(resultSet.getInt("user_id"));
            reservation.setServiceType(resultSet.getString("service_type"));
            reservation.setReservationDate(resultSet.getDate("reservation_date"));
            reservation.setReservationTime(resultSet.getTime("reservation_time"));
            reservation.setCustomerName(resultSet.getString("customer_name"));
            reservation.setContactDetails(resultSet.getString("contact_details"));
            reservation.setSpecialRequests(resultSet.getString("special_requests"));
            reservation.setPaymentStatus(resultSet.getString("payment_status"));
            reservation.setStatus(resultSet.getString("status"));
            reservation.setCreatedAt(resultSet.getTimestamp("created_at"));
            reservations.add(reservation);
        }

        resultSet.close(); // Close the previous result set before executing the next query

        // Fetch user queries
        String queriesSql = "SELECT * FROM user_queries";
        statement = connection.prepareStatement(queriesSql);
        resultSet = statement.executeQuery();

        while (resultSet.next()) {
            Query query = new Query();
            query.setId(resultSet.getInt("id"));
            query.setUserId(resultSet.getInt("user_id"));
            query.setName(resultSet.getString("name"));
            query.setEmail(resultSet.getString("email"));
            query.setQuery(resultSet.getString("query"));
            query.setSubmissionDate(resultSet.getDate("submission_date"));
            query.setAnswer(resultSet.getString("answer"));
            queries.add(query);
        }

    } catch (SQLException e) {
        e.printStackTrace();  // Consider logging this instead of printing stack trace in production
        request.setAttribute("errorMessage", "An error occurred while retrieving data. Please try again later.");
    } finally {
        // Close resources in reverse order of their creation
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    request.setAttribute("reservations", reservations);
    request.setAttribute("queries", queries);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard</title>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/staff_dashboard.css">
</head>
<body>
    <header>
        <%@ include file="navbar.jsp" %>
    </header>

    <main>
        <div class="container">
            <!-- Reservation Management -->
            <section>
                <h2>Reservation Management</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Service Type</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Customer Name</th>
                            <th>Contact Details</th>
                            <th>Special Requests</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Reservation reservation : reservations) {
                        %>
                        <tr>
                            <td><%= reservation.getId() %></td>
                            <td><%= reservation.getServiceType() %></td>
                            <td><%= reservation.getReservationDate() %></td>
                            <td><%= reservation.getReservationTime() %></td>
                            <td><%= reservation.getCustomerName() %></td>
                            <td><%= reservation.getContactDetails() %></td>
                            <td><%= reservation.getSpecialRequests() %></td>
                            <td><%= reservation.getStatus() %></td>
                            <td>
                                <form action="UpdateReservationServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="reservationId" value="<%= reservation.getId() %>">
                                    <button type="submit" name="action" value="confirm">Confirm</button>
                                    <button type="submit" name="action" value="cancel">Cancel</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </section>

            <!-- Query Management -->
            <section>
                <h2>Query Management</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User Name</th>
                            <th>Email</th>
                            <th>Query</th>
                            <th>Submission Date</th>
                            <th>Answer</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Query query : queries) {
                        %>
                        <tr>
                            <td><%= query.getId() %></td>
                            <td><%= query.getName() %></td>
                            <td><%= query.getEmail() %></td>
                            <td><%= query.getQuery() %></td>
                            <td><%= query.getSubmissionDate() %></td>
                            <td>
                                <form action="UpdateQueryServlet" method="post">
                                    <input type="hidden" name="queryId" value="<%= query.getId() %>">
                                    <textarea name="answer" rows="3" cols="30"><%= query.getAnswer() %></textarea>
                                    <button type="submit">Update Answer</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </section>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 ABC Restaurant. All rights reserved.</p>
    </footer>
</body>
</html>
