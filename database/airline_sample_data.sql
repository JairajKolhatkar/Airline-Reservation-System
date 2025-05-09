-- Airline Reservation System Sample Data
-- This script populates the database with sample data for testing

USE airline_reservation;

-- Clear existing data while keeping the schema
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE payments;
TRUNCATE TABLE passengers;
TRUNCATE TABLE bookings;
TRUNCATE TABLE flight_pricing;
TRUNCATE TABLE flights;
TRUNCATE TABLE aircraft;
TRUNCATE TABLE seat_classes;
TRUNCATE TABLE flight_categories;
TRUNCATE TABLE airlines;
TRUNCATE TABLE airports;
TRUNCATE TABLE users;
TRUNCATE TABLE roles;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert roles
INSERT INTO roles (role_name) VALUES ('user'), ('admin');

-- Insert users
-- Admin user (password: admin123)
INSERT INTO users (first_name, last_name, email, password, phone, role_id) 
VALUES ('Admin', 'User', 'admin@airline.com', 'admin123', '9876543210', 2);

-- Regular users (password: password)
INSERT INTO users (first_name, last_name, email, password, phone, role_id) 
VALUES 
('John', 'Doe', 'john@example.com', 'password', '1234567890', 1),
('Jane', 'Smith', 'jane@example.com', 'password', '2345678901', 1),
('Robert', 'Johnson', 'robert@example.com', 'password', '3456789012', 1),
('Emily', 'Davis', 'emily@example.com', 'password', '4567890123', 1),
('Michael', 'Wilson', 'michael@example.com', 'password', '5678901234', 1);

-- Insert airports
INSERT INTO airports (airport_code, airport_name, city, country, latitude, longitude) VALUES 
('JFK', 'John F. Kennedy International Airport', 'New York', 'USA', 40.6413, -73.7781),
('LAX', 'Los Angeles International Airport', 'Los Angeles', 'USA', 33.9416, -118.4085),
('ORD', 'Chicago O\'Hare International Airport', 'Chicago', 'USA', 41.9742, -87.9073),
('ATL', 'Hartsfield-Jackson Atlanta International Airport', 'Atlanta', 'USA', 33.6407, -84.4277),
('LHR', 'London Heathrow Airport', 'London', 'United Kingdom', 51.4700, -0.4543),
('CDG', 'Charles de Gaulle Airport', 'Paris', 'France', 49.0097, 2.5479),
('DXB', 'Dubai International Airport', 'Dubai', 'United Arab Emirates', 25.2532, 55.3657),
('SIN', 'Singapore Changi Airport', 'Singapore', 'Singapore', 1.3644, 103.9915),
('HND', 'Tokyo Haneda Airport', 'Tokyo', 'Japan', 35.5494, 139.7798),
('DEL', 'Indira Gandhi International Airport', 'Delhi', 'India', 28.5562, 77.1000),
('BOM', 'Chhatrapati Shivaji International Airport', 'Mumbai', 'India', 19.0896, 72.8656),
('SYD', 'Sydney Kingsford Smith Airport', 'Sydney', 'Australia', -33.9399, 151.1753),
('GRU', 'São Paulo International Airport', 'São Paulo', 'Brazil', -23.4356, -46.4731),
('MEX', 'Mexico City International Airport', 'Mexico City', 'Mexico', 19.4361, -99.0719),
('YYZ', 'Toronto Pearson International Airport', 'Toronto', 'Canada', 43.6777, -79.6248);

