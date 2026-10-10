package com.realestate.servlet;

import com.realestate.model.User;
import com.realestate.util.FileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");

        String searchValue = request.getParameter("searchValue");

        User user = FileHandler.findUserById(searchValue);

        if (user == null) {
            user = FileHandler.findUserByUsername(searchValue);
        }

        response.setContentType("text/html");

        if (user != null) {

            response.getWriter().println("<h1>User Found</h1>");
            response.getWriter().println("<p>User ID: " + user.getUserId() + "</p>");
            response.getWriter().println("<p>Username: " + user.getUsername() + "</p>");
            response.getWriter().println("<p>Email: " + user.getEmail() + "</p>");
            response.getWriter().println("<p>Password: " + user.getPassword() + "</p>");
            response.getWriter().println("<p>Membership Type: " + user.getMembershipType() + "</p>");

        } else {

            response.getWriter().println("<h1>User Not Found</h1>");
            response.getWriter().println("<p>No user found with ID: " + userId + "</p>");
        }
    }
}