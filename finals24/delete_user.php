<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the ID and type from the URL
$id = $_GET['id'];
$type = $_GET['type'];

// Delete based on type (student or lecturer)
if ($type === 'student') {
    $sql = "DELETE FROM students WHERE id='$id'";
} elseif ($type === 'lecturer') {
    $sql = "DELETE FROM lecturers WHERE id='$id'";
}

if ($conn->query($sql) === TRUE) {
    echo "Record deleted successfully";
} else {
    echo "Error deleting record: " . $conn->error;
}

$conn->close();

// Redirect back to admin page
header("Location: AdminProfile.html");
?>
