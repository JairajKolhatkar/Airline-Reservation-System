package com.airline.dao;

import com.airline.models.Flight;
import com.airline.models.FlightPricing;
import com.airline.utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FlightDAO {
    
    // Method to search flights based on criteria
    public List<Flight> searchFlights(int originAirportId, int destinationAirportId, 
                                    Date departureDate, int categoryId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Flight> flights = new ArrayList<>();
        
        try {
            connection = DBUtil.getConnection();
            // SQL for flight search with detailed information
            String query = "SELECT f.*, a.airline_name, a.airline_code, " + 
                          "o.airport_code as origin_code, o.city as origin_city, " + 
                          "d.airport_code as destination_code, d.city as destination_city, " + 
                          "fc.category_name " + 
                          "FROM flights f " + 
                          "JOIN airlines a ON f.airline_id = a.airline_id " + 
                          "JOIN airports o ON f.origin_airport_id = o.airport_id " + 
                          "JOIN airports d ON f.destination_airport_id = d.airport_id " + 
                          "JOIN flight_categories fc ON f.category_id = fc.category_id " + 
                          "WHERE f.origin_airport_id = ? AND f.destination_airport_id = ? " + 
                          "AND DATE(f.departure_time) = ? ";
            
            if (categoryId > 0) {
                query += "AND f.category_id = ? ";
            }
            
            statement = connection.prepareStatement(query);
            statement.setInt(1, originAirportId);
            statement.setInt(2, destinationAirportId);
            
            // Convert java.util.Date to java.sql.Date for the query
            java.sql.Date sqlDate = new java.sql.Date(departureDate.getTime());
            statement.setDate(3, sqlDate);
            
            if (categoryId > 0) {
                statement.setInt(4, categoryId);
            }
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Flight flight = new Flight();
                flight.setFlightId(resultSet.getInt("flight_id"));
                flight.setFlightNumber(resultSet.getString("flight_number"));
                flight.setAirlineId(resultSet.getInt("airline_id"));
                flight.setOriginAirportId(resultSet.getInt("origin_airport_id"));
                flight.setDestinationAirportId(resultSet.getInt("destination_airport_id"));
                flight.setDepartureTime(resultSet.getTimestamp("departure_time"));
                flight.setArrivalTime(resultSet.getTimestamp("arrival_time"));
                flight.setCategoryId(resultSet.getInt("category_id"));
                flight.setTotalSeats(resultSet.getInt("total_seats"));
                
                // Set additional display properties
                flight.setAirlineName(resultSet.getString("airline_name"));
                flight.setAirlineCode(resultSet.getString("airline_code"));
                flight.setOriginAirportCode(resultSet.getString("origin_code"));
                flight.setOriginCity(resultSet.getString("origin_city"));
                flight.setDestinationAirportCode(resultSet.getString("destination_code"));
                flight.setDestinationCity(resultSet.getString("destination_city"));
                flight.setCategoryName(resultSet.getString("category_name"));
                
                flights.add(flight);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, statement, resultSet);
        }
        
        return flights;
    }
    
    // Method to filter flights by price range
    public List<Flight> filterFlightsByPrice(List<Flight> flights, 
                                           double minPrice, double maxPrice) {
        List<Flight> filteredFlights = new ArrayList<>();
        
        for (Flight flight : flights) {
            FlightPricingDAO pricingDAO = new FlightPricingDAO();
            List<FlightPricing> pricings = pricingDAO.getPricingByFlightId(flight.getFlightId());
            boolean priceInRange = false;
            
            for (FlightPricing pricing : pricings) {
                double price = pricing.getPrice().doubleValue();
                if (price >= minPrice && price <= maxPrice) {
                    priceInRange = true;
                    break;
                }
            }
            
            if (priceInRange) {
                filteredFlights.add(flight);
            }
        }
        
        return filteredFlights;
    }
    
    // Method to filter flights by airline
    public List<Flight> filterFlightsByAirline(List<Flight> flights, int airlineId) {
        List<Flight> filteredFlights = new ArrayList<>();
        
        for (Flight flight : flights) {
            if (flight.getAirlineId() == airlineId) {
                filteredFlights.add(flight);
            }
        }
        
        return filteredFlights;
    }
    
    // Method to filter flights by seat class availability
    public List<Flight> filterFlightsByClass(List<Flight> flights, int classId) {
        List<Flight> filteredFlights = new ArrayList<>();
        
        for (Flight flight : flights) {
            FlightPricingDAO pricingDAO = new FlightPricingDAO();
            List<FlightPricing> pricings = pricingDAO.getPricingByFlightId(flight.getFlightId());
            
            for (FlightPricing pricing : pricings) {
                if (pricing.getClassId() == classId && pricing.getAvailableSeats() > 0) {
                    filteredFlights.add(flight);
                    break;
                }
            }
        }
        
        return filteredFlights;
    }
    
    // Method to get flight by ID
    public Flight getFlightById(int flightId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        Flight flight = null;
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT f.*, a.airline_name, a.airline_code, " + 
                          "o.airport_code as origin_code, o.city as origin_city, " + 
                          "d.airport_code as destination_code, d.city as destination_city, " + 
                          "fc.category_name " + 
                          "FROM flights f " + 
                          "JOIN airlines a ON f.airline_id = a.airline_id " + 
                          "JOIN airports o ON f.origin_airport_id = o.airport_id " + 
                          "JOIN airports d ON f.destination_airport_id = d.airport_id " + 
                          "JOIN flight_categories fc ON f.category_id = fc.category_id " + 
                          "WHERE f.flight_id = ?";
            
            statement = connection.prepareStatement(query);
            statement.setInt(1, flightId);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                flight = new Flight();
                flight.setFlightId(resultSet.getInt("flight_id"));
                flight.setFlightNumber(resultSet.getString("flight_number"));
                flight.setAirlineId(resultSet.getInt("airline_id"));
                flight.setOriginAirportId(resultSet.getInt("origin_airport_id"));
                flight.setDestinationAirportId(resultSet.getInt("destination_airport_id"));
                flight.setDepartureTime(resultSet.getTimestamp("departure_time"));
                flight.setArrivalTime(resultSet.getTimestamp("arrival_time"));
                flight.setCategoryId(resultSet.getInt("category_id"));
                flight.setTotalSeats(resultSet.getInt("total_seats"));
                
                // Set additional display properties
                flight.setAirlineName(resultSet.getString("airline_name"));
                flight.setAirlineCode(resultSet.getString("airline_code"));
                flight.setOriginAirportCode(resultSet.getString("origin_code"));
                flight.setOriginCity(resultSet.getString("origin_city"));
                flight.setDestinationAirportCode(resultSet.getString("destination_code"));
                flight.setDestinationCity(resultSet.getString("destination_city"));
                flight.setCategoryName(resultSet.getString("category_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, statement, resultSet);
        }
        
        return flight;
    }
    
    // Method to get all flights (Admin)
    public List<Flight> getAllFlights() {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        List<Flight> flights = new ArrayList<>();
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT f.*, a.airline_name, a.airline_code, " + 
                          "o.airport_code as origin_code, o.city as origin_city, " + 
                          "d.airport_code as destination_code, d.city as destination_city, " + 
                          "fc.category_name " + 
                          "FROM flights f " + 
                          "JOIN airlines a ON f.airline_id = a.airline_id " + 
                          "JOIN airports o ON f.origin_airport_id = o.airport_id " + 
                          "JOIN airports d ON f.destination_airport_id = d.airport_id " + 
                          "JOIN flight_categories fc ON f.category_id = fc.category_id " + 
                          "ORDER BY f.departure_time";
            
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            
            while (resultSet.next()) {
                Flight flight = new Flight();
                flight.setFlightId(resultSet.getInt("flight_id"));
                flight.setFlightNumber(resultSet.getString("flight_number"));
                flight.setAirlineId(resultSet.getInt("airline_id"));
                flight.setOriginAirportId(resultSet.getInt("origin_airport_id"));
                flight.setDestinationAirportId(resultSet.getInt("destination_airport_id"));
                flight.setDepartureTime(resultSet.getTimestamp("departure_time"));
                flight.setArrivalTime(resultSet.getTimestamp("arrival_time"));
                flight.setCategoryId(resultSet.getInt("category_id"));
                flight.setTotalSeats(resultSet.getInt("total_seats"));
                
                // Set additional display properties
                flight.setAirlineName(resultSet.getString("airline_name"));
                flight.setAirlineCode(resultSet.getString("airline_code"));
                flight.setOriginAirportCode(resultSet.getString("origin_code"));
                flight.setOriginCity(resultSet.getString("origin_city"));
                flight.setDestinationAirportCode(resultSet.getString("destination_code"));
                flight.setDestinationCity(resultSet.getString("destination_city"));
                flight.setCategoryName(resultSet.getString("category_name"));
                
                flights.add(flight);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, null, resultSet);
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return flights;
    }
    
    // Method to add a new flight (Admin)
    public boolean addFlight(Flight flight, List<FlightPricing> pricings) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet generatedKeys = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            connection.setAutoCommit(false);
            
            // Insert flight
            String query = "INSERT INTO flights (flight_number, airline_id, origin_airport_id, " +
                          "destination_airport_id, departure_time, arrival_time, category_id, total_seats) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, flight.getFlightNumber());
            statement.setInt(2, flight.getAirlineId());
            statement.setInt(3, flight.getOriginAirportId());
            statement.setInt(4, flight.getDestinationAirportId());
            statement.setTimestamp(5, flight.getDepartureTime());
            statement.setTimestamp(6, flight.getArrivalTime());
            statement.setInt(7, flight.getCategoryId());
            statement.setInt(8, flight.getTotalSeats());
            
            int rowsAffected = statement.executeUpdate();
            
            if (rowsAffected > 0) {
                generatedKeys = statement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int flightId = generatedKeys.getInt(1);
                    
                    // Insert flight pricing for each class
                    FlightPricingDAO pricingDAO = new FlightPricingDAO();
                    boolean pricingSuccess = true;
                    
                    for (FlightPricing pricing : pricings) {
                        pricing.setFlightId(flightId);
                        pricingSuccess = pricingSuccess && pricingDAO.addFlightPricing(pricing, connection);
                    }
                    
                    if (pricingSuccess) {
                        connection.commit();
                        result = true;
                    } else {
                        connection.rollback();
                    }
                }
            }
        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            if (generatedKeys != null) {
                try {
                    generatedKeys.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            DBUtil.closePreparedStatement(statement);
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return result;
    }
    
    // Method to update flight (Admin)
    public boolean updateFlight(Flight flight) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "UPDATE flights SET flight_number = ?, airline_id = ?, " +
                          "origin_airport_id = ?, destination_airport_id = ?, " +
                          "departure_time = ?, arrival_time = ?, category_id = ?, " +
                          "total_seats = ? WHERE flight_id = ?";
            
            statement = connection.prepareStatement(query);
            statement.setString(1, flight.getFlightNumber());
            statement.setInt(2, flight.getAirlineId());
            statement.setInt(3, flight.getOriginAirportId());
            statement.setInt(4, flight.getDestinationAirportId());
            statement.setTimestamp(5, flight.getDepartureTime());
            statement.setTimestamp(6, flight.getArrivalTime());
            statement.setInt(7, flight.getCategoryId());
            statement.setInt(8, flight.getTotalSeats());
            statement.setInt(9, flight.getFlightId());
            
            int rowsAffected = statement.executeUpdate();
            result = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return result;
    }
    
    // Method to delete flight (Admin)
    public boolean deleteFlight(int flightId) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            connection.setAutoCommit(false);
            
            // Delete associated pricing records first (foreign key constraint)
            FlightPricingDAO pricingDAO = new FlightPricingDAO();
            pricingDAO.deleteFlightPricingByFlightId(flightId, connection);
            
            // Then delete the flight
            String query = "DELETE FROM flights WHERE flight_id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, flightId);
            
            int rowsAffected = statement.executeUpdate();
            if (rowsAffected > 0) {
                connection.commit();
                result = true;
            } else {
                connection.rollback();
            }
        } catch (SQLException e) {
            try {
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            DBUtil.closePreparedStatement(statement);
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return result;
    }

    /**
     * Get upcoming flights with limit
     * @param limit Maximum number of flights to return
     * @return List of upcoming flights
     */
    public List<Flight> getUpcomingFlights(int limit) throws SQLException {
        List<Flight> flights = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT f.*, a1.airport_code as origin_code, a1.city as origin_city, " +
                         "a2.airport_code as destination_code, a2.city as destination_city, " +
                         "ar.airline_name, ac.model, ac.total_seats " +
                         "FROM flights f " +
                         "JOIN airports a1 ON f.origin_airport_id = a1.airport_id " +
                         "JOIN airports a2 ON f.destination_airport_id = a2.airport_id " +
                         "JOIN airlines ar ON f.airline_id = ar.airline_id " +
                         "JOIN aircraft ac ON f.aircraft_id = ac.aircraft_id " +
                         "WHERE f.departure_time > NOW() " +
                         "ORDER BY f.departure_time ASC " +
                         "LIMIT ?";
            
            statement = connection.prepareStatement(sql);
            statement.setInt(1, limit);
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Flight flight = extractFlightFromResultSet(resultSet);
                flights.add(flight);
            }
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return flights;
    }

    /**
     * Get count of currently active flights
     * @return Number of active flights
     */
    public int getActiveFlightsCount() throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) as count FROM flights " +
                         "WHERE departure_time <= NOW() AND arrival_time >= NOW()";
            
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return resultSet.getInt("count");
            }
            
            return 0;
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
    }
    
    /**
     * Extract flight information from a result set
     * @param resultSet The result set to extract data from
     * @return A Flight object with populated data
     */
    private Flight extractFlightFromResultSet(ResultSet resultSet) throws SQLException {
        Flight flight = new Flight();
        flight.setFlightId(resultSet.getInt("flight_id"));
        flight.setFlightNumber(resultSet.getString("flight_number"));
        flight.setAirlineId(resultSet.getInt("airline_id"));
        flight.setOriginAirportId(resultSet.getInt("origin_airport_id"));
        flight.setDestinationAirportId(resultSet.getInt("destination_airport_id"));
        flight.setDepartureTime(resultSet.getTimestamp("departure_time"));
        flight.setArrivalTime(resultSet.getTimestamp("arrival_time"));
        flight.setTotalSeats(resultSet.getInt("total_seats"));
        
        // Set additional display properties if available
        try {
            flight.setAirlineName(resultSet.getString("airline_name"));
        } catch (SQLException e) {
            // Column might not exist, ignore
        }
        
        try {
            flight.setOriginAirportCode(resultSet.getString("origin_code"));
            flight.setOriginCity(resultSet.getString("origin_city"));
            flight.setDestinationAirportCode(resultSet.getString("destination_code"));
            flight.setDestinationCity(resultSet.getString("destination_city"));
        } catch (SQLException e) {
            // Columns might not exist, ignore
        }
        
        return flight;
    }
} 