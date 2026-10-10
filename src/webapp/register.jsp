<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register | RealEstate</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background-color: #F7F3EA;
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
        }

        .logo {
            color: #C9A227;
            font-size: 25px;
            font-weight: bold;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-links a {
            color: #F7F3EA;
            text-decoration: none;
            font-size: 14px;

            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #C9A227;
        }

        .login-btn {
            background-color: #C9A227;
            color: #171717 !important;

            padding: 10px 20px;

            font-weight: bold;

            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background-color: #F7F3EA;
            transform: translateY(-2px);
        }

        /* ================= REGISTER AREA ================= */

        .register-section {
            flex: 1;

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 50px 20px;
        }

        /* ================= REGISTER CARD ================= */

        .register-container {
            width: 450px;

            background-color: white;

            padding: 40px 45px;

            border-top: 4px solid #C9A227;

            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.10);

            animation: fadeUp 0.8s ease;
        }

        /* ================= ANIMATION ================= */

        @keyframes fadeUp {

            from {
                opacity: 0;
                transform: translateY(40px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }

        /* ================= TITLE ================= */

        .register-container h1 {
            color: #171717;

            text-align: center;

            margin-bottom: 10px;

            font-size: 30px;
        }

        .subtitle {
            text-align: center;

            color: #777;

            margin-bottom: 30px;

            font-size: 14px;
        }

        /* ================= FORM ================= */

        .form-group {
            margin-bottom: 17px;
        }

        .form-group label {
            display: block;

            margin-bottom: 7px;

            color: #333;

            font-size: 14px;

            font-weight: bold;
        }

        .form-group input,
        .form-group select {

            width: 100%;

            padding: 12px 14px;

            border: 1px solid #D8D2C8;

            outline: none;

            font-size: 14px;

            background-color: white;

            transition: all 0.3s ease;
        }

        /* INPUT FOCUS ANIMATION */

        .form-group input:focus,
        .form-group select:focus {

            border-color: #C9A227;

            box-shadow: 0 0 0 2px rgba(201, 162, 39, 0.10);
        }

        /* ================= REGISTER BUTTON ================= */

        .register-submit {

            width: 100%;

            padding: 14px;

            margin-top: 8px;

            border: none;

            background-color: #171717;

            color: #C9A227;

            font-size: 15px;

            font-weight: bold;

            cursor: pointer;

            transition: all 0.3s ease;
        }

        .register-submit:hover {

            background-color: #C9A227;

            color: #171717;

            transform: translateY(-3px);

            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.15);
        }

        .register-submit:active {

            transform: translateY(0);

        }

        /* ================= LOGIN TEXT ================= */

        .login-text {

            text-align: center;

            margin-top: 22px;

            color: #777;

            font-size: 14px;
        }

        .login-text a {

            color: #B28B16;

            font-weight: bold;

            text-decoration: none;

            transition: color 0.3s ease;
        }

        .login-text a:hover {

            color: #171717;

        }

        /* ================= FOOTER ================= */

        footer {

            background-color: #171717;

            color: #aaa;

            text-align: center;

            padding: 20px;

            font-size: 13px;
        }

        /* ================= MOBILE ================= */

        @media (max-width: 700px) {

            .nav-links a:not(.login-btn) {
                display: none;
            }

            .register-container {

                width: 100%;

                padding: 30px;

            }

        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <a href="index.jsp" class="logo">
        RealEstate
    </a>

    <div class="nav-links">

        <a href="index.jsp">
            Home
        </a>

        <a href="index.jsp#properties">
            Properties
        </a>

        <a href="index.jsp#about">
            About
        </a>

        <a href="index.jsp#contact">
            Contact
        </a>

        <a href="login.jsp" class="login-btn">
            Login
        </a>

    </div>

</nav>


<!-- ================= REGISTER ================= -->

<section class="register-section">

    <div class="register-container">

        <h1>Create Account</h1>

        <p class="subtitle">
            Join RealEstate and find your perfect property
        </p>


        <form action="register" method="post" autocomplete="off">
            <input type="text" name="form-check" tabindex="-1"
                   aria-hidden="true"
                   autocomplete="username"
                   style="position:absolute; left:-10000px; width:1px; height:1px;">


            <!-- USER ID -->

            <div class="form-group">

                <label>User ID</label>

                <input
                        type="text"
                        name="userId"
                        placeholder="Enter your user ID"
                        required>

            </div>


            <!-- USERNAME -->

            <div class="form-group">

                <label>Username</label>

                <input
                        type="text"
                        name="username"
                        placeholder="Enter your username"
                        required>

            </div>


            <!-- EMAIL -->

            <div class="form-group">

                <label>Email Address</label>

                <input
                        type="email"
                        name="email"
                        placeholder="Enter your email"
                        required>

            </div>


            <!-- PASSWORD -->

            <div class="form-group">

                <label>Password</label>

                <input
                        type="password"
                        name="password"
                        placeholder="Create a password"
                        required>

            </div>



            <!-- MEMBERSHIP -->

            <div class="form-group">

                <label for="membershipType">Membership Type</label>

                <select name="membershipType" id="membershipType" required>
                    <option value="Regular" selected>Regular</option>
                </select>

            </div>




            <!-- BUTTON -->

            <button
                    type="submit"
                    class="register-submit">

                Create Account

            </button>


        </form>


        <!-- LOGIN LINK -->

        <p class="login-text">

            Already have an account?

            <a href="login.jsp">
                Login here
            </a>

        </p>

    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    © 2026 RealEstate Property Portal. All Rights Reserved.

</footer>


</body>

</html>