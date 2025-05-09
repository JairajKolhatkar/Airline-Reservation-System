package com.airline.models;

import java.math.BigDecimal;

public class FlightPricing {
    private int pricingId;
    private int flightId;
    private int classId;
    private BigDecimal price;
    private int availableSeats;
    
    // Additional properties for display
    private String className;
    
    // Default constructor
    public FlightPricing() {
    }
    
    // Parameterized constructor
    public FlightPricing(int pricingId, int flightId, int classId, 
                        BigDecimal price, int availableSeats) {
        this.pricingId = pricingId;
        this.flightId = flightId;
        this.classId = classId;
        this.price = price;
        this.availableSeats = availableSeats;
    }
    
    // Getters and Setters
    public int getPricingId() {
        return pricingId;
    }
    
    public void setPricingId(int pricingId) {
        this.pricingId = pricingId;
    }
    
    public int getFlightId() {
        return flightId;
    }
    
    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }
    
    public int getClassId() {
        return classId;
    }
    
    public void setClassId(int classId) {
        this.classId = classId;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public int getAvailableSeats() {
        return availableSeats;
    }
    
    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }
    
    public String getClassName() {
        return className;
    }
    
    public void setClassName(String className) {
        this.className = className;
    }
    
    @Override
    public String toString() {
        return "FlightPricing{" +
                "pricingId=" + pricingId +
                ", flightId=" + flightId +
                ", classId=" + classId +
                ", price=" + price +
                ", availableSeats=" + availableSeats +
                ", className='" + className + '\'' +
                '}';
    }
} 