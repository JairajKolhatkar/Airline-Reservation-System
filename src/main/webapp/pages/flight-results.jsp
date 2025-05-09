<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Search Results - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container">
        <section class="page-header">
            <h1>Flight Search Results</h1>
            <p>
                <c:forEach var="airport" items="${airports}">
                    <c:if test="${airport.airportId == origin}">
                        <span class="route-info">${airport.city} (${airport.airportCode})</span>
                    </c:if>
                </c:forEach>
                <span class="route-separator">→</span>
                <c:forEach var="airport" items="${airports}">
                    <c:if test="${airport.airportId == destination}">
                        <span class="route-info">${airport.city} (${airport.airportCode})</span>
                    </c:if>
                </c:forEach>
                | <span class="date-info">${departureDate}</span>
            </p>
            
            <div class="search-actions">
                <a href="${pageContext.request.contextPath}/flights/search" class="btn btn-outline">Modify Search</a>
            </div>
        </section>
        
        <section class="results-section">
            <div class="filter-sidebar">
                <h3>Filter Results</h3>
                
                <div class="filter-group">
                    <h4>Airlines</h4>
                    <div class="checkbox-list">
                        <c:forEach var="airline" items="${airlines}">
                            <div class="checkbox-item">
                                <input type="checkbox" id="airline_${airline.airlineId}" name="airline_filter" value="${airline.airlineId}" class="filter-checkbox">
                                <label for="airline_${airline.airlineId}">${airline.airlineName}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <div class="filter-group">
                    <h4>Price Range</h4>
                    <div class="price-range-slider">
                        <input type="range" id="price_range" min="0" max="2000" step="100" value="2000">
                        <div class="price-inputs">
                            <input type="number" id="min_price_filter" placeholder="Min" min="0">
                            <span>to</span>
                            <input type="number" id="max_price_filter" placeholder="Max" min="0" value="2000">
                        </div>
                    </div>
                </div>
                
                <div class="filter-group">
                    <h4>Departure Time</h4>
                    <div class="checkbox-list">
                        <div class="checkbox-item">
                            <input type="checkbox" id="time_morning" name="time_filter" value="morning" class="filter-checkbox">
                            <label for="time_morning">Morning (6AM - 12PM)</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="time_afternoon" name="time_filter" value="afternoon" class="filter-checkbox">
                            <label for="time_afternoon">Afternoon (12PM - 6PM)</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="time_evening" name="time_filter" value="evening" class="filter-checkbox">
                            <label for="time_evening">Evening (6PM - 12AM)</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="time_night" name="time_filter" value="night" class="filter-checkbox">
                            <label for="time_night">Night (12AM - 6AM)</label>
                        </div>
                    </div>
                </div>
                
                <div class="filter-group">
                    <h4>Class</h4>
                    <div class="checkbox-list">
                        <div class="checkbox-item">
                            <input type="checkbox" id="class_economy" name="class_filter" value="1" class="filter-checkbox">
                            <label for="class_economy">Economy</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="class_business" name="class_filter" value="2" class="filter-checkbox">
                            <label for="class_business">Business</label>
                        </div>
                        <div class="checkbox-item">
                            <input type="checkbox" id="class_first" name="class_filter" value="3" class="filter-checkbox">
                            <label for="class_first">First</label>
                        </div>
                    </div>
                </div>
                
                <button id="apply_filters" class="btn btn-primary btn-block">Apply Filters</button>
            </div>
            
            <div class="results-container">
                <div class="results-header">
                    <div class="results-count">
                        <span>${flights.size()} flights found</span>
                    </div>
                    <div class="results-sort">
                        <label for="sort_by">Sort by:</label>
                        <select id="sort_by">
                            <option value="price_asc">Price: Low to High</option>
                            <option value="price_desc">Price: High to Low</option>
                            <option value="duration_asc">Duration: Shortest First</option>
                            <option value="departure_asc">Departure: Earliest First</option>
                            <option value="departure_desc">Departure: Latest First</option>
                        </select>
                    </div>
                </div>
                
                <c:choose>
                    <c:when test="${empty flights}">
                        <div class="no-results">
                            <p>No flights found matching your criteria.</p>
                            <p>Try adjusting your search parameters or try different dates.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flight-list">
                            <c:forEach var="flight" items="${flights}">
                                <div class="flight-card">
                                    <div class="flight-header">
                                        <div class="airline-info">
                                            <img src="${pageContext.request.contextPath}/assets/images/airlines/${flight.airlineCode}.png" alt="${flight.airlineName}" class="airline-logo">
                                            <div>
                                                <span class="airline-name">${flight.airlineName}</span>
                                                <span class="flight-number">${flight.flightNumber}</span>
                                            </div>
                                        </div>
                                        <div class="flight-type">
                                            <span class="flight-category">${flight.categoryName}</span>
                                        </div>
                                    </div>
                                    
                                    <div class="flight-details">
                                        <div class="flight-route">
                                            <div class="departure">
                                                <div class="time">
                                                    <fmt:formatDate value="${flight.departureTime}" pattern="HH:mm" />
                                                </div>
                                                <div class="airport">
                                                    ${flight.originAirportCode}
                                                </div>
                                                <div class="city">
                                                    ${flight.originCity}
                                                </div>
                                            </div>
                                            
                                            <div class="flight-duration">
                                                <div class="duration-time">${flight.formattedFlightDuration()}</div>
                                                <div class="duration-line"></div>
                                                <div class="flight-stops">Direct</div>
                                            </div>
                                            
                                            <div class="arrival">
                                                <div class="time">
                                                    <fmt:formatDate value="${flight.arrivalTime}" pattern="HH:mm" />
                                                </div>
                                                <div class="airport">
                                                    ${flight.destinationAirportCode}
                                                </div>
                                                <div class="city">
                                                    ${flight.destinationCity}
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="flight-classes">
                                            <c:set var="pricings" value="${requestScope['pricing_'.concat(flight.flightId)]}" />
                                            
                                            <c:forEach var="pricing" items="${pricings}">
                                                <div class="class-option ${pricing.availableSeats == 0 ? 'sold-out' : ''}">
                                                    <div class="class-name">${pricing.className}</div>
                                                    <div class="class-price">$${pricing.price}</div>
                                                    <div class="seats-left">${pricing.availableSeats} seats left</div>
                                                    
                                                    <c:choose>
                                                        <c:when test="${pricing.availableSeats > 0}">
                                                            <a href="${pageContext.request.contextPath}/booking?flight_id=${flight.flightId}&class_id=${pricing.classId}" class="btn btn-outline-primary">Select</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="sold-out-label">Sold Out</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    
                                    <div class="flight-actions">
                                        <button class="btn-toggle-details">Flight Details</button>
                                    </div>
                                    
                                    <div class="flight-expanded-details">
                                        <div class="flight-info-sections">
                                            <div class="info-section">
                                                <h4>Flight Information</h4>
                                                <ul>
                                                    <li><strong>Aircraft:</strong> Boeing 737</li>
                                                    <li><strong>Flight Duration:</strong> ${flight.formattedFlightDuration()}</li>
                                                    <li><strong>Distance:</strong> 1,500 km</li>
                                                </ul>
                                            </div>
                                            
                                            <div class="info-section">
                                                <h4>Baggage Information</h4>
                                                <ul>
                                                    <li><strong>Carry-on:</strong> 7 kg</li>
                                                    <li><strong>Checked Baggage:</strong> 
                                                        <ul>
                                                            <li>Economy: 23 kg</li>
                                                            <li>Business: 2 x 32 kg</li>
                                                            <li>First: 3 x 32 kg</li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                            </div>
                                            
                                            <div class="info-section">
                                                <h4>Amenities</h4>
                                                <ul>
                                                    <li>In-flight Entertainment</li>
                                                    <li>Wi-Fi Available</li>
                                                    <li>Power Outlets</li>
                                                    <li>Complimentary Meals</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    <script>
        // Toggle flight details
        document.querySelectorAll('.btn-toggle-details').forEach(function(button) {
            button.addEventListener('click', function() {
                const flightCard = this.closest('.flight-card');
                flightCard.classList.toggle('expanded');
                
                if (flightCard.classList.contains('expanded')) {
                    this.textContent = 'Hide Details';
                } else {
                    this.textContent = 'Flight Details';
                }
            });
        });
        
        // Filters functionality
        document.getElementById('apply_filters').addEventListener('click', function() {
            const cards = document.querySelectorAll('.flight-card');
            
            cards.forEach(function(card) {
                let show = true;
                
                // Price filter
                const minPrice = parseFloat(document.getElementById('min_price_filter').value) || 0;
                const maxPrice = parseFloat(document.getElementById('max_price_filter').value) || Infinity;
                const prices = Array.from(card.querySelectorAll('.class-price')).map(el => parseFloat(el.textContent.replace('$', '')));
                const minCardPrice = Math.min(...prices);
                
                if (minCardPrice < minPrice || minCardPrice > maxPrice) {
                    show = false;
                }
                
                // Airline filter
                const selectedAirlines = Array.from(document.querySelectorAll('input[name="airline_filter"]:checked')).map(el => el.value);
                if (selectedAirlines.length > 0) {
                    const airlineId = card.dataset.airlineId;
                    if (!selectedAirlines.includes(airlineId)) {
                        show = false;
                    }
                }
                
                // Class filter
                const selectedClasses = Array.from(document.querySelectorAll('input[name="class_filter"]:checked')).map(el => el.value);
                if (selectedClasses.length > 0) {
                    const hasSelectedClass = selectedClasses.some(classId => {
                        return card.querySelector(`.class-option[data-class-id="${classId}"]`) !== null;
                    });
                    
                    if (!hasSelectedClass) {
                        show = false;
                    }
                }
                
                // Time filter
                const selectedTimes = Array.from(document.querySelectorAll('input[name="time_filter"]:checked')).map(el => el.value);
                if (selectedTimes.length > 0) {
                    const departureTime = card.querySelector('.departure .time').textContent.trim();
                    const hour = parseInt(departureTime.split(':')[0]);
                    
                    const timeCategory = 
                        (hour >= 6 && hour < 12) ? 'morning' :
                        (hour >= 12 && hour < 18) ? 'afternoon' :
                        (hour >= 18 && hour < 24) ? 'evening' : 'night';
                    
                    if (!selectedTimes.includes(timeCategory)) {
                        show = false;
                    }
                }
                
                // Show or hide card
                card.style.display = show ? 'block' : 'none';
            });
            
            // Update results count
            const visibleCards = document.querySelectorAll('.flight-card[style="display: block;"]').length;
            document.querySelector('.results-count span').textContent = visibleCards + ' flights found';
        });
        
        // Price range slider
        const priceRangeSlider = document.getElementById('price_range');
        const maxPriceInput = document.getElementById('max_price_filter');
        
        priceRangeSlider.addEventListener('input', function() {
            maxPriceInput.value = this.value;
        });
        
        maxPriceInput.addEventListener('input', function() {
            priceRangeSlider.value = this.value;
        });
        
        // Sorting functionality
        document.getElementById('sort_by').addEventListener('change', function() {
            const sortValue = this.value;
            const flightList = document.querySelector('.flight-list');
            const flightCards = Array.from(flightList.querySelectorAll('.flight-card'));
            
            flightCards.sort(function(a, b) {
                if (sortValue === 'price_asc') {
                    const priceA = parseFloat(a.querySelector('.class-price').textContent.replace('$', ''));
                    const priceB = parseFloat(b.querySelector('.class-price').textContent.replace('$', ''));
                    return priceA - priceB;
                } else if (sortValue === 'price_desc') {
                    const priceA = parseFloat(a.querySelector('.class-price').textContent.replace('$', ''));
                    const priceB = parseFloat(b.querySelector('.class-price').textContent.replace('$', ''));
                    return priceB - priceA;
                } else if (sortValue === 'duration_asc') {
                    const durationA = a.querySelector('.duration-time').textContent;
                    const durationB = b.querySelector('.duration-time').textContent;
                    const hoursA = parseInt(durationA.split('h')[0]);
                    const minsA = parseInt(durationA.split('h ')[1].split('m')[0]);
                    const hoursB = parseInt(durationB.split('h')[0]);
                    const minsB = parseInt(durationB.split('h ')[1].split('m')[0]);
                    return (hoursA * 60 + minsA) - (hoursB * 60 + minsB);
                } else if (sortValue === 'departure_asc' || sortValue === 'departure_desc') {
                    const timeA = a.querySelector('.departure .time').textContent.trim();
                    const timeB = b.querySelector('.departure .time').textContent.trim();
                    const [hoursA, minsA] = timeA.split(':').map(Number);
                    const [hoursB, minsB] = timeB.split(':').map(Number);
                    const totalMinsA = hoursA * 60 + minsA;
                    const totalMinsB = hoursB * 60 + minsB;
                    
                    return sortValue === 'departure_asc' ? totalMinsA - totalMinsB : totalMinsB - totalMinsA;
                }
                
                return 0;
            });
            
            // Re-append sorted cards
            flightCards.forEach(function(card) {
                flightList.appendChild(card);
            });
        });
    </script>
</body>
</html> 