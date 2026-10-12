package com.realestate.model;

/**
 * Model class representing a Real Estate Agent.
 * Part of Function 01: Agent Management.
 */
public class Agent {

    // Private attributes
    private String agentID;
    private String name;
    private String specialization;
    private String contactInfo;
    private String email;
    private double averageRating;
    private int totalReviews;

    // Default constructor
    public Agent() {
    }

    // Parameterized constructor
    public Agent(String agentID, String name, String specialization, String contactInfo, String email, double averageRating, int totalReviews) {
        this.agentID = agentID;
        this.name = name;
        this.specialization = specialization;
        this.contactInfo = contactInfo;
        this.email = email;
        this.averageRating = averageRating;
        this.totalReviews = totalReviews;
    }

    // Getters and Setters
    public String getAgentID() {
        return agentID;
    }

    public void setAgentID(String agentID) {
        this.agentID = agentID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public int getTotalReviews() {
        return totalReviews;
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }

    // Method to convert the Agent object into a single line suitable for agents.txt
    public String toFileString() {
        return agentID + "," + name + "," + specialization + "," + contactInfo + "," + email + "," + averageRating + "," + totalReviews;
    }

    @Override
    public String toString() {
        return "Agent [agentID=" + agentID + ", name=" + name + ", specialization=" + specialization
                + ", contactInfo=" + contactInfo + ", email=" + email + ", averageRating=" + averageRating
                + ", totalReviews=" + totalReviews + "]";
    }
}
