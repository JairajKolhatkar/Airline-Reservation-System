-- Airline Reservation System Database Schema

CREATE DATABASE IF NOT EXISTS airline_reservation;
USE airline_reservation;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Airport Table
CREATE TABLE airports (
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_code VARCHAR(10) NOT NULL UNIQUE,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    is_international BOOLEAN DEFAULT TRUE
);

-- Airlines Table
CREATE TABLE airlines (
    airline_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL,
    airline_code VARCHAR(5) NOT NULL UNIQUE
);

-- Flight Categories
CREATE TABLE flight_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(20) NOT NULL -- Domestic, International
);

-- Seat Classes
CREATE TABLE seat_classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(20) NOT NULL -- Economy, Business, First
);

-- Flights Table
CREATE TABLE flights (
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_number VARCHAR(20) NOT NULL,
    airline_id INT NOT NULL,
    origin_airport_id INT NOT NULL,
    destination_airport_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    category_id INT NOT NULL,
    total_seats INT NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),
    FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id),
    FOREIGN KEY (category_id) REFERENCES flight_categories(category_id)
);

-- Flight Seat Pricing
CREATE TABLE flight_pricing (
    pricing_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT NOT NULL,
    class_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    available_seats INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    FOREIGN KEY (class_id) REFERENCES seat_classes(class_id)
);

-- Bookings Table
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_passengers INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    booking_status VARCHAR(20) DEFAULT 'CONFIRMED', -- CONFIRMED, CANCELLED, COMPLETED
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id)
);

-- Passenger Details
CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    age INT,
    seat_number VARCHAR(10),
    class_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (class_id) REFERENCES seat_classes(class_id)
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'COMPLETED',
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Insert sample data for seat classes
INSERT INTO seat_classes (class_name) VALUES 
('Economy'),
('Business'),
('First');

-- Insert sample data for flight categories
INSERT INTO flight_categories (category_name) VALUES 
('Domestic'),
('International');

-- Insert sample airlines
INSERT INTO airlines (airline_name, airline_code) VALUES 
('Air India', 'AI'),
('IndiGo', '6E'),
('SpiceJet', 'SG'),
('Emirates', 'EK'),
('Singapore Airlines', 'SQ');

-- Insert sample airports
INSERT INTO airports (airport_code, airport_name, city, country, is_international) VALUES 
('DEL', 'Indira Gandhi International Airport', 'Delhi', 'India', TRUE),
('BOM', 'Chhatrapati Shivaji International Airport', 'Mumbai', 'India', TRUE),
('MAA', 'Chennai International Airport', 'Chennai', 'India', TRUE),
('CCU', 'Netaji Subhas Chandra Bose International Airport', 'Kolkata', 'India', TRUE),
('BLR', 'Kempegowda International Airport', 'Bengaluru', 'India', TRUE),
('HYD', 'Rajiv Gandhi International Airport', 'Hyderabad', 'India', TRUE),
('DXB', 'Dubai International Airport', 'Dubai', 'UAE', TRUE),
('JFK', 'John F. Kennedy International Airport', 'New York', 'USA', TRUE),
('LHR', 'London Heathrow Airport', 'London', 'UK', TRUE),
('SIN', 'Singapore Changi Airport', 'Singapore', 'Singapore', TRUE);

-- Insert sample admin user
INSERT INTO users (username, password, email, first_name, last_name, phone, is_admin) 
VALUES ('admin', 'admin123', 'admin@airline.com', 'Admin', 'User', '9876543210', TRUE); 