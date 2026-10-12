package com.realestate.service;

import com.realestate.datastructure.AgentBST;
import com.realestate.model.Agent;
import com.realestate.util.AgentFileHandler;

import java.util.ArrayList;
import java.util.List;

/**
 * Central service class coordinating the Agent model, AgentBST data structure,
 * and AgentFileHandler persistent storage.
 *
 * Part of Function 01: Agent Management (Part 4).
 * Designed for SLIIT Year 1 Semester 2.
 */
public class AgentManagement {

    // Main in-memory data structure for indexing and searching agents by AgentID
    private AgentBST agentBST;

    /**
     * Default constructor.
     * Initializes an empty BST and loads existing agents from agents.txt.
     */
    public AgentManagement() {
        this.agentBST = new AgentBST();
        loadBSTFromFile();
    }

    /**
     * Parameterized constructor allowing injection of an existing AgentBST.
     *
     * @param agentBST Existing AgentBST instance.
     */
    public AgentManagement(AgentBST agentBST) {
        if (agentBST != null) {
            this.agentBST = agentBST;
        } else {
            this.agentBST = new AgentBST();
            loadBSTFromFile();
        }
    }

    /**
     * 7. loadBSTFromFile()
     * Loads all agents from persistent storage (via AgentFileHandler),
     * inserts them into a new/empty AgentBST, and prevents duplicate AgentIDs.
     * Safely handles non-existent or empty files by leaving the BST empty.
     */
    public void loadBSTFromFile() {
        // Initialize a new empty BST
        this.agentBST = new AgentBST();

        // Load agents from file persistence
        List<Agent> agents = AgentFileHandler.loadAllAgents();

        if (agents != null) {
            for (Agent agent : agents) {
                if (agent != null && agent.getAgentID() != null && !agent.getAgentID().trim().isEmpty()) {
                    String id = agent.getAgentID().trim();
                    // Avoid duplicate AgentIDs
                    if (this.agentBST.searchByID(id) == null) {
                        this.agentBST.insert(agent);
                    }
                }
            }
        }
    }

    /**
     * 8. serializeBSTToFile()
     * Retrieves all agents from the BST in sorted order (using in-order traversal via getAllAgents())
     * and saves them to agents.txt via AgentFileHandler.saveAllAgents().
     * Does not manually perform file I/O operations inside AgentManagement.
     *
     * @return true if persistence succeeded, false otherwise
     */
    public boolean serializeBSTToFile() {
        List<Agent> allAgents = getAllAgents();
        return AgentFileHandler.saveAllAgents(allAgents);
    }

    /**
     * 1. registerAgent(Agent agent)
     * Registers a new agent into the system.
     * - Validates that the agent and its ID are not null or empty.
     * - Verifies whether the AgentID already exists in the BST.
     * - Inserts the agent into the BST.
     * - Persists the updated agents to agents.txt.
     *
     * @param agent The Agent object to register.
     * @return true if registration and file persistence succeeded, false otherwise.
     */
    public boolean registerAgent(Agent agent) {
        // Validate agent object and ID
        if (agent == null || agent.getAgentID() == null || agent.getAgentID().trim().isEmpty()) {
            System.err.println("Cannot register agent: Agent or AgentID is null/empty.");
            return false;
        }

        String agentID = agent.getAgentID().trim();

        // Check whether AgentID already exists in BST
        if (searchAgentByID(agentID) != null) {
            System.err.println("Cannot register agent: AgentID " + agentID + " already exists.");
            return false;
        }

        // Add agent to the BST
        agentBST.insert(agent);

        // Persist the updated agents to agents.txt
        boolean saved = serializeBSTToFile();
        if (!saved) {
            // Roll back insertion in BST if persistence fails to maintain synchronization
            agentBST.delete(agentID);
            System.err.println("Registration failed: Could not persist agents to file.");
            return false;
        }

        return true;
    }

    /**
     * 2. searchAgentByID(String agentID)
     * Searches for an agent using BST search (O(log n) average).
     * Does not search the file directly when the in-memory BST can be used.
     *
     * @param agentID The ID of the agent to search for.
     * @return The matching Agent object, or null if not found.
     */
    public Agent searchAgentByID(String agentID) {
        if (agentID == null || agentID.trim().isEmpty() || agentBST == null) {
            return null;
        }
        return agentBST.searchByID(agentID.trim());
    }

    /**
     * 3. searchAgentBySpecialization(String specialization)
     * Searches for agents matching the specified specialization using the BST traversal.
     *
     * @param specialization The specialization to search for (e.g., "Residential", "Commercial").
     * @return A List of matching Agent objects.
     */
    public List<Agent> searchAgentBySpecialization(String specialization) {
        if (specialization == null || agentBST == null) {
            return new ArrayList<>();
        }
        return agentBST.searchBySpecialization(specialization.trim());
    }

