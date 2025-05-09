package com.airline.controllers;

import com.airline.dao.BookingDAO;
import com.airline.dao.FlightDAO;
import com.airline.dao.FlightPricingDAO;
import com.airline.models.Booking;
import com.airline.models.Flight;
import com.airline.models.FlightPricing;
import com.airline.models.Passenger;
import com.airline.models.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get flight ID from request
        String flightIdStr = request.getParameter("flight_id");
        String classIdStr = request.getParameter("class_id");
        
        if (flightIdStr == null || classIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/flights/search");
            return;
        }
        
        try {
            // Parse flight ID and class ID
            int flightId = Integer.parseInt(flightIdStr);
            int classId = Integer.parseInt(classIdStr);
            
            // Get flight and pricing details
            FlightDAO flightDAO = new FlightDAO();
            Flight flight = flightDAO.getFlightById(flightId);
            
            FlightPricingDAO pricingDAO = new FlightPricingDAO();
            List<FlightPricing> pricings = pricingDAO.getPricingByFlightId(flightId);
            
            FlightPricing selectedPricing = null;
            for (FlightPricing pricing : pricings) {
                if (pricing.getClassId() == classId) {
                    selectedPricing = pricing;
                    break;
                }
            }
            
            if (flight == null || selectedPricing == null) {
                // Flight or pricing not found
                request.setAttribute("error", "Selected flight or class is not available");
                request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
                return;
            }
            
            // Store flight and pricing details in request
            request.setAttribute("flight", flight);
            request.setAttribute("pricing", selectedPricing);
            
            // Forward to booking page
            request.getRequestDispatcher("/pages/booking-form.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/flights/search");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // User not logged in, redirect to login page
            session = request.getSession();
            session.setAttribute("message", "Please login to complete your booking.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get logged in user
        User user = (User) session.getAttribute("user");
        
        // Get booking parameters
        String flightIdStr = request.getParameter("flight_id");
        String classIdStr = request.getParameter("class_id");
        String passengersCountStr = request.getParameter("passengers_count");
        
        if (flightIdStr == null || classIdStr == null || passengersCountStr == null) {
            request.setAttribute("error", "Invalid booking request");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse parameters
            int flightId = Integer.parseInt(flightIdStr);
            int classId = Integer.parseInt(classIdStr);
            int passengersCount = Integer.parseInt(passengersCountStr);
            
            // Validate passenger count
            if (passengersCount <= 0 || passengersCount > 10) {
                request.setAttribute("error", "Invalid number of passengers");
                request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
                return;
            }
            
            // Get flight and pricing details
            FlightDAO flightDAO = new FlightDAO();
            Flight flight = flightDAO.getFlightById(flightId);
            
            FlightPricingDAO pricingDAO = new FlightPricingDAO();
            List<FlightPricing> pricings = pricingDAO.getPricingByFlightId(flightId);
            
            FlightPricing selectedPricing = null;
            for (FlightPricing pricing : pricings) {
                if (pricing.getClassId() == classId) {
                    selectedPricing = pricing;
                    break;
                }
            }
            
            if (flight == null || selectedPricing == null) {
                // Flight or pricing not found
                request.setAttribute("error", "Selected flight or class is not available");
                request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
                return;
            }
            
            // Check seat availability
            if (selectedPricing.getAvailableSeats() < passengersCount) {
                request.setAttribute("error", "Not enough seats available");
                request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
                return;
            }
            
            // Create passenger list
            List<Passenger> passengers = new ArrayList<>();
            for (int i = 1; i <= passengersCount; i++) {
                String firstName = request.getParameter("first_name_" + i);
                String lastName = request.getParameter("last_name_" + i);
                String gender = request.getParameter("gender_" + i);
                String ageStr = request.getParameter("age_" + i);
                String seatNumber = request.getParameter("seat_" + i);
                
                if (firstName == null || lastName == null || gender == null || ageStr == null) {
                    request.setAttribute("error", "Please provide details for all passengers");
                    request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
                    return;
                }
                
                int age = Integer.parseInt(ageStr);
                
                Passenger passenger = new Passenger();
                passenger.setFirstName(firstName);
                passenger.setLastName(lastName);
                passenger.setGender(gender);
                passenger.setAge(age);
                passenger.setSeatNumber(seatNumber);
                passenger.setClassId(classId);
                
                passengers.add(passenger);
            }
            
            // Calculate total amount
            BigDecimal price = selectedPricing.getPrice();
            BigDecimal totalAmount = price.multiply(new BigDecimal(passengersCount));
            
            // Create booking
            Booking booking = new Booking();
            booking.setUserId(user.getUserId());
            booking.setFlightId(flightId);
            booking.setTotalPassengers(passengersCount);
            booking.setTotalAmount(totalAmount);
            booking.setBookingStatus("CONFIRMED");
            
            // Save booking
            BookingDAO bookingDAO = new BookingDAO();
            try {
                Booking createdBooking = bookingDAO.createBooking(booking, passengers);
                
                if (createdBooking != null && createdBooking.getBookingId() > 0) {
                    // Booking successful
                    int bookingId = createdBooking.getBookingId();
                    session.setAttribute("message", "Booking confirmed! Your booking ID is: " + bookingId);
                    response.sendRedirect(request.getContextPath() + "/booking/confirm?id=" + bookingId);
                } else {
                    // Booking failed
                    request.setAttribute("error", "Booking failed. Please try again.");
                    request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            request.getRequestDispatcher("/pages/error.jsp").forward(request, response);
        }
    }
}