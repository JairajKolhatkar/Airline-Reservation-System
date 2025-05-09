<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="main-footer">
    <div class="container">
        <div class="footer-grid">
            <div class="footer-column">
                <h3>SkyJet Airlines</h3>
                <p>We make the world more accessible by providing safe, reliable, and affordable air travel.</p>
                <div class="social-links">
                    <a href="#" class="social-icon" aria-label="Facebook"><i class="fa fa-facebook"></i></a>
                    <a href="#" class="social-icon" aria-label="Twitter"><i class="fa fa-twitter"></i></a>
                    <a href="#" class="social-icon" aria-label="Instagram"><i class="fa fa-instagram"></i></a>
                    <a href="#" class="social-icon" aria-label="LinkedIn"><i class="fa fa-linkedin"></i></a>
                </div>
            </div>
            
            <div class="footer-column">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/flights/search">Flight Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq">FAQs</a></li>
                </ul>
            </div>
            
            <div class="footer-column">
                <h4>Destinations</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/flights/search?destination=8">New York</a></li>
                    <li><a href="${pageContext.request.contextPath}/flights/search?destination=9">London</a></li>
                    <li><a href="${pageContext.request.contextPath}/flights/search?destination=7">Dubai</a></li>
                    <li><a href="${pageContext.request.contextPath}/flights/search?destination=10">Singapore</a></li>
                    <li><a href="${pageContext.request.contextPath}/flights/search">More Destinations</a></li>
                </ul>
            </div>
            
            <div class="footer-column">
                <h4>Contact Information</h4>
                <address>
                    <p><i class="fa fa-map-marker"></i> 123 Aviation Road, Skyline Tower</p>
                    <p><i class="fa fa-phone"></i> +1 (555) 123-4567</p>
                    <p><i class="fa fa-envelope"></i> info@skyjetairlines.com</p>
                </address>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="copyright">
                <p>&copy; ${java.time.Year.now().getValue()} SkyJet Airlines. All Rights Reserved.</p>
            </div>
            <div class="footer-nav">
                <a href="${pageContext.request.contextPath}/terms">Terms & Conditions</a>
                <a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a>
                <a href="${pageContext.request.contextPath}/cookies">Cookie Policy</a>
            </div>
        </div>
    </div>
</footer>

<!-- Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">