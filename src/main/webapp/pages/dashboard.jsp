<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container dashboard-page">
        <div class="dashboard-header">
            <h1>Welcome, ${user.firstName}!</h1>
            <p>Manage your bookings and account information from your personal dashboard.</p>
        </div>
        
        <div class="dashboard-grid">
            <section class="user-profile">
                <div class="profile-card">
                    <h2>Personal Information</h2>
                    <div class="profile-details">
                        <div class="profile-item">
                            <span class="label">Name:</span>
                            <span class="value">${user.firstName} ${user.lastName}</span>
                        </div>
                        <div class="profile-item">
                            <span class="label">Email:</span>
                            <span class="value">${user.email}</span>
                        </div>
                        <div class="profile-item">
                            <span class="label">Phone:</span>
                            <span class="value">${user.phone != null ? user.phone : 'Not provided'}</span>
                        </div>
                        <div class="profile-item">
                            <span class="label">Address:</span>
                            <span class="value">
                                <c:choose>
                                    <c:when test="${user.address != null}">
                                        ${user.address}, ${user.city}, ${user.state} ${user.zipCode}, ${user.country}
                                    </c:when>
                                    <c:otherwise>
                                        Not provided
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    <div class="profile-actions">
                        <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-secondary">Edit Profile</a>
                        <a href="${pageContext.request.contextPath}/profile/password" class="btn btn-outline">Change Password</a>
                    </div>
                </div>
            </section>
            
            <section class="user-bookings">
                <h2>Your Bookings</h2>
                <c:choose>
                    <c:when test="${empty bookings}">
                        <div class="no-bookings">
                            <p>You have no bookings yet. Ready to plan your next adventure?</p>
                            <a href="${pageContext.request.contextPath}/flights/search" class="btn btn-primary">Book a Flight</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="booking-cards">
                            <c:forEach items="${bookings}" var="booking">
                                <div class="booking-card">
                                    <div class="booking-status ${booking.status.toLowerCase()}">
                                        <span>${booking.status}</span>
                                    </div>
                                    <div class="booking-info">
                                        <div class="booking-reference">
                                            <span class="label">Booking Reference:</span>
                                            <span class="value">${booking.bookingReference}</span>
                                        </div>
                                        <div class="flight-basic-info">
                                            <div class="origin-destination">
                                                <span class="origin">${booking.flight.originAirport.airportCode}</span>
                                                <span class="route-icon">✈</span>
                                                <span class="destination">${booking.flight.destinationAirport.airportCode}</span>
                                            </div>
                                            <div class="date-time">
                                                <span class="date"><fmt:formatDate value="${booking.flight.departureTime}" pattern="EEE, MMM d, yyyy" /></span>
                                            </div>
                                        </div>
                                        <div class="passenger-count">
                                            <span class="label">Passengers:</span>
                                            <span class="value">${booking.passengerCount}</span>
                                        </div>
                                        <div class="booking-class">
                                            <span class="label">Class:</span>
                                            <span class="value">${booking.seatClass.className}</span>
                                        </div>
                                    </div>
                                    <div class="booking-actions">
                                        <a href="${pageContext.request.contextPath}/bookings/view?id=${booking.bookingId}" class="btn btn-secondary">View Details</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="more-bookings">
                            <a href="${pageContext.request.contextPath}/bookings/history" class="btn btn-outline">View All Bookings</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
            
            <section class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/flights/search" class="action-btn">
                        <span class="icon">✈</span>
                        <span class="text">Book a Flight</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/bookings/manage" class="action-btn">
                        <span class="icon">📋</span>
                        <span class="text">Manage Bookings</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/check-in" class="action-btn">
                        <span class="icon">✓</span>
                        <span class="text">Online Check-in</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/support" class="action-btn">
                        <span class="icon">💬</span>
                        <span class="text">Customer Support</span>
                    </a>
                </div>
            </section>
        </div>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html> 