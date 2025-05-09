<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - Airline Reservation System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .error-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            max-width: 500px;
        }
        .error-icon {
            font-size: 3em;
            color: #FF5252;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            background-color: #1a73e8;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1>Oops! Something went wrong</h1>
        <p>We're sorry, but an error occurred while processing your request.</p>
        <p>Error code: <%= request.getAttribute("javax.servlet.error.status_code") %></p>
        <a href="/airline-reservation-system/" class="btn">Go to Homepage</a>
    </div>
</body>
</html> 