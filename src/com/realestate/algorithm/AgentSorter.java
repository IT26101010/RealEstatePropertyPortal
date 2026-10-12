package com.realestate.algorithm;

import com.realestate.model.Agent;

import java.util.ArrayList;
import java.util.List;

/**
 * Utility class providing custom sorting algorithms for Agent entities.
 * Implements Selection Sort to sort agents by AverageRating in descending order.
 *
 * Part of Function 01: Agent Management (Part 5).
 * Designed for SLIIT Year 1 Semester 2.
 */
public class AgentSorter {

    /**
     * Sorts a list of Agent objects by their AverageRating in DESCENDING order
     * (highest rating first) using the Selection Sort algorithm.
     *
     * Rules followed:
     * - No built-in sorting methods (Collections.sort, List.sort, Arrays.sort) used.
     * - Creates and returns a new list without modifying the original input list.
     * - Safely handles null lists, empty lists, single-element lists, and null Agent objects.
     * - Preserves stability for agents with equal ratings where appropriate.
     *
     * @param agents The list of Agent objects to sort.
     * @return A new List containing the agents sorted by AverageRating in descending order.
     */
    public static List<Agent> sortAgentsByRating(List<Agent> agents) {
        // Handle null input safely
        if (agents == null) {
            return new ArrayList<>();
        }

        // Create a copy of the list to prevent mutating the caller's original list
        List<Agent> sortedList = new ArrayList<>();
        for (Agent agent : agents) {
            if (agent != null) {
                sortedList.add(agent);
            }
        }

        int n = sortedList.size();
        // If 0 or 1 element, already sorted
        if (n <= 1) {
            return sortedList;
        }

        // Selection Sort Algorithm: Descending Order (Highest to Lowest)
        for (int i = 0; i < n - 1; i++) {
            // Assume the maximum element is at the current index i
            int maxIndex = i;

            // Search the remaining unsorted portion [i + 1 ... n - 1] for the highest rating
            for (int j = i + 1; j < n; j++) {
                if (sortedList.get(j).getAverageRating() > sortedList.get(maxIndex).getAverageRating()) {
                    maxIndex = j;
                }
            }

            // Swap the found maximum element with the element at position i
            if (maxIndex != i) {
                Agent temp = sortedList.get(i);
                sortedList.set(i, sortedList.get(maxIndex));
                sortedList.set(maxIndex, temp);
            }
        }

        return sortedList;
    }

    /**
     * Optional utility method to display a list of agents sorted by rating to console.
     *
     * @param agents The list of agents to print.
     */
    public static void printAgentsByRating(List<Agent> agents) {
        if (agents == null || agents.isEmpty()) {
            System.out.println("No agents to display.");
            return;
        }

        System.out.println("=== Agents Ranked by Rating (Highest First) ===");
        for (Agent agent : agents) {
            if (agent != null) {
                System.out.printf("%s - %.1f (Name: %s, Specialization: %s)%n",
                        agent.getAgentID(),
                        agent.getAverageRating(),
                        agent.getName(),
                        agent.getSpecialization());
            }
        }
    }
}
