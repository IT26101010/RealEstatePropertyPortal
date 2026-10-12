package com.realestate.util;

import com.realestate.model.Agent;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Utility class for managing file persistence of Agent records.
 * Uses agents.txt with comma-separated values matching Agent.toFileString().
 * Part of Function 01: Agent Management.
 */
public class AgentFileHandler {

    private static final String DEFAULT_FILE_NAME = "agents.txt";
    private static String customFilePath = null;

    /**
     * Allows setting a custom file path dynamically if required (e.g., from a ServletContext).
     */
    public static void setFilePath(String path) {
        customFilePath = path;
    }

    /**
     * Resolves the agents.txt file dynamically without hardcoded personal system paths.
     * Automatically creates the file if it does not exist.
     */
    public static File getFile() {
        if (customFilePath != null && !customFilePath.trim().isEmpty()) {
            File customFile = new File(customFilePath);
            ensureFileExists(customFile);
            return customFile;
        }

        // 1. Check in the current working directory (e.g. project root during standard execution)
        File currentDirFile = new File(DEFAULT_FILE_NAME);
        if (currentDirFile.exists()) {
            return currentDirFile;
        }

        // 2. Check in parent directory (useful when running inside an application server container)
        File parentDirFile = new File("..", DEFAULT_FILE_NAME);
        if (parentDirFile.exists()) {
            return parentDirFile;
        }

        // 3. Fallback to current directory and ensure it is created
        ensureFileExists(currentDirFile);
        return currentDirFile;
    }

    /**
     * Ensures the file and its parent directories exist.
     */
    private static void ensureFileExists(File file) {
        try {
            if (!file.exists()) {
                File parent = file.getParentFile();
                if (parent != null && !parent.exists()) {
                    parent.mkdirs();
                }
                file.createNewFile();
            }
        } catch (IOException e) {
            System.err.println("Error ensuring " + file.getName() + " exists: " + e.getMessage());
        }
    }

    /**
     * Safely parses one line from agents.txt into an Agent object.
     * Returns null if the line is empty, invalid, or malformed.
     */
    private static Agent parseAgentLine(String line) {
        if (line == null) {
            return null;
        }

        String trimmed = line.trim();
        if (trimmed.isEmpty()) {
            return null;
        }

        String[] parts = trimmed.split(",", -1);
        if (parts.length < 7) {
            System.err.println("Skipping malformed agent line (insufficient columns): " + line);
            return null;
        }

        try {
            String agentID = parts[0].trim();
            String name = parts[1].trim();
            String specialization = parts[2].trim();
            String contactInfo = parts[3].trim();
            String email = parts[4].trim();
            double averageRating = Double.parseDouble(parts[5].trim());
            int totalReviews = Integer.parseInt(parts[6].trim());

            return new Agent(agentID, name, specialization, contactInfo, email, averageRating, totalReviews);
        } catch (NumberFormatException e) {
            System.err.println("Skipping malformed agent line (number parse error): " + line);
            return null;
        }
    }

    /**
     * Reads and loads all agents from agents.txt.
     * Safely handles empty lines and malformed entries.
     */
    public static List<Agent> loadAllAgents() {
        List<Agent> agents = new ArrayList<>();
        File file = getFile();

        if (!file.exists()) {
            return agents;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Agent agent = parseAgentLine(line);
                if (agent != null) {
                    agents.add(agent);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading agents.txt: " + e.getMessage());
        }

        return agents;
    }

    /**
     * Returns all agents from file persistence.
     * Wrapper for loadAllAgents().
     */
    public static List<Agent> getAllAgents() {
        return loadAllAgents();
    }

    /**
     * Finds and returns an Agent by AgentID.
     * Returns null if no matching agent is found.
     */
    public static Agent findAgentById(String agentID) {
        if (agentID == null || agentID.trim().isEmpty()) {
            return null;
        }

        String targetId = agentID.trim();
        List<Agent> agents = loadAllAgents();

        for (Agent agent : agents) {
            if (agent.getAgentID().equalsIgnoreCase(targetId)) {
                return agent;
            }
        }

        return null;
    }

    /**
     * Appends a new Agent to agents.txt.
     * Validates that the agent is not null and AgentID does not already exist.
     */
    public static boolean addAgent(Agent agent) {
        if (agent == null || agent.getAgentID() == null || agent.getAgentID().trim().isEmpty()) {
            return false;
        }

        // Check if an agent with the same ID already exists
        if (findAgentById(agent.getAgentID()) != null) {
            System.err.println("Cannot add duplicate Agent ID: " + agent.getAgentID());
            return false;
        }

        File file = getFile();

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
            writer.write(agent.toFileString());
            writer.newLine();
            return true;
        } catch (IOException e) {
            System.err.println("Error appending agent to file: " + e.getMessage());
            return false;
        }
    }

    /**
     * Updates an existing Agent in agents.txt by AgentID.
     * Replaces the matching record while preserving all other records.
     */
    public static boolean updateAgent(Agent updatedAgent) {
        if (updatedAgent == null || updatedAgent.getAgentID() == null || updatedAgent.getAgentID().trim().isEmpty()) {
            return false;
        }

        String targetId = updatedAgent.getAgentID().trim();
        List<Agent> agents = loadAllAgents();
        boolean found = false;

        for (int i = 0; i < agents.size(); i++) {
            if (agents.get(i).getAgentID().equalsIgnoreCase(targetId)) {
                agents.set(i, updatedAgent);
                found = true;
                break;
            }
        }

        if (found) {
            return saveAllAgents(agents);
        }

        return false;
    }

    /**
     * Deletes an Agent by AgentID from agents.txt.
     * Preserves all other agents.
     */
    public static boolean deleteAgent(String agentID) {
        if (agentID == null || agentID.trim().isEmpty()) {
            return false;
        }

        String targetId = agentID.trim();
        List<Agent> agents = loadAllAgents();
        boolean removed = false;

        Iterator<Agent> iterator = agents.iterator();
        while (iterator.hasNext()) {
            Agent agent = iterator.next();
            if (agent.getAgentID().equalsIgnoreCase(targetId)) {
                iterator.remove();
                removed = true;
                break;
            }
        }

        if (removed) {
            return saveAllAgents(agents);
        }

        return false;
    }

    /**
     * Overwrites agents.txt with the provided list of agents using a temporary file
     * and atomic replace to prevent data corruption.
     */
    public static boolean saveAllAgents(List<Agent> agents) {
        File file = getFile();
        File parentDir = file.getParentFile() != null ? file.getParentFile() : new File(".");
        File tempFile = new File(parentDir, "agents_temp.txt");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile, false))) {
            if (agents != null) {
                for (Agent agent : agents) {
                    if (agent != null) {
                        writer.write(agent.toFileString());
                        writer.newLine();
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error writing to temporary file: " + e.getMessage());
            if (tempFile.exists()) {
                tempFile.delete();
            }
            return false;
        }

        try {
            Files.move(
                    tempFile.toPath(),
                    file.toPath(),
                    StandardCopyOption.REPLACE_EXISTING
            );
            return true;
        } catch (IOException e) {
            System.err.println("Error replacing agents file: " + e.getMessage());
            if (tempFile.exists()) {
                tempFile.delete();
            }
            return false;
        }
    }
}
