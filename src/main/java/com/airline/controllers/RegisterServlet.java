package com.airline.controllers;

import com.airline.dao.UserDAO;
import com.airline.models.User;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String email = request.getParameter("email");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String phone = request.getParameter("phone");
        
        // Validate input
        String errorMessage = validateInput(username, password, confirmPassword, email, firstName, lastName);
        
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username or email already exists
        UserDAO userDAO = new UserDAO();
        
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username already exists");
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already exists");
            request.setAttribute("username", username);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        // Create user object
        User user = new User();
        user.setUsername(username);
        user.setPassword(password); // In a real app, you should hash this password
        user.setEmail(email);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhone(phone);
        
        // Save user to database
        boolean registered = userDAO.registerUser(user);
        
        if (registered) {
            // Set success message
            HttpSession session = request.getSession();
            session.setAttribute("message", "Registration successful. Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        }
    }
    
    private String validateInput(String username, String password, String confirmPassword, 
                                String email, String firstName, String lastName) {
        if (username == null || username.trim().isEmpty()) {
            return "Username is required";
        }
        
        if (password == null || password.trim().isEmpty()) {
            return "Password is required";
        }
        
        if (!password.equals(confirmPassword)) {
            return "Passwords do not match";
        }
        
        if (password.length() < 6) {
            return "Password must be at least 6 characters long";
        }
        
        if (email == null || email.trim().isEmpty()) {
            return "Email is required";
        }
        
        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            return "Invalid email format";
        }
        
        if (firstName == null || firstName.trim().isEmpty()) {
            return "First name is required";
        }
        
        if (lastName == null || lastName.trim().isEmpty()) {
            return "Last name is required";
        }
        
        return null;
    }
} 