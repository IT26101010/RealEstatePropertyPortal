package com.realestate.datastructure;

import com.realestate.model.Agent;

import java.util.ArrayList;
import java.util.List;

/**
 * Binary Search Tree (BST) implementation for managing Agent objects.
 * Uses AgentID as the primary key for tree ordering.
 * Part of Function 01: Agent Management.
 */
public class AgentBST {

    // Internal Node class representing each element in the BST
    public static class Node {
        public Agent data;
        public Node left;
        public Node right;

        public Node(Agent data) {
            this.data = data;
            this.left = null;
            this.right = null;
        }
    }

    // Root node of the Binary Search Tree
    private Node root;

    // Default constructor
    public AgentBST() {
        this.root = null;
    }

    // Getter for root node
    public Node getRoot() {
        return root;
    }

    // Check if BST is empty
    public boolean isEmpty() {
        return root == null;
    }

    // Clear the tree
    public void clear() {
        root = null;
    }

    /**
     * Inserts an Agent into the BST based on AgentID.
     * If an agent with the same ID already exists, its data is updated.
     */
    public void insert(Agent agent) {
        if (agent == null || agent.getAgentID() == null) {
            return;
        }
        root = insertRecursive(root, agent);
    }

    private Node insertRecursive(Node current, Agent agent) {
        if (current == null) {
            return new Node(agent);
        }

        // Compare agentID using String comparison
        int compare = agent.getAgentID().compareTo(current.data.getAgentID());

        if (compare < 0) {
            current.left = insertRecursive(current.left, agent);
        } else if (compare > 0) {
            current.right = insertRecursive(current.right, agent);
        } else {
            // Duplicate AgentID: update existing node data
            current.data = agent;
        }

        return current;
    }

    /**
     * Searches for an Agent by AgentID using BST traversal (O(log n) average).
     */
    public Agent searchByID(String agentID) {
        if (agentID == null) {
            return null;
        }
        return searchByIDRecursive(root, agentID);
    }

    private Agent searchByIDRecursive(Node current, String agentID) {
        if (current == null) {
            return null;
        }

        // Compare agentID using String comparison
        int compare = agentID.compareTo(current.data.getAgentID());

        if (compare == 0) {
            return current.data; // Agent found
        } else if (compare < 0) {
            return searchByIDRecursive(current.left, agentID); // Search left subtree
        } else {
            return searchByIDRecursive(current.right, agentID); // Search right subtree
        }
    }

    /**
     * Searches and returns all agents matching the given specialization.
     * Traverses the entire tree since tree ordering is by AgentID.
     */
    public List<Agent> searchBySpecialization(String specialization) {
        List<Agent> results = new ArrayList<>();
        if (specialization == null) {
            return results;
        }

        searchBySpecializationRecursive(root, specialization.trim(), results);

        // Display results to console
        if (results.isEmpty()) {
            System.out.println("No agents found with specialization: " + specialization);
        } else {
            System.out.println("Found " + results.size() + " agent(s) with specialization '" + specialization + "':");
            for (Agent agent : results) {
                System.out.println(agent);
            }
        }

        return results;
    }

    private void searchBySpecializationRecursive(Node current, String specialization, List<Agent> results) {
        if (current == null) {
            return;
        }

        // Inorder traversal to inspect all nodes
        searchBySpecializationRecursive(current.left, specialization, results);

        if (current.data.getSpecialization() != null &&
                current.data.getSpecialization().equalsIgnoreCase(specialization)) {
            results.add(current.data);
        }

        searchBySpecializationRecursive(current.right, specialization, results);
    }

    /**
     * Deletes an Agent from the BST by AgentID.
     * Handles leaf nodes, nodes with one child, and nodes with two children.
     */
    public void delete(String agentID) {
        if (agentID == null) {
            return;
        }
        root = deleteRecursive(root, agentID);
    }

    private Node deleteRecursive(Node current, String agentID) {
        if (current == null) {
            return null;
        }

        int compare = agentID.compareTo(current.data.getAgentID());

        if (compare < 0) {
            current.left = deleteRecursive(current.left, agentID);
            return current;
        } else if (compare > 0) {
            current.right = deleteRecursive(current.right, agentID);
            return current;
        } else {
            // Node to be deleted found!

            // Case 1: Leaf node (no children)
            if (current.left == null && current.right == null) {
                return null;
            }

            // Case 2: Node with only one child
            if (current.left == null) {
                return current.right;
            }
            if (current.right == null) {
                return current.left;
            }

            // Case 3: Node with two children
            // Find in-order successor (smallest value in right subtree)
            Node successor = findMin(current.right);

            // Replace current node's data with successor's data
            current.data = successor.data;

            // Delete the successor from the right subtree
            current.right = deleteRecursive(current.right, successor.data.getAgentID());
            return current;
        }
    }

    // Helper method to find the node with minimum key value in a subtree
    private Node findMin(Node node) {
        while (node.left != null) {
            node = node.left;
        }
        return node;
    }

    /**
     * Performs an In-Order Traversal (Left, Root, Right) and prints each Agent.
     * This prints agents sorted in ascending order of AgentID.
     */
    public void inorderTraversal() {
        inorderTraversalRecursive(root);
    }

    private void inorderTraversalRecursive(Node current) {
        if (current != null) {
            inorderTraversalRecursive(current.left);
            System.out.println(current.data);
            inorderTraversalRecursive(current.right);
        }
    }

    /**
     * Returns a List of all agents in sorted order of AgentID using in-order traversal.
     */
    public List<Agent> getAllAgents() {
        List<Agent> agentList = new ArrayList<>();
        getAllAgentsRecursive(root, agentList);
        return agentList;
    }

    private void getAllAgentsRecursive(Node current, List<Agent> agentList) {
        if (current != null) {
            getAllAgentsRecursive(current.left, agentList);
            agentList.add(current.data);
            getAllAgentsRecursive(current.right, agentList);
        }
    }
}
