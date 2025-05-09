package com.airline.controllers;

import com.airline.dao.FlightDAO;
import com.airline.dao.FlightPricingDAO;
import com.airline.models.Flight;
import com.airline.models.FlightPricing;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/flights/search")
public class FlightSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to search page
        request.getRequestDispatcher("/pages/flight-search.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get search parameters
        String originStr = request.getParameter("origin");
        String destinationStr = request.getParameter("destination");
        String departureDateStr = request.getParameter("departure_date");
        String categoryStr = request.getParameter("category");
        
        // Validate required parameters
        if (originStr == null || originStr.trim().isEmpty() ||
            destinationStr == null || destinationStr.trim().isEmpty() ||
            departureDateStr == null || departureDateStr.trim().isEmpty()) {
            
            request.setAttribute("error", "Origin, destination and departure date are required");
            request.getRequestDispatcher("/pages/flight-search.jsp").forward(request, response);
            return;
        }
        
        try {
            // Parse parameters
            int originAirportId = Integer.parseInt(originStr);
            int destinationAirportId = Integer.parseInt(destinationStr);
            
            // Parse departure date
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date departureDate = dateFormat.parse(departureDateStr);
            
            // Parse category (optional)
            int categoryId = 0; // 0 means any category
            if (categoryStr != null && !categoryStr.trim().isEmpty()) {
                categoryId = Integer.parseInt(categoryStr);
            }
            
            // Search flights
            FlightDAO flightDAO = new FlightDAO();
            List<Flight> flights = flightDAO.searchFlights(
                originAirportId, destinationAirportId, departureDate, categoryId);
            
            // Get pricing for each flight
            FlightPricingDAO pricingDAO = new FlightPricingDAO();
            for (Flight flight : flights) {
                List<FlightPricing> pricings = pricingDAO.getPricingByFlightId(flight.getFlightId());
                request.setAttribute("pricing_" + flight.getFlightId(), pricings);
            }
            
            // Check for filters
            String airlineFilter = request.getParameter("airline");
            String minPriceFilter = request.getParameter("min_price");
            String maxPriceFilter = request.getParameter("max_price");
            String classFilter = request.getParameter("class");
            
            // Apply filters if provided
            if (airlineFilter != null && !airlineFilter.trim().isEmpty()) {
                int airlineId = Integer.parseInt(airlineFilter);
                flights = flightDAO.filterFlightsByAirline(flights, airlineId);
            }
            
            if (minPriceFilter != null && !minPriceFilter.trim().isEmpty() &&
                maxPriceFilter != null && !maxPriceFilter.trim().isEmpty()) {
                double minPrice = Double.parseDouble(minPriceFilter);
                double maxPrice = Double.parseDouble(maxPriceFilter);
                flights = flightDAO.filterFlightsByPrice(flights, minPrice, maxPrice);
            }
            
            if (classFilter != null && !classFilter.trim().isEmpty()) {
                int classId = Integer.parseInt(classFilter);
                flights = flightDAO.filterFlightsByClass(flights, classId);
            }
            
            // Store search results in request
            request.setAttribute("flights", flights);
            request.setAttribute("origin", originAirportId);
            request.setAttribute("destination", destinationAirportId);
            request.setAttribute("departureDate", departureDateStr);
            request.setAttribute("category", categoryId);
            
            // Forward to search results page
            request.getRequestDispatcher("/pages/flight-results.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            request.getRequestDispatcher("/pages/flight-search.jsp").forward(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use YYYY-MM-DD");
            request.getRequestDispatcher("/pages/flight-search.jsp").forward(request, response);
        }
    }
} 