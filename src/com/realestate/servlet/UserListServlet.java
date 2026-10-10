package com.realestate.servlet;

import com.realestate.model.User;
import com.realestate.util.FileHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/user-list")
public class UserListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInUser") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        if (!"Admin".equalsIgnoreCase(
                loggedInUser.getMembershipType())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN,
                    "Access denied. Admin access is required."
            );
            return;
        }

        List<User> users = FileHandler.getAllUsers();

        request.setAttribute("users", users);

        request.getRequestDispatcher("user-list.jsp")
                .forward(request, response);
    }
}
