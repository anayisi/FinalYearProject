<?php
header('Content-Type: application/json');
$input = json_decode(file_get_contents('php://input'), true);

$name = $input['name'];
$dob = $input['dob'];
$email = $input['email'];
$password = $input['password'];
$category = $input['category'];

if (empty($name) || empty($dob) || empty($email) || empty($password) || empty($category)) {
    echo json_encode(['success' => false, 'message' => 'All fields are required.']);
    exit();
}

// Hash the password
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

// Database connection
$conn = new mysqli('localhost', 'root', '', 'project');
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed.']);
    exit();
}

// Check if email already exists in students table
$sql = "SELECT * FROM students WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    echo json_encode(['success' => false, 'message' => 'Email already registered as a student.']);
    $stmt->close();
    $conn->close();
    exit();
}
$stmt->close();

// Check if email already exists in lecturers table
$sql = "SELECT * FROM lecturers WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    echo json_encode(['success' => false, 'message' => 'Email already registered as a lecturer.']);
    $stmt->close();
    $conn->close();
    exit();
}
$stmt->close();

// Check if email already exists in administrators table
$sql = "SELECT * FROM administrators WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
    echo json_encode(['success' => false, 'message' => 'Email already registered as an administrator.']);
    $stmt->close();
    $conn->close();
    exit();
}
$stmt->close();

// Insert new user based on category
if ($category === 'student') {
    $level = $input['level'];
    $school = $input['school'];
    $program = $input['program'];
    $id_num = $input['id_num'];

    $sql = "INSERT INTO students (name, dob, email, password, level, school, program, id_num) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssssss", $name, $dob, $email, $hashed_password, $level, $school, $program, $id_num);
} 
elseif ($category === 'lecturer') {
    $lec_school = $input['lec_school'];
    $lec_id_num = $input['lec_id_num'];

    $sql = "INSERT INTO lecturers (name, dob, email, password, school, id_num) VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ssssss", $name, $dob, $email, $hashed_password, $lec_school, $lec_id_num);
} 
elseif ($category === 'administrator') {
    $admin_id_num = $input['admin_id_num'];

    $sql = "INSERT INTO administrators (name, dob, email, password, id_num) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssss", $name, $dob, $email, $hashed_password, $admin_id_num);
}
else {
    echo json_encode(['success' => false, 'message' => 'Invalid category.']);
    exit();
}

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Signup Successful!']);
} else {
    echo json_encode(['success' => false, 'message' => 'Signup failed. Please try again.']);
}

$stmt->close();
$conn->close();

