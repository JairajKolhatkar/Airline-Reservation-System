-- Drop database if exists
DROP DATABASE IF EXISTS airline_reservation;

-- Create database
CREATE DATABASE airline_reservation;

-- Use the database
USE airline_reservation;

-- User roles table
CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(20) NOT NULL UNIQUE
);

-- Insert basic roles
INSERT INTO roles (role_name) VALUES ('user'), ('admin');

-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    country VARCHAR(50),
    date_of_birth DATE,
    role_id INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Insert admin user (password: admin123)
INSERT INTO users (first_name, last_name, email, password, role_id) 
VALUES ('Admin', 'User', 'admin@airline.com', 'admin123', 2);

-- Airports table
CREATE TABLE airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_code VARCHAR(3) NOT NULL UNIQUE,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8)
);

-- Insert some sample airports
INSERT INTO airports (airport_code, airport_name, city, country) VALUES 
('JFK', 'John F. Kennedy International Airport', 'New York', 'USA'),
('LAX', 'Los Angeles International Airport', 'Los Angeles', 'USA'),
('ORD', 'Chicago O\'Hare International Airport', 'Chicago', 'USA'),
('ATL', 'Hartsfield-Jackson Atlanta International Airport', 'Atlanta', 'USA'),
('LHR', 'London Heathrow Airport', 'London', 'United Kingdom'),
('CDG', 'Charles de Gaulle Airport', 'Paris', 'France'),
('DXB', 'Dubai International Airport', 'Dubai', 'United Arab Emirates'),
('SIN', 'Singapore Changi Airport', 'Singapore', 'Singapore'),
('HND', 'Tokyo Haneda Airport', 'Tokyo', 'Japan'),
('DEL', 'Indira Gandhi International Airport', 'Delhi', 'India');

-- Airlines table
CREATE TABLE airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_name VARCHAR(100) NOT NULL,
    airline_code VARCHAR(3) NOT NULL UNIQUE,
    country VARCHAR(50) NOT NULL,
    logo_url VARCHAR(255)
);

-- Insert sample airlines
INSERT INTO airlines (airline_name, airline_code, country) VALUES 
('American Airlines', 'AAL', 'USA'),
('Delta Air Lines', 'DAL', 'USA'),
('United Airlines', 'UAL', 'USA'),
('British Airways', 'BAW', 'United Kingdom'),
('Air France', 'AFR', 'France'),
('Emirates', 'UAE', 'United Arab Emirates'),
('Singapore Airlines', 'SIA', 'Singapore'),
('Lufthansa', 'DLH', 'Germany'),
('Japan Airlines', 'JAL', 'Japan'),
('Air India', 'AIC', 'India');

-- Aircraft table
CREATE TABLE aircraft (
    aircraft_id INT PRIMARY KEY AUTO_INCREMENT,
    aircraft_name VARCHAR(100) NOT NULL,
    model VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL,
    economy_seats INT NOT NULL,
    business_seats INT NOT NULL,
    first_class_seats INT NOT NULL
);

-- Insert sample aircraft
INSERT INTO aircraft (aircraft_name, model, total_seats, economy_seats, business_seats, first_class_seats) VALUES 
('Boeing 747', '747-400', 416, 316, 80, 20),
('Boeing 777', '777-300ER', 368, 268, 80, 20),
('Airbus A380', 'A380-800', 525, 425, 80, 20),
('Boeing 787', '787-9', 290, 220, 60, 10),
('Airbus A350', 'A350-900', 325, 250, 65, 10);

-- Flight categories
CREATE TABLE flight_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- Insert flight categories
INSERT INTO flight_categories (category_name) VALUES 
('Domestic'), ('International');

-- Seat classes
CREATE TABLE seat_classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(20) NOT NULL UNIQUE
);

-- Insert seat classes
INSERT INTO seat_classes (class_name) VALUES 
('Economy'), ('Business'), ('First Class');

-- Flights table
CREATE TABLE flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10) NOT NULL,
    airline_id INT NOT NULL,
    origin_airport_id INT NOT NULL,
    destination_airport_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    aircraft_id INT NOT NULL,
    category_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (airline_id) REFERENCES airlines(airline_id),
    FOREIGN KEY (origin_airport_id) REFERENCES airports(airport_id),
    FOREIGN KEY (destination_airport_id) REFERENCES airports(airport_id),
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(aircraft_id),
    FOREIGN KEY (category_id) REFERENCES flight_categories(category_id)
);

