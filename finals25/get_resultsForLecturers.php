<?php
header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);
$examId = $data['exam_id'];

$conn = new mysqli("localhost", "root", "", "project");
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed.']);
    exit();
}

$stmt = $conn->prepare("SELECT student_name, student_idNum, exam_id, result_id, score FROM results WHERE exam_id = ?");
$stmt->bind_param("s", $examId);
$stmt->execute();
$result = $stmt->get_result();

$results = [];
while ($row = $result->fetch_assoc()) {
    $results[] = $row;
}

echo json_encode(['success' => true, 'results' => $results]);

$stmt->close();
$conn->close();
?>
