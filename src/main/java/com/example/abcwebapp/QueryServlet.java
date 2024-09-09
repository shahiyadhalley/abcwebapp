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

public class QueryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String query = request.getParameter("query");

        HttpSession session = request.getSession(false);
        int userId = 0; // Default value for userId
        if (session != null) {
            Object userIdObj = session.getAttribute("userId");
            if (userIdObj instanceof Integer) {
                userId = (Integer) userIdObj; 
            } else if (userIdObj instanceof String) {
                try {
                    userId = Integer.parseInt((String) userIdObj); 
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    request.setAttribute("message", "Invalid user ID format.");
                    request.getRequestDispatcher("customer_dashboard.jsp").forward(request, response);
                    return;
                }
            } else {
                request.setAttribute("message", "Invalid user ID format.");
                request.getRequestDispatcher("customer_dashboard.jsp").forward(request, response);
                return;
            }
        }

        boolean success = false;

        // Insert query into the database
        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO user_queries (user_id, name, email, query, answer) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
                pstmt.setInt(1, userId);
                pstmt.setString(2, name);
                pstmt.setString(3, email);
                pstmt.setString(4, query);
                pstmt.setString(5, "");
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
        }

        response.sendRedirect("customer_dashboard.jsp");

        
    }
}
