package com.airline.filters;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AuthenticationFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
        // Initialization code
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get the session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is authenticated
        if (session != null && session.getAttribute("userID") != null) {
            // User is logged in, continue request
            chain.doFilter(request, response);
        } else {
            // User is not logged in, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    public void destroy() {
        // Cleanup code
    }
} 