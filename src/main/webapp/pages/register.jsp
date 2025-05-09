<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container">
        <section class="form-section">
            <div class="auth-form-container">
                <h2>Create an Account</h2>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form" id="registerForm">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="${username}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${email}" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group half">
                            <label for="first_name">First Name</label>
                            <input type="text" id="first_name" name="first_name" value="${firstName}" required>
                        </div>
                        
                        <div class="form-group half">
                            <label for="last_name">Last Name</label>
                            <input type="text" id="last_name" name="last_name" value="${lastName}" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" value="${phone}">
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group half">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" required>
                            <p class="form-hint">At least 6 characters long</p>
                        </div>
                        
                        <div class="form-group half">
                            <label for="confirm_password">Confirm Password</label>
                            <input type="password" id="confirm_password" name="confirm_password" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="checkbox-group">
                            <input type="checkbox" id="terms" name="terms" required>
                            <label for="terms">I agree to the <a href="${pageContext.request.contextPath}/terms" target="_blank">Terms & Conditions</a> and <a href="${pageContext.request.contextPath}/privacy" target="_blank">Privacy Policy</a></label>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary btn-block">Register</button>
                    </div>
                </form>
                
                <div class="auth-links">
                    <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
    <script>
        // Form validation script
        document.getElementById('registerForm').addEventListener('submit', function(event) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm_password').value;
            
            if (password !== confirmPassword) {
                event.preventDefault();
                alert('Passwords do not match!');
            }
        });
    </script>
</body>
</html> 