<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="admin-header">
    <div class="container">
        <div class="header-content">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <span class="logo-text">SkyJet</span>
                    <span class="logo-admin">Admin</span>
                </a>
            </div>
            
            <nav class="admin-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link ${pageContext.request.servletPath.contains('/admin/dashboard') ? 'active' : ''}">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/flights" class="nav-link ${pageContext.request.servletPath.contains('/admin/flights') ? 'active' : ''}">Flights</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/bookings" class="nav-link ${pageContext.request.servletPath.contains('/admin/bookings') ? 'active' : ''}">Bookings</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users" class="nav-link ${pageContext.request.servletPath.contains('/admin/users') ? 'active' : ''}">Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/reports" class="nav-link ${pageContext.request.servletPath.contains('/admin/reports') ? 'active' : ''}">Reports</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/settings" class="nav-link ${pageContext.request.servletPath.contains('/admin/settings') ? 'active' : ''}">Settings</a></li>
                </ul>
            </nav>
            
            <div class="user-menu">
                <div class="user-info">
                    <span class="user-name">${user.firstName}</span>
                    <span class="user-role">Administrator</span>
                </div>
                <div class="dropdown">
                    <button class="dropdown-toggle">
                        <span class="avatar">${user.firstName.charAt(0)}${user.lastName.charAt(0)}</span>
                        <span class="caret">▼</span>
                    </button>
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/admin/profile" class="dropdown-item">My Profile</a>
                        <a href="${pageContext.request.contextPath}/" class="dropdown-item">View Site</a>
                        <div class="dropdown-divider"></div>
                        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="admin-subheader">
    <div class="container">
        <div class="breadcrumbs">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Home</a>
            <c:if test="${not empty pageTitle}">
                <span class="separator">/</span>
                <span class="current">${pageTitle}</span>
            </c:if>
        </div>
        
        <c:if test="${not empty actionButton}">
            <div class="action-button">
                <a href="${actionButtonUrl}" class="btn btn-primary">${actionButton}</a>
            </div>
        </c:if>
    </div>
</div> 