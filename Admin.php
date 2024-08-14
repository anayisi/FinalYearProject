<?php
header('X-Content-Type-Options: nosniff');

header('Cache-Control: no-cache, no-store, must-revalidate'); // HTTP 1.1
header('Pragma: no-cache'); // HTTP 1.0
header('Expires: 0');

session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['admin_id'])) {
    echo json_encode(['success' => false, 'message' => 'User not authenticated.']);
    exit();
}

// Database connection
$conn = new mysqli('localhost', 'root', '', 'project');
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed.']);
    exit();
}

$response = ['success' => true];

if (isset($_SESSION['admin_id'])) {
    $admin_id = $_SESSION['admin_id'];

    // Fetch administrator details
    $sql = "SELECT * FROM administrators WHERE admin_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $admin_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $admin = $result->fetch_assoc();
    $response['administrator'] = $admin;

    // Fetch all students and their results (example admin task)
    $sql = "SELECT students.name, students.email, results.exam_id, results.score FROM students
            JOIN results ON students.student_id = results.student_id";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $all_results = $stmt->get_result();

    $all_results_array = [];
    while ($row = $all_results->fetch_assoc()) {
        $all_results_array[] = $row;
    }
    $response['all_results'] = $all_results_array;
}

echo json_encode($response);

$conn->close();
