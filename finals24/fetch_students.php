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

// Query to fetch lecturer details
$sql = "SELECT student_id, name, dob, school FROM students"; // Adjust the table and column names as needed
$result = $conn->query($sql);

$students = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $students[] = $row;
    }
}

// Return lecturer data as JSON
echo json_encode($students);
$conn->close();
?>
