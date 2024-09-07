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

if (isset($_GET['student_id'])) {
    $studentId = $_GET['student_id'];

    // Example query to delete or mark the student as rejected
    $query = "DELETE FROM students WHERE student_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $studentId);

    if ($stmt->execute()) {
        echo "Student has been rejected successfully.";
    } else {
        echo "Error rejecting the student.";
    }

    $stmt->close();
}
$conn->close();
?>