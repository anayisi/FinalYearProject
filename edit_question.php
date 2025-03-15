<?php
header('X-Content-Type-Options: nosniff');

session_start();

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'];
    $question = $_POST['question'];

    // Update the question
    $sql = "UPDATE questions SET question = ? WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $question, $id);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        echo "Question updated successfully.";
    } else {
        echo "Error updating question.";
    }

    $stmt->close();
}

$conn->close();
?>
