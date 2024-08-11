<?php
header('X-Content-Type-Options: nosniff');
header('Cache-Control: no-cache, no-store, must-revalidate'); // HTTP 1.1
header('Pragma: no-cache'); // HTTP 1.0
header('Expires: 0');
header('Content-Type: application/json');

// Retrieve JSON input
$input = json_decode(file_get_contents('php://input'), true);

$name = $input['name'];
$dob = $input['dob'];
$email = $input['email'];
$password = $input['password'];
$category = $input['category'];

// Validate input fields
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

// Check if email already exists in any user table
$tables = ['students', 'lecturers', 'administrators'];
$email_exists = false;

foreach ($tables as $table) {
    $stmt = $conn->prepare("SELECT * FROM $table WHERE email = ?");
    $stmt->bind_param('s', $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $email_exists = true;
        break;
    }
}

if ($email_exists) {
    echo json_encode(['success' => false, 'message' => 'Email already exists.']);
    exit();
}

// Insert user data based on the category
if ($category === 'student') {
    $level = $input['level'];
    $school = $input['school'];
    $program = $input['program'];
    $id_num = $input['id_num'];

    $stmt = $conn->prepare("INSERT INTO students (name, dob, email, password, level, school, program, id_num) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('ssssssss', $name, $dob, $email, $hashed_password, $level, $school, $program, $id_num);

} elseif ($category === 'lecturer') {
    $school = $input['school'];
    $id_num = $input['id_num'];

    $stmt = $conn->prepare("INSERT INTO lecturers (name, dob, email, password, school, id_num) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param('ssssss', $name, $dob, $email, $hashed_password, $school, $id_num);

} elseif ($category === 'administrator') {
    $id_num = $input['id_num'];

    $stmt = $conn->prepare("INSERT INTO administrators (name, dob, email, password, id_num) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param('sssss', $name, $dob, $email, $hashed_password, $id_num);
}

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Signup successful!']);
} else {
    echo json_encode(['success' => false, 'message' => 'Signup failed. Please try again later.']);
}

$stmt->close();
$conn->close();
?>
