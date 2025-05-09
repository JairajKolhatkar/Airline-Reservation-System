package com.airline.models;

public class Airport {
    private int airportId;
    private String airportCode;
    private String airportName;
    private String city;
    private String country;
    private boolean isInternational;
    
    // Default constructor
    public Airport() {
    }
    
    // Parameterized constructor
    public Airport(int airportId, String airportCode, String airportName, String city, 
                  String country, boolean isInternational) {
        this.airportId = airportId;
        this.airportCode = airportCode;
        this.airportName = airportName;
        this.city = city;
        this.country = country;
        this.isInternational = isInternational;
    }
    
    // Getters and Setters
    public int getAirportId() {
        return airportId;
    }
    
    public void setAirportId(int airportId) {
        this.airportId = airportId;
    }
    
    public String getAirportCode() {
        return airportCode;
    }
    
    public void setAirportCode(String airportCode) {
        this.airportCode = airportCode;
    }
    
    public String getAirportName() {
        return airportName;
    }
    
    public void setAirportName(String airportName) {
        this.airportName = airportName;
    }
    
    public String getCity() {
        return city;
    }
    
    public void setCity(String city) {
        this.city = city;
    }
    
    public String getCountry() {
        return country;
    }
    
    public void setCountry(String country) {
        this.country = country;
    }
    
    public boolean isInternational() {
        return isInternational;
    }
    
    public void setInternational(boolean isInternational) {
        this.isInternational = isInternational;
    }
    
    @Override
    public String toString() {
        return "Airport{" +
                "airportId=" + airportId +
                ", airportCode='" + airportCode + '\'' +
                ", airportName='" + airportName + '\'' +
                ", city='" + city + '\'' +
                ", country='" + country + '\'' +
                ", isInternational=" + isInternational +
                '}';
    }
} 