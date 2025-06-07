-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2025 at 08:00 PM
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
(5, 'Emmanuel Ayisi', 'emm4090@gmail.com', '$2y$10$iFI2DnR4xDp6uA8buVwn1uFUraXu1zYEIh27Fpev3NB17Y6qv.6cy', '2025-05-16', 'AC5gt0'),
(6, 'Agyei Sofaraa', 'jsofaraaagyei@gmail.com', '$2y$10$N04qo3GpDjdWOldWFpOx4.inVPHPN2XPqSr0EkGY.tXcgAjchWZca', '2025-05-06', 'ADM1100343');

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
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` int(11) NOT NULL,
  `sender_type` enum('admin','student','lecturer') DEFAULT NULL,
  `sender_id` varchar(50) DEFAULT NULL,
  `receiver_type` enum('admin','student','lecturer') DEFAULT NULL,
  `receiver_id` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `sender_type`, `sender_id`, `receiver_type`, `receiver_id`, `message`, `timestamp`, `is_read`) VALUES
(95, 'student', '8', 'admin', '5', '...', '2025-06-07 17:20:05', 1);

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
(8, 'Mr. Asante', 'asante@gmail.com', '$2y$10$YX0hVwKBk7G1V.a4MZajQeeIslcEjVXvciz0lg0cVAwaXshenmZCC', '1996-02-07', 'GEOSCIENCES', 'LECF4YP0UHM');

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
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `lecturer_id` varchar(255) NOT NULL,
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

INSERT INTO `questions` (`id`, `lecturer_id`, `exam_id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`) VALUES
(1, '1', 'CENG402', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(2, '1', 'CENG402', 'Who is the founder of Ghana?', 'Addo', 'Danquah', 'Busia', 'Nkrumah', 'D'),
(3, '2', 'CENG505', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(4, '2', 'CENG505', 'Who is the founder of Ghana?', 'Addo', 'Danquah', 'Busia', 'Nkrumah', 'D'),
(5, '4', 'CENG111', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(6, '4', 'CENG111', 'Who is the founder of Ghana?', 'Addo', 'Danquah', 'Busia', 'Nkrumah', 'D'),
(7, '4', 'CENG111', 'What is the capital of Nigeria?', 'Abuja', 'Lagos', 'Benin', 'Port H.', 'A'),
(8, '4', 'CENG111', 'Who is the founder of Ghana?', 'Addo', 'Danquah', 'Busia', 'Nkrumah', 'D'),
(10, '7', 'HIST101', '2. Who is Ghana\'s President?', 'Nana', 'J. A. Kuffour', 'Mahama', 'Mills', 'C'),
(11, '7', 'HIST101', '3. Capital of Ghana?', 'Kumasii', 'Accra', 'Tumu', 'Koforidua', 'B'),
(15, '7', 'HIST102', '1. What is 1+8?', '10', '9', '8', '7', 'B'),
(16, '7', 'HIST102', '2. Who is USA\'s President?', 'Kamala', 'George', 'Trump', 'Obama', 'C'),
(17, '7', 'HIST102', '3. Capital of Burkina Faso?', 'Ouagadugu', 'Yamosokro', 'Tumu', 'Koforidua', 'A'),
(19, '7', 'HIST103', '2. Who is USA\'s President?', 'Kamala', 'George', 'Trump', 'Obama', 'C'),
(20, '7', 'HIST103', '3. Capital of Burkina Faso?', 'Ouagadugu', 'Yamosokro', 'Tumu', 'Koforidua', 'A'),
(21, '7', 'HIST104', '1. What is 1+8?', '10', '9', '8', '7', 'B'),
(22, '7', 'HIST104', '2. Who is USA\'s President?', 'Kamala', 'George', 'Trump', 'Obama', 'C'),
(23, '7', 'HIST104', '3. Capital of Burkina Faso?', 'Ouagadugu', 'Yamosokro', 'Tumu', 'Koforidua', 'A'),
(24, '8', 'ELNG101', '1. What is 1+8?', '10', '9', '8', '7', 'B'),
(25, '8', 'ELNG101', '2. Who is USA\'s President?', 'Kamala', 'George', 'Trump', 'Obama', 'C'),
(26, '8', 'ELNG101', '3. Capital of Burkina Faso?', 'Ouagadugu', 'Yamosokro', 'Tumu', 'Koforidua', 'A'),
(27, '8', 'ACT101', 'Kofi goes to school on________________\nI. Monday\nII. Tuesday\nIII. Saturday\nIV. Sunday', 'I & II', 'III & IV', 'I, II, IV', 'I & IV', 'A'),
(28, '8', 'ACT101', 'Kofi goes to church on________________', 'Monday', 'Tuesday', 'Sunday', 'Wednesday', 'C'),
(32, '8', 'ACT101', 'Abu goes to mosque on________________', 'Monday', 'Tuesday', 'Sunday', 'Friday', 'D'),
(33, '8', 'ACT101', 'Who is wrong?\nI. Kofi\nII. Ama\nIII. Yaw\nIV. None is wrong', 'I', 'I & II', 'I & III', 'IV', 'D'),
(34, '8', 'RENG111', 'What is 1+8....', '100', '9', '8', '7', 'C'),
(35, '8', 'RENG111', 'Who is USA\'s President?', 'Kamala', 'George', 'Trump', 'Obama', 'C'),
(36, '8', 'RENG111', 'Capital of Burkina Faso?', 'Ouagadugu', 'Yamosokro', 'Tumu', 'Koforidua', 'A'),
(37, '8', 'RENG112', 'What is 1+8?', '10', '9', '8', '7', 'AB'),
(38, '8', 'RENG112', 'Who is USA\'s President?', 'Kamala', 'George', 'Trump', 'Obama', 'C'),
(39, '8', 'RENG112', 'Capital of Burkina Faso?', 'Ouagadugu', 'Yamosokro', 'Tumu', 'Koforidua', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `randadmin`
--

CREATE TABLE `randadmin` (
  `admin_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `randadmin`
