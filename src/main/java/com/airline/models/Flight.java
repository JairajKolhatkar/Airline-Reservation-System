package com.airline.models;

import java.sql.Timestamp;
import java.util.Date;

public class Flight {
    private int flightId;
    private String flightNumber;
    private int airlineId;
    private int originAirportId;
    private int destinationAirportId;
    private Timestamp departureTime;
    private Timestamp arrivalTime;
    private int categoryId;
    private int totalSeats;
    
    // Additional properties for display purposes
    private String airlineName;
    private String airlineCode;
    private String originAirportCode;
    private String originCity;
    private String destinationAirportCode;
    private String destinationCity;
    private String categoryName;
    
    // Default constructor
    public Flight() {
    }
    
    // Parameterized constructor
    public Flight(int flightId, String flightNumber, int airlineId, int originAirportId, 
                int destinationAirportId, Timestamp departureTime, 
                Timestamp arrivalTime, int categoryId, int totalSeats) {
        this.flightId = flightId;
        this.flightNumber = flightNumber;
        this.airlineId = airlineId;
        this.originAirportId = originAirportId;
        this.destinationAirportId = destinationAirportId;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.categoryId = categoryId;
        this.totalSeats = totalSeats;
    }
    
    // Getters and Setters
    public int getFlightId() {
        return flightId;
    }
    
    public void setFlightId(int flightId) {
        this.flightId = flightId;
    }
    
    public String getFlightNumber() {
        return flightNumber;
    }
    
    public void setFlightNumber(String flightNumber) {
        this.flightNumber = flightNumber;
    }
    
    public int getAirlineId() {
        return airlineId;
    }
    
    public void setAirlineId(int airlineId) {
        this.airlineId = airlineId;
    }
    
    public int getOriginAirportId() {
        return originAirportId;
    }
    
    public void setOriginAirportId(int originAirportId) {
        this.originAirportId = originAirportId;
    }
    
    public int getDestinationAirportId() {
        return destinationAirportId;
    }
    
    public void setDestinationAirportId(int destinationAirportId) {
        this.destinationAirportId = destinationAirportId;
    }
    
    public Timestamp getDepartureTime() {
        return departureTime;
    }
    
    public void setDepartureTime(Timestamp departureTime) {
        this.departureTime = departureTime;
    }
    
    public Timestamp getArrivalTime() {
        return arrivalTime;
    }
    
    public void setArrivalTime(Timestamp arrivalTime) {
        this.arrivalTime = arrivalTime;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public int getTotalSeats() {
        return totalSeats;
    }
    
    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
    }
    
    public String getAirlineName() {
        return airlineName;
    }

    public void setAirlineName(String airlineName) {
        this.airlineName = airlineName;
    }

    public String getAirlineCode() {
        return airlineCode;
    }

    public void setAirlineCode(String airlineCode) {
        this.airlineCode = airlineCode;
    }

    public String getOriginAirportCode() {
        return originAirportCode;
    }

    public void setOriginAirportCode(String originAirportCode) {
        this.originAirportCode = originAirportCode;
    }

    public String getOriginCity() {
        return originCity;
    }

    public void setOriginCity(String originCity) {
        this.originCity = originCity;
    }

    public String getDestinationAirportCode() {
        return destinationAirportCode;
    }

    public void setDestinationAirportCode(String destinationAirportCode) {
        this.destinationAirportCode = destinationAirportCode;
    }

    public String getDestinationCity() {
        return destinationCity;
    }

    public void setDestinationCity(String destinationCity) {
        this.destinationCity = destinationCity;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    // Method to calculate flight duration in minutes
    public long getFlightDurationMinutes() {
        if (departureTime != null && arrivalTime != null) {
            long diffInMillies = arrivalTime.getTime() - departureTime.getTime();
            return diffInMillies / (60 * 1000);
        }
        return 0;
    }
    
    // Method to get formatted flight duration (e.g., "2h 30m")
    public String getFormattedFlightDuration() {
        long minutes = getFlightDurationMinutes();
        long hours = minutes / 60;
        long remainingMinutes = minutes % 60;
        return hours + "h " + remainingMinutes + "m";
    }
    
    @Override
    public String toString() {
        return "Flight{" +
                "flightId=" + flightId +
                ", flightNumber='" + flightNumber + '\'' +
                ", airlineId=" + airlineId +
                ", originAirportId=" + originAirportId +
                ", destinationAirportId=" + destinationAirportId +
                ", departureTime=" + departureTime +
                ", arrivalTime=" + arrivalTime +
                ", categoryId=" + categoryId +
                ", totalSeats=" + totalSeats +
                '}';
    }
} 