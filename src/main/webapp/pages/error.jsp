<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - SkyJet Airlines</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <main class="container error-page">
        <div class="error-container">
            <div class="error-icon">⚠️</div>
            <h1>Oops! Something went wrong</h1>
            
            <c:choose>
                <c:when test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:when>
                <c:when test="${not empty param.message}">
                    <p class="error-message">${param.message}</p>
                </c:when>
                <c:otherwise>
                    <p class="error-message">An unexpected error occurred. Please try again later.</p>
                </c:otherwise>
            </c:choose>
            
            <c:if test="${not empty pageContext.exception}">
                <div class="error-details">
                    <h3>Error Details:</h3>
                    <p>${pageContext.exception.message}</p>
                </div>
            </c:if>
            
            <div class="error-actions">
                <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go to Homepage</a>
            </div>
            
            <div class="help-text">
                <p>If you continue to experience issues, please <a href="${pageContext.request.contextPath}/support">contact our support team</a>.</p>
            </div>
        </div>
    </main>
    
    <jsp:include page="/pages/footer.jsp" />
    
    <script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html> 