<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

function displayStudents() {
    global $conn;
    $sql = "SELECT * FROM students";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['student_id']}</td>
                    <td>{$row['name']}</td>
                    <td>{$row['email']}</td>
                    <td><a href='delete_user.php?id={$row['student_id']}&type=student' class='btn btn-danger'>Delete</a></td>
                  </tr>";
        }
    } else {
        echo "<tr><td colspan='4'>No students found</td></tr>";
    }
}

function displayLecturers() {
    global $conn;
    $sql = "SELECT * FROM lecturers";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                    <td>{$row['lecturer_id']}</td>
                    <td>{$row['name']}</td>
                    <td>{$row['email']}</td>
                    <td><a href='delete_user.php?id={$row['lecturer_id']}&type=lecturer' class='btn btn-danger'>Delete</a></td>
                  </tr>";
        }
    } else {
        echo "<tr><td colspan='4'>No lecturers found</td></tr>";
    }
}

$conn->close();
?>
