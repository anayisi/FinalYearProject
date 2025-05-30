<?php
session_start();
$conn = new mysqli("localhost", "root", "", "project");

$admin_id = $_SESSION['admin_id'];
$data = json_decode(file_get_contents("php://input"), true);

$receiver_id = $data['user_id'];
$receiver_role = $data['user_role'];
$message = $data['message'];

$stmt = $conn->prepare("INSERT INTO conversation (sender_id, sender_role, receiver_id, receiver_role, message) VALUES (?, 'admin', ?, ?, ?)");
$stmt->bind_param("ssss", $admin_id, $receiver_id, $receiver_role, $message);
$stmt->execute();

echo json_encode(["success" => true]);
?>
