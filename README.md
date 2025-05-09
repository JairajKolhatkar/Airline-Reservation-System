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
2. Run the database scripts provided in the `database` directory

### Application Setup
1. Clone this repository
2. Place required JAR files (JSTL, MySQL connector) in the appropriate directories
3. Configure the database connection in `DBUtil.java`
4. Build the project using the provided `compile.bat` script
5. Deploy the WAR file to Tomcat using `clean-and-run.bat`

## Project Structure

- `src/main/java/com/airline/controllers`: Servlet controllers
- `src/main/java/com/airline/models`: Data models
- `src/main/java/com/airline/dao`: Data Access Objects
- `src/main/java/com/airline/utils`: Utility classes
- `src/main/webapp/`: Web resources (JSP, CSS, JS)

## Contact

For any queries or support, please contact [jaykool2001@gmail.com] 