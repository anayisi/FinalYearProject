-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 26, 2024 at 04:33 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

CREATE TABLE `administrators` (
  `admin_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `id_num` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrators`
--

INSERT INTO `administrators` (`admin_id`, `name`, `email`, `password`, `dob`, `id_num`) VALUES
(1, 'Emmanuel Ayisi', 'patupa@gmail.com', '$2y$10$PEhPxYSNQlkxD4KstwlpTe7H8i/d5yWSfUWvyPmaws02Gg.qg3VxK', '2024-08-21', ''),
(2, 'Kaka Kay', 'kaka@gmail.com', '$2y$10$GIP1VEtcNnrdHLgbmfDGUO9wi/eae3iQBFqUDaxHsmRjuvFe3chNy', '2024-07-31', '1233'),
(3, 'panyin', 'panyin@gmail.com', '$2y$10$LhisVJe3RAQFxTI0MFaO3.cMOGUOQY7iw5uhY1pco/LHOK/sguj72', '2024-07-30', '12345'),
(4, 'Isaac', 'ik@gmail.com', '$2y$10$BRzKfwBjec7BDJ3HKlAZLOYa8XB5vnJSlRUf2UibnMZ3vAkM2lmCW', '2024-08-01', '1111');

--
-- Triggers `administrators`
--
DELIMITER $$
CREATE TRIGGER `before_insert_administrators` BEFORE INSERT ON `administrators` FOR EACH ROW BEGIN
    IF NEW.admin_id IS NULL THEN
        SET NEW.admin_id = IFNULL((SELECT MAX(admin_id) + 1 FROM administrators), 1);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `id_ans` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `answer` text NOT NULL,
  `is_correct` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `course_code` int(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `lecturer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exams`
--

CREATE TABLE `exams` (
  `exam_id` int(11) NOT NULL,
  `course` varchar(255) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_questions`
--

CREATE TABLE `exam_questions` (
  `id` int(11) NOT NULL,
  `exam_session_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `question_type` enum('objective','subjective') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_sessions`
--

CREATE TABLE `exam_sessions` (
  `id` int(11) NOT NULL,
  `num_objective_questions` int(11) NOT NULL,
  `objective_question_timing` int(11) NOT NULL,
  `num_subjective_questions` int(11) NOT NULL,
  `subjective_question_timing` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lecturer`
--

CREATE TABLE `lecturer` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `lecturer`
--

INSERT INTO `lecturer` (`id`, `name`, `email`, `department`) VALUES
(1, 'Mike Brown', 'mike.brown@gmail.com', 'Computer'),
(2, 'Kwame Eddy', 'kwameeddy@gmail.com', 'Electrical'),
(3, 'Kojo Kwarteng', 'kojokwarteng@gmail.com', 'Civil');

-- --------------------------------------------------------

--
-- Table structure for table `lecturers`
--

CREATE TABLE `lecturers` (
  `lecturer_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `school` varchar(255) NOT NULL,
  `id_num` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lecturers`
--

INSERT INTO `lecturers` (`lecturer_id`, `name`, `email`, `password`, `dob`, `school`, `id_num`) VALUES
(2, 'Adzo Evon', 'adzo@gmail.com', '$2y$10$Sp/OJ8alVbnmMyM/.QUmh.w5NgUS6pPuXHyTN21QxsQyTtHzOHMB.', '2024-07-29', 'lec_GRADUATE STUDIES', '1231'),
(3, 'daavi', 'daavi@gmail.com', '$2y$10$77KGQkeWI2trUhsuG5gTQO7krUkh7JNKPUNLVsPx7xt4ujEf/yY3W', '2024-09-03', 'lec_GEOSCIENCES', '12345'),
(4, 'Owusu', 'owusu@gmail.com', '$2y$10$m3qWlQIUHc35MhJOp0hIYecMB.3keJJJUD/rRFAAND5GAHe0hn896', '2024-09-02', 'lec_MINES AND BUILT ENVIRONMENT', '1255'),
(5, 'Ali', 'ali@gmail.com', '$2y$10$AFTTrf6Uen48grQamnIU8ef9.f/pFiI.gPl7m3gCyYCiDNNSLpwke', '2024-09-05', 'lec_GRADUATE STUDIES', '1212');

--
-- Triggers `lecturers`
--
DELIMITER $$
CREATE TRIGGER `before_insert_lecturers` BEFORE INSERT ON `lecturers` FOR EACH ROW BEGIN
    IF NEW.lecturer_id IS NULL THEN
        SET NEW.lecturer_id = IFNULL((SELECT MAX(lecturer_id) + 1 FROM lecturers), 1);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `sender_role` enum('student','lecturer','administrator') NOT NULL,
  `receiver_role` enum('student','lecturer','administrator') NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `objective_questions`
--

CREATE TABLE `objective_questions` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `lecturer_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `exam_id` varchar(255) NOT NULL,
  `question` text NOT NULL,
  `option_a` varchar(255) NOT NULL,
  `option_b` varchar(255) NOT NULL,
  `option_c` varchar(255) NOT NULL,
  `option_d` varchar(255) NOT NULL,
  `correct_answer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `lecturer_id`, `admin_id`, `exam_id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`) VALUES
(20, 1, 0, 'CENG402', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(21, 1, 0, 'CENG402', 'Who is the founder of Ghana?', 'Addo', 'Danquah', 'Busia', 'Nkrumah', 'D'),
(22, 2, 0, 'CENG505', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(23, 2, 0, 'CENG505', 'Who is the founder of Ghana?', 'Addo', 'Danquah', 'Busia', 'Nkrumah', 'D'),
(24, 2, 0, 'ELNG404', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(32, 4, 0, 'CENG504', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(33, 4, 0, 'CENG504', 'Who is the founder of Ghana?', 'Addo', 'Danquah', 'Busia', 'Nkrumah', 'D');

-- --------------------------------------------------------

--
-- Table structure for table `questionss`
--

CREATE TABLE `questionss` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questionss`
--

INSERT INTO `questionss` (`id`, `question`, `type`, `subject_id`, `created_at`) VALUES
(14, '2. How many parts of speech are there?', '', NULL, '2024-07-10 02:12:24'),
(15, '3. What is an adjective?', '', NULL, '2024-07-10 02:12:24'),
(20, '2. How many parts of speech are there?', '', NULL, '2024-07-10 03:34:49'),
(22, '1. What is a noun?', '', NULL, '2024-08-14 18:53:10'),
(23, '2. How many colors has a rainbow.', '', NULL, '2024-08-14 18:53:10'),
(24, '3. where is africa.', '', NULL, '2024-08-14 18:53:10');

-- --------------------------------------------------------

--
-- Table structure for table `random_ids`
--

CREATE TABLE `random_ids` (
  `id` int(11) NOT NULL,
  `random_id` varchar(10) NOT NULL,
  `role` enum('student','lecturer','admin') NOT NULL,
  `used` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `result_id` int(10) NOT NULL,
  `student_id` varchar(255) NOT NULL,
  `exam_id` varchar(255) NOT NULL,
  `score` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`result_id`, `student_id`, `exam_id`, `score`) VALUES
(61, '1', 'CENG402', '0/0'),
(62, '1', 'CENG402', '2/2'),
(63, '1', 'CENG505', '0/0');

-- --------------------------------------------------------

--
-- Table structure for table `resultss`
--

CREATE TABLE `resultss` (
  `result_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `score` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `name`, `dob`, `email`, `password`, `gender`, `created_at`) VALUES
(2, 'Ayisi Emmanuel', NULL, 'emm4090@gmail.com', '$2y$10$4KP5TZP81QP7MHcxlce2weZA2fRZN57BoXie.o7zyd.RqZBeRpUTO', NULL, '2024-07-20 09:00:38');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `level` varchar(50) NOT NULL,
  `school` varchar(255) NOT NULL,
  `program` varchar(255) NOT NULL,
  `id_num` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `email`, `password`, `dob`, `level`, `school`, `program`, `id_num`) VALUES
(1, 'Ayisi Emmanuel George', 'kaice@gmail.com', '$2y$10$r96Kp3.Y0zdNt25KANHeDOYGLXuf0UYl11Yx1s7X/7RuqqRJ8yjme', '2024-08-28', 'level_200', 'ENGINEERING', 'BSc. Agricultural Engineering', '11111'),
(5, 'kwao', 'kwao@gmail.com', '$2y$10$XFpgN8/btJTZV.ZQbK169ubxH6FBc8uLvBmIc.9e8ujkDZz/3ZMOq', '2024-07-29', 'level_400', 'ENGINEERING', 'BSc. Environmental Engineering', '121');

--
-- Triggers `students`
--
DELIMITER $$
CREATE TRIGGER `before_insert_students` BEFORE INSERT ON `students` FOR EACH ROW BEGIN
    IF NEW.student_id IS NULL THEN
        SET NEW.student_id = IFNULL((SELECT MAX(student_id) + 1 FROM students), 1);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `subjective_questions`
--

CREATE TABLE `subjective_questions` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id_sub` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id_user` int(11) NOT NULL,
  `name` text NOT NULL,
  `random_id` varchar(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `role` enum('student','lecturer','admin') NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `dob` date NOT NULL,
  `level` enum('100','200','300','400') NOT NULL,
  `school` varchar(255) NOT NULL,
  `program` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `user_details`
--
DELIMITER $$
CREATE TRIGGER `update_email_before_insert` BEFORE INSERT ON `user_details` FOR EACH ROW BEGIN
	SET NEW.username = CONCAT(NEW.name, '@uenr.edu');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_email_before_update` BEFORE UPDATE ON `user_details` FOR EACH ROW BEGIN
	SET NEW.username = CONCAT(NEW.name, '@uenr.edu');
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrators`
--
ALTER TABLE `administrators`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id_ans`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`),
  ADD KEY `lecturer_id` (`lecturer_id`);

--
-- Indexes for table `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`exam_id`);

--
-- Indexes for table `exam_questions`
--
ALTER TABLE `exam_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_session_id` (`exam_session_id`);

--
-- Indexes for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lecturer`
--
ALTER TABLE `lecturer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lecturers`
--
ALTER TABLE `lecturers`
  ADD PRIMARY KEY (`lecturer_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `objective_questions`
--
ALTER TABLE `objective_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questionss`
--
ALTER TABLE `questionss`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `random_ids`
--
ALTER TABLE `random_ids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fk_1` (`random_id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`result_id`);

--
-- Indexes for table `resultss`
--
ALTER TABLE `resultss`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `subjective_questions`
--
ALTER TABLE `subjective_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id_sub`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `subject_id` (`subject_id`),
  ADD KEY `user_details_ibfk_1` (`random_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrators`
--
ALTER TABLE `administrators`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `id_ans` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exams`
--
ALTER TABLE `exams`
  MODIFY `exam_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_questions`
--
ALTER TABLE `exam_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_sessions`
--
ALTER TABLE `exam_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lecturer`
--
ALTER TABLE `lecturer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lecturers`
--
ALTER TABLE `lecturers`
  MODIFY `lecturer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `objective_questions`
--
ALTER TABLE `objective_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `questionss`
--
ALTER TABLE `questionss`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `random_ids`
--
ALTER TABLE `random_ids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `result_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `resultss`
--
ALTER TABLE `resultss`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subjective_questions`
--
ALTER TABLE `subjective_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id_sub` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questionss` (`id`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturers` (`lecturer_id`);

--
-- Constraints for table `exam_questions`
--
ALTER TABLE `exam_questions`
  ADD CONSTRAINT `exam_questions_ibfk_1` FOREIGN KEY (`exam_session_id`) REFERENCES `exam_sessions` (`id`);

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `administrators` (`admin_id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `administrators` (`admin_id`);

--
-- Constraints for table `questionss`
--
ALTER TABLE `questionss`
  ADD CONSTRAINT `questionss_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id_sub`);

--
-- Constraints for table `resultss`
--
ALTER TABLE `resultss`
  ADD CONSTRAINT `resultss_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `resultss_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`exam_id`);

--
-- Constraints for table `user_details`
--
ALTER TABLE `user_details`
  ADD CONSTRAINT `user_details_ibfk_1` FOREIGN KEY (`random_id`) REFERENCES `random_ids` (`random_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
