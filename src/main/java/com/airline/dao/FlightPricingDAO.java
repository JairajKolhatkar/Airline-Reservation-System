package com.airline.dao;

import com.airline.models.FlightPricing;
import com.airline.utils.DBUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FlightPricingDAO {
    
    // Method to get pricing by flight ID
    public List<FlightPricing> getPricingByFlightId(int flightId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<FlightPricing> pricings = new ArrayList<>();
        
        try {
            connection = DBUtil.getConnection();
            String query = "SELECT fp.*, sc.class_name " + 
                          "FROM flight_pricing fp " + 
                          "JOIN seat_classes sc ON fp.class_id = sc.class_id " + 
                          "WHERE fp.flight_id = ?";
            
            statement = connection.prepareStatement(query);
            statement.setInt(1, flightId);
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                FlightPricing pricing = new FlightPricing();
                pricing.setPricingId(resultSet.getInt("pricing_id"));
                pricing.setFlightId(resultSet.getInt("flight_id"));
                pricing.setClassId(resultSet.getInt("class_id"));
                pricing.setPrice(resultSet.getBigDecimal("price"));
                pricing.setAvailableSeats(resultSet.getInt("available_seats"));
                pricing.setClassName(resultSet.getString("class_name"));
                
                pricings.add(pricing);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(connection, statement, resultSet);
        }
        
        return pricings;
    }
    
    // Method to add flight pricing
    public boolean addFlightPricing(FlightPricing pricing, Connection connection) {
        PreparedStatement statement = null;
        boolean result = false;
        boolean shouldCloseConnection = (connection == null);
        
        try {
            if (connection == null) {
                connection = DBUtil.getConnection();
            }
            
            String query = "INSERT INTO flight_pricing (flight_id, class_id, price, available_seats) " +
                          "VALUES (?, ?, ?, ?)";
            
            statement = connection.prepareStatement(query);
            statement.setInt(1, pricing.getFlightId());
            statement.setInt(2, pricing.getClassId());
            statement.setBigDecimal(3, pricing.getPrice());
            statement.setInt(4, pricing.getAvailableSeats());
            
            int rowsAffected = statement.executeUpdate();
            result = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closePreparedStatement(statement);
            if (shouldCloseConnection) {
                DBUtil.closeConnection(connection);
            }
        }
        
        return result;
    }
    
    // Method to update flight pricing
    public boolean updateFlightPricing(FlightPricing pricing) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "UPDATE flight_pricing SET price = ?, available_seats = ? " +
                          "WHERE pricing_id = ?";
            
            statement = connection.prepareStatement(query);
            statement.setBigDecimal(1, pricing.getPrice());
            statement.setInt(2, pricing.getAvailableSeats());
            statement.setInt(3, pricing.getPricingId());
            
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
    
    // Method to delete flight pricing
    public boolean deleteFlightPricing(int pricingId) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "DELETE FROM flight_pricing WHERE pricing_id = ?";
            
            statement = connection.prepareStatement(query);
            statement.setInt(1, pricingId);
            
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
    
    // Method to delete all pricing for a flight
    public boolean deleteFlightPricingByFlightId(int flightId, Connection connection) {
        PreparedStatement statement = null;
        boolean result = false;
        boolean shouldCloseConnection = (connection == null);
        
        try {
            if (connection == null) {
                connection = DBUtil.getConnection();
            }
            
            String query = "DELETE FROM flight_pricing WHERE flight_id = ?";
            
            statement = connection.prepareStatement(query);
            statement.setInt(1, flightId);
            
            int rowsAffected = statement.executeUpdate();
            result = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closePreparedStatement(statement);
            if (shouldCloseConnection) {
                DBUtil.closeConnection(connection);
            }
        }
        
        return result;
    }
    
    // Method to update available seats after booking
    public boolean updateAvailableSeats(int flightId, int classId, int seatsToReduce) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean result = false;
        
        try {
            connection = DBUtil.getConnection();
            String query = "UPDATE flight_pricing SET available_seats = available_seats - ? " +
                          "WHERE flight_id = ? AND class_id = ? AND available_seats >= ?";
            
            statement = connection.prepareStatement(query);
            statement.setInt(1, seatsToReduce);
            statement.setInt(2, flightId);
            statement.setInt(3, classId);
            statement.setInt(4, seatsToReduce); // Ensures we don't go negative
            
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
} 