    /**
     * 4. updateAgentProfile(Agent updatedAgent)
     * Updates an existing agent's details in the BST and file.
     * - Finds the existing agent by AgentID using the BST.
     * - Updates fields while keeping the same AgentID.
     * - Updates the BST data correctly.
     * - Persists the updated data to agents.txt.
     *
     * @param updatedAgent The Agent object containing updated details.
     * @return true if update and persistence succeeded, false otherwise.
     */
    public boolean updateAgentProfile(Agent updatedAgent) {
        if (updatedAgent == null || updatedAgent.getAgentID() == null || updatedAgent.getAgentID().trim().isEmpty()) {
            System.err.println("Cannot update agent: Agent or AgentID is null/empty.");
            return false;
        }

        String agentID = updatedAgent.getAgentID().trim();
        Agent existingAgent = searchAgentByID(agentID);

        if (existingAgent == null) {
            System.err.println("Cannot update agent: No agent found with ID " + agentID);
            return false;
        }

        // Backup existing values for rollback if persistence fails
        String oldName = existingAgent.getName();
        String oldSpecialization = existingAgent.getSpecialization();
        String oldContact = existingAgent.getContactInfo();
        String oldEmail = existingAgent.getEmail();
        double oldRating = existingAgent.getAverageRating();
        int oldReviews = existingAgent.getTotalReviews();

        // Update existing agent fields while preserving AgentID
        existingAgent.setName(updatedAgent.getName());
        existingAgent.setSpecialization(updatedAgent.getSpecialization());
        existingAgent.setContactInfo(updatedAgent.getContactInfo());
        existingAgent.setEmail(updatedAgent.getEmail());
        existingAgent.setAverageRating(updatedAgent.getAverageRating());
        existingAgent.setTotalReviews(updatedAgent.getTotalReviews());

        // Update BST data correctly
        agentBST.insert(existingAgent);

        // Persist updated data to agents.txt
        boolean saved = serializeBSTToFile();
        if (!saved) {
            // Roll back to previous state to maintain consistency
            existingAgent.setName(oldName);
            existingAgent.setSpecialization(oldSpecialization);
            existingAgent.setContactInfo(oldContact);
            existingAgent.setEmail(oldEmail);
            existingAgent.setAverageRating(oldRating);
            existingAgent.setTotalReviews(oldReviews);
            agentBST.insert(existingAgent);
            System.err.println("Update failed: Could not persist changes to file.");
            return false;
        }

        return true;
    }

    /**
     * 5. deleteAgentFromBST(String agentID)
     * Deletes the agent from the AgentBST and synchronizes the updated data to agents.txt.
     *
     * @param agentID The ID of the agent to delete.
     * @return true if deletion and persistence succeeded, false otherwise.
     */
    public boolean deleteAgentFromBST(String agentID) {
        if (agentID == null || agentID.trim().isEmpty() || agentBST == null) {
            return false;
        }

        String targetID = agentID.trim();
        Agent existingAgent = searchAgentByID(targetID);

        if (existingAgent == null) {
            System.err.println("Cannot delete agent: AgentID " + targetID + " not found.");
            return false;
        }

        // Delete from BST
        agentBST.delete(targetID);

        // Persist updated BST data to agents.txt
        boolean saved = serializeBSTToFile();
        if (!saved) {
            // Roll back BST deletion if file saving fails
            agentBST.insert(existingAgent);
            System.err.println("Deletion failed: Could not persist updated tree to file.");
            return false;
        }

        return true;
    }

    /**
     * 6. removeAgent(String agentID)
     * Complete agent removal operation.
     * Removes the agent from the BST and ensures persistent storage remains synchronized.
     *
     * @param agentID The ID of the agent to remove.
     * @return true if removal succeeded, false otherwise.
     */
    public boolean removeAgent(String agentID) {
        // Coordinates BST deletion and file persistence
        return deleteAgentFromBST(agentID);
    }

    /**
     * 9. getAllAgents()
     * Returns all agents currently stored in the BST in sorted order of AgentID.
     *
     * @return List of all agents in the BST.
     */
    public List<Agent> getAllAgents() {
        if (agentBST == null) {
            return new ArrayList<>();
        }
        return agentBST.getAllAgents();
    }

    /**
     * 10. getAgentBST()
     * Returns the internal AgentBST instance for internal operations if needed,
     * without exposing unnecessary implementation details directly to JSP views.
     *
     * @return The current AgentBST instance.
     */
    public AgentBST getAgentBST() {
        return this.agentBST;
    }

    /**
     * Alias method for getAgentBST() to support alternative getter naming.
     *
     * @return The current AgentBST instance.
     */
    public AgentBST getBST() {
        return this.agentBST;
    }

    /**
     * Checks if the agent collection is currently empty.
     *
     * @return true if empty, false otherwise.
     */
    public boolean isEmpty() {
        return agentBST == null || agentBST.isEmpty();
    }

    /**
     * Returns the total count of agents currently in the BST.
     *
     * @return Total number of agents.
     */
    public int getAgentCount() {
        return getAllAgents().size();
    }
}
