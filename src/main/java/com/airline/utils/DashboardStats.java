package com.airline.utils;

/**
 * Utility class to hold dashboard statistics 
 */
public class DashboardStats {
    private int totalBookings;
    private int todayBookings;
    private int activeFlights;
    private int registeredUsers;
    
    public DashboardStats() {
        // Default constructor
    }

    public int getTotalBookings() {
        return totalBookings;
    }

    public void setTotalBookings(int totalBookings) {
        this.totalBookings = totalBookings;
    }

    public int getTodayBookings() {
        return todayBookings;
    }

    public void setTodayBookings(int todayBookings) {
        this.todayBookings = todayBookings;
    }

    public int getActiveFlights() {
        return activeFlights;
    }

    public void setActiveFlights(int activeFlights) {
        this.activeFlights = activeFlights;
    }

    public int getRegisteredUsers() {
        return registeredUsers;
    }

    public void setRegisteredUsers(int registeredUsers) {
        this.registeredUsers = registeredUsers;
    }
} 