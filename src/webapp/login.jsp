
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Login | RealEstate</title>

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

        /* NAVBAR */

        .navbar {
            min-height: 75px;
            background-color: #171717;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 7%;
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
        }

        .nav-links a:hover {
            color: #C9A227;
        }

        .register-btn {
            border: 1px solid #C9A227;
            padding: 10px 20px;
            color: #C9A227 !important;
        }

        /* LOGIN AREA */

        .login-section {
            flex: 1;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .login-container {
            width: 100%;
            max-width: 420px;
            background-color: white;
            padding: 45px;
            border-top: 4px solid #C9A227;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.10);
        }

        .login-container h1 {
            color: #171717;
            text-align: center;
            margin-bottom: 10px;
            font-size: 30px;
        }

        .login-container .subtitle {
            text-align: center;
            color: #777;
            margin-bottom: 30px;
            font-size: 14px;
            line-height: 1.5;
        }

        /* STATUS MESSAGES */

        .message {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 7px;
            font-size: 14px;
            line-height: 1.5;
        }

        .message.success {
            background: #e8f5e9;
            color: #246b35;
            border: 1px solid #b7dfbd;
        }

        .message.error {
            background: #fdecec;
            color: #a52828;
            border: 1px solid #f2bcbc;
        }

        /* FORM */

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-size: 14px;
            font-weight: bold;
        }

        .form-group input {
            display: block;
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #D8D2C8;
            outline: none;
            font-size: 14px;
            background-color: white;
        }

        .form-group input:focus {
            border-color: #C9A227;
        }

        .login-button {
            width: 100%;
            padding: 14px;
            border: none;
            background-color: #171717;
            color: #C9A227;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
            transition: 0.3s;
        }

        .login-button:hover {
            background-color: #C9A227;
            color: #171717;
        }

        .register-text {
            text-align: center;
            margin-top: 25px;
            color: #777;
            font-size: 14px;
            line-height: 1.6;
        }

        .register-text a {
            color: #B28B16;
            font-weight: bold;
            text-decoration: none;
        }

        .register-text a:hover {
            text-decoration: underline;
        }

        /* FOOTER */

        footer {
            background-color: #171717;
            color: #aaa;
            text-align: center;
            padding: 20px;
            font-size: 13px;
            margin-top: auto;
        }

        /* MOBILE */

        @media (max-width: 700px) {
            .navbar {
                padding: 18px 5%;
                flex-wrap: wrap;
                gap: 15px;
            }

            .nav-links {
                gap: 15px;
                flex-wrap: wrap;
            }

            .nav-links a {
                display: none;
            }

            .nav-links .register-btn {
                display: inline-block;
            }

            .login-section {
                padding: 30px 16px;
            }

            .login-container {
                padding: 30px 25px;
            }

            .login-container h1 {
                font-size: 26px;
            }
        }


/* Registration Success Popup */
.success-toast {
    position: fixed;
    top: 25px;
    right: 25px;
    z-index: 9999;
    display: flex;
    align-items: center;
    gap: 14px;
    max-width: 360px;
    padding: 18px 22px;
    background: #171717;
    color: #F7F3EA;
    border: 1px solid #C9A227;
    border-left: 5px solid #C9A227;
    border-radius: 12px;
    box-shadow: 0 10px 35px rgba(0, 0, 0, 0.3);
    animation: toastSlideIn 0.5s ease forwards;
}

.success-toast .success-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: #C9A227;
    color: #171717;
    font-size: 22px;
    font-weight: bold;
}

.success-toast strong {
    display: block;
    color: #C9A227;
    font-size: 15px;
    margin-bottom: 5px;
}

.success-toast p {
    margin: 0;
    font-size: 13px;
    line-height: 1.5;
    color: #F7F3EA;
}

.success-toast .close-toast {
    align-self: flex-start;
    margin-left: 5px;
    border: none;
    background: transparent;
    color: #F7F3EA;
    font-size: 20px;
    cursor: pointer;
}

.success-toast.hide {
    animation: toastSlideOut 0.4s ease forwards;
}

@keyframes toastSlideIn {
    from { opacity: 0; transform: translateX(40px); }
    to { opacity: 1; transform: translateX(0); }
}

@keyframes toastSlideOut {
    to { opacity: 0; transform: translateX(40px); }
}

@media (max-width: 480px) {
    .success-toast {
        top: 15px;
        right: 15px;
        left: 15px;
        max-width: none;
    }
}
    </style>
</head>

<body>

    <!-- NAVBAR -->

    <nav class="navbar">

        <a href="index.jsp" class="logo">
            RealEstate
        </a>

        <div class="nav-links">

            <a href="index.jsp">Home</a>

            <a href="index.jsp#properties">Properties</a>

            <a href="index.jsp#about">About</a>

            <a href="index.jsp#contact">Contact</a>

            <a href="register.jsp" class="register-btn">
                Register
            </a>

        </div>

    </nav>

    <!-- LOGIN SECTION -->

    <section class="login-section">

        <div class="login-container">

            <h1>Welcome Back</h1>

            <p class="subtitle">
                Login to your RealEstate account
            </p>

            <%
                String logout = request.getParameter("logout");
                String deleted = request.getParameter("deleted");
                String error = request.getParameter("error");
            %>

            <% if ("success".equals(logout)) { %>
                <div class="message success">
                    You have logged out successfully.
                </div>
            <% } %>

            <% if ("true".equals(deleted)) { %>
                <div class="message success">
                    Your account has been deleted successfully.
                </div>
            <% } %>

            <% if ("invalid".equals(error)) { %>
                <div class="message error">
                    Invalid username or password. Please try again.
                </div>
            <% } %>

            <form action="login" method="post">

                <div class="form-group">

                    <label for="username">Username</label>

                    <input
                        type="text"
                        id="username"
                        name="username"
                        placeholder="Enter your username"
                        autocomplete="username"
                        required>

                </div>

                <div class="form-group">

                    <label for="password">Password</label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required>

                </div>

                <button type="submit" class="login-button">
                    Login
                </button>

            </form>

            <p class="register-text">
                Don't have an account?

                <a href="register.jsp">
                    Create an account
                </a>
            </p>

        </div>

    </section>

    <!-- FOOTER -->

    <footer>
        © 2026 RealEstate Property Portal. All Rights Reserved.
    </footer>

    <% if ("success".equals(request.getParameter("registered"))) { %>
        <div class="success-toast" id="successToast" role="status">
            <div class="success-icon">&#10003;</div>
            <div>
                <strong>Registration Successful!</strong>
                <p>Your account has been created successfully. You can now log in.</p>
            </div>
            <button class="close-toast" type="button"
                    onclick="closeSuccessToast()"
                    aria-label="Close">&times;</button>
        </div>

        <script>
            function closeSuccessToast() {
                const toast = document.getElementById("successToast");
                if (toast) {
                    toast.classList.add("hide");
                    setTimeout(() => toast.remove(), 400);
                }
            }

            setTimeout(closeSuccessToast, 5000);
        </script>
    <% } %>

</body>

</html>

