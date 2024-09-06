<?php
// fetch_questionss.php
session_start();
include 'db_conn.php'; // Assuming you have a file to handle DB connection

$exam_id = $_GET['exam_id'];
$questions = [];

if ($exam_id) {
    $query = "SELECT * FROM questions WHERE exam_id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $exam_id);
    $stmt->execute();
    $result = $stmt->get_result();

    while ($row = $result->fetch_assoc()) {
        $questions[] = $row;
    }

    echo json_encode($questions);
}
?>
