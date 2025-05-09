<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/admin/header.jsp" />
    
    <main class="container admin-dashboard">
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <p>Welcome back, ${user.firstName}! Manage all aspects of SkyJet Airlines from this control panel.</p>
        </div>
        
        <div class="stats-overview">
            <div class="stat-card">
                <div class="stat-value">${stats.totalBookings}</div>
                <div class="stat-title">Total Bookings</div>
                <div class="stat-period">All Time</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">${stats.todayBookings}</div>
                <div class="stat-title">Today's Bookings</div>
                <div class="stat-period">Last 24 hours</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">${stats.activeFlights}</div>
                <div class="stat-title">Active Flights</div>
                <div class="stat-period">Currently</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">${stats.registeredUsers}</div>
                <div class="stat-title">Registered Users</div>
                <div class="stat-period">All Time</div>
            </div>
        </div>
        
        <div class="admin-grid">
            <section class="recent-bookings">
                <div class="section-header">
                    <h2>Recent Bookings</h2>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="view-all">View All</a>
                </div>
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Ref #</th>
                                <th>Customer</th>
                                <th>Flight</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Amount</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${recentBookings}" var="booking">
                                <tr>
                                    <td>${booking.bookingReference}</td>
                                    <td>${booking.user.firstName} ${booking.user.lastName}</td>
                                    <td>${booking.flight.flightNumber}</td>
                                    <td><fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy" /></td>
                                    <td><span class="status-badge ${booking.status.toLowerCase()}">${booking.status}</span></td>
                                    <td>$<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/bookings/view?id=${booking.bookingId}" class="action-btn view">View</a>
                                        <a href="${pageContext.request.contextPath}/admin/bookings/edit?id=${booking.bookingId}" class="action-btn edit">Edit</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
            
            <section class="upcoming-flights">
                <div class="section-header">
                    <h2>Upcoming Flights</h2>
                    <a href="${pageContext.request.contextPath}/admin/flights" class="view-all">View All</a>
                </div>
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Flight #</th>
                                <th>Route</th>
                                <th>Departure</th>
                                <th>Status</th>
                                <th>Capacity</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${upcomingFlights}" var="flight">
                                <tr>
                                    <td>${flight.flightNumber}</td>
                                    <td>${flight.originAirport.airportCode} to ${flight.destinationAirport.airportCode}</td>
                                    <td><fmt:formatDate value="${flight.departureTime}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td><span class="status-badge ${flight.status.toLowerCase()}">${flight.status}</span></td>
                                    <td>${flight.bookedSeats}/${flight.totalSeats}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/admin/flights/view?id=${flight.flightId}" class="action-btn view">View</a>
                                        <a href="${pageContext.request.contextPath}/admin/flights/edit?id=${flight.flightId}" class="action-btn edit">Edit</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
            
            <section class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/admin/flights/add" class="action-card">
                        <span class="icon">✈</span>
                        <span class="title">Add New Flight</span>
                        <span class="description">Schedule a new flight in the system</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="action-card">
                        <span class="icon">👥</span>
                        <span class="title">Manage Users</span>
                        <span class="description">View and edit user accounts</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/reports" class="action-card">
                        <span class="icon">📊</span>
                        <span class="title">Generate Reports</span>
                        <span class="description">Create financial and operational reports</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/settings" class="action-card">
                        <span class="icon">⚙️</span>
                        <span class="title">System Settings</span>
                        <span class="description">Configure application settings</span>
                    </a>
                </div>
            </section>
        </div>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html> 