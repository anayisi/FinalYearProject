<?php
include 'db_conn.php'; //this file connects to your database

$message = $_POST['message'];
$receiver_id = $_POST['receiver_id'];
$sender_id = // fetch the current logged-in user ID;
$sender_role = // fetch the current logged-in user role;

$query = "INSERT INTO messages (sender_id, receiver_id, sender_role, receiver_role, message) VALUES ('$sender_id', '$receiver_id', '$sender_role', 'administrator', '$message')";
mysqli_query($conn, $query);
?>
