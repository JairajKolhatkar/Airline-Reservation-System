<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyJet Airlines - Book Your Flight</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container">
        <section class="hero">
            <div class="hero-content">
                <h1>Travel the World with SkyJet</h1>
                <p>Explore amazing destinations with our best deals on flights</p>
                <a href="${pageContext.request.contextPath}/flights/search" class="btn btn-primary">Book Now</a>
            </div>
        </section>
        
        <section class="features">
            <div class="feature-card">
                <div class="feature-icon">✈️</div>
                <h3>Flights Around the World</h3>
                <p>Domestic and international flights to over 100 destinations.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔍</div>
                <h3>Easy Search</h3>
                <p>Find the perfect flight with our powerful search filters.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">💰</div>
                <h3>Best Prices</h3>
                <p>Get the best deals and discounts on all flights.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🛋️</div>
                <h3>Comfortable Travel</h3>
                <p>Choose from Economy, Business, or First Class seating.</p>
            </div>
        </section>
        
        <section class="destinations">
            <h2>Popular Destinations</h2>
            <div class="destination-grid">
                <div class="destination-card">
                    <div class="destination-image" style="background-image: url('${pageContext.request.contextPath}/assets/images/new-york.jpg')"></div>
                    <div class="destination-info">
                        <h3>New York</h3>
                        <p>Experience the vibrant city that never sleeps.</p>
                        <a href="${pageContext.request.contextPath}/flights/search?destination=8" class="btn btn-secondary">Book Flight</a>
                    </div>
                </div>
                <div class="destination-card">
                    <div class="destination-image" style="background-image: url('${pageContext.request.contextPath}/assets/images/london.jpg')"></div>
                    <div class="destination-info">
                        <h3>London</h3>
                        <p>Explore the historic and cultural capital of England.</p>
                        <a href="${pageContext.request.contextPath}/flights/search?destination=9" class="btn btn-secondary">Book Flight</a>
                    </div>
                </div>
                <div class="destination-card">
                    <div class="destination-image" style="background-image: url('${pageContext.request.contextPath}/assets/images/dubai.jpg')"></div>
                    <div class="destination-info">
                        <h3>Dubai</h3>
                        <p>Discover luxury and adventure in this modern city.</p>
                        <a href="${pageContext.request.contextPath}/flights/search?destination=7" class="btn btn-secondary">Book Flight</a>
                    </div>
                </div>
                <div class="destination-card">
                    <div class="destination-image" style="background-image: url('${pageContext.request.contextPath}/assets/images/singapore.jpg')"></div>
                    <div class="destination-info">
                        <h3>Singapore</h3>
                        <p>Visit the futuristic garden city of Southeast Asia.</p>
                        <a href="${pageContext.request.contextPath}/flights/search?destination=10" class="btn btn-secondary">Book Flight</a>
                    </div>
                </div>
            </div>
        </section>
        
        <section class="about">
            <h2>Why Choose SkyJet Airlines?</h2>
            <div class="about-content">
                <div class="about-text">
                    <p>SkyJet Airlines is dedicated to providing the best travel experience for our customers. With a modern fleet of aircraft, professional crew, and excellent service, we ensure your journey is comfortable and enjoyable.</p>
                    <p>We offer competitive prices, flexible booking options, and a wide range of destinations to choose from. Whether you're traveling for business or leisure, SkyJet Airlines has got you covered.</p>
                    <a href="${pageContext.request.contextPath}/about" class="btn btn-outline">Learn More</a>
                </div>
                <div class="about-image">
                    <img src="${pageContext.request.contextPath}/assets/images/airplane.jpg" alt="SkyJet Airplane">
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html> 