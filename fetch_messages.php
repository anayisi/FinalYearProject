<?php
include 'db_conn.php'; //this file connects to your database

$receiver_role = $_POST['receiver_role'];
$receiver_id = $_POST['id'];

$query = "SELECT * FROM messages WHERE (sender_role='$receiver_role' OR receiver_role='$receiver_role') AND (sender_id='$receiver_id' OR receiver_id='$receiver_id') ORDER BY timestamp ASC";
$result = mysqli_query($conn, $query);

while($row = mysqli_fetch_assoc($result)) {
    echo '<div><strong>' . $row['sender_role'] . ':</strong> ' . htmlspecialchars($row['message']) . '</div>';
}
?>
