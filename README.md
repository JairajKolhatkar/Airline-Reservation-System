# Airline Reservation System

A web-based airline reservation system built with Java Servlets, JSP, and MySQL.

## Features

- User authentication (Login/Registration)
- Flight search and booking
- Passenger management
- Booking management
- User dashboard
- Admin panel for flight and booking management

## Technologies Used

- Java Servlets & JSP
- JDBC for database connectivity
- MySQL database
- HTML, CSS, JavaScript
- Apache Tomcat server

## Setup Instructions

### Prerequisites
- JDK 8 or higher
- Apache Tomcat 9.x
- MySQL Server

### Database Setup
1. Create a MySQL database
2. Run the database scripts provided in the `database` directory:
   - `airline_schema.sql` - Creates the database schema (tables and relationships)
   - `airline_sample_data.sql` - Populates the database with sample data

### Application Setup
1. Clone this repository
2. Place required JAR files (JSTL, MySQL connector) in the appropriate directories
3. Configure the database connection in `DBUtil.java`
4. Build the project using the provided `compile.bat` script
5. Deploy the WAR file to Tomcat using `clean-and-run.bat`

## Getting Started

### Running the Application

1. **Clone the repository:**
   ```
   git clone https://github.com/JairajKolhatkar/Airline-Reservation-System.git
   cd Airline-Reservation-System
   ```

2. **Configure Database:**
   - Open MySQL and create a database:
     ```sql
     CREATE DATABASE airline_reservation;
     ```
   - Import the database schema:
     ```
     mysql -u root -p airline_reservation < database/airline_schema.sql
     ```
   - Optionally, load sample data:
     ```
     mysql -u root -p airline_reservation < database/airline_sample_data.sql
     ```
   - Configure the database connection:
     Edit `src/main/java/com/airline/utils/DBUtil.java` with your database credentials

3. **Build and Run:**
   - Use the provided script to compile, build, and deploy:
     ```
     .\clean-and-run.bat
     ```
   - This will:
     - Compile the Java files
     - Create the WAR file
     - Deploy to Tomcat
     - Start the Tomcat server

4. **Access the Application:**
   - Open your browser and navigate to:
     ```
     http://localhost:8080/airline-reservation-system/
     ```

5. **Default Credentials:**
   - Regular User:
     - Username: john@example.com
     - Password: password
   - Admin User:
     - Username: admin@airline.com
     - Password: admin123

### Stopping the Application
To stop the Tomcat server:
1. Go to the Tomcat bin directory: `apache-tomcat\apache-tomcat-9.0.82\bin`
2. Run: `shutdown.bat`

## Project Structure

- `src/main/java/com/airline/controllers`: Servlet controllers
- `src/main/java/com/airline/models`: Data models
- `src/main/java/com/airline/dao`: Data Access Objects
- `src/main/java/com/airline/utils`: Utility classes
- `src/main/webapp/`: Web resources (JSP, CSS, JS)
- `database/`: SQL scripts for database setup

## Database Schema

The application uses the following main tables:
- `users`: Stores user account information
- `airlines`: Airlines information
- `airports`: Airport details including codes and locations
- `flights`: Flight details with departure/arrival times 
- `bookings`: Reservation information
- `passengers`: Passenger details for each booking
- `flight_pricing`: Pricing for different seat classes on flights

## Contact

For any queries or support, please contact [jaykool2001@gmail.com] 