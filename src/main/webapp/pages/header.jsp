<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="main-header">
    <div class="container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="SkyJet Airlines Logo">
                <span>SkyJet</span>
            </a>
        </div>
        
        <nav class="main-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/flights/search">Flights</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </nav>
        
        <div class="user-actions">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register</a>
                </c:when>
                <c:otherwise>
                    <div class="dropdown">
                        <button class="dropdown-toggle">
                            Hello, ${sessionScope.user.firstName}
                            <span class="arrow-down"></span>
                        </button>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                            <a href="${pageContext.request.contextPath}/bookings">My Bookings</a>
                            <a href="${pageContext.request.contextPath}/profile">My Profile</a>
                            <c:if test="${sessionScope.user.admin}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard">Admin Panel</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/logout">Logout</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <button class="mobile-menu-toggle">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </div>
    
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success">
            ${sessionScope.message}
            <button class="close-alert">&times;</button>
        </div>
        <c:remove var="message" scope="session" />
    </c:if>
</header> 