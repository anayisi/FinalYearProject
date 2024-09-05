<?php
header('X-Content-Type-Options: nosniff');

session_start();

// Assuming lecturer_id is stored in session when the lecturer logs in
$lecturer_id = $_SESSION['lecturer_id'];

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

// Fetch questions from the database for the current lecturer
$sql = "SELECT id, question, option_a, option_b, option_c, option_d, correct_answer FROM questions WHERE lecturer_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $lecturer_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . htmlspecialchars($row['id']) . "</td>";
        echo "<td>" . htmlspecialchars($row['question']) . "</td>";
        echo "<td>" . htmlspecialchars($row['option_a']) . "</td>";
        echo "<td>" . htmlspecialchars($row['option_b']) . "</td>";
        echo "<td>" . htmlspecialchars($row['option_c']) . "</td>";
        echo "<td>" . htmlspecialchars($row['option_d']) . "</td>";
        echo "<td>" . htmlspecialchars($row['correct_answer']) . "</td>";
        echo '<td><button class="btn btn-danger" onclick="removeQuestion(this)">Remove</button>';
        echo "</tr>";
    }
} else {
    echo "<tr><td colspan='8'>No questions found</td></tr>";
}

$stmt->close();
$conn->close();
?>
