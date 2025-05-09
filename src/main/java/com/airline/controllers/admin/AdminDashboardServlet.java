package com.airline.controllers.admin;

import com.airline.dao.BookingDAO;
import com.airline.dao.FlightDAO;
import com.airline.dao.UserDAO;
import com.airline.models.Booking;
import com.airline.models.Flight;
import com.airline.models.User;
import com.airline.utils.DashboardStats;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in and is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        try {
            // Get dashboard statistics
            DashboardStats stats = getDashboardStats();
            request.setAttribute("stats", stats);
            
            // Get recent bookings
            BookingDAO bookingDAO = new BookingDAO();
            List<Booking> recentBookings = bookingDAO.getRecentBookings(10);
            request.setAttribute("recentBookings", recentBookings);
            
            // Get upcoming flights
            FlightDAO flightDAO = new FlightDAO();
            List<Flight> upcomingFlights = flightDAO.getUpcomingFlights(10);
            request.setAttribute("upcomingFlights", upcomingFlights);
            
            // Forward to admin dashboard
            request.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            // Log the error
            getServletContext().log("Error in AdminDashboardServlet", e);
            request.setAttribute("error", "An error occurred while loading the admin dashboard. Please try again later.");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
    
    private DashboardStats getDashboardStats() throws SQLException {
        BookingDAO bookingDAO = new BookingDAO();
        FlightDAO flightDAO = new FlightDAO();
        UserDAO userDAO = new UserDAO();
        
        DashboardStats stats = new DashboardStats();
        stats.setTotalBookings(bookingDAO.getTotalBookingsCount());
        stats.setTodayBookings(bookingDAO.getTodayBookingsCount());
        stats.setActiveFlights(flightDAO.getActiveFlightsCount());
        stats.setRegisteredUsers(userDAO.getTotalUsersCount());
        
        return stats;
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 