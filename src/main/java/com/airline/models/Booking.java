package com.airline.models;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Booking {
    private int bookingId;
    private String bookingReference;
    private int userId;
    private int flightId;
    private Timestamp bookingDate;
    private int classId;
    private int totalPassengers;
    private BigDecimal totalAmount;
    private String bookingStatus;
    private int passengerCount;
    
    // For backward compatibility
    private User user;
    private Flight flight;
    private SeatClass seatClass;
    private String className;
    
    // Default constructor
    public Booking() {
    }
    
    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }
    
    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }
    
    public String getBookingReference() {
        return bookingReference;
    }
    
    public void setBookingReference(String bookingReference) {
        this.bookingReference = bookingReference;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getFlightId() {
        return flightId;
    }
    
    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }
    
    public Timestamp getBookingDate() {
        return bookingDate;
    }
    
    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }
    
    public int getClassId() {
        return classId;
    }
    
    public void setClassId(int classId) {
        this.classId = classId;
    }
    
    public int getTotalPassengers() {
        return totalPassengers;
    }
    
    public void setTotalPassengers(int totalPassengers) {
        this.totalPassengers = totalPassengers;
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getBookingStatus() {
        return bookingStatus;
    }
    
    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
    
    public int getPassengerCount() {
        return passengerCount;
    }
    
    public void setPassengerCount(int passengerCount) {
        this.passengerCount = passengerCount;
    }
    
    public String getClassName() {
        return className;
    }
    
    public void setClassName(String className) {
        this.className = className;
    }
    
    // Legacy getters and setters for backward compatibility
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
        if (user != null) {
            this.userId = user.getUserId();
        }
    }
    
    public Flight getFlight() {
        return flight;
    }
    
    public void setFlight(Flight flight) {
        this.flight = flight;
        if (flight != null) {
            this.flightId = flight.getFlightId();
        }
    }
    
    public SeatClass getSeatClass() {
        return seatClass;
    }
    
    public void setSeatClass(SeatClass seatClass) {
        this.seatClass = seatClass;
        if (seatClass != null) {
            this.classId = seatClass.getClassId();
            this.className = seatClass.getClassName();
        }
    }
    
    public String getStatus() {
        return bookingStatus;
    }
    
    public void setStatus(String status) {
        this.bookingStatus = status;
    }
    
    @Override
    public String toString() {
        return "Booking{" +
                "bookingId=" + bookingId +
                ", bookingReference='" + bookingReference + '\'' +
                ", userId=" + userId +
                ", flightId=" + flightId +
                ", bookingDate=" + bookingDate +
                ", status='" + bookingStatus + '\'' +
                ", totalAmount=" + totalAmount +
                ", passengerCount=" + passengerCount +
                '}';
    }
} 