<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container confirmation-page">
        <section class="confirmation">
            <div class="confirmation-header">
                <h1>Booking Confirmed!</h1>
                <p>Your booking has been successfully confirmed. Please find your booking details below.</p>
            </div>
            
            <div class="booking-details">
                <div class="booking-reference">
                    <h3>Booking Reference</h3>
                    <p class="reference-code">${booking.bookingReference}</p>
                </div>
                
                <div class="flight-details">
                    <h3>Flight Details</h3>
                    <div class="flight-info">
                        <div class="flight-header">
                            <span class="airline">${booking.flight.airline.airlineName}</span>
                            <span class="flight-number">${booking.flight.flightNumber}</span>
                        </div>
                        
                        <div class="flight-route">
                            <div class="origin">
                                <span class="airport-code">${booking.flight.originAirport.airportCode}</span>
                                <span class="airport-name">${booking.flight.originAirport.city}</span>
                                <span class="departure-time">
                                    <fmt:formatDate value="${booking.flight.departureTime}" pattern="hh:mm a" />
                                </span>
                                <span class="departure-date">
                                    <fmt:formatDate value="${booking.flight.departureTime}" pattern="EEE, MMM d, yyyy" />
                                </span>
                            </div>
                            
                            <div class="route-line">
                                <span class="plane-icon">✈</span>
                            </div>
                            
                            <div class="destination">
                                <span class="airport-code">${booking.flight.destinationAirport.airportCode}</span>
                                <span class="airport-name">${booking.flight.destinationAirport.city}</span>
                                <span class="arrival-time">
                                    <fmt:formatDate value="${booking.flight.arrivalTime}" pattern="hh:mm a" />
                                </span>
                                <span class="arrival-date">
                                    <fmt:formatDate value="${booking.flight.arrivalTime}" pattern="EEE, MMM d, yyyy" />
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="passenger-details">
                    <h3>Passenger Information</h3>
                    <table class="passenger-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Seat</th>
                                <th>Class</th>
                                <th>Special Requirements</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${passengers}" var="passenger">
                                <tr>
                                    <td>${passenger.firstName} ${passenger.lastName}</td>
                                    <td>${passenger.seatNumber}</td>
                                    <td>${booking.seatClass.className}</td>
                                    <td>${passenger.specialRequirements != null ? passenger.specialRequirements : 'None'}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="payment-details">
                    <h3>Payment Information</h3>
                    <table class="payment-table">
                        <tr>
                            <td>Base Fare:</td>
                            <td>$<fmt:formatNumber value="${booking.baseAmount}" pattern="#,##0.00" /></td>
                        </tr>
                        <tr>
                            <td>Taxes & Fees:</td>
                            <td>$<fmt:formatNumber value="${booking.taxAmount}" pattern="#,##0.00" /></td>
                        </tr>
                        <tr class="total-row">
                            <td>Total Amount:</td>
                            <td>$<fmt:formatNumber value="${booking.totalAmount}" pattern="#,##0.00" /></td>
                        </tr>
                        <tr>
                            <td>Payment Method:</td>
                            <td>${payment.paymentMethod}</td>
                        </tr>
                        <tr>
                            <td>Payment Status:</td>
                            <td>${payment.paymentStatus}</td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <div class="confirmation-actions">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">Go to Dashboard</a>
                <a href="${pageContext.request.contextPath}/bookings/print?id=${booking.bookingId}" class="btn btn-secondary">Print Ticket</a>
            </div>
        </section>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html> 