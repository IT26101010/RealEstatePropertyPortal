package com.realestate.servlet;

import com.realestate.model.User;
import com.realestate.util.FileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = FileHandler.findUser(username, password);


        if (user != null) {

            request.getSession().setAttribute("loggedInUser", user);

            response.sendRedirect("profile.jsp");

        } else {

            response.sendRedirect("login.jsp?error=invalid");

        }
    }
}