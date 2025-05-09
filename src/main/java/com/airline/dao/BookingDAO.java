package com.airline.dao;

import com.airline.models.Booking;
import com.airline.models.Flight;
import com.airline.models.Passenger;
import com.airline.models.SeatClass;
import com.airline.models.User;
import com.airline.utils.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    
    public BookingDAO() {
        // Empty constructor
    }
    
    /**
     * Get all bookings for a user
     * @param userId User ID
     * @param limit Maximum number of bookings to return (0 for all)
     * @return List of bookings
     */
    public List<Booking> getUserBookings(int userId, int limit) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT b.*, sc.class_name, COUNT(p.passenger_id) as passenger_count " +
                         "FROM bookings b " +
                         "JOIN seat_classes sc ON b.class_id = sc.class_id " +
                         "LEFT JOIN passengers p ON b.booking_id = p.booking_id " +
                         "WHERE b.user_id = ? " +
                         "GROUP BY b.booking_id " +
                         "ORDER BY b.booking_date DESC";
            
            if (limit > 0) {
                sql += " LIMIT ?";
            }
            
            statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            
            if (limit > 0) {
                statement.setInt(2, limit);
            }
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Booking booking = extractBookingFromResultSet(resultSet);
                bookings.add(booking);
            }
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return bookings;
    }
    
    /**
     * Get recent bookings with limit
     * @param limit Maximum number of bookings to return
     * @return List of recent bookings
     */
    public List<Booking> getRecentBookings(int limit) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT b.*, sc.class_name, COUNT(p.passenger_id) as passenger_count " +
                         "FROM bookings b " +
                         "JOIN seat_classes sc ON b.class_id = sc.class_id " +
                         "LEFT JOIN passengers p ON b.booking_id = p.booking_id " +
                         "GROUP BY b.booking_id " +
                         "ORDER BY b.booking_date DESC " +
                         "LIMIT ?";
            
            statement = connection.prepareStatement(sql);
            statement.setInt(1, limit);
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Booking booking = extractBookingFromResultSet(resultSet);
                bookings.add(booking);
            }
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return bookings;
    }
    
    /**
     * Get total number of bookings in the system
     * @return Total number of bookings
     */
    public int getTotalBookingsCount() throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) as count FROM bookings";
            
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
     * Get the number of bookings made today
     * @return Number of bookings made today
     */
    public int getTodayBookingsCount() throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) as count FROM bookings " +
                         "WHERE DATE(booking_date) = CURRENT_DATE";
            
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
     * Get a booking by its ID
     * @param bookingId Booking ID
     * @return Booking object or null if not found
     */
    public Booking getBookingById(int bookingId) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT b.*, sc.class_name, COUNT(p.passenger_id) as passenger_count " +
                         "FROM bookings b " +
                         "JOIN seat_classes sc ON b.class_id = sc.class_id " +
                         "LEFT JOIN passengers p ON b.booking_id = p.booking_id " +
                         "WHERE b.booking_id = ? " +
                         "GROUP BY b.booking_id";
                         
            statement = connection.prepareStatement(sql);
            statement.setInt(1, bookingId);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return extractBookingFromResultSet(resultSet);
            }
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return null;
    }
    
    /**
     * Get a booking by reference number
     * @param reference Booking reference
     * @return Booking object or null if not found
     */
    public Booking getBookingByReference(String reference) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT b.*, sc.class_name, COUNT(p.passenger_id) as passenger_count " +
                         "FROM bookings b " +
                         "JOIN seat_classes sc ON b.class_id = sc.class_id " +
                         "LEFT JOIN passengers p ON b.booking_id = p.booking_id " +
                         "WHERE b.booking_reference = ? " +
                         "GROUP BY b.booking_id";
            
            statement = connection.prepareStatement(sql);
            statement.setString(1, reference);
            
            resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return extractBookingFromResultSet(resultSet);
            }
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return null;
    }
    
    /**
     * Create a new booking with passengers
     * @param booking Booking to create
     * @param passengers List of passengers to add
     * @return Created booking with ID
     */
    public Booking createBooking(Booking booking, List<Passenger> passengers) throws SQLException {
        Connection connection = null;
        PreparedStatement bookingStatement = null;
        PreparedStatement passengerStatement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DBUtil.getConnection();
            connection.setAutoCommit(false);
            
            // Insert booking
            String sql = "INSERT INTO bookings (user_id, flight_id, booking_reference, booking_date, " +
                         "total_passengers, total_amount, class_id, booking_status) " +
                         "VALUES (?, ?, ?, NOW(), ?, ?, ?, ?)";
            
            bookingStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            bookingStatement.setInt(1, booking.getUserId());
            bookingStatement.setInt(2, booking.getFlightId());
            bookingStatement.setString(3, booking.getBookingReference());
            bookingStatement.setInt(4, booking.getTotalPassengers());
            bookingStatement.setBigDecimal(5, booking.getTotalAmount());
            bookingStatement.setInt(6, booking.getClassId());
            bookingStatement.setString(7, booking.getBookingStatus());
            
            int affectedRows = bookingStatement.executeUpdate();
            
            if (affectedRows == 0) {
                connection.rollback();
                throw new SQLException("Creating booking failed, no rows affected.");
            }
            
            generatedKeys = bookingStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                int bookingId = generatedKeys.getInt(1);
                booking.setBookingId(bookingId);
                
                // Insert passengers
                for (Passenger passenger : passengers) {
                    sql = "INSERT INTO passengers (booking_id, first_name, last_name, email, " +
                          "phone, birthdate, passport_number, passport_expiry, nationality, gender) " +
                          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    
                    passengerStatement = connection.prepareStatement(sql);
                    passengerStatement.setInt(1, bookingId);
                    passengerStatement.setString(2, passenger.getFirstName());
                    passengerStatement.setString(3, passenger.getLastName());
                    passengerStatement.setString(4, passenger.getEmail());
                    passengerStatement.setString(5, passenger.getPhone());
                    passengerStatement.setDate(6, new java.sql.Date(passenger.getBirthdate().getTime()));
                    passengerStatement.setString(7, passenger.getPassportNumber());
                    passengerStatement.setDate(8, new java.sql.Date(passenger.getPassportExpiry().getTime()));
                    passengerStatement.setString(9, passenger.getNationality());
                    passengerStatement.setString(10, passenger.getGender());
                    
                    passengerStatement.executeUpdate();
                    DBUtil.closePreparedStatement(passengerStatement);
                    passengerStatement = null;
                }
                
                connection.commit();
                return booking;
            } else {
                connection.rollback();
                throw new SQLException("Creating booking failed, no ID obtained.");
            }
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            DBUtil.closeResultSet(generatedKeys);
            DBUtil.closePreparedStatement(bookingStatement);
            DBUtil.closePreparedStatement(passengerStatement);
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * Update booking status
     * @param bookingId Booking ID
     * @param newStatus New status
     * @return True if update successful
     */
    public boolean updateBookingStatus(int bookingId, String newStatus) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DBUtil.getConnection();
            String sql = "UPDATE bookings SET booking_status = ? WHERE booking_id = ?";
            
            statement = connection.prepareStatement(sql);
            statement.setString(1, newStatus);
            statement.setInt(2, bookingId);
            
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } finally {
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
    }
    
    /**
     * Get all passengers for a booking
     * @param bookingId Booking ID
     * @return List of passengers
     */
    public List<Passenger> getPassengersForBooking(int bookingId) throws SQLException {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<Passenger> passengers = new ArrayList<>();
        
        try {
            connection = DBUtil.getConnection();
            String sql = "SELECT * FROM passengers WHERE booking_id = ?";
            
            statement = connection.prepareStatement(sql);
            statement.setInt(1, bookingId);
            
            resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Passenger passenger = new Passenger();
                passenger.setPassengerId(resultSet.getInt("passenger_id"));
                passenger.setBookingId(resultSet.getInt("booking_id"));
                passenger.setFirstName(resultSet.getString("first_name"));
                passenger.setLastName(resultSet.getString("last_name"));
                passenger.setEmail(resultSet.getString("email"));
                passenger.setPhone(resultSet.getString("phone"));
                passenger.setBirthdate(resultSet.getDate("birthdate"));
                passenger.setPassportNumber(resultSet.getString("passport_number"));
                passenger.setPassportExpiry(resultSet.getDate("passport_expiry"));
                passenger.setNationality(resultSet.getString("nationality"));
                passenger.setGender(resultSet.getString("gender"));
                
                passengers.add(passenger);
            }
        } finally {
            DBUtil.closeResultSet(resultSet);
            DBUtil.closePreparedStatement(statement);
            DBUtil.closeConnection(connection);
        }
        
        return passengers;
    }
    
    /**
     * Extract booking information from a result set
     * @param rs The result set to extract data from
     * @return A Booking object with populated data
     */
    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setFlightId(rs.getInt("flight_id"));
        booking.setBookingReference(rs.getString("booking_reference"));
        booking.setBookingDate(rs.getTimestamp("booking_date"));
        booking.setTotalPassengers(rs.getInt("total_passengers"));
        booking.setTotalAmount(rs.getBigDecimal("total_amount"));
        booking.setClassId(rs.getInt("class_id"));
        booking.setBookingStatus(rs.getString("booking_status"));
        
        try {
            booking.setClassName(rs.getString("class_name"));
        } catch (SQLException e) {
            // Column might not exist, ignore
        }
        
        try {
            booking.setPassengerCount(rs.getInt("passenger_count"));
        } catch (SQLException e) {
            // Column might not exist, ignore
        }
        
        return booking;
    }
} 