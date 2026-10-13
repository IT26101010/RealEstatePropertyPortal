<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Agent" %>

<%
    // Ensure data flows through AgentServlet for MVC separation
    List<Agent> agents = (List<Agent>) request.getAttribute("agents");
    if (agents == null) {
        response.sendRedirect("agents");
        return;
    }

    String msg = request.getParameter("msg");
    String error = request.getParameter("error");
    String searchQuery = (String) request.getAttribute("searchQuery");
    String searchType = (String) request.getAttribute("searchType");
    Boolean isSorted = (Boolean) request.getAttribute("isSorted");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Management | RealEstate</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #F7F3EA;
            color: #222;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ================= NAVBAR ================= */
        .navbar {
            height: 75px;
            background-color: #171717;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 7%;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.15);
        }

        .logo {
            color: #C9A227;
            font-size: 25px;
            font-weight: bold;
            text-decoration: none;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 28px;
        }

        .nav-links a {
            color: #F7F3EA;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .nav-links a:hover,
        .nav-links a.active-link {
            color: #C9A227;
        }

        .login-btn {
            background-color: #C9A227;
            color: #171717 !important;
            padding: 10px 20px;
            font-weight: bold;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background-color: #F7F3EA;
            transform: translateY(-2px);
        }

        .register-btn {
            border: 1px solid #C9A227;
            color: #C9A227 !important;
            padding: 9px 20px;
            border-radius: 5px;
            transition: 0.3s;
        }

        .register-btn:hover {
            background-color: #C9A227;
            color: #171717 !important;
        }

        /* ================= ALERTS ================= */
        .alert-container {
            width: 86%;
            max-width: 1200px;
            margin: 25px auto 0;
            animation: fadeDown 0.5s ease;
        }

        .alert {
            padding: 14px 20px;
            border-radius: 8px;
            font-size: 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .alert-success {
            background-color: #E8F5E9;
            color: #2E7D32;
            border-left: 5px solid #4CAF50;
        }

        .alert-error {
            background-color: #FFEBEE;
            color: #C62828;
            border-left: 5px solid #F44336;
        }

        .alert-close {
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            color: inherit;
        }

        /* ================= PAGE HEADER ================= */
        .page-header {
            text-align: center;
            padding: 60px 20px 35px;
            animation: fadeDown 0.8s ease;
        }

        .page-header h1 {
            font-size: 42px;
            color: #171717;
            margin-bottom: 12px;
        }

        .page-header h1 span {
            color: #C9A227;
        }

        .page-header h1::after {
            content: "";
            display: block;
            width: 55px;
            height: 3px;
            background-color: #C9A227;
            margin: 15px auto 0;
        }

        .page-header p {
            color: #777;
            font-size: 15px;
            max-width: 650px;
            margin: 0 auto;
            line-height: 1.6;
        }

        /* ================= SEARCH & TOOLBAR ================= */
        .filter-container {
            width: 86%;
            max-width: 1200px;
            margin: 0 auto 35px;
            background-color: white;
            padding: 22px 25px;
            border-top: 3px solid #C9A227;
            border-radius: 8px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
            animation: fadeUp 0.8s ease;
        }

        .filter-form {
            display: flex;
            gap: 12px;
            flex: 1;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-container input,
        .filter-container select {
            flex: 1;
            min-width: 180px;
            padding: 13px 15px;
            border: 1px solid #D8D2C8;
            border-radius: 5px;
            outline: none;
            background-color: #FAF8F3;
            font-size: 14px;
            color: #333;
            transition: all 0.3s ease;
        }

        .filter-container input:focus,
        .filter-container select:focus {
            border-color: #C9A227;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.15);
        }

        .btn-action {
            padding: 13px 22px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .filter-button {
            background-color: #171717;
            color: #C9A227;
        }

        .filter-button:hover {
            background-color: #C9A227;
            color: #171717;
            transform: translateY(-2px);
        }

        .sort-button {
            background-color: #C9A227;
            color: #171717;
        }

        .sort-button:hover {
            background-color: #E0BE45;
            transform: translateY(-2px);
        }

        .reset-button {
            background-color: #FAF8F3;
            color: #666;
            border: 1px solid #D8D2C8;
        }

        .reset-button:hover {
            background-color: #E8E2D8;
            color: #171717;
        }

        .register-agent-btn {
            background-color: #171717;
            color: #F7F3EA;
            border: 1px solid #C9A227;
            margin-left: auto;
        }

        .register-agent-btn:hover {
            background-color: #C9A227;
            color: #171717;
            transform: translateY(-2px);
        }

        /* ================= STATUS / META BAR ================= */
        .meta-status-bar {
            width: 86%;
            max-width: 1200px;
            margin: 0 auto 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #666;
            font-size: 14px;
        }

        .meta-status-bar .highlight-badge {
            background-color: #F3E8BF;
            color: #6F5510;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 8px;
        }

        /* ================= AGENTS SECTION & GRID ================= */
        .agents-section {
            width: 86%;
            max-width: 1200px;
            margin: 0 auto 80px;
            flex: 1;
        }

        .agent-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 28px;
        }

        /* ================= AGENT CARD ================= */
        .agent-card {
            background-color: white;
            border: 1px solid #E8E2D8;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);
            transition: transform 0.35s ease, box-shadow 0.35s ease, border-color 0.35s ease;
            animation: fadeUp 0.8s ease;
            display: flex;
            flex-direction: column;
        }

        .agent-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 35px rgba(0, 0, 0, 0.12);
            border-color: #C9A227;
        }

        .agent-image-wrapper {
            position: relative;
            width: 100%;
            height: 220px;
            background-color: #171717;
            overflow: hidden;
        }

        .agent-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .agent-card:hover .agent-image {
            transform: scale(1.05);
        }

        .specialization-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: #171717;
            color: #C9A227;
            padding: 6px 14px;
            font-size: 11px;
            font-weight: bold;
            border-radius: 4px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            border: 1px solid rgba(201, 162, 39, 0.3);
        }

        .agent-id-badge {
            position: absolute;
            bottom: 12px;
            left: 15px;
            background-color: rgba(23, 23, 23, 0.85);
            color: #F7F3EA;
            padding: 4px 10px;
            font-size: 12px;
            font-weight: bold;
            border-radius: 4px;
            backdrop-filter: blur(4px);
        }

        .agent-content {
            padding: 22px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .agent-name {
            font-size: 20px;
            color: #171717;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .agent-specialization-text {
            color: #888;
            font-size: 13px;
            margin-bottom: 14px;
        }

        /* Rating Area */
        .rating-box {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 16px;
            padding: 8px 12px;
            background-color: #FAF8F3;
            border-radius: 6px;
            border: 1px solid #E8E2D8;
        }

        .stars {
            color: #C9A227;
            font-size: 15px;
            letter-spacing: 2px;
        }

        .rating-num {
            font-weight: bold;
            color: #171717;
            font-size: 14px;
        }

        .reviews-count {
            color: #888;
            font-size: 12px;
            margin-left: auto;
        }

        /* Contact details */
        .contact-info-list {
            margin-bottom: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 7px;
            font-size: 13px;
            color: #555;
        }

        .contact-info-item {
            display: flex;
            align-items: center;
            gap: 8px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .contact-icon {
            color: #C9A227;
            font-size: 14px;
            min-width: 16px;
        }

        /* Card Action Buttons */
        .agent-card-actions {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 8px;
            padding-top: 15px;
            border-top: 1px solid #E8E2D8;
        }

        .card-action-btn {
            padding: 9px 8px;
            font-size: 12px;
            font-weight: bold;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            text-align: center;
            transition: all 0.25s ease;
            text-decoration: none;
        }

        .btn-view {
            background-color: #FAF8F3;
            color: #171717;
            border: 1px solid #D8D2C8;
        }

        .btn-view:hover {
            background-color: #E8E2D8;
            border-color: #C9A227;
        }

        .btn-update {
            background-color: #C9A227;
            color: #171717;
        }

        .btn-update:hover {
            background-color: #E0BE45;
            transform: translateY(-1px);
        }

        .btn-delete {
            background-color: #171717;
            color: #F7F3EA;
        }

        .btn-delete:hover {
            background-color: #c0392b;
            transform: translateY(-1px);
        }

        /* Empty State */
        .empty-state {
            grid-column: 1 / -1;
            background-color: white;
            border-radius: 8px;
            padding: 50px 20px;
            text-align: center;
            border: 1px solid #E8E2D8;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .empty-state h3 {
            font-size: 22px;
            margin-bottom: 10px;
            color: #171717;
        }

        .empty-state p {
            color: #777;
            margin-bottom: 25px;
        }

        /* ================= MODAL STYLES ================= */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.65);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            padding: 20px;
            backdrop-filter: blur(3px);
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-card {
            background-color: white;
            width: 100%;
            max-width: 520px;
            padding: 38px 40px;
            border-radius: 12px;
            border-top: 4px solid #C9A227;
            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.25);
            animation: fadeUp 0.4s ease;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
        }

        .modal-header {
            margin-bottom: 25px;
            text-align: center;
        }

        .modal-header h2 {
            font-size: 26px;
            color: #171717;
            margin-bottom: 6px;
        }

        .modal-header h2 span {
            color: #C9A227;
        }

        .modal-header p {
            color: #777;
            font-size: 13px;
        }

        .modal-close-btn {
            position: absolute;
            top: 18px;
            right: 20px;
            background: none;
            border: none;
            font-size: 22px;
            color: #999;
            cursor: pointer;
            transition: color 0.2s;
        }

        .modal-close-btn:hover {
            color: #171717;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-size: 13px;
            font-weight: bold;
            color: #333;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #D8D2C8;
            border-radius: 6px;
            font-size: 14px;
            background-color: #FAF8F3;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #C9A227;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.15);
        }

        .form-group input.readonly-id {
            background-color: #F7F3EA;
            color: #777;
            cursor: not-allowed;
        }

        .modal-footer {
            margin-top: 25px;
            display: flex;
            gap: 12px;
        }

        .modal-btn {
            flex: 1;
            padding: 13px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            border: none;
            transition: all 0.3s ease;
            text-align: center;
        }

        .modal-btn-primary {
            background-color: #C9A227;
            color: #171717;
        }

        .modal-btn-primary:hover {
            background-color: #E0BE45;
            transform: translateY(-1px);
        }

        .modal-btn-danger {
            background-color: #c0392b;
            color: white;
        }

        .modal-btn-danger:hover {
            background-color: #a93226;
            transform: translateY(-1px);
        }

        .modal-btn-secondary {
            background-color: #171717;
            color: #F7F3EA;
        }

        .modal-btn-secondary:hover {
            background-color: #333;
        }

        /* View Modal Details */
        .view-avatar-wrapper {
            text-align: center;
            margin-bottom: 20px;
        }

        .view-avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #C9A227;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .view-info-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .view-info-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #EEE;
        }

        .view-info-table td.label-cell {
            font-weight: bold;
            color: #666;
            width: 40%;
        }

        .view-info-table td.val-cell {
            color: #171717;
        }

        /* ================= FOOTER ================= */
        footer {
            background-color: #171717;
            color: #888;
            padding: 45px 7% 25px;
            margin-top: auto;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            padding-bottom: 25px;
            border-bottom: 1px solid #2B2B2B;
        }

        .footer-logo {
            font-size: 24px;
            font-weight: bold;
            color: #C9A227;
            margin-bottom: 6px;
        }

        .footer-text {
            color: #AAA;
            font-size: 13px;
        }

        .copyright {
            text-align: center;
            font-size: 13px;
            color: #666;
            padding-top: 20px;
        }

        /* ================= KEYFRAME ANIMATIONS ================= */
        @keyframes fadeDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(25px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ================= RESPONSIVE ================= */
        @media (max-width: 992px) {
            .agent-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .filter-container {
                flex-direction: column;
                align-items: stretch;
            }
            .register-agent-btn {
                margin-left: 0;
            }
        }

        @media (max-width: 650px) {
            .navbar {
                padding: 0 4%;
            }
            .nav-links a:not(.login-btn):not(.active-link) {
                display: none;
            }
            .agent-grid {
                grid-template-columns: 1fr;
            }
            .filter-form {
                flex-direction: column;
            }
            .filter-container input,
            .filter-container select,
            .btn-action {
                width: 100%;
            }
            .form-row {
                grid-template-columns: 1fr;
            }
            .modal-card {
                padding: 25px 20px;
            }
        }
    </style>
</head>
<body>

<!-- ================= NAVBAR ================= -->
<nav class="navbar">
    <a href="index.jsp" class="logo">RealEstate</a>

    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="properties.jsp">Properties</a>
        <a href="agents" class="active-link">Agents</a>
        <a href="search.jsp">Search Users</a>
        <a href="login.jsp" class="login-btn">Login</a>
        <a href="register.jsp" class="register-btn">Register</a>
    </div>
</nav>

<!-- ================= FLASH ALERTS ================= -->
<% if (msg != null && !msg.trim().isEmpty()) { %>
    <div class="alert-container">
        <div class="alert alert-success">
            <div>
                <% if ("registered_success".equals(msg)) { %>
                    <strong>Success!</strong> Agent registered successfully and saved to BST & persistent storage.
                <% } else if ("updated_success".equals(msg)) { %>
                    <strong>Success!</strong> Agent profile details updated successfully.
                <% } else if ("deleted_success".equals(msg)) { %>
                    <strong>Success!</strong> Agent removed successfully from the system.
                <% } else { %>
                    <strong>Success!</strong> Operation completed successfully.
                <% } %>
            </div>
            <button class="alert-close" onclick="this.parentElement.style.display='none';">&times;</button>
        </div>
    </div>
<% } %>

<% if (error != null && !error.trim().isEmpty()) { %>
    <div class="alert-container">
        <div class="alert alert-error">
            <div>
                <% if ("duplicate_id".equals(error)) { %>
                    <strong>Error:</strong> Registration failed. An agent with this Agent ID already exists!
                <% } else if ("update_failed".equals(error)) { %>
                    <strong>Error:</strong> Failed to update agent. ID not found or persistence issue.
                <% } else if ("delete_failed".equals(error)) { %>
                    <strong>Error:</strong> Failed to delete agent. ID not found.
                <% } else if ("validation_failed".equals(error)) { %>
                    <strong>Error:</strong> Please provide all required agent fields.
                <% } else { %>
                    <strong>Error:</strong> Operation failed. Please check inputs and try again.
                <% } %>
            </div>
            <button class="alert-close" onclick="this.parentElement.style.display='none';">&times;</button>
        </div>
    </div>
<% } %>

<!-- ================= PAGE HEADER ================= -->
<section class="page-header">
    <h1>Agent <span>Management</span></h1>
    <p>
        Discover, search and manage certified real estate agents across Sri Lanka.
        Powered by binary search tree indexing and custom Selection Sort ranking.
    </p>
</section>

<!-- ================= SEARCH & TOOLBAR ================= -->
<div class="filter-container">
    <form action="agents" method="get" class="filter-form">
        <input type="hidden" name="action" value="search">

        <!-- Search by Agent ID -->
        <input
            type="text"
            name="agentId"
            placeholder="Search by Agent ID (e.g. A001)"
            value="<%= ("id".equals(searchType) && searchQuery != null) ? searchQuery : "" %>">

        <!-- Search by Specialization -->
        <select name="specialization">
            <option value="">All Specializations</option>
            <option value="Residential" <%= ("Residential".equalsIgnoreCase(searchQuery)) ? "selected" : "" %>>Residential</option>
            <option value="Commercial" <%= ("Commercial".equalsIgnoreCase(searchQuery)) ? "selected" : "" %>>Commercial</option>
            <option value="Luxury" <%= ("Luxury".equalsIgnoreCase(searchQuery)) ? "selected" : "" %>>Luxury</option>
            <option value="Land" <%= ("Land".equalsIgnoreCase(searchQuery)) ? "selected" : "" %>>Land</option>
        </select>

        <button type="submit" class="btn-action filter-button">
            🔍 Search
        </button>

        <a href="agents" class="btn-action reset-button">
            ↺ Clear
        </a>

        <!-- Sort by Rating Button (Uses AgentManagement.sortAgentsByRating via Selection Sort) -->
        <a href="agents?action=sort" class="btn-action sort-button">
            ★ Sort by Rating
        </a>
    </form>

    <!-- Register Agent Button -->
    <button type="button" class="btn-action register-agent-btn" onclick="openRegisterModal()">
        + Register Agent
    </button>
</div>

<!-- ================= META STATUS BAR ================= -->
<div class="meta-status-bar">
    <div>
        <strong><%= (agents != null) ? agents.size() : 0 %></strong> Agent(s) Available
        <% if (Boolean.TRUE.equals(isSorted)) { %>
            <span class="highlight-badge">Sorted by Rating (Highest First)</span>
        <% } else if (searchQuery != null && !searchQuery.isEmpty()) { %>
            <span class="highlight-badge">Search Filter: <%= searchQuery %></span>
        <% } %>
    </div>
    <div>
        Index: In-Memory Binary Search Tree (BST)
    </div>
</div>

<!-- ================= AGENTS SECTION ================= -->
<section class="agents-section">
    <div class="agent-grid">

        <%
            // Curated photos matching agent index / style
            String[] agentPhotos = {
                "https://images.unsplash.com/photo-1560250097-0b93528c311a", // Businessman
                "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2", // Businesswoman
                "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7", // Businessman
                "https://images.unsplash.com/photo-1580489944761-15a19d654956", // Businesswoman
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d", // Businessman
                "https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e", // Businesswoman
                "https://images.unsplash.com/photo-1500648767791-00dcc994a43e", // Businessman
                "https://images.unsplash.com/photo-1534528741775-53994a69daeb", // Businesswoman
                "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61", // Businessman
                "https://images.unsplash.com/photo-1544005313-94ddf0286df2"  // Businesswoman
            };

            if (agents != null && !agents.isEmpty()) {
                int cardIndex = 0;
                for (Agent agent : agents) {
                    if (agent == null) continue;
                    String photoUrl = agentPhotos[cardIndex % agentPhotos.length];
                    cardIndex++;
        %>

        <!-- AGENT CARD -->
        <div class="agent-card">
            <div class="agent-image-wrapper">
                <img
                    class="agent-image"
                    src="<%= photoUrl %>"
                    alt="<%= agent.getName() %>">

                <span class="specialization-badge">
                    <%= agent.getSpecialization() %>
                </span>

                <span class="agent-id-badge">
                    ID: <%= agent.getAgentID() %>
                </span>
            </div>

            <div class="agent-content">
                <h3 class="agent-name"><%= agent.getName() %></h3>
                <p class="agent-specialization-text">Specialist in <%= agent.getSpecialization() %> Properties</p>

                <!-- Rating Display -->
                <div class="rating-box">
                    <span class="stars">★★★★★</span>
                    <span class="rating-num"><%= String.format("%.1f", agent.getAverageRating()) %></span>
                    <span class="reviews-count"><%= agent.getTotalReviews() %> Reviews</span>
                </div>

                <!-- Contact Details -->
                <div class="contact-info-list">
                    <div class="contact-info-item">
                        <span class="contact-icon">📞</span>
                        <span><%= agent.getContactInfo() %></span>
                    </div>
                    <div class="contact-info-item">
                        <span class="contact-icon">✉️</span>
                        <span><%= agent.getEmail() %></span>
                    </div>
                </div>

                <!-- Agent Actions: View, Update, Delete -->
                <div class="agent-card-actions">
                    <button
                        type="button"
                        class="card-action-btn btn-view"
                        onclick="openViewModal('<%= agent.getAgentID() %>', '<%= agent.getName() %>', '<%= agent.getSpecialization() %>', '<%= agent.getContactInfo() %>', '<%= agent.getEmail() %>', '<%= agent.getAverageRating() %>', '<%= agent.getTotalReviews() %>', '<%= photoUrl %>')">
                        View
                    </button>

                    <button
                        type="button"
                        class="card-action-btn btn-update"
                        onclick="openUpdateModal('<%= agent.getAgentID() %>', '<%= agent.getName() %>', '<%= agent.getSpecialization() %>', '<%= agent.getContactInfo() %>', '<%= agent.getEmail() %>', '<%= agent.getAverageRating() %>', '<%= agent.getTotalReviews() %>')">
                        Update
                    </button>

                    <button
                        type="button"
                        class="card-action-btn btn-delete"
                        onclick="openDeleteModal('<%= agent.getAgentID() %>', '<%= agent.getName() %>')">
                        Delete
                    </button>
                </div>
            </div>
        </div>

        <%
                }
            } else {
        %>

        <!-- EMPTY STATE -->
        <div class="empty-state">
            <h3>No Agents Found</h3>
            <p>No agents matched your search query. Try clearing the filter or registering a new agent.</p>
            <a href="agents" class="btn-action filter-button">View All Agents</a>
        </div>

        <% } %>

    </div>
</section>

<!-- ================= REGISTER AGENT MODAL ================= -->
<div id="registerModal" class="modal-overlay">
    <div class="modal-card">
        <button type="button" class="modal-close-btn" onclick="closeRegisterModal()">&times;</button>
        <div class="modal-header">
            <h2>Register <span>New Agent</span></h2>
            <p>Add a new real estate agent to the BST index and persistent storage</p>
        </div>

        <form action="agents" method="post">
            <input type="hidden" name="action" value="register">

            <div class="form-row">
                <div class="form-group">
                    <label>Agent ID *</label>
                    <input type="text" name="agentID" placeholder="e.g. A011" required>
                </div>

                <div class="form-group">
                    <label>Specialization *</label>
                    <select name="specialization" required>
                        <option value="Residential">Residential</option>
                        <option value="Commercial">Commercial</option>
                        <option value="Luxury">Luxury</option>
                        <option value="Land">Land</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" name="name" placeholder="e.g. Nuwan Pradeep" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Contact Info (Phone) *</label>
                    <input type="text" name="contactInfo" placeholder="e.g. 0771234567" required>
                </div>

                <div class="form-group">
                    <label>Email Address *</label>
                    <input type="email" name="email" placeholder="e.g. agent@gmail.com" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Average Rating (0.0 - 5.0)</label>
                    <input type="number" step="0.1" min="0.0" max="5.0" name="averageRating" value="4.5" required>
                </div>

                <div class="form-group">
                    <label>Total Reviews</label>
                    <input type="number" min="0" name="totalReviews" value="0" required>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="modal-btn modal-btn-secondary" onclick="closeRegisterModal()">Cancel</button>
                <button type="submit" class="modal-btn modal-btn-primary">Register Agent</button>
            </div>
        </form>
    </div>
</div>

<!-- ================= UPDATE AGENT MODAL ================= -->
<div id="updateModal" class="modal-overlay">
    <div class="modal-card">
        <button type="button" class="modal-close-btn" onclick="closeUpdateModal()">&times;</button>
        <div class="modal-header">
            <h2>Update <span>Agent Profile</span></h2>
            <p>Modify agent details while preserving the unique Agent ID</p>
        </div>

        <form action="agents" method="post">
            <input type="hidden" name="action" value="update">

            <div class="form-row">
                <div class="form-group">
                    <label>Agent ID (Read Only)</label>
                    <input type="text" id="updateAgentID" name="agentID" class="readonly-id" readonly required>
                </div>

                <div class="form-group">
                    <label>Specialization *</label>
                    <select id="updateSpecialization" name="specialization" required>
                        <option value="Residential">Residential</option>
                        <option value="Commercial">Commercial</option>
                        <option value="Luxury">Luxury</option>
                        <option value="Land">Land</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" id="updateName" name="name" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Contact Phone *</label>
                    <input type="text" id="updateContact" name="contactInfo" required>
                </div>

                <div class="form-group">
                    <label>Email Address *</label>
                    <input type="email" id="updateEmail" name="email" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Average Rating (0.0 - 5.0)</label>
                    <input type="number" step="0.1" min="0.0" max="5.0" id="updateRating" name="averageRating" required>
                </div>

                <div class="form-group">
                    <label>Total Reviews</label>
                    <input type="number" min="0" id="updateReviews" name="totalReviews" required>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="modal-btn modal-btn-secondary" onclick="closeUpdateModal()">Cancel</button>
                <button type="submit" class="modal-btn modal-btn-primary">Save Changes</button>
            </div>
        </form>
    </div>
</div>

<!-- ================= DELETE AGENT MODAL ================= -->
<div id="deleteModal" class="modal-overlay">
    <div class="modal-card">
        <button type="button" class="modal-close-btn" onclick="closeDeleteModal()">&times;</button>
        <div class="modal-header">
            <h2>Delete <span>Agent</span></h2>
            <p>Confirm permanent removal of agent record</p>
        </div>

        <form action="agents" method="post">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" id="deleteAgentID" name="agentID" value="">

            <p style="text-align: center; color: #444; line-height: 1.6; margin-bottom: 25px;">
                Are you sure you want to remove agent
                <strong id="deleteAgentName" style="color: #171717;"></strong>
                (<span id="deleteAgentIDDisplay" style="color: #C9A227; font-weight: bold;"></span>)?
                <br><br>
                This action will delete the agent node from the <strong>AgentBST</strong> and remove the record from <strong>agents.txt</strong>.
            </p>

            <div class="modal-footer">
                <button type="button" class="modal-btn modal-btn-secondary" onclick="closeDeleteModal()">Cancel</button>
                <button type="submit" class="modal-btn modal-btn-danger">Yes, Delete Agent</button>
            </div>
        </form>
    </div>
</div>

<!-- ================= VIEW AGENT DETAILS MODAL ================= -->
<div id="viewModal" class="modal-overlay">
    <div class="modal-card">
        <button type="button" class="modal-close-btn" onclick="closeViewModal()">&times;</button>
        <div class="modal-header">
            <h2>Agent <span>Profile</span></h2>
            <p>Detailed verification and certification info</p>
        </div>

        <div class="view-avatar-wrapper">
            <img id="viewAvatar" src="" alt="Agent" class="view-avatar">
        </div>

        <table class="view-info-table">
            <tr>
                <td class="label-cell">Agent ID</td>
                <td id="viewAgentID" class="val-cell"></td>
            </tr>
            <tr>
                <td class="label-cell">Full Name</td>
                <td id="viewName" class="val-cell"></td>
            </tr>
            <tr>
                <td class="label-cell">Specialization</td>
                <td id="viewSpecialization" class="val-cell"></td>
            </tr>
            <tr>
                <td class="label-cell">Contact Phone</td>
                <td id="viewContact" class="val-cell"></td>
            </tr>
            <tr>
                <td class="label-cell">Email Address</td>
                <td id="viewEmail" class="val-cell"></td>
            </tr>
            <tr>
                <td class="label-cell">Average Rating</td>
                <td id="viewRating" class="val-cell"></td>
            </tr>
            <tr>
                <td class="label-cell">Total Reviews</td>
                <td id="viewReviews" class="val-cell"></td>
            </tr>
        </table>

        <div class="modal-footer">
            <button type="button" class="modal-btn modal-btn-primary" onclick="closeViewModal()">Close Profile</button>
        </div>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<footer>
    <div class="footer-content">
        <div>
            <div class="footer-logo">RealEstate</div>
            <p class="footer-text">
                Your trusted platform for finding exceptional properties and certified real estate specialists.
            </p>
        </div>
    </div>

    <div class="copyright">
        &copy; 2026 RealEstate Property Portal. All rights reserved.
    </div>
</footer>

<!-- ================= JAVASCRIPT LOGIC ================= -->
<script>
    // Register Modal
    function openRegisterModal() {
        document.getElementById('registerModal').classList.add('active');
    }
    function closeRegisterModal() {
        document.getElementById('registerModal').classList.remove('active');
    }

    // Update Modal
    function openUpdateModal(id, name, specialization, contact, email, rating, reviews) {
        document.getElementById('updateAgentID').value = id;
        document.getElementById('updateName').value = name;
        document.getElementById('updateSpecialization').value = specialization;
        document.getElementById('updateContact').value = contact;
        document.getElementById('updateEmail').value = email;
        document.getElementById('updateRating').value = rating;
        document.getElementById('updateReviews').value = reviews;
        document.getElementById('updateModal').classList.add('active');
    }
    function closeUpdateModal() {
        document.getElementById('updateModal').classList.remove('active');
    }

    // Delete Modal
    function openDeleteModal(id, name) {
        document.getElementById('deleteAgentID').value = id;
        document.getElementById('deleteAgentIDDisplay').innerText = id;
        document.getElementById('deleteAgentName').innerText = name;
        document.getElementById('deleteModal').classList.add('active');
    }
    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.remove('active');
    }

    // View Modal
    function openViewModal(id, name, specialization, contact, email, rating, reviews, photo) {
        document.getElementById('viewAvatar').src = photo;
        document.getElementById('viewAgentID').innerText = id;
        document.getElementById('viewName').innerText = name;
        document.getElementById('viewSpecialization').innerText = specialization;
        document.getElementById('viewContact').innerText = contact;
        document.getElementById('viewEmail').innerText = email;
        document.getElementById('viewRating').innerText = '★ ' + rating + ' / 5.0';
        document.getElementById('viewReviews').innerText = reviews + ' Reviews';
        document.getElementById('viewModal').classList.add('active');
    }
    function closeViewModal() {
        document.getElementById('viewModal').classList.remove('active');
    }

    // Close on Escape or click outside
    window.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeRegisterModal();
            closeUpdateModal();
            closeDeleteModal();
            closeViewModal();
        }
    });

    document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
        overlay.addEventListener('click', function(e) {
            if (e.target === overlay) {
                closeRegisterModal();
                closeUpdateModal();
                closeDeleteModal();
                closeViewModal();
            }
        });
    });
</script>

</body>
</html>
