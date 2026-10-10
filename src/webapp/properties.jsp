<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Properties | RealEstate</title>

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
            height: 75px;
            background-color: #171717;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;

            position: sticky;
            top: 0;
            z-index: 100;
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

        /* ================= PAGE HEADER ================= */

        .page-header {
            text-align: center;

            padding: 70px 20px 45px;

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

        .page-header p {
            color: #777;
            font-size: 15px;
        }

        /* ================= ANIMATION ================= */

        @keyframes fadeDown {

            from {
                opacity: 0;
                transform: translateY(-25px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }

        }

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

        /* ================= FILTER AREA ================= */

        .filter-container {
            width: 86%;
            max-width: 1200px;

            margin: 0 auto 45px;

            background-color: white;

            padding: 25px;

            border-top: 3px solid #C9A227;

            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);

            display: flex;
            gap: 15px;
            align-items: center;

            animation: fadeUp 0.9s ease;
        }

        .filter-container input,
        .filter-container select {

            flex: 1;

            padding: 13px;

            border: 1px solid #D8D2C8;

            outline: none;

            background-color: white;

            transition: border 0.3s ease;
        }

        .filter-container input:focus,
        .filter-container select:focus {

            border-color: #C9A227;
        }

        .filter-button {

            padding: 13px 28px;

            background-color: #171717;

            color: #C9A227;

            border: none;

            font-weight: bold;

            cursor: pointer;

            transition: all 0.3s ease;
        }

        .filter-button:hover {

            background-color: #C9A227;

            color: #171717;

            transform: translateY(-2px);
        }

        /* ================= PROPERTY SECTION ================= */

        .properties-section {

            width: 86%;
            max-width: 1200px;

            margin: 0 auto 80px;
        }

        .section-title {

            display: flex;
            justify-content: space-between;
            align-items: center;

            margin-bottom: 25px;
        }

        .section-title h2 {

            font-size: 25px;
            color: #171717;
        }

        .section-title span {

            color: #888;
            font-size: 14px;
        }

        /* ================= PROPERTY GRID ================= */

        .property-grid {

            display: grid;

            grid-template-columns: repeat(3, 1fr);

            gap: 25px;
        }

        /* ================= PROPERTY CARD ================= */

        .property-card {

            background-color: white;

            border: 1px solid #E8E2D8;

            overflow: hidden;

            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.06);

            animation: fadeUp 0.8s ease;

            transition:
                    transform 0.35s ease,
                    box-shadow 0.35s ease;
        }

        .property-card:hover {

            transform: translateY(-10px);

            box-shadow: 0 18px 35px rgba(0, 0, 0, 0.14);
        }

        /* ================= IMAGE ================= */

        .property-image {

            width: 100%;
            height: 220px;

            overflow: hidden;

            position: relative;
        }

        .property-image img {

            width: 100%;
            height: 100%;

            object-fit: cover;

            transition: transform 0.5s ease;
        }

        .property-card:hover .property-image img {

            transform: scale(1.08);
        }

        /* ================= BADGE ================= */

        .badge {

            position: absolute;

            top: 15px;
            left: 15px;

            background-color: #C9A227;

            color: #171717;

            padding: 7px 12px;

            font-size: 11px;

            font-weight: bold;
        }

        /* ================= CARD CONTENT ================= */

        .property-info {

            padding: 22px;
        }

        .property-info h3 {

            font-size: 19px;

            margin-bottom: 8px;

            color: #171717;
        }

        .location {

            color: #777;

            font-size: 13px;

            margin-bottom: 15px;
        }

        .price {

            color: #B28B16;

            font-size: 21px;

            font-weight: bold;

            margin-bottom: 18px;
        }

        /* ================= FEATURES ================= */

        .features {

            display: flex;

            gap: 15px;

            padding-top: 15px;

            border-top: 1px solid #E8E2D8;

            color: #666;

            font-size: 12px;
        }

        .features span {

            white-space: nowrap;
        }

        /* ================= DETAILS BUTTON ================= */

        .details-button {

            display: block;

            text-align: center;

            text-decoration: none;

            margin-top: 18px;

            padding: 11px;

            border: 1px solid #171717;

            color: #171717;

            font-size: 13px;

            font-weight: bold;

            transition: all 0.3s ease;
        }

        .details-button:hover {

            background-color: #171717;

            color: #C9A227;
        }

        /* ================= FOOTER ================= */

        footer {

            background-color: #171717;

            color: #aaa;

            text-align: center;

            padding: 25px;

            font-size: 13px;
        }

        /* ================= RESPONSIVE ================= */

        @media (max-width: 900px) {

            .property-grid {

                grid-template-columns: repeat(2, 1fr);
            }

            .filter-container {

                flex-wrap: wrap;
            }

            .filter-container input,
            .filter-container select {

                min-width: 45%;
            }

        }

        @media (max-width: 600px) {

            .nav-links a:not(.login-btn) {

                display: none;
            }

            .property-grid {

                grid-template-columns: 1fr;
            }

            .filter-container {

                width: 90%;

                flex-direction: column;
            }

            .filter-container input,
            .filter-container select,
            .filter-button {

                width: 100%;
            }

            .properties-section {

                width: 90%;
            }

            .page-header h1 {

                font-size: 32px;
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

        <a href="properties.jsp">
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


<!-- ================= PAGE HEADER ================= -->

<section class="page-header">

    <h1>
        Explore Our <span>Properties</span>
    </h1>

    <p>
        Discover beautiful homes and premium properties
        that match your lifestyle.
    </p>

</section>


<!-- ================= FILTER ================= -->

<div class="filter-container">

    <input
            type="text"
            placeholder="Search by location">

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
            Villa
        </option>

    </select>

    <select>

        <option>
            Price Range
        </option>

        <option>
            Under Rs. 25M
        </option>

        <option>
            Rs. 25M - Rs. 50M
        </option>

        <option>
            Above Rs. 50M
        </option>

    </select>

    <button class="filter-button">
        Search
    </button>

</div>


<!-- ================= PROPERTIES ================= -->

<section class="properties-section">

    <div class="section-title">

        <h2>
            Featured Properties
        </h2>

        <span>
            6 Properties Available
        </span>

    </div>


    <div class="property-grid">


        <!-- PROPERTY 1 -->

        <div class="property-card">

            <div class="property-image">

                <img
                        src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c"
                        alt="Modern House">

                <span class="badge">
                    FOR SALE
                </span>

            </div>

            <div class="property-info">

                <h3>
                    Modern Luxury Villa
                </h3>

                <p class="location">
                    📍 Colombo 07, Sri Lanka
                </p>

                <p class="price">
                    Rs. 48,500,000
                </p>

                <div class="features">

                    <span>🛏 4 Beds</span>

                    <span>🚿 3 Baths</span>

                    <span>📐 3,200 sqft</span>

                </div>

                <a href="#" class="details-button">
                    View Details
                </a>

            </div>

        </div>


        <!-- PROPERTY 2 -->

        <div class="property-card">

            <div class="property-image">

                <img
                        src="https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3"
                        alt="Luxury House">

                <span class="badge">
                    FOR SALE
                </span>

            </div>

            <div class="property-info">

                <h3>
                    Elegant Family Home
                </h3>

                <p class="location">
                    📍 Kandy, Sri Lanka
                </p>

                <p class="price">
                    Rs. 32,000,000
                </p>

                <div class="features">

                    <span>🛏 3 Beds</span>

                    <span>🚿 2 Baths</span>

                    <span>📐 2,450 sqft</span>

                </div>

                <a href="#" class="details-button">
                    View Details
                </a>

            </div>

        </div>


        <!-- PROPERTY 3 -->

        <div class="property-card">

            <div class="property-image">

                <img
                        src="https://images.unsplash.com/photo-1600585154526-990dced4db0d"
                        alt="Premium Villa">

                <span class="badge">
                    FOR SALE
                </span>

            </div>

            <div class="property-info">

                <h3>
                    Premium Garden Villa
                </h3>

                <p class="location">
                    📍 Nugegoda, Sri Lanka
                </p>

                <p class="price">
                    Rs. 41,750,000
                </p>

                <div class="features">

                    <span>🛏 4 Beds</span>

                    <span>🚿 4 Baths</span>

                    <span>📐 3,600 sqft</span>

                </div>

                <a href="#" class="details-button">
                    View Details
                </a>

            </div>

        </div>


        <!-- PROPERTY 4 -->

        <div class="property-card">

            <div class="property-image">

                <img
                        src="https://images.unsplash.com/photo-1600607687920-4e2a09cf159d"
                        alt="Modern Apartment">

                <span class="badge">
                    FOR RENT
                </span>

            </div>

            <div class="property-info">

                <h3>
                    Modern City Apartment
                </h3>

                <p class="location">
                    📍 Colombo 03, Sri Lanka
                </p>

                <p class="price">
                    Rs. 180,000 / Month
                </p>

                <div class="features">

                    <span>🛏 2 Beds</span>

                    <span>🚿 2 Baths</span>

                    <span>📐 1,450 sqft</span>

                </div>

                <a href="#" class="details-button">
                    View Details
                </a>

            </div>

        </div>


        <!-- PROPERTY 5 -->

        <div class="property-card">

            <div class="property-image">

                <img
                        src="https://images.unsplash.com/photo-1600607688969-a5bfcd646154"
                        alt="Luxury Apartment">

                <span class="badge">
                    FOR SALE
                </span>

            </div>

            <div class="property-info">

                <h3>
                    Contemporary Residence
                </h3>

                <p class="location">
                    📍 Rajagiriya, Sri Lanka
                </p>

                <p class="price">
                    Rs. 27,500,000
                </p>

                <div class="features">

                    <span>🛏 3 Beds</span>

                    <span>🚿 2 Baths</span>

                    <span>📐 2,100 sqft</span>

                </div>

                <a href="#" class="details-button">
                    View Details
                </a>

            </div>

        </div>


        <!-- PROPERTY 6 -->

        <div class="property-card">

            <div class="property-image">

                <img
                        src="https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea"
                        alt="Luxury Villa">

                <span class="badge">
                    FOR SALE
                </span>

            </div>

            <div class="property-info">

                <h3>
                    Exclusive Luxury Villa
                </h3>

                <p class="location">
                    📍 Battaramulla, Sri Lanka
                </p>

                <p class="price">
                    Rs. 65,000,000
                </p>

                <div class="features">

                    <span>🛏 5 Beds</span>

                    <span>🚿 4 Baths</span>

                    <span>📐 4,200 sqft</span>

                </div>

                <a href="#" class="details-button">
                    View Details
                </a>

            </div>

        </div>


    </div>

</section>


<!-- ================= FOOTER ================= -->

<footer>

    © 2026 RealEstate Property Portal. All Rights Reserved.

</footer>


</body>

</html>