-- Insert airlines
INSERT INTO airlines (airline_name, airline_code, country, logo_url) VALUES 
('American Airlines', 'AAL', 'USA', '/assets/images/airlines/american.png'),
('Delta Air Lines', 'DAL', 'USA', '/assets/images/airlines/delta.png'),
('United Airlines', 'UAL', 'USA', '/assets/images/airlines/united.png'),
('British Airways', 'BAW', 'United Kingdom', '/assets/images/airlines/british.png'),
('Air France', 'AFR', 'France', '/assets/images/airlines/airfrance.png'),
('Emirates', 'UAE', 'United Arab Emirates', '/assets/images/airlines/emirates.png'),
('Singapore Airlines', 'SIA', 'Singapore', '/assets/images/airlines/singapore.png'),
('Lufthansa', 'DLH', 'Germany', '/assets/images/airlines/lufthansa.png'),
('Japan Airlines', 'JAL', 'Japan', '/assets/images/airlines/japan.png'),
('Air India', 'AIC', 'India', '/assets/images/airlines/airindia.png'),
('Qantas', 'QFA', 'Australia', '/assets/images/airlines/qantas.png'),
('Air Canada', 'ACA', 'Canada', '/assets/images/airlines/aircanada.png');

-- Insert aircraft
INSERT INTO aircraft (aircraft_name, model, total_seats, economy_seats, business_seats, first_class_seats) VALUES 
('Boeing 747', '747-400', 416, 316, 80, 20),
('Boeing 777', '777-300ER', 368, 268, 80, 20),
('Airbus A380', 'A380-800', 525, 425, 80, 20),
('Boeing 787', '787-9', 290, 220, 60, 10),
('Airbus A350', 'A350-900', 325, 250, 65, 10),
('Boeing 737', '737-800', 180, 150, 30, 0),
('Airbus A320', 'A320neo', 186, 156, 30, 0),
('Bombardier CRJ', 'CRJ-900', 90, 75, 15, 0);

-- Insert flight categories
INSERT INTO flight_categories (category_name) VALUES 
('Domestic'), ('International');

-- Insert seat classes
INSERT INTO seat_classes (class_name) VALUES 
('Economy'), ('Business'), ('First Class');

-- Generate flights for the next 30 days
-- Create a set of sample flights with appropriate departure/arrival times

