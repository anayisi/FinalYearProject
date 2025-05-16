<?php
session_start();
header('Content-Type: application/json');

// Ensure student is logged in
if (!isset($_SESSION['student_id'])) {
    echo json_encode(['success' => false, 'message' => 'Not logged in.']);
    exit();
}

// Read JSON input
$data = json_decode(file_get_contents('php://input'), true);
$studentId = $_SESSION['student_id'];
$examId = $data['exam_id'];
$score = $data['score'];

$conn = new mysqli("localhost", "root", "", "project");
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed.']);
    exit();
}

// Retrieve student name and ID number
$stmt = $conn->prepare("SELECT name, id_num FROM students WHERE student_id = ?");
$stmt->bind_param("s", $studentId);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(['success' => false, 'message' => 'Student not found.']);
    $stmt->close();
    $conn->close();
    exit();
}

$row = $result->fetch_assoc();
$studentName = $row['name'];
$studentIdNum = $row['id_num'];
$stmt->close();

// Insert result
$stmt = $conn->prepare("INSERT INTO results (student_id, student_name, student_idNum, exam_id, score) VALUES (?, ?, ?, ?, ?)");
$stmt->bind_param("sssss", $studentId, $studentName, $studentIdNum, $examId, $score);

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $conn->error]);
}

$stmt->close();
$conn->close();
?>
