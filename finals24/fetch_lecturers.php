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
$sql = "SELECT lecturer_id, name, dob, school FROM lecturers"; // Adjust the table and column names as needed
$result = $conn->query($sql);

$lecturers = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $lecturers[] = $row;
    }
}

// Return lecturer data as JSON
echo json_encode($lecturers);
$conn->close();
?>
