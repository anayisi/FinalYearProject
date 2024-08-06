<?php
session_start();
header('Content-Type: application/json');

$conn = new mysqli('localhost', 'root', '', 'project');
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed.']);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];
    
    $user = null;
    $table = '';
    
    // Check if email exists in students table
    $sql = "SELECT * FROM students WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();
    
    if ($user) {
        $table = 'students';
    } else {
        // Check if email exists in lecturers table
        $sql = "SELECT * FROM lecturers WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();
        
        if ($user) {
            $table = 'lecturers';
        } else {
            // Check if email exists in administrators table
            $sql = "SELECT * FROM administrators WHERE email = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("s", $email);
            $stmt->execute();
            $result = $stmt->get_result();
            $user = $result->fetch_assoc();
            
            if ($user) {
                $table = 'administrators';
            }
        }
    }
    
    if ($user && password_verify($password, $user['password'])) {
        if ($table === 'students') {
            $_SESSION['student_id'] = $user['student_id'];
        } elseif ($table === 'lecturers') {
            $_SESSION['lecturer_id'] = $user['lecturer_id'];
        } elseif ($table === 'administrators') {
            $_SESSION['admin_id'] = $user['admin_id'];
        }
        echo json_encode(['success' => true, 'message' => 'Login successful!']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid email or password.']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method.']);
}

$conn->close();
