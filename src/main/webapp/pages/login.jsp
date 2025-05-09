<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container">
        <section class="form-section">
            <div class="auth-form-container">
                <h2>Login to Your Account</h2>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        ${error}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="${username}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </div>
                </form>
                
                <div class="auth-links">
                    <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
                    <p><a href="${pageContext.request.contextPath}/forgot-password">Forgot your password?</a></p>
                </div>
            </div>
        </section>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>