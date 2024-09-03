<?php
header('X-Content-Type-Options: nosniff');

error_reporting(E_ALL);
ini_set('display_errors', 1);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $target_dir = "uploads/";
    $target_file = $target_dir . basename($_FILES["questionFile"]["name"]);

    // Check if file is a .txt file
    $fileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
    if($fileType != "txt") {
        echo "Sorry, only .txt files are allowed.";
        exit;
    }

    // Check for upload errors
    if ($_FILES["questionFile"]["error"] != UPLOAD_ERR_OK) {
        echo "Error uploading file. Error code: " . $_FILES["questionFile"]["error"];
        exit;
    }

    if (move_uploaded_file($_FILES["questionFile"]["tmp_name"], $target_file)) {
        echo "The file ". basename($_FILES["questionFile"]["name"]). " has been uploaded.";
        
        // Read the uploaded file and process it
        $questions = file($target_file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
        $parsedQuestions = parseQuestions($questions);
        storeQuestions($parsedQuestions);
        
        echo "Questions have been processed and stored in the database.";
    } else {
        echo "Sorry, there was an error uploading your file.";
    }
}

function parseQuestions($lines) {
    $questions = [];
    foreach ($lines as $line) {
        $parts = explode('|', $line);
        if (count($parts) == 6) { // Ensure the format is correct
            $questions[] = [
                'question' => trim($parts[0]),
                'option_a' => trim($parts[1]),
                'option_b' => trim($parts[2]),
                'option_c' => trim($parts[3]),
                'option_d' => trim($parts[4]),
                'correct_answer' => trim($parts[5]),
            ];
        }
    }
    return $questions;
}

function storeQuestions($questions) {
    // Database connection
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "project";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    $stmt = $conn->prepare("INSERT INTO questions (question, option_a, option_b, option_c, option_d, correct_answer) VALUES (?, ?, ?, ?, ?, ?)");
    foreach ($questions as $question) {
        $stmt->bind_param(
            "ssssss",
            $question['question'],
            $question['option_a'],
            $question['option_b'],
            $question['option_c'],
            $question['option_d'],
            $question['correct_answer']
        );
        $stmt->execute();
    }
    $stmt->close();
    $conn->close();
}

