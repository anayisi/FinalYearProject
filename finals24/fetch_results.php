<?php
session_start();
include 'db_conn.php'; // Include your database connection file

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve the student_id from the session
    $student_id = $_SESSION['student_id'];
    
    // Retrieve the entered exam_id
    $exam_id = $_POST['exam_id'];

    // Prepare the SQL statement to fetch the result
    $stmt = $conn->prepare("SELECT score FROM results WHERE student_id = ? AND exam_id = ?");
    $stmt->bind_param("ss", $student_id, $exam_id);
    
    // Execute the statement
    $stmt->execute();
    $stmt->store_result();
    
    if ($stmt->num_rows > 0) {
        $stmt->bind_result($score);
        $resultOutput = '<h4>Results:</h4><ul class="list-group">';
        
        while ($stmt->fetch()) {
            $resultOutput .= "<li class='list-group-item'>Score: $score</li>";
        }
        
        $resultOutput .= '</ul>';
    } else {
        $resultOutput = '<div class="alert alert-warning">No results found for this Exam ID.</div>';
    }
    
    $stmt->close();
    $conn->close();
    
    // Output the result to be displayed on the same page
    echo $resultOutput;
}
?>
