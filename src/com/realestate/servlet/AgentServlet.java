package com.realestate.servlet;

import com.realestate.model.Agent;
import com.realestate.service.AgentManagement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet controller for Agent Management operations.
 * Coordinates between the JSP frontend and the AgentManagement service layer.
 *
 * Supported Actions:
 * - List all agents (default)
 * - Sort agents by Average Rating descending (via Selection Sort)
 * - Search agent by ID (via AgentBST)
 * - Search agents by Specialization (via AgentBST)
 * - Register new agent
 * - Update existing agent profile
 * - Delete/remove agent
 *
 * Part of Function 01: Agent Management (Part 5/Frontend).
 */
@WebServlet({"/agents", "/agent-management"})
public class AgentServlet extends HttpServlet {

    private AgentManagement agentManagement;

    @Override
    public void init() throws ServletException {
        super.init();
        this.agentManagement = new AgentManagement();
    }

    /**
     * Helper method to ensure AgentManagement is initialized.
     */
    private AgentManagement getAgentManagement() {
        if (this.agentManagement == null) {
            this.agentManagement = new AgentManagement();
        }
        return this.agentManagement;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AgentManagement am = getAgentManagement();
        String action = request.getParameter("action");
        List<Agent> agents;

        if ("sort".equalsIgnoreCase(action)) {
            // Sort agents by AverageRating descending using AgentManagement & AgentSorter (Selection Sort)
            agents = am.sortAgentsByRating();
            request.setAttribute("isSorted", true);

        } else if ("search".equalsIgnoreCase(action)) {
            String agentId = request.getParameter("agentId");
            String specialization = request.getParameter("specialization");

            if (agentId != null && !agentId.trim().isEmpty()) {
                // Search by Agent ID using BST
                Agent match = am.searchAgentByID(agentId.trim());
                agents = new ArrayList<>();
                if (match != null) {
                    agents.add(match);
                }
                request.setAttribute("searchQuery", agentId.trim());
                request.setAttribute("searchType", "id");

            } else if (specialization != null && !specialization.trim().isEmpty() && !"all".equalsIgnoreCase(specialization.trim())) {
                // Search by Specialization using BST
                agents = am.searchAgentBySpecialization(specialization.trim());
                request.setAttribute("searchQuery", specialization.trim());
                request.setAttribute("searchType", "specialization");

            } else {
                agents = am.getAllAgents();
            }

        } else {
            // Default: display all agents loaded from BST
            agents = am.getAllAgents();
        }

        request.setAttribute("agents", agents);
        request.getRequestDispatcher("agent-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AgentManagement am = getAgentManagement();
        String action = request.getParameter("action");

        if ("register".equalsIgnoreCase(action)) {
            handleRegisterAgent(request, response, am);
        } else if ("update".equalsIgnoreCase(action)) {
            handleUpdateAgent(request, response, am);
        } else if ("delete".equalsIgnoreCase(action)) {
            handleDeleteAgent(request, response, am);
        } else {
            response.sendRedirect("agents");
        }
    }

    /**
     * Handles registering a new Agent into the BST and persistent storage.
     */
    private void handleRegisterAgent(HttpServletRequest request, HttpServletResponse response, AgentManagement am)
            throws IOException {

        String agentID = request.getParameter("agentID");
        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String contactInfo = request.getParameter("contactInfo");
        String email = request.getParameter("email");
        String ratingStr = request.getParameter("averageRating");
        String reviewsStr = request.getParameter("totalReviews");

        // Basic validation
        if (agentID == null || agentID.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            specialization == null || specialization.trim().isEmpty()) {
            response.sendRedirect("agents?error=validation_failed");
            return;
        }

        double averageRating = 0.0;
        int totalReviews = 0;

        try {
            if (ratingStr != null && !ratingStr.trim().isEmpty()) {
                averageRating = Double.parseDouble(ratingStr.trim());
            }
            if (reviewsStr != null && !reviewsStr.trim().isEmpty()) {
                totalReviews = Integer.parseInt(reviewsStr.trim());
            }
        } catch (NumberFormatException e) {
            // Keep safe defaults on malformed number
            averageRating = 4.0;
            totalReviews = 0;
        }

        Agent newAgent = new Agent(
                agentID.trim(),
                name.trim(),
                specialization.trim(),
                contactInfo != null ? contactInfo.trim() : "",
                email != null ? email.trim() : "",
                averageRating,
                totalReviews
        );

        boolean success = am.registerAgent(newAgent);

        if (success) {
            response.sendRedirect("agents?msg=registered_success");
        } else {
            response.sendRedirect("agents?error=duplicate_id");
        }
    }

    /**
     * Handles updating an existing Agent profile in the BST and persistent storage.
     */
    private void handleUpdateAgent(HttpServletRequest request, HttpServletResponse response, AgentManagement am)
            throws IOException {

        String agentID = request.getParameter("agentID");
        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String contactInfo = request.getParameter("contactInfo");
        String email = request.getParameter("email");
        String ratingStr = request.getParameter("averageRating");
        String reviewsStr = request.getParameter("totalReviews");

        if (agentID == null || agentID.trim().isEmpty() ||
            name == null || name.trim().isEmpty()) {
            response.sendRedirect("agents?error=validation_failed");
            return;
        }

        double averageRating = 0.0;
        int totalReviews = 0;

        try {
            if (ratingStr != null && !ratingStr.trim().isEmpty()) {
                averageRating = Double.parseDouble(ratingStr.trim());
            }
            if (reviewsStr != null && !reviewsStr.trim().isEmpty()) {
                totalReviews = Integer.parseInt(reviewsStr.trim());
            }
        } catch (NumberFormatException e) {
            averageRating = 4.0;
            totalReviews = 0;
        }

        Agent updatedAgent = new Agent(
                agentID.trim(),
                name.trim(),
                specialization != null ? specialization.trim() : "Residential",
                contactInfo != null ? contactInfo.trim() : "",
                email != null ? email.trim() : "",
                averageRating,
                totalReviews
        );

        boolean success = am.updateAgentProfile(updatedAgent);

        if (success) {
            response.sendRedirect("agents?msg=updated_success");
        } else {
            response.sendRedirect("agents?error=update_failed");
        }
    }

    /**
     * Handles deleting/removing an Agent from the BST and persistent storage.
     */
    private void handleDeleteAgent(HttpServletRequest request, HttpServletResponse response, AgentManagement am)
            throws IOException {

        String agentID = request.getParameter("agentID");

        if (agentID == null || agentID.trim().isEmpty()) {
            response.sendRedirect("agents?error=validation_failed");
            return;
        }

        boolean success = am.removeAgent(agentID.trim());

        if (success) {
            response.sendRedirect("agents?msg=deleted_success");
        } else {
            response.sendRedirect("agents?error=delete_failed");
        }
    }
}
