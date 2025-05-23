<?php
session_start();
include 'db_conn.php'; // Include your database connection file

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve the entered exam_id
    $exam_id = $_POST['exam_id'];

    // Prepare the SQL statement to fetch all student IDs, their scores, and the result_id for the given exam_id
    $stmt = $conn->prepare("SELECT result_id, student_id, score FROM results WHERE exam_id = ?");
    $stmt->bind_param("s", $exam_id);
    
    // Execute the statement
    $stmt->execute();
    $stmt->store_result();
    
    if ($stmt->num_rows > 0) {
        $stmt->bind_result($result_id, $student_id, $score);
        $resultOutput = '<h4>Results:</h4><ul class="list-group">';
        
        while ($stmt->fetch()) {
            // Each result has a "Delete" button
            $resultOutput .= "
                <li class='list-group-item'>
                    Student ID: $student_id - Score: $score
                    <button class='btn btn-danger btn-sm float-right' onclick='confirmDelete($result_id)'>Delete</button>
                </li>";
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

<script>
function confirmDelete(result_id) {
    // Show a confirmation dialog
    if (confirm("Are you sure you want to delete this result?")) {
        // If confirmed, send a request to delete the result
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'delete_result.php', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                alert(xhr.responseText); // Display success or error message
                location.reload(); // Reload the page to update the results
            }
        };
        
        xhr.send('result_id=' + encodeURIComponent(result_id));
    }
}
</script>
