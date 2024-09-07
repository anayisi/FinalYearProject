<?php
include 'db_conn.php'; // Include your database connection file

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Retrieve the result ID from the POST data
    $result_id = $_POST['result_id'];
    /*
    // Prepare the SQL statement to delete the result
    $stmt = $conn->prepare("DELETE FROM results WHERE result_id = ?");
    $stmt->bind_param("i", $result_id);
    */
    $sql = "DELETE FROM results WHERE result_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $result_id);
    $stmt->execute();


    // Execute the statement
    if ($stmt->execute()) {
        echo "Result deleted successfully.";
    } else {
        echo "Error deleting result.";
    }
    
    $stmt->close();
    $conn->close();
}
?>
