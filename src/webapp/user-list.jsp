
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.User" %>

<%
    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if (!"Admin".equalsIgnoreCase(
            loggedInUser.getMembershipType())) {
        response.sendError(403, "Admin access required.");
        return;
    }

    List<User> users =
        (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>User Management | Real Estate Portal</title>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background: #F7F3EA;
            color: #222;
            min-height: 100vh;
        }

        nav {
            background: #171717;
            color: white;
            padding: 20px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            color: #C9A227;
            font-size: 22px;
            font-weight: bold;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        nav a:hover {
            color: #C9A227;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 45px auto;
            animation: fadeUp 0.6s ease;
        }

        .heading {
            margin-bottom: 25px;
        }

        .heading h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #666;
            line-height: 1.6;
        }

        .table-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.07);
            overflow-x: auto;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }

        .user-table th {
            background: #171717;
            color: #C9A227;
            text-align: left;
            padding: 16px 14px;
        }

        .user-table td {
            padding: 15px 14px;
            border-bottom: 1px solid #eee;
        }

        .user-table tbody tr:hover {
            background: #FCF8ED;
        }

        .role {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: #F3E8BF;
            color: #6F5510;
            font-size: 12px;
            font-weight: bold;
        }

        .count {
            margin-bottom: 18px;
            color: #555;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
            background: #171717;
            color: #C9A227;
            padding: 12px 20px;
            border-radius: 6px;
            text-decoration: none;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: #C9A227;
            color: #171717;
            transform: translateY(-2px);
        }

        .empty {
            text-align: center;
            padding: 30px;
            color: #777;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(15px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 600px) {
            nav {
                padding: 18px 5%;
            }

            nav a {
                margin-left: 0;
                margin-right: 14px;
            }

            .container {
                margin: 30px auto;
            }

            .heading h1 {
                font-size: 26px;
            }

            .table-card {
                padding: 12px;
            }
        }
    </style>
</head>

<body>

<nav>
    <div class="logo">REAL ESTATE</div>

    <div>
        <a href="index.jsp">Home</a>
        <a href="profile.jsp">My Profile</a>
        <a href="logout">Logout</a>
    </div>
</nav>

<div class="container">

    <div class="heading">
        <h1>User Management</h1>
        <p>
            View registered users and their account information.
        </p>
    </div>

    <div class="table-card">

        <p class="count">
            Total registered users:
            <strong><%= users == null ? 0 : users.size() %></strong>
        </p>

        <table class="user-table">
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Membership Type</th>
                </tr>
            </thead>

            <tbody>
            <% if (users != null && !users.isEmpty()) {
                   for (User user : users) { %>

                <tr>
                    <td><%= escapeHtml(user.getUserId()) %></td>
                    <td><%= escapeHtml(user.getUsername()) %></td>
                    <td><%= escapeHtml(user.getEmail()) %></td>
                    <td>
                        <span class="role">
                            <%= escapeHtml(user.getMembershipType()) %>
                        </span>
                    </td>
                </tr>

            <%     }
               } else { %>

                <tr>
                    <td colspan="4" class="empty">
                        No registered users found.
                    </td>
                </tr>

            <% } %>
            </tbody>
        </table>

    </div>

    <a href="profile.jsp" class="back-btn">
        Back to My Profile
    </a>

</div>

<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>

</body>
</html>