-- Domestic US Flights
INSERT INTO flights (flight_number, airline_id, origin_airport_id, destination_airport_id, departure_time, arrival_time, aircraft_id, category_id, status) VALUES
-- New York (JFK) to Los Angeles (LAX)
('AA100', 1, 1, 2, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '08:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '11:30' HOUR_MINUTE, 4, 1, 'Scheduled'),
('AA101', 1, 1, 2, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '08:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '11:30' HOUR_MINUTE, 4, 1, 'Scheduled'),
('UA500', 3, 1, 2, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '10:15' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '13:45' HOUR_MINUTE, 6, 1, 'Scheduled'),
('UA501', 3, 1, 2, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '10:15' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '13:45' HOUR_MINUTE, 6, 1, 'Scheduled'),

-- Los Angeles (LAX) to New York (JFK)
('AA102', 1, 2, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '14:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '22:30' HOUR_MINUTE, 4, 1, 'Scheduled'),
('AA103', 1, 2, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '14:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '22:30' HOUR_MINUTE, 4, 1, 'Scheduled'),
('UA502', 3, 2, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '16:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '01:00' HOUR_MINUTE, 6, 1, 'Scheduled'),
('UA503', 3, 2, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '16:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY) + INTERVAL '01:00' HOUR_MINUTE, 6, 1, 'Scheduled'),

-- Chicago (ORD) to Atlanta (ATL)
('DL200', 2, 3, 4, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '09:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '11:30' HOUR_MINUTE, 7, 1, 'Scheduled'),
('DL201', 2, 3, 4, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '09:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '11:30' HOUR_MINUTE, 7, 1, 'Scheduled'),

-- Atlanta (ATL) to Chicago (ORD)
('DL202', 2, 4, 3, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '13:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '15:30' HOUR_MINUTE, 7, 1, 'Scheduled'),
('DL203', 2, 4, 3, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '13:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '15:30' HOUR_MINUTE, 7, 1, 'Scheduled');

-- International Flights
INSERT INTO flights (flight_number, airline_id, origin_airport_id, destination_airport_id, departure_time, arrival_time, aircraft_id, category_id, status) VALUES
-- New York (JFK) to London (LHR)
('BA100', 4, 1, 5, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '19:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '07:45' HOUR_MINUTE, 2, 2, 'Scheduled'),
('BA101', 4, 1, 5, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '19:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY) + INTERVAL '07:45' HOUR_MINUTE, 2, 2, 'Scheduled'),
('AA300', 1, 1, 5, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '21:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '09:15' HOUR_MINUTE, 3, 2, 'Scheduled'),
('AA301', 1, 1, 5, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '21:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY) + INTERVAL '09:15' HOUR_MINUTE, 3, 2, 'Scheduled'),

-- London (LHR) to New York (JFK)
('BA102', 4, 5, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '10:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '13:15' HOUR_MINUTE, 2, 2, 'Scheduled'),
('BA103', 4, 5, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '10:00' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '13:15' HOUR_MINUTE, 2, 2, 'Scheduled'),
('AA302', 1, 5, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '12:45' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '16:00' HOUR_MINUTE, 3, 2, 'Scheduled'),
('AA303', 1, 5, 1, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '12:45' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '16:00' HOUR_MINUTE, 3, 2, 'Scheduled'),

-- Dubai (DXB) to Singapore (SIN)
('EK400', 6, 7, 8, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '01:45' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '13:15' HOUR_MINUTE, 3, 2, 'Scheduled'),
('EK401', 6, 7, 8, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '01:45' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '13:15' HOUR_MINUTE, 3, 2, 'Scheduled'),

-- Singapore (SIN) to Dubai (DXB)
('EK402', 6, 8, 7, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '20:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '00:15' HOUR_MINUTE, 3, 2, 'Scheduled'),
('EK403', 6, 8, 7, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '20:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY) + INTERVAL '00:15' HOUR_MINUTE, 3, 2, 'Scheduled'),

-- Tokyo (HND) to Delhi (DEL)
('AI500', 10, 9, 10, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '10:15' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '16:45' HOUR_MINUTE, 2, 2, 'Scheduled'),
('AI501', 10, 9, 10, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '10:15' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '16:45' HOUR_MINUTE, 2, 2, 'Scheduled'),

-- Delhi (DEL) to Tokyo (HND)
('AI502', 10, 10, 9, DATE_ADD(CURRENT_DATE(), INTERVAL 1 DAY) + INTERVAL '23:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '10:00' HOUR_MINUTE, 2, 2, 'Scheduled'),
('AI503', 10, 10, 9, DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY) + INTERVAL '23:30' HOUR_MINUTE, DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY) + INTERVAL '10:00' HOUR_MINUTE, 2, 2, 'Scheduled');

-- Flight pricing
-- Set pricing for all the flights

-- Domestic flights pricing (generally cheaper)
-- AA100, AA101 (JFK-LAX) Boeing 787
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(1, 1, 250.00, 25.00, 220), -- Economy
(1, 2, 650.00, 65.00, 60),  -- Business
(1, 3, 1100.00, 110.00, 10), -- First Class
(2, 1, 250.00, 25.00, 220), -- Economy
(2, 2, 650.00, 65.00, 60),  -- Business
(2, 3, 1100.00, 110.00, 10); -- First Class

-- UA500, UA501 (JFK-LAX) Boeing 737
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(3, 1, 230.00, 23.00, 150), -- Economy
(3, 2, 600.00, 60.00, 30),  -- Business
(4, 1, 230.00, 23.00, 150), -- Economy
(4, 2, 600.00, 60.00, 30);  -- Business

-- AA102, AA103 (LAX-JFK) Boeing 787
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(5, 1, 270.00, 27.00, 220), -- Economy
(5, 2, 680.00, 68.00, 60),  -- Business
(5, 3, 1150.00, 115.00, 10), -- First Class
(6, 1, 270.00, 27.00, 220), -- Economy
(6, 2, 680.00, 68.00, 60),  -- Business
(6, 3, 1150.00, 115.00, 10); -- First Class

-- UA502, UA503 (LAX-JFK) Boeing 737
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(7, 1, 250.00, 25.00, 150), -- Economy
(7, 2, 650.00, 65.00, 30),  -- Business
(8, 1, 250.00, 25.00, 150), -- Economy
(8, 2, 650.00, 65.00, 30);  -- Business

-- DL200, DL201 (ORD-ATL) Airbus A320
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(9, 1, 180.00, 18.00, 156), -- Economy
(9, 2, 450.00, 45.00, 30),  -- Business
(10, 1, 180.00, 18.00, 156), -- Economy
(10, 2, 450.00, 45.00, 30);  -- Business

-- DL202, DL203 (ATL-ORD) Airbus A320
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(11, 1, 190.00, 19.00, 156), -- Economy
(11, 2, 470.00, 47.00, 30),  -- Business
(12, 1, 190.00, 19.00, 156), -- Economy
(12, 2, 470.00, 47.00, 30);  -- Business

-- International flights pricing (generally more expensive)
-- BA100, BA101 (JFK-LHR) Boeing 777
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(13, 1, 650.00, 65.00, 268), -- Economy
(13, 2, 1800.00, 180.00, 80),  -- Business
(13, 3, 3500.00, 350.00, 20), -- First Class
(14, 1, 650.00, 65.00, 268), -- Economy
(14, 2, 1800.00, 180.00, 80),  -- Business
(14, 3, 3500.00, 350.00, 20); -- First Class

-- AA300, AA301 (JFK-LHR) Airbus A380
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(15, 1, 620.00, 62.00, 425), -- Economy
(15, 2, 1750.00, 175.00, 80),  -- Business
(15, 3, 3300.00, 330.00, 20), -- First Class
(16, 1, 620.00, 62.00, 425), -- Economy
(16, 2, 1750.00, 175.00, 80),  -- Business
(16, 3, 3300.00, 330.00, 20); -- First Class

-- BA102, BA103 (LHR-JFK) Boeing 777
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(17, 1, 680.00, 68.00, 268), -- Economy
(17, 2, 1850.00, 185.00, 80),  -- Business
(17, 3, 3600.00, 360.00, 20), -- First Class
(18, 1, 680.00, 68.00, 268), -- Economy
(18, 2, 1850.00, 185.00, 80),  -- Business
(18, 3, 3600.00, 360.00, 20); -- First Class

-- AA302, AA303 (LHR-JFK) Airbus A380
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(19, 1, 650.00, 65.00, 425), -- Economy
(19, 2, 1800.00, 180.00, 80),  -- Business
(19, 3, 3500.00, 350.00, 20), -- First Class
(20, 1, 650.00, 65.00, 425), -- Economy
(20, 2, 1800.00, 180.00, 80),  -- Business
(20, 3, 3500.00, 350.00, 20); -- First Class

-- EK400, EK401 (DXB-SIN) Airbus A380
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(21, 1, 750.00, 75.00, 425), -- Economy
(21, 2, 2100.00, 210.00, 80),  -- Business
(21, 3, 4000.00, 400.00, 20), -- First Class
(22, 1, 750.00, 75.00, 425), -- Economy
(22, 2, 2100.00, 210.00, 80),  -- Business
(22, 3, 4000.00, 400.00, 20); -- First Class

-- EK402, EK403 (SIN-DXB) Airbus A380
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(23, 1, 780.00, 78.00, 425), -- Economy
(23, 2, 2150.00, 215.00, 80),  -- Business
(23, 3, 4100.00, 410.00, 20), -- First Class
(24, 1, 780.00, 78.00, 425), -- Economy
(24, 2, 2150.00, 215.00, 80),  -- Business
(24, 3, 4100.00, 410.00, 20); -- First Class

-- AI500, AI501 (HND-DEL) Boeing 777
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(25, 1, 700.00, 70.00, 268), -- Economy
(25, 2, 1950.00, 195.00, 80),  -- Business
(25, 3, 3800.00, 380.00, 20), -- First Class
(26, 1, 700.00, 70.00, 268), -- Economy
(26, 2, 1950.00, 195.00, 80),  -- Business
(26, 3, 3800.00, 380.00, 20); -- First Class

-- AI502, AI503 (DEL-HND) Boeing 777
INSERT INTO flight_pricing (flight_id, class_id, base_price, tax_amount, available_seats) VALUES
(27, 1, 720.00, 72.00, 268), -- Economy
(27, 2, 2000.00, 200.00, 80),  -- Business
(27, 3, 3900.00, 390.00, 20), -- First Class
(28, 1, 720.00, 72.00, 268), -- Economy
(28, 2, 2000.00, 200.00, 80),  -- Business
(28, 3, 3900.00, 390.00, 20); -- First Class

-- Insert sample bookings
-- Booking 1: John Doe traveling from JFK to LAX
INSERT INTO bookings (booking_reference, user_id, flight_id, class_id, booking_date, total_amount, booking_status)
VALUES ('ABCD1234', 2, 1, 1, DATE_SUB(CURRENT_DATE(), INTERVAL 5 DAY), 275.00, 'CONFIRMED');

-- Add passenger for this booking
INSERT INTO passengers (booking_id, first_name, last_name, date_of_birth, passport_number, seat_number)
VALUES (1, 'John', 'Doe', '1985-05-15', 'US123456', '15A');

-- Booking 2: Jane Smith and family traveling from LHR to JFK
INSERT INTO bookings (booking_reference, user_id, flight_id, class_id, booking_date, total_amount, booking_status)
VALUES ('EFGH5678', 3, 17, 1, DATE_SUB(CURRENT_DATE(), INTERVAL 10 DAY), 2040.00, 'CONFIRMED');

-- Add passengers for this booking
INSERT INTO passengers (booking_id, first_name, last_name, date_of_birth, passport_number, seat_number)
VALUES 
(2, 'Jane', 'Smith', '1982-07-20', 'UK789012', '22B'),
(2, 'David', 'Smith', '1980-03-10', 'UK789013', '22C'),
(2, 'Emily', 'Smith', '2015-11-23', 'UK789014', '22D');

-- Booking 3: Robert Johnson traveling business class from ORD to ATL
INSERT INTO bookings (booking_reference, user_id, flight_id, class_id, booking_date, total_amount, booking_status)
VALUES ('IJKL9012', 4, 9, 2, DATE_SUB(CURRENT_DATE(), INTERVAL 3 DAY), 495.00, 'CONFIRMED');

-- Add passenger for this booking
INSERT INTO passengers (booking_id, first_name, last_name, date_of_birth, passport_number, seat_number)
VALUES (3, 'Robert', 'Johnson', '1975-12-05', 'US456789', '5F');

-- Booking 4: Emily Davis traveling first class from DXB to SIN
INSERT INTO bookings (booking_reference, user_id, flight_id, class_id, booking_date, total_amount, booking_status)
VALUES ('MNOP3456', 5, 21, 3, DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY), 4400.00, 'CONFIRMED');

-- Add passenger for this booking
INSERT INTO passengers (booking_id, first_name, last_name, date_of_birth, passport_number, seat_number)
VALUES (4, 'Emily', 'Davis', '1990-08-30', 'US789123', '2A');

-- Insert payment records for these bookings
INSERT INTO payments (booking_id, amount, payment_date, payment_method, payment_status, transaction_id)
VALUES 
(1, 275.00, DATE_SUB(CURRENT_DATE(), INTERVAL 5 DAY), 'Credit Card', 'COMPLETED', 'TXN123456'),
(2, 2040.00, DATE_SUB(CURRENT_DATE(), INTERVAL 10 DAY), 'Credit Card', 'COMPLETED', 'TXN234567'),
(3, 495.00, DATE_SUB(CURRENT_DATE(), INTERVAL 3 DAY), 'PayPal', 'COMPLETED', 'TXN345678'),
(4, 4400.00, DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY), 'Credit Card', 'COMPLETED', 'TXN456789');

-- Print completion message
SELECT 'Sample data has been loaded successfully!' AS Message; 