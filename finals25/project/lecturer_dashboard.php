<?php
session_start();
if (!isset($_SESSION['lecturer_id'])) {
    header('Location: login.html');
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lecturer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100 font-sans">
    <header class="bg-white shadow-sm p-4 flex justify-between items-center">
        <h1 class="text-xl font-bold">Lecturer Dashboard</h1>
        <a href="logout.php" class="text-red-600 hover:underline">
            <i class="fas fa-sign-out-alt mr-2"></i>Sign out
        </a>
    </header>

    <main class="p-4">
        <h2 class="text-2xl font-semibold">Welcome, Lecturer</h2>
        <!-- Lecturer dashboard content goes here -->
    </main>
</body>
</html>
