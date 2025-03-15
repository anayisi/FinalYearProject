<?php
include 'db_conn.php'; // This file connects to your database

// Fetch both students and lecturers
$query = "(SELECT student_id AS id, name FROM students) UNION (SELECT lecturer_id AS id, name FROM lecturers)";
$result = mysqli_query($conn, $query);

while($row = mysqli_fetch_assoc($result)) {
    echo '<li class="list-group-item user-item" data-id="' . $row['id'] . '">' . htmlspecialchars($row['name']) . '</li>';
}
?>
