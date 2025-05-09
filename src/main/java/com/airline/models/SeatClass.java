package com.airline.models;

import java.math.BigDecimal;

/**
 * Model class representing seat classes (Economy, Business, First Class)
 */
public class SeatClass {
    private int classId;
    private String className;
    private BigDecimal basePrice;
    private int availableSeats;
    
    // Default constructor
    public SeatClass() {
    }
    
    // Parameterized constructor
    public SeatClass(int classId, String className) {
        this.classId = classId;
        this.className = className;
    }
    
    // Full constructor
    public SeatClass(int classId, String className, BigDecimal basePrice, int availableSeats) {
        this.classId = classId;
        this.className = className;
        this.basePrice = basePrice;
        this.availableSeats = availableSeats;
    }
    
    // Getters and Setters
    public int getClassId() {
        return classId;
    }
    
    public void setClassId(int classId) {
        this.classId = classId;
    }
    
    public String getClassName() {
        return className;
    }
    
    public void setClassName(String className) {
        this.className = className;
    }
    
    public BigDecimal getBasePrice() {
        return basePrice;
    }
    
    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }
    
    public int getAvailableSeats() {
        return availableSeats;
    }
    
    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }
    
    @Override
    public String toString() {
        return "SeatClass{" +
                "classId=" + classId +
                ", className='" + className + '\'' +
                ", basePrice=" + basePrice +
                ", availableSeats=" + availableSeats +
                '}';
    }
} 