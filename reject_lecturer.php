<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project"; // Make sure this matches your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_GET['lecturer_id'])) {
    $lecturerId = $_GET['lecturer_id'];

    // Example query to delete or mark the lecturer as rejected
    $query = "DELETE FROM lecturers WHERE lecturer_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $lecturerId);

    if ($stmt->execute()) {
        echo "Lecturer has been rejected successfully.";
    } else {
        echo "Error rejecting the lecturer.";
    }

    $stmt->close();
}
$conn->close();
?>
