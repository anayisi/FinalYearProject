<?php
header('X-Content-Type-Options: nosniff');

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

// Fetch questions from the database
$sql = "SELECT id, question FROM questions";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($row['id']) . "</td>";
        echo "<td>" . htmlspecialchars($row['question']) . "</td>";
        echo '<td><button class="btn btn-danger" onclick="removeQuestion(this)">Remove</button>';
        echo '<button class="btn btn-warning" onclick="editQuestion(this)">Edit</button></td>';
        echo "</tr>";
    }
} else {
    echo "<tr><td colspan='3'>No questions found</td></tr>";
}

$conn->close();
?>