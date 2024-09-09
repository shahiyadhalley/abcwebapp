package com.example.abcwebapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReservationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Retrieve form parameters
        String serviceType = request.getParameter("serviceType");
        String reservationDate = request.getParameter("reservationDate");
        String reservationTime = request.getParameter("reservationTime");
        int participants = Integer.parseInt(request.getParameter("participants"));
        String customerName = request.getParameter("customerName");
        String contactDetails = request.getParameter("contactDetails");
        String specialRequests = request.getParameter("specialRequests");
        String paymentStatus = request.getParameter("paymentStatus");

        // Get user ID from session
        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");

        try (Connection connection = DatabaseConnection.getConnection()) {

            String sql = "INSERT INTO reservations (user_id, service_type, reservation_date, reservation_time, participants, customer_name, contact_details, special_requests, payment_status, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, userId);
                statement.setString(2, serviceType);
                statement.setString(3, reservationDate);
                statement.setString(4, reservationTime);
                statement.setInt(5, participants);
                statement.setString(6, customerName);
                statement.setString(7, contactDetails);
                statement.setString(8, specialRequests);
                statement.setString(9, paymentStatus);
                statement.setString(10, "Pending");

                statement.executeUpdate();
            }
            response.sendRedirect("reservation.jsp"); 

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp"); 
        } 
    }
}