-- Pricing for each flight and seat class
CREATE TABLE flight_pricing (
    pricing_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    class_id INT NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    tax_amount DECIMAL(10, 2) NOT NULL,
    available_seats INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    FOREIGN KEY (class_id) REFERENCES seat_classes(class_id),
    UNIQUE KEY (flight_id, class_id)
);

-- Bookings table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_reference VARCHAR(10) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    flight_id INT NOT NULL,
    class_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id),
    FOREIGN KEY (class_id) REFERENCES seat_classes(class_id)
);

-- Passengers table
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    passport_number VARCHAR(20),
    seat_number VARCHAR(5),
    special_requirements TEXT,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Payments table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Completed',
    transaction_id VARCHAR(100),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Insert sample flights
-- Let's add 10 flights between different airports with different airlines
INSERT INTO flights (flight_number, airline_id, origin_airport_id, destination_airport_id, departure_time, arrival_time, aircraft_id, category_id) VALUES
('AA100', 1, 1, 2, '2025-06-01 08:00:00', '2025-06-01 11:30:00', 1, 1),
('DL200', 2, 2, 3, '2025-06-01 09:15:00', '2025-06-01 12:45:00', 2, 1),
('UA300', 3, 3, 4, '2025-06-01 10:30:00', '2025-06-01 13:00:00', 3, 1),
('BA400', 4, 5, 1, '2025-06-01 18:00:00', '2025-06-02 06:30:00', 4, 2),
('AF500', 5, 6, 5, '2025-06-01 20:15:00', '2025-06-02 07:45:00', 5, 2),
('EK600', 6, 7, 8, '2025-06-01 22:30:00', '2025-06-02 10:30:00', 1, 2),
('SQ700', 7, 8, 9, '2025-06-02 01:45:00', '2025-06-02 09:15:00', 2, 2),
('LH800', 8, 5, 6, '2025-06-02 07:00:00', '2025-06-02 09:00:00', 3, 2),
('JL900', 9, 9, 7, '2025-06-02 14:15:00', '2025-06-02 23:45:00', 4, 2),
('AI1000', 10, 10, 8, '2025-06-02 16:30:00', '2025-06-03 02:00:00', 5, 2);

-- Insert flight pricing
-- For each flight, add pricing for each seat class
-- Flight 1 (AA100) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(1, 1, 200.00, 20.00, 316), -- Economy
(1, 2, 500.00, 50.00, 80),  -- Business
(1, 3, 900.00, 90.00, 20);  -- First Class

-- Flight 2 (DL200) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(2, 1, 220.00, 22.00, 268), -- Economy
(2, 2, 550.00, 55.00, 80),  -- Business
(2, 3, 950.00, 95.00, 20);  -- First Class

-- Flight 3 (UA300) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(3, 1, 240.00, 24.00, 425), -- Economy
(3, 2, 600.00, 60.00, 80),  -- Business
(3, 3, 1000.00, 100.00, 20); -- First Class

-- Flight 4 (BA400) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(4, 1, 600.00, 60.00, 220), -- Economy
(4, 2, 1200.00, 120.00, 60), -- Business
(4, 3, 2000.00, 200.00, 10); -- First Class

-- Flight 5 (AF500) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(5, 1, 550.00, 55.00, 250), -- Economy
(5, 2, 1150.00, 115.00, 65), -- Business
(5, 3, 1950.00, 195.00, 10); -- First Class

-- Flight 6 (EK600) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(6, 1, 800.00, 80.00, 316), -- Economy
(6, 2, 1600.00, 160.00, 80), -- Business
(6, 3, 2800.00, 280.00, 20); -- First Class

-- Flight 7 (SQ700) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(7, 1, 750.00, 75.00, 268), -- Economy
(7, 2, 1550.00, 155.00, 80), -- Business
(7, 3, 2700.00, 270.00, 20); -- First Class

-- Flight 8 (LH800) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(8, 1, 400.00, 40.00, 425), -- Economy
(8, 2, 800.00, 80.00, 80),  -- Business
(8, 3, 1400.00, 140.00, 20); -- First Class

-- Flight 9 (JL900) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(9, 1, 850.00, 85.00, 220), -- Economy
(9, 2, 1750.00, 175.00, 60), -- Business
(9, 3, 3000.00, 300.00, 10); -- First Class

-- Flight 10 (AI1000) Pricing
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(10, 1, 700.00, 70.00, 250), -- Economy
(10, 2, 1400.00, 140.00, 65), -- Business
(10, 3, 2500.00, 250.00, 10); -- First Class 