<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>RealEstate | Find Your Dream Property</title>

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
        }

        /* ================= NAVBAR ================= */

        .navbar {
            height: 78px;
            background-color: #171717;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;

            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.15);
        }

        .logo {
            font-size: 27px;
            font-weight: bold;
            color: #C9A227;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: #F7F3EA;
            font-size: 15px;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: #C9A227;
        }

        .login-btn {
            padding: 10px 20px;

            background-color: #C9A227;
            color: #171717 !important;

            border-radius: 5px;
            font-weight: bold;

            transition: 0.3s;
        }

        .login-btn:hover {
            background-color: #E0BE45;
        }

        .register-btn {
            padding: 9px 20px;

            border: 1px solid #C9A227;
            color: #C9A227 !important;

            border-radius: 5px;

            transition: 0.3s;
        }

        .register-btn:hover {
            background-color: #C9A227;
            color: #171717 !important;
        }


        /* ================= HERO ================= */

        .hero {
            min-height: 540px;

            background:
                linear-gradient(
                    rgba(15, 15, 15, 0.62),
                    rgba(15, 15, 15, 0.62)
                ),
                url("https://images.unsplash.com/photo-1600585154340-be6161a56a0c")
                center/cover;

            display: flex;
            align-items: center;

            padding: 0 7%;
        }

        .hero-content {
            max-width: 700px;
            color: white;
        }

        .hero-content h1 {
            font-size: 58px;
            line-height: 1.1;
            margin-bottom: 20px;

            font-weight: 700;
        }

        .hero-content h1::after {
            content: "";
            display: block;

            width: 70px;
            height: 3px;

            background-color: #C9A227;

            margin-top: 22px;
        }

        .hero-content p {
            font-size: 18px;
            line-height: 1.7;

            margin: 25px 0 30px;

            color: #E8E2D8;
        }

        .hero-btn {
            display: inline-block;

            background-color: #C9A227;
            color: #171717;

            padding: 14px 30px;

            text-decoration: none;

            border-radius: 5px;

            font-size: 16px;
            font-weight: bold;

            transition: 0.3s;
        }

        .hero-btn:hover {
            background-color: #E0BE45;

            transform: translateY(-2px);
        }


        .user-search-section {
            padding: 55px 20px;
            text-align: center;
            background: #F7F3EA;
        }

        .user-search-section h2 {
            color: #171717;
            font-size: 28px;
            margin-bottom: 12px;
        }

        .user-search-section h2 span {
            color: #C9A227;
        }

        .user-search-section p {
            color: #777;
            margin-bottom: 24px;
            font-size: 14px;
        }

        .user-search-form {
            display: flex;
            gap: 10px;
            max-width: 550px;
            margin: 0 auto;
        }

        .user-search-form input {
            flex: 1;
            min-width: 0;
            padding: 14px;
            border: 1px solid #ddd5c4;
            border-radius: 7px;
            outline: none;
        }

        .user-search-form input:focus {
            border-color: #C9A227;
        }

        .user-search-form button {
            padding: 14px 20px;
            background: #C9A227;
            color: #171717;
            border: none;
            border-radius: 7px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .user-search-form button:hover {
            background: #171717;
            color: #F7F3EA;
            transform: translateY(-2px);
        }

        @media (max-width: 500px) {
            .user-search-form {
                flex-direction: column;
            }
        }



        /* ================= SEARCH ================= */

        .search-box {
            width: 86%;

            margin: -45px auto 65px;

            background-color: #FFFFFF;

            padding: 25px;

            border-radius: 8px;

            border-top: 3px solid #C9A227;

            box-shadow:
                0 8px 30px rgba(0, 0, 0, 0.12);

            display: flex;

            gap: 15px;

            align-items: center;
        }

        .search-box input,
        .search-box select {

            flex: 1;

            padding: 14px;

            border: 1px solid #D8D1C5;

            border-radius: 5px;

            font-size: 14px;

            background-color: #FAF8F3;

            color: #333;
        }

        .search-box input:focus,
        .search-box select:focus {

            outline: none;

            border-color: #C9A227;
        }

        .search-btn {

            padding: 14px 30px;

            background-color: #171717;

            color: #C9A227;

            border: none;

            border-radius: 5px;

            cursor: pointer;

            font-weight: bold;

            transition: 0.3s;
        }

        .search-btn:hover {

            background-color: #C9A227;

            color: #171717;
        }


        /* ================= SECTION ================= */

        .section {

            width: 86%;

            margin: auto;

            margin-bottom: 80px;
        }

        .section-title {

            text-align: center;

            margin-bottom: 40px;
        }

        .section-title h2 {

            font-size: 34px;

            margin-bottom: 12px;

            color: #171717;
        }

        .section-title h2::after {

            content: "";

            display: block;

            width: 55px;

            height: 2px;

            background-color: #C9A227;

            margin: 15px auto 0;
        }

        .section-title p {

            color: #777;

            margin-top: 12px;
        }


        /* ================= PROPERTY CARDS ================= */

        .property-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 28px;
        }

        .property-card {

            background-color: #FFFFFF;

            border-radius: 8px;

            overflow: hidden;

            box-shadow:
                0 5px 20px rgba(0, 0, 0, 0.08);

            transition: 0.3s;

            border: 1px solid #E8E2D8;
        }

        .property-card:hover {

            transform: translateY(-7px);

            box-shadow:
                0 12px 30px rgba(0, 0, 0, 0.15);

            border-color: #C9A227;
        }

        .property-image {

            width: 100%;

            height: 220px;

            object-fit: cover;
        }

        .property-content {

            padding: 22px;
        }

        .property-content h3 {

            margin-bottom: 9px;

            font-size: 20px;

            color: #171717;
        }

        .location {

            color: #777;

            font-size: 14px;

            margin-bottom: 15px;
        }

        .price {

            color: #B28B16;

            font-size: 21px;

            font-weight: bold;

            margin-bottom: 17px;
        }

        .details {

            display: flex;

            gap: 18px;

            color: #666;

            font-size: 13px;

            border-top: 1px solid #eee;

            padding-top: 14px;
        }


        /* ================= FOOTER ================= */

        footer {

            background-color: #171717;

            color: white;

            padding: 45px 7%;

            margin-top: 50px;
        }

        .footer-content {

            display: flex;

            justify-content: space-between;
        }

        .footer-logo {

            font-size: 24px;

            font-weight: bold;

            color: #C9A227;

            margin-bottom: 12px;
        }

        .footer-text {

            color: #AAA;

            max-width: 400px;

            line-height: 1.7;
        }

        .copyright {

            text-align: center;

            color: #777;

            margin-top: 35px;

            padding-top: 20px;

            border-top: 1px solid #333;

            font-size: 13px;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .property-grid {

                grid-template-columns: 1fr 1fr;
            }

            .search-box {

                flex-direction: column;
            }

            .search-box input,
            .search-box select,
            .search-btn {

                width: 100%;
            }
        }


        @media (max-width: 600px) {

            .nav-links {

                display: none;
            }

            .hero-content h1 {

                font-size: 40px;
            }

            .property-grid {

                grid-template-columns: 1fr;
            }
        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="logo">
        RealEstate
    </div>


    <div class="nav-links">

        <a href="index.jsp">
            Home
        </a>

        <a href="#">
            Properties
        </a>

        <a href="#">
            About
        </a>

        <a href="#">
            Contact
        </a>

        <a href="login.jsp" class="login-btn">
            Login
        </a>

        <a href="register.jsp" class="register-btn">
            Register
        </a>

        <a href="search.jsp">Search Users</a>

    </div>

</nav>



<!-- ================= HERO ================= -->

<section class="hero">

    <div class="hero-content">

        <h1>
            Find Your Dream Property
        </h1>

        <p>
            Discover exceptional homes, apartments and
            properties designed for the way you want to live.
        </p>

        <a href="#" class="hero-btn">
            Explore Properties
        </a>

    </div>

</section>

<section class="user-search-section">
    <h2>Looking for a <span>User?</span></h2>

    <p>Search registered users by User ID or username.</p>

    <form action="search" method="post" class="user-search-form">
        <input
            type="text"
            name="searchValue"
            placeholder="Enter User ID or Username"
            required
        >

        <button type="submit">Search Users</button>
    </form>
</section>

<!-- ================= SEARCH ================= -->

<div class="search-box">

    <input
            type="text"
            placeholder="Search by location..."
    >


    <select>

        <option>
            Property Type
        </option>

        <option>
            House
        </option>

        <option>
            Apartment
        </option>

        <option>
            Land
        </option>

    </select>


    <select>

        <option>
            Price Range
        </option>

        <option>
            Under Rs. 5M
        </option>

        <option>
            Rs. 5M - 10M
        </option>

        <option>
            Above Rs. 10M
        </option>

    </select>


    <button class="search-btn">
        Search
    </button>

</div>



<!-- ================= FEATURED PROPERTIES ================= -->

<section class="section">


    <div class="section-title">

        <h2>
            Featured Properties
        </h2>

        <p>
            Explore some of our latest property listings
        </p>

    </div>



    <div class="property-grid">


        <!-- PROPERTY 1 -->

        <div class="property-card">

            <img
                    class="property-image"
                    src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c"
                    alt="Modern House"
            >

            <div class="property-content">

                <h3>
                    Modern Family House
                </h3>

                <p class="location">
                    📍 Colombo 07, Sri Lanka
                </p>

                <p class="price">
                    Rs. 45,000,000
                </p>

                <div class="details">

                    <span>🛏 4 Beds</span>

                    <span>🚿 3 Baths</span>

                    <span>📐 2,500 sqft</span>

                </div>

            </div>

        </div>



        <!-- PROPERTY 2 -->

        <div class="property-card">

            <img
                    class="property-image"
                    src="https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3"
                    alt="Luxury Apartment"
            >

            <div class="property-content">

                <h3>
                    Luxury Apartment
                </h3>

                <p class="location">
                    📍 Kandy, Sri Lanka
                </p>

                <p class="price">
                    Rs. 28,500,000
                </p>

                <div class="details">

                    <span>🛏 3 Beds</span>

                    <span>🚿 2 Baths</span>

                    <span>📐 1,800 sqft</span>

                </div>

            </div>

        </div>



        <!-- PROPERTY 3 -->

        <div class="property-card">

            <img
                    class="property-image"
                    src="https://images.unsplash.com/photo-1600585154526-990dced4db0d"
                    alt="Modern Villa"
            >

            <div class="property-content">

                <h3>
                    Modern Villa
                </h3>

                <p class="location">
                    📍 Nugegoda, Sri Lanka
                </p>

                <p class="price">
                    Rs. 65,000,000
                </p>

                <div class="details">

                    <span>🛏 5 Beds</span>

                    <span>🚿 4 Baths</span>

                    <span>📐 3,200 sqft</span>

                </div>

            </div>

        </div>


    </div>

</section>



<!-- ================= FOOTER ================= -->

<footer>

    <div class="footer-content">

        <div>

            <div class="footer-logo">
                RealEstate
            </div>

            <p class="footer-text">

                Your trusted platform for finding
                exceptional properties and your perfect home.

            </p>

        </div>

    </div>


    <div class="copyright">

        © 2026 RealEstate Property Portal.
        All rights reserved.

    </div>

</footer>


</body>

</html>