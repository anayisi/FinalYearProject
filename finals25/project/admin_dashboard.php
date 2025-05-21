<?php
session_start();
if (!isset($_SESSION['admin_id'])) {
    header('Location: login.html');
    exit();
}
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100 font-sans">
    <header class="bg-white shadow-sm p-4 flex justify-between items-center">
        <h1 class="text-xl font-bold">Admin Dashboard</h1>
        <a href="logout.php" class="text-red-600 hover:underline" id="signout">
            <i class="fas fa-sign-out-alt mr-2"></i>Sign out
        </a>
    </header>

    <main class="p-4">
        <h2 class="text-2xl font-semibold">Welcome, Admin</h2>
        <!-- Admin dashboard content goes here -->
    </main>

    <script>
        // Push a state to detect back button
        history.pushState(null, null, location.href);
        
        // Detect back/forward navigation and force logout
        window.addEventListener("popstate", function () {
            window.location.href = "logout.php";
        });
    </script>
</body>
</html>
