<?php
$servername = "localhost"; // Typically "localhost", but may vary depending on your server setup.
$username = "root";        // Replace with your database username.
$password = "";            // Replace with your database password.
$dbname = "project"; // Replace with your actual database name.

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
