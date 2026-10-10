
<%@ page import="com.realestate.model.User" %>

<%
    User loggedInUser =
        (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Profile | RealEstate</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f7f3ea;
            color: #171717;
        }

        nav {
            background: #171717;
            color: #c9a227;
            padding: 25px 7%;
            font-size: 24px;
            font-weight: bold;
        }

        .container {
            min-height: calc(100vh - 74px);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 35px 20px;
        }

        .card {
            width: 100%;
            max-width: 500px;
            background: white;
            padding: 38px;
            border-radius: 12px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.1);
            animation: fadeUp 0.7s ease;
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

        h1 {
            text-align: center;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 28px;
            font-size: 14px;
        }

        label {
            display: block;
            margin: 17px 0 7px;
            font-size: 14px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 13px;
            border: 1px solid #ddd5c5;
            border-radius: 6px;
            background: #fff;
            font-size: 15px;
            outline: none;
        }

        input:focus, select:focus {
            border-color: #c9a227;
            box-shadow: 0 0 5px rgba(201,162,39,0.25);
        }

        .user-id {
            background: #f7f3ea;
            color: #777;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 14px;
            border: none;
            border-radius: 6px;
            background: #c9a227;
            color: #171717;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #b18d1c;
            transform: translateY(-2px);
        }

        .back {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #171717;
            text-decoration: none;
            font-size: 14px;
        }

        .back:hover {
            color: #b18d1c;
        }

        @media (max-width: 520px) {
            .card {
                padding: 25px;
            }
        }
    </style>
</head>

<body>

<nav>RealEstate</nav>

<div class="container">
    <div class="card">

        <h1>Update Profile</h1>

        <p class="subtitle">
            Keep your account information up to date
        </p>

        <form action="update-profile" method="post">

            <label>User ID</label>
            <input type="text"
                   value="<%= loggedInUser.getUserId() %>"
                   class="user-id"
                   readonly>

            <label>Username</label>
            <input type="text"
                   value="<%= loggedInUser.getUsername() %>"
                   readonly
                   class="user-id">

            <label>Email</label>
            <input type="email"
                   name="email"
                   value="<%= loggedInUser.getEmail() %>"
                   required>

            <label>New Password</label>
            <input type="password"
                   name="password"
                   placeholder="Enter your new password"
                   required>

            <label>Membership Type</label>
            <select name="membershipType" required>
                <option value="Regular"
                    <%= "Regular".equals(loggedInUser.getMembershipType())
                        ? "selected" : "" %>>
                    Regular
                </option>

                <option value="Admin"
                    <%= "Admin".equals(loggedInUser.getMembershipType())
                        ? "selected" : "" %>>
                    Admin
                </option>
            </select>

            <button type="submit">Save Changes</button>

        </form>

        <a href="profile.jsp" class="back">← Back to My Account</a>

    </div>
</div>

</body>
</html>