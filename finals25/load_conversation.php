<?php
session_start();
$conn = new mysqli("localhost", "root", "", "project");

$admin_id = $_SESSION['admin_id'];
$user_id = $_POST['user_id'];
$user_role = $_POST['user_role'];

$query = $conn->prepare("
    SELECT * FROM conversation 
    WHERE (sender_id = ? AND sender_role = 'admin' AND receiver_id = ? AND receiver_role = ?) 
       OR (sender_id = ? AND sender_role = ? AND receiver_id = ? AND receiver_role = 'admin')
    ORDER BY timestamp ASC
");

$query->bind_param("ssssss", $admin_id, $user_id, $user_role, $user_id, $user_role, $admin_id);
$query->execute();
$result = $query->get_result();

$messages = [];
while ($row = $result->fetch_assoc()) {
    $messages[] = $row;
}

echo json_encode($messages);
?>
