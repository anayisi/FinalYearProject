<?php
session_start();
$conn = new mysqli("localhost", "root", "", "project");

$student_id = $_SESSION['student_id'];
$admin_id = $_GET['admin_id'];

$sql = "SELECT * FROM conversation WHERE 
        (sender_id = ? AND receiver_id = ? AND sender_role = 'student' AND receiver_role = 'admin') OR
        (sender_id = ? AND receiver_id = ? AND sender_role = 'admin' AND receiver_role = 'student')
        ORDER BY timestamp ASC";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssss", $student_id, $admin_id, $admin_id, $student_id);
$stmt->execute();
$result = $stmt->get_result();

$messages = [];
while ($row = $result->fetch_assoc()) {
    $messages[] = $row;
}

// Mark admin messages as seen
$update = "UPDATE conversation SET seen = 1 WHERE sender_id = ? AND receiver_id = ? AND sender_role = 'admin' AND receiver_role = 'student'";
$stmt = $conn->prepare($update);
$stmt->bind_param("ss", $admin_id, $student_id);
$stmt->execute();

echo json_encode($messages);
