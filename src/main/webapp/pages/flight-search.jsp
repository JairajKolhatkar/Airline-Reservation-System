<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Search - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container">
        <section class="page-header">
            <h1>Search Flights</h1>
            <p>Find the best flights to your destination</p>
        </section>
        
        <section class="search-section">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    ${error}
                </div>
            </c:if>
            
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/flights/search" method="post" id="flight-search-form" class="search-form">
                    <div class="form-group">
                        <label for="origin">From</label>
                        <select id="origin" name="origin" required>
                            <option value="">Select Origin</option>
                            <c:forEach var="airport" items="${airports}">
                                <option value="${airport.airportId}" ${origin == airport.airportId ? 'selected' : ''}>${airport.city} (${airport.airportCode}) - ${airport.country}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="destination">To</label>
                        <select id="destination" name="destination" required>
                            <option value="">Select Destination</option>
                            <c:forEach var="airport" items="${airports}">
                                <option value="${airport.airportId}" ${destination == airport.airportId ? 'selected' : ''}>${airport.city} (${airport.airportCode}) - ${airport.country}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="departure_date">Departure Date</label>
                        <input type="date" id="departure_date" name="departure_date" value="${departureDate}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="category">Flight Type</label>
                        <select id="category" name="category">
                            <option value="">Any</option>
                            <option value="1" ${category == 1 ? 'selected' : ''}>Domestic</option>
                            <option value="2" ${category == 2 ? 'selected' : ''}>International</option>
                        </select>
                    </div>
                    
                    <div class="search-filters">
                        <h3>Filters</h3>
                        
                        <div class="filter-group">
                            <label for="airline">Airline</label>
                            <select id="airline" name="airline">
                                <option value="">Any</option>
                                <c:forEach var="airline" items="${airlines}">
                                    <option value="${airline.airlineId}">${airline.airlineName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label>Price Range</label>
                            <div class="price-range">
                                <input type="number" id="min_price" name="min_price" placeholder="Min" min="0">
                                <span>to</span>
                                <input type="number" id="max_price" name="max_price" placeholder="Max" min="0">
                            </div>
                        </div>
                        
                        <div class="filter-group">
                            <label for="class">Class</label>
                            <select id="class" name="class">
                                <option value="">Any</option>
                                <option value="1">Economy</option>
                                <option value="2">Business</option>
                                <option value="3">First</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Search Flights</button>
                    </div>
                </form>
            </div>
        </section>
        
        <section class="search-tips">
            <h2>Search Tips</h2>
            <div class="tips-container">
                <div class="tip-item">
                    <h3>Book in Advance</h3>
                    <p>For the best prices, book your flights at least 30 days in advance.</p>
                </div>
                <div class="tip-item">
                    <h3>Flexible Dates</h3>
                    <p>Try different dates to find the best deals on flights.</p>
                </div>
                <div class="tip-item">
                    <h3>Compare Classes</h3>
                    <p>Check prices across Economy, Business, and First Class for the best value.</p>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html> 