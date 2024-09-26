<?php
// submit_exam.php
session_start();
include 'db_conn.php'; // Assuming you have a file to handle DB connection

$student_id = $_SESSION['student_id']; // Assuming student_id is stored in session
$exam_id = $_POST['exam_id']; // Passed from the form
$total_questions = 0;
$correct_answers = 0;

foreach ($_POST as $key => $value) {
    if (strpos($key, 'answer_') === 0) {
        $total_questions++;
        $question_id = str_replace('answer_', '', $key);
        $student_answer = $value;

        // Fetch correct answer from the database
        $query = "SELECT correct_answer FROM questions WHERE id = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("i", $question_id);
        $stmt->execute();
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        // If student did not answer, consider it wrong
        if (!isset($student_answer) || $row['correct_answer'] != $student_answer) {
            // Answer is incorrect or unanswered
        } else {
            $correct_answers++;
        }
    }
}

$score = "$correct_answers/$total_questions";

// Store results in the results table
$query = "INSERT INTO results (student_id, exam_id, score) VALUES (?, ?, ?)";
$stmt = $conn->prepare($query);
$stmt->bind_param("iss", $student_id, $exam_id, $score);
$stmt->execute();

// Return a success message
echo "Exam submitted successfully!";
?>