<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the form data
    $role = $_POST['role'];
    $email = $_POST['email'];
    $id_num = $_POST['id_num'];
    $dob = $_POST['dob'];
    $password = $_POST['password'];
    
    // Hash the new password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Determine the table based on the role
    switch ($role) {
        case 'Administrator':
            $table = 'administrators';
            break;
        case 'Lecturer':
            $table = 'lecturers';
            break;
        case 'Student':
            $table = 'students';
            break;
        default:
            echo "<script>alert('Invalid role selected.'); window.location.href = 'forgot.html';</script>";
            exit();
    }

    // Connect to the database
    require 'db_conn.php'; // Include your database connection file

    // Prepare and execute the query
    $stmt = $conn->prepare("SELECT * FROM $table WHERE email = ? AND id_num = ? AND dob = ?");
    $stmt->bind_param("sss", $email, $id_num, $dob);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        // Update the password
        $stmt = $conn->prepare("UPDATE $table SET password = ? WHERE email = ? AND id_num = ? AND dob = ?");
        $stmt->bind_param("ssss", $hashed_password, $email, $id_num, $dob);
        if ($stmt->execute()) {
            echo "<script>alert('Password updated successfully.'); window.location.href = 'login.html';</script>";
        } else {
            echo "<script>alert('Failed to update password. Please try again.'); window.location.href = 'forgot.html';</script>";
        }
    } else {
        echo "<script>alert('Invalid details provided.'); window.location.href = 'forgot.html';</script>";
    }

    $stmt->close();
    $conn->close();
}
?>
