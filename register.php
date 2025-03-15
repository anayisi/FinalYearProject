<?php
// Include the database connection file
include 'db.php';

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the form data and sanitize it
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $dob = mysqli_real_escape_string($conn, $_POST['dob']);
    $gender = mysqli_real_escape_string($conn, $_POST['gender']);
    $category = mysqli_real_escape_string($conn, $_POST['category']);
    $level = mysqli_real_escape_string($conn, $_POST['level']);
    $school = mysqli_real_escape_string($conn, $_POST['school']);
    $program = mysqli_real_escape_string($conn, $_POST['program']);
    $id_num = mysqli_real_escape_string($conn, $_POST['id_num']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    // Hash the password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);
    // Insert the data into the registration table
    $sql = "INSERT INTO register (name, dob, gender, category, level, school, program, id_num, password) VALUES ('$name', '$dob', '$gender', '$category', '$level', '$school', '$program', '$id_num', '$hashed_password')";

    if ($conn->query($sql) === TRUE) {
        echo "Registration successful!";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    // Close the database connection
    $conn->close();
}
?>