--

INSERT INTO `randadmin` (`admin_id`) VALUES
('AC5gt0'),
('ADM1100343'),
('ADMLXIE7Y3K'),
('ADMM7XE3RI1'),
('C'),
('UEB110129');

-- --------------------------------------------------------

--
-- Table structure for table `randlec`
--

CREATE TABLE `randlec` (
  `lecturer_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `randlec`
--

INSERT INTO `randlec` (`lecturer_id`) VALUES
('A'),
('LEC1108022'),
('LECF3PQVZT2'),
('LECF4YP0UHM'),
('LECUI76UBX0');

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
-- Table structure for table `randstu`
--

CREATE TABLE `randstu` (
  `student_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `randstu`
--

INSERT INTO `randstu` (`student_id`) VALUES
('B'),
('OOOO'),
('STUBEHHBKF8'),
('STUJUNPVA9Q'),
('UEB1101820'),
('UEB1101920');

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `result_id` int(10) NOT NULL,
  `student_id` varchar(255) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `student_idNum` varchar(255) NOT NULL,
  `exam_id` varchar(255) NOT NULL,
  `score` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`result_id`, `student_id`, `student_name`, `student_idNum`, `exam_id`, `score`) VALUES
(79, '1', 'Ayisi Emmanuel George', '11111', 'HIST101', '3/4'),
(80, '1', 'Ayisi Emmanuel George', '11111', 'HIST104', '2/3'),
(81, '1', 'Ayisi Emmanuel George', '11111', 'HIST101', '0/2'),
(82, '1', 'Ayisi Emmanuel George', '11111', 'HIST104', '1/3'),
(83, '1', 'Ayisi Emmanuel George', '11111', 'HIST104', '0/3'),
(84, '1', 'Ayisi Emmanuel George', '11111', 'HIST104', '0/3'),
(85, '1', 'Ayisi Emmanuel George', '11111', 'HIST101', '2/2'),
(86, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '0/3'),
(87, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '2/3'),
(88, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '1/2'),
(89, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(90, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(91, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(92, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(93, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(94, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '1/2'),
(95, '1', 'Ayisi Emmanuel Georgee', '11111', 'CENG402', '2/2'),
(96, '1', 'Ayisi Emmanuel Georgee', '11111', 'CENG505', '1/2'),
(97, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '0/3'),
(98, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '0/3'),
(99, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '0/3'),
(100, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '1/2'),
(101, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(102, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '0/3'),
(103, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '2/2'),
(104, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '0/3'),
(105, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '0/3'),
(106, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(107, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST104', '2/3'),
(108, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(109, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(110, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(111, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(112, '1', 'Ayisi Emmanuel Georgee', '11111', 'HIST101', '0/2'),
(113, '8', 'Naheem', 'STUBEHHBKF8', 'HIST104', '0/3'),
(114, '8', 'Naheem', 'STUBEHHBKF8', 'HIST104', '2/3'),
(115, '8', 'Naheem', 'STUBEHHBKF8', 'HIST104', '0/3'),
(116, '8', 'Naheem', 'STUBEHHBKF8', 'HIST101', '0/2'),
(117, '8', 'Naheem', 'STUBEHHBKF8', 'HIST104', '0/3'),
(118, '8', 'Naheema', 'STUBEHHBKF8', 'HIST101', '1/2'),
(119, '8', 'Naheema', 'STUBEHHBKF8', 'HIST101', '1/2'),
(120, '8', 'Naheema', 'STUBEHHBKF8', 'HIST101', '0/2'),
(121, '8', 'Naheem', 'STUBEHHBKF8', 'ACT101', '4/4'),
(122, '8', 'Naheem', 'STUBEHHBKF8', 'HIST101', '1/2'),
(123, '8', 'Naheem', 'STUBEHHBKF8', 'HIST101', '0/2'),
(124, '8', 'Naheem', 'STUBEHHBKF8', 'HIST101', '0/2'),
(125, '8', 'Naheem', 'STUBEHHBKF8', 'HIST101', '0/2'),
(126, '8', 'Naheem', 'STUBEHHBKF8', 'HIST101', '1/2'),
(127, '8', 'Naheem', 'STUBEHHBKF8', 'RENG112', '0/3'),
(128, '8', 'Naheem', 'STUBEHHBKF8', 'RENG111', '0/3'),
(129, '8', 'Naheem', 'STUBEHHBKF8', 'RENG112', '0/3'),
(130, '8', 'Naheem', 'STUBEHHBKF8', 'RENG112', '0/3');

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
(8, 'Naheem', 'naheem@gmail.com', '$2y$10$hiP7NQmn/pMq0d4OxVXlbOL2eP53SJ4LAPhDLDIHHtVir7PE3qj7W', '2025-05-08', '100', 'ENGINEERING', 'BSc. Computer Engineering', 'STUBEHHBKF8');

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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrators`
--
ALTER TABLE `administrators`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lecturers`
--
ALTER TABLE `lecturers`
  ADD PRIMARY KEY (`lecturer_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `randadmin`
--
ALTER TABLE `randadmin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `randlec`
--
ALTER TABLE `randlec`
  ADD PRIMARY KEY (`lecturer_id`);

--
-- Indexes for table `random_ids`
--
ALTER TABLE `random_ids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fk_1` (`random_id`);

--
-- Indexes for table `randstu`
--
ALTER TABLE `randstu`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `student_id` (`student_id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`result_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrators`
--
ALTER TABLE `administrators`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `lecturers`
--
ALTER TABLE `lecturers`
  MODIFY `lecturer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `random_ids`
--
ALTER TABLE `random_ids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `result_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
