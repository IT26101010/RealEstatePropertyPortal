```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Search User | Real Estate</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #F7F3EA;
            color: #171717;
            min-height: 100vh;
        }

        nav {
            background: #171717;
            color: #F7F3EA;
            padding: 22px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: #C9A227;
            font-size: 21px;
            font-weight: bold;
        }

        nav a {
            color: #F7F3EA;
            text-decoration: none;
            margin-left: 22px;
            font-size: 14px;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #C9A227;
        }

        .container {
            min-height: 75vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .search-card {
            width: 100%;
            max-width: 520px;
            padding: 40px;
            background: white;
            border: 1px solid #e5d9b8;
            border-radius: 16px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
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

        .search-card h1 {
            font-size: 28px;
            margin-bottom: 12px;
        }

        .highlight {
            color: #C9A227;
        }

        .description {
            color: #777;
            line-height: 1.7;
            font-size: 14px;
            margin-bottom: 28px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-size: 14px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #ddd5c4;
            border-radius: 8px;
            outline: none;
            font-size: 14px;
            transition: border 0.3s, box-shadow 0.3s;
        }

        input:focus {
            border-color: #C9A227;
            box-shadow: 0 0 0 3px rgba(201, 162, 39, 0.15);
        }

        .search-btn {
            width: 100%;
            margin-top: 20px;
            padding: 14px;
            border: none;
            border-radius: 8px;
            background: #C9A227;
            color: #171717;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-btn:hover {
            background: #171717;
            color: #F7F3EA;
            transform: translateY(-2px);
            box-shadow: 0 7px 18px rgba(0, 0, 0, 0.15);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 24px;
            color: #6f5a1c;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .error {
            margin-top: 18px;
            color: #a33a2b;
            font-size: 14px;
            text-align: center;
        }

        footer {
            text-align: center;
            background: #171717;
            color: #c9c3b6;
            padding: 18px;
            font-size: 12px;
        }

        @media (max-width: 600px) {
            nav {
                padding: 20px;
                flex-direction: column;
                gap: 15px;
            }

            nav a {
                margin: 0 7px;
            }

            .search-card {
                padding: 28px 22px;
            }

            .search-card h1 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

<nav>
    <div class="logo">REAL ESTATE</div>

    <div>
        <a href="index.jsp">Home</a>
        <a href="properties.jsp">Properties</a>
        <a href="profile.jsp">My Profile</a>
    </div>
</nav>

<main class="container">

    <section class="search-card">

        <h1>Search <span class="highlight">Users</span></h1>

        <p class="description">
            Find a registered user using their User ID or username.
        </p>

        <form action="search" method="post">

            <label for="searchValue">User ID or Username</label>

            <input
                type="text"
                id="searchValue"
                name="searchValue"
                placeholder="e.g. U001 or kamal"
                required
            >

            <button type="submit" class="search-btn">
                Search User
            </button>

        </form>

        <% if ("empty".equals(request.getParameter("error"))) { %>
            <p class="error">Please enter a User ID or username.</p>
        <% } %>

        <a href="profile.jsp" class="back-link">
            ← Back to My Profile
        </a>

    </section>

</main>

<footer>
    © 2026 Real Estate Property Portal | User Management
</footer>

</body>
</html>
```
