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

    <title>My Account | RealEstate</title>

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

        /* Navbar */

        nav {
            height: 75px;
            background: #171717;

            display: flex;
            align-items: center;
            justify-content: space-between;

            padding: 0 7%;
        }

        .logo {
            color: #c9a227;
            font-size: 25px;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            gap: 28px;
            align-items: center;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-size: 15px;

            transition: 0.3s;
        }

        .nav-links a:hover {
            color: #c9a227;
        }

        .logout {
            border: 1px solid #c9a227;
            padding: 10px 18px;
            border-radius: 5px;
        }

        .logout:hover {
            background: #c9a227;
            color: #171717 !important;
        }

        /* Main */

        .container {
            min-height: calc(100vh - 75px);

            display: flex;
            justify-content: center;
            align-items: center;

            padding: 50px 20px;
        }

        /* Profile Card */

        .profile-card {
            width: 520px;
            background: white;

            padding: 40px;

            border-radius: 12px;

            box-shadow: 0 15px 40px rgba(0,0,0,0.12);

            animation: fadeUp 0.8s ease;
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

        .profile-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-title h1 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .profile-title p {
            color: #777;
            font-size: 14px;
        }

        /* User Information */

        .info {
            margin-bottom: 18px;
        }

        .info label {
            display: block;

            font-size: 13px;
            font-weight: bold;

            color: #777;

            margin-bottom: 6px;
        }

        .info-box {
            width: 100%;

            background: #f7f3ea;

            padding: 13px 15px;

            border-radius: 6px;

            border: 1px solid #e4dfd3;

            font-size: 15px;
        }

        /* Buttons */

        .buttons {
            margin-top: 30px;

            display: flex;
            gap: 12px;
            flex-direction: column;
        }

        .btn {
            width: 100%;

            padding: 13px;

            border: none;
            border-radius: 6px;

            font-size: 15px;
            font-weight: bold;

            cursor: pointer;

            transition: 0.3s;
        }

        .update-btn {
            background: #c9a227;
            color: #171717;
        }

        .update-btn:hover {
            background: #b18d1c;
            transform: translateY(-2px);
        }

        .delete-btn {
            background: #171717;
            color: white;
        }

        .delete-btn:hover {
            background: #333;
            transform: translateY(-2px);
        }

        /* Mobile */

        @media (max-width: 600px) {

            nav {
                padding: 0 20px;
            }

            .nav-links {
                gap: 12px;
            }

            .nav-links a:not(.logout) {
                display: none;
            }

            .profile-card {
                padding: 25px;
            }

        }


/* Modal background */
.modal-overlay {
    position: fixed;
    inset: 0;
    background: rgba(23, 23, 23, 0.65);
    backdrop-filter: blur(5px);

    display: flex;
    justify-content: center;
    align-items: center;

    padding: 20px;
    z-index: 9999;

    opacity: 0;
    visibility: hidden;
    transition: opacity 0.3s ease, visibility 0.3s ease;
}

/* Show modal */
.modal-overlay.show {
    opacity: 1;
    visibility: visible;
}

/* Modal card */
.modal-box {
    width: 100%;
    max-width: 420px;
    background: #F7F3EA;
    border: 1px solid rgba(201, 162, 39, 0.6);
    border-radius: 16px;
    padding: 35px 30px;
    text-align: center;

    box-shadow: 0 25px 70px rgba(0, 0, 0, 0.3);

    transform: translateY(25px) scale(0.92);
    transition: transform 0.35s cubic-bezier(.2,.8,.2,1);
}

.modal-overlay.show .modal-box {
    transform: translateY(0) scale(1);
}

/* Warning icon */
.warning-icon {
    width: 62px;
    height: 62px;
    margin: 0 auto 20px;

    display: flex;
    justify-content: center;
    align-items: center;

    border: 2px solid #C9A227;
    border-radius: 50%;

    color: #C9A227;
    font-size: 34px;
    font-weight: bold;
}

/* Modal text */
.modal-box h2 {
    color: #171717;
    font-size: 24px;
    margin-bottom: 13px;
}

.modal-box p {
    color: #6f6a60;
    font-size: 14px;
    line-height: 1.7;
    margin-bottom: 28px;
}

/* Modal buttons */
.modal-buttons {
    display: flex;
    gap: 12px;
    justify-content: center;
}

.modal-buttons form {
    flex: 1;
}

.cancel-btn,
.confirm-delete-btn {
    width: 100%;
    padding: 12px 10px;
    border-radius: 7px;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.25s ease;
}

.cancel-btn {
    background: transparent;
    color: #171717;
    border: 1px solid #c9a227;
}

.cancel-btn:hover {
    background: #eae2d0;
    transform: translateY(-2px);
}

.confirm-delete-btn {
    background: #171717;
    color: #F7F3EA;
    border: 1px solid #171717;
}

.confirm-delete-btn:hover {
    background: #C9A227;
    color: #171717;
    border-color: #C9A227;
    transform: translateY(-2px);
}

@media (max-width: 420px) {
    .modal-box {
        padding: 28px 20px;
    }

    .modal-buttons {
        gap: 8px;
    }

    .cancel-btn,
    .confirm-delete-btn {
        font-size: 12px;
    }
}

    </style>

</head>


<body>

<!-- Navigation Bar -->

<nav>

    <div class="logo">
        RealEstate
    </div>

    <div class="nav-links">

        <a href="index.jsp">Home</a>

        <a href="properties.jsp">Properties</a>

        <a href="profile.jsp">My Account</a>

        <a href="login.jsp" class="logout">Logout</a>

    </div>

</nav>


<!-- Profile Section -->

<div class="container">

    <div class="profile-card">

        <div class="profile-title">

            <h1>My Account</h1>

            <p>View and manage your account information</p>

        </div>


        <!-- User ID -->

        <div class="info">

            <label>User ID</label>

            <div class="info-box">
                <%= loggedInUser.getUserId() %>
            </div>

        </div>


        <!-- Username -->

        <div class="info">

            <label>Username</label>

            <div class="info-box">
                <%= loggedInUser.getUsername() %>
            </div>

        </div>


        <!-- Email -->

        <div class="info">

            <label>Email</label>

            <div class="info-box">
                <%= loggedInUser.getEmail() %>
            </div>

        </div>


        <!-- Password -->

        <div class="info">

            <label>Password</label>

            <div class="info-box">
                ••••••••
            </div>

        </div>


        <!-- Membership -->

        <div class="info">

            <label>Membership Type</label>

            <div class="info-box">
                <%= loggedInUser.getMembershipType() %>
            </div>

        </div>


        <!-- Buttons -->

        <div class="buttons">

            <button class="btn update-btn"
                    onclick="location.href='update-profile.jsp'">

                Update Profile

            </button>




<button type="button" class="btn delete-btn"
        onclick="openDeleteModal()">
    Delete Account
</button>

<!-- Custom Delete Confirmation Modal -->
<div class="modal-overlay" id="deleteModal">

    <div class="modal-box" id="deleteModalBox">

        <div class="warning-icon">!</div>

        <h2>Delete Your Account?</h2>

        <p>
            Are you sure you want to delete your account?
            This action cannot be undone.
        </p>

        <div class="modal-buttons">

            <button type="button" class="cancel-btn"
                    onclick="closeDeleteModal()">
                Cancel
            </button>

            <form action="delete-account" method="post">
                <button type="submit" class="confirm-delete-btn">
                    Delete Account
                </button>
            </form>

        </div>

    </div>

</div>

        </div>

    </div>

</div>


<script>
    const deleteModal = document.getElementById("deleteModal");

    function openDeleteModal() {
        deleteModal.classList.add("show");
    }

    function closeDeleteModal() {
        deleteModal.classList.remove("show");
    }

    deleteModal.addEventListener("click", function(event) {
        if (event.target === deleteModal) {
            closeDeleteModal();
        }
    });

    document.addEventListener("keydown", function(event) {
        if (event.key === "Escape") {
            closeDeleteModal();
        }
    });
</script>

</body>

</html>