
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

@WebServlet("/update-profile")
public class UpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
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

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank()
                || password == null || password.isBlank()
                || email.contains(",")
                || password.contains(",")
                || email.contains("\n")
                || password.contains("\n")
                || email.contains("\r")
                || password.contains("\r")) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid email or password."
            );
            return;
        }

        String membershipType = loggedInUser.getMembershipType();

        User updatedUser = new User(
                loggedInUser.getUserId(),
                loggedInUser.getUsername(),
                email.trim(),
                password,
                membershipType
        );

        boolean updated = FileHandler.updateUser(updatedUser);

        if (updated) {

            session.setAttribute("loggedInUser", updatedUser);

            response.sendRedirect("profile.jsp?updated=true");

        } else {

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update user details."
            );
        }
    }
}