package com.airline.filters;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
        // Initialization code
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get the session
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is authenticated as admin
        if (session != null && session.getAttribute("userRole") != null && 
                session.getAttribute("userRole").equals("admin")) {
            // User is admin, continue request
            chain.doFilter(request, response);
        } else {
            // User is not admin, redirect to access denied page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/accessDenied.jsp");
        }
    }

    public void destroy() {
        // Cleanup code
    }
} 