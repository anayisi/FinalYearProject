<?php
session_start();
$conn = new mysqli("localhost", "root", "", "project");

$student_id = $_SESSION['student_id'];
$admin_id = $_POST['admin_id'];
$message = trim($_POST['message']);

$sql = "INSERT INTO conversation (sender_id, receiver_id, sender_role, receiver_role, message) 
        VALUES (?, ?, 'student', 'admin', ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $student_id, $admin_id, $message);
$stmt->execute();

echo json_encode(['success' => true]);
