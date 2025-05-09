package com.airline.controllers;

import com.airline.dao.BookingDAO;
import com.airline.models.Booking;
import com.airline.models.User;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get current user
        User user = (User) session.getAttribute("user");
        
        // If admin, redirect to admin dashboard
        if (user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        try {
            // Get user's bookings
            BookingDAO bookingDAO = new BookingDAO();
            List<Booking> bookings = bookingDAO.getUserBookings(user.getUserId(), 5); // Get most recent 5 bookings
            
            // Set attributes for JSP
            request.setAttribute("bookings", bookings);
            
            // Forward to dashboard page
            request.getRequestDispatcher("/pages/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error
            getServletContext().log("Error in DashboardServlet", e);
            request.setAttribute("error", "An error occurred while loading your dashboard. Please try again later.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 