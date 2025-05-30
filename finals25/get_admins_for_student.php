<?php
session_start();
$conn = new mysqli("localhost", "root", "", "project");

$student_id = $_SESSION['student_id'];

// Get all admins
$sql = "SELECT name, id_num FROM administrators";
$result = $conn->query($sql);

$admins = [];
while ($row = $result->fetch_assoc()) {
    $admin_id = $row['id_num'];

    // Check for unseen messages from this admin
    $notif_sql = "SELECT COUNT(*) AS unseen FROM conversation 
                  WHERE sender_id = ? AND receiver_id = ? 
                  AND sender_role = 'admin' AND receiver_role = 'student' AND seen = 0";
    $stmt = $conn->prepare($notif_sql);
    $stmt->bind_param("ss", $admin_id, $student_id);
    $stmt->execute();
    $notif_result = $stmt->get_result()->fetch_assoc();
    $unseen = $notif_result['unseen'];

    $admins[] = [
        'name' => $row['name'],
        'id' => $admin_id,
        'hasNewMsg' => $unseen > 0
    ];
}

echo json_encode($admins);
