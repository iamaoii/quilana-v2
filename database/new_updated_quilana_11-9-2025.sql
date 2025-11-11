-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2025 at 12:18 PM
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
-- Database: `quilana`
--

-- --------------------------------------------------------

--
-- Table structure for table `administer_assessment`
--

CREATE TABLE `administer_assessment` (
  `administer_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `ranks_status` tinyint(1) NOT NULL,
  `date_administered` date NOT NULL DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administer_assessment`
--

INSERT INTO `administer_assessment` (`administer_id`, `assessment_id`, `program_id`, `class_id`, `start_time`, `status`, `ranks_status`, `date_administered`) VALUES
(2, 5, 3, 2, '2025-11-09 19:07:18', 2, 0, '2025-11-09');

-- --------------------------------------------------------

--
-- Table structure for table `assessment`
--

CREATE TABLE `assessment` (
  `assessment_id` int(11) NOT NULL,
  `assessment_type` int(11) NOT NULL,
  `assessment_mode` tinyint(1) NOT NULL,
  `assessment_name` varchar(150) NOT NULL,
  `program_id` int(11) NOT NULL,
  `course_name` varchar(150) NOT NULL,
  `topic` varchar(200) NOT NULL,
  `time_limit` int(11) DEFAULT NULL,
  `passing_rate` int(11) DEFAULT NULL,
  `total_points` int(11) NOT NULL,
  `max_points` int(11) DEFAULT NULL,
  `max_warnings` int(3) NOT NULL DEFAULT 3,
  `student_count` int(11) DEFAULT NULL,
  `remaining_points` int(11) DEFAULT NULL,
  `randomize_questions` tinyint(1) NOT NULL DEFAULT 1,
  `faculty_id` int(11) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assessment`
--

INSERT INTO `assessment` (`assessment_id`, `assessment_type`, `assessment_mode`, `assessment_name`, `program_id`, `course_name`, `topic`, `time_limit`, `passing_rate`, `total_points`, `max_points`, `max_warnings`, `student_count`, `remaining_points`, `randomize_questions`, `faculty_id`, `date_updated`) VALUES
(5, 1, 1, 'First Quiz', 3, 'DBA', 'pre-test', 10, 60, 0, NULL, 3, NULL, NULL, 1, 4, '2025-11-09 19:06:46');

-- --------------------------------------------------------

--
-- Table structure for table `assessment_uploads`
--

CREATE TABLE `assessment_uploads` (
  `upload_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `class_id` int(11) NOT NULL,
  `code` varchar(8) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `course_name` varchar(150) NOT NULL,
  `class_name` varchar(100) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`class_id`, `code`, `faculty_id`, `program_id`, `course_name`, `class_name`, `date_created`, `date_updated`) VALUES
(2, 'c86bea7f', 4, 3, 'DBA', 'BSIT 3-2', '2025-11-09 18:56:05', '2025-11-09 18:56:05');

-- --------------------------------------------------------

--
-- Table structure for table `dashboard_settings`
--

CREATE TABLE `dashboard_settings` (
  `setting_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` tinyint(1) NOT NULL,
  `summary` tinyint(1) NOT NULL DEFAULT 1,
  `recent` tinyint(1) NOT NULL DEFAULT 1,
  `request` tinyint(1) NOT NULL DEFAULT 1,
  `report` tinyint(1) NOT NULL DEFAULT 0,
  `calendar` tinyint(1) NOT NULL DEFAULT 1,
  `upcoming` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `faculty_id` int(11) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `faculty_number` varchar(15) NOT NULL,
  `webmail` varchar(150) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` tinyint(1) NOT NULL DEFAULT 2,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`faculty_id`, `firstname`, `lastname`, `faculty_number`, `webmail`, `username`, `password`, `user_type`, `date_updated`) VALUES
(3, 'Bobby', 'Amorsolo', '1234-12345-MN-0', 'bobby@pup.edu.ph', 'bobby', '$2y$10$.Iv05prfRjGWhM2WYMt1ue4VhQDtAH3sp9VjVw4aq0HSG3SbFBQpG', 2, '2025-11-09 14:05:02'),
(4, 'Lian', 'Canlas', '7432-04586-MN-0', 'lian@pup.edu.ph', 'lian', '$2y$10$/giSF5DNQVkeP9l5OoAp0u3hRxybwB6gEATWzbHc8zs/sKUe1f/j.', 2, '2025-11-09 14:21:50');

-- --------------------------------------------------------

--
-- Table structure for table `join_assessment`
--

CREATE TABLE `join_assessment` (
  `join_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `administer_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `attempts` int(1) NOT NULL DEFAULT 0,
  `suspicious_act` int(2) DEFAULT 0,
  `if_display` tinyint(1) NOT NULL DEFAULT 0,
  `method` varchar(150) NOT NULL,
  `time_updated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `join_assessment`
--

INSERT INTO `join_assessment` (`join_id`, `student_id`, `administer_id`, `status`, `attempts`, `suspicious_act`, `if_display`, `method`, `time_updated`) VALUES
(2, 2, 2, 2, 0, 1, 1, 'App Switching / Screenshot', '2025-11-09 19:06:26');

-- --------------------------------------------------------

--
-- Table structure for table `program`
--

CREATE TABLE `program` (
  `program_id` int(11) NOT NULL,
  `program_name` varchar(150) NOT NULL,
  `faculty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `program`
--

INSERT INTO `program` (`program_id`, `program_name`, `faculty_id`) VALUES
(3, 'BSIT', 4);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `order_by` int(11) NOT NULL,
  `ques_type` tinyint(1) NOT NULL,
  `total_points` int(3) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `time_limit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`question_id`, `question`, `assessment_id`, `order_by`, `ques_type`, `total_points`, `date_updated`, `time_limit`) VALUES
(49, 'What does DDL stands for?', 5, 0, 4, 1, '2025-11-09 19:06:06', NULL),
(50, 'The hardware device used to control the movement of the cursor.', 5, 0, 4, 1, '2025-11-09 19:06:06', NULL),
(51, 'Which of the following statements about early computers are TRUE?', 5, 0, 2, 3, '2025-11-09 19:06:06', NULL),
(52, 'Computers used for space exploration, weather forecasting, and cryptanalysis are called _____.', 5, 0, 5, 3, '2025-11-09 19:06:06', NULL),
(53, 'The person who interacts directly with a computer system.', 5, 0, 4, 2, '2025-11-09 19:06:06', NULL),
(54, 'Microcomputers are used for highly complex mathematical computations.', 5, 0, 3, 1, '2025-11-09 19:06:06', NULL),
(55, 'Which of the following is a mainframe computer?', 5, 0, 1, 1, '2025-11-09 19:06:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `question_identifications`
--

CREATE TABLE `question_identifications` (
  `identification_id` int(11) NOT NULL,
  `identification_answer` text NOT NULL,
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `question_identifications`
--

INSERT INTO `question_identifications` (`identification_id`, `identification_answer`, `question_id`) VALUES
(23, 'Data Definition Language', 49),
(24, 'Computer mouse', 50),
(25, 'supercomputers', 52),
(26, 'End-user', 53);

-- --------------------------------------------------------

--
-- Table structure for table `question_options`
--

CREATE TABLE `question_options` (
  `option_id` int(11) NOT NULL,
  `option_txt` text NOT NULL,
  `is_right` tinyint(1) NOT NULL,
  `question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `question_options`
--

INSERT INTO `question_options` (`option_id`, `option_txt`, `is_right`, `question_id`) VALUES
(41, 'CDC 6600 is a mainframe', 1, 51),
(42, 'Atari 800 is a microcomputer', 1, 51),
(43, 'VAX 780 is a minicomputer', 1, 51),
(44, 'IBM System/360 is a supercomputer', 0, 51),
(45, 'True', 0, 54),
(46, 'False', 1, 54),
(47, 'IBM System/360', 0, 55),
(48, 'CDC 6600', 1, 55),
(49, 'Cray', 0, 55),
(50, 'Apple II', 0, 55);

-- --------------------------------------------------------

--
-- Table structure for table `rw_answer`
--

CREATE TABLE `rw_answer` (
  `rw_answer_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `answer_text` text NOT NULL,
  `rw_submission_id` int(11) NOT NULL,
  `rw_question_id` int(11) NOT NULL,
  `rw_option_id` int(11) DEFAULT NULL,
  `is_right` tinyint(1) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_assessment`
--

CREATE TABLE `rw_bank_assessment` (
  `assessment_id` int(11) NOT NULL,
  `assessment_title` varchar(200) NOT NULL,
  `assessment_type` char(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `no_of_questions` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_assessment`
--

INSERT INTO `rw_bank_assessment` (`assessment_id`, `assessment_title`, `assessment_type`, `created_by`, `no_of_questions`) VALUES
(6, 'First Quiz', '2', 4, 7);

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_assessment_question`
--

CREATE TABLE `rw_bank_assessment_question` (
  `assessment_question_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_assessment_question`
--

INSERT INTO `rw_bank_assessment_question` (`assessment_question_id`, `assessment_id`, `question_id`, `date_added`) VALUES
(11, 6, 11, '2025-11-09 18:53:36'),
(12, 6, 10, '2025-11-09 18:53:36'),
(13, 6, 9, '2025-11-09 18:53:36'),
(14, 6, 8, '2025-11-09 18:53:36'),
(15, 6, 7, '2025-11-09 18:53:36'),
(16, 6, 6, '2025-11-09 18:53:36'),
(17, 6, 13, '2025-11-09 18:53:50');

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_course`
--

CREATE TABLE `rw_bank_course` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(150) NOT NULL,
  `created_by` int(11) NOT NULL,
  `no_of_topics` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_course`
--

INSERT INTO `rw_bank_course` (`course_id`, `course_name`, `created_by`, `no_of_topics`) VALUES
(9, 'Information Management', 3, 0),
(13, 'Software Development', 4, 0),
(14, 'Database Administration', 4, 0),
(16, 'Sample Course 1', 3, 0),
(23, 'Object Oriented Programming', 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_program`
--

CREATE TABLE `rw_bank_program` (
  `program_id` int(11) NOT NULL,
  `program_name` varchar(150) NOT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_program`
--

INSERT INTO `rw_bank_program` (`program_id`, `program_name`, `created_by`) VALUES
(4, 'BSIT', 3),
(11, 'BSCS', 4),
(12, 'BSCE', 4);

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_program_course`
--

CREATE TABLE `rw_bank_program_course` (
  `program_course_id` int(11) NOT NULL,
  `program_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_program_course`
--

INSERT INTO `rw_bank_program_course` (`program_course_id`, `program_id`, `course_id`) VALUES
(9, 4, 9),
(11, 4, 14);

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_question`
--

CREATE TABLE `rw_bank_question` (
  `question_id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `question_type` char(1) NOT NULL,
  `difficulty` char(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `total_points` int(3) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_question`
--

INSERT INTO `rw_bank_question` (`question_id`, `topic_id`, `question_text`, `question_type`, `difficulty`, `created_by`, `date_created`, `date_updated`, `total_points`) VALUES
(6, 15, 'Which of the following is a mainframe computer?', '1', '1', 3, '2025-11-09 14:17:04', '2025-11-09 14:17:04', 1),
(7, 15, 'Microcomputers are used for highly complex mathematical computations.', '3', '1', 3, '2025-11-09 14:17:45', '2025-11-09 14:17:45', 1),
(8, 15, 'The person who interacts directly with a computer system.', '4', '2', 3, '2025-11-09 14:18:14', '2025-11-09 14:18:14', 2),
(9, 15, 'Computers used for space exploration, weather forecasting, and cryptanalysis are called _____.', '5', '3', 3, '2025-11-09 14:18:54', '2025-11-09 14:18:54', 3),
(10, 15, 'Which of the following statements about early computers are TRUE?', '2', '2', 3, '2025-11-09 14:19:37', '2025-11-09 14:19:37', 3),
(11, 15, 'The hardware device used to control the movement of the cursor.', '4', '1', 4, '2025-11-09 14:23:12', '2025-11-09 14:23:20', 1),
(12, 16, 'What does SQL stands for?', '4', '1', 4, '2025-11-09 16:13:41', '2025-11-09 16:13:41', 1),
(13, 16, 'What does DDL stands for?', '4', '1', 4, '2025-11-09 16:20:50', '2025-11-09 16:20:50', 1);

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_question_answer`
--

CREATE TABLE `rw_bank_question_answer` (
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `correct_answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_question_answer`
--

INSERT INTO `rw_bank_question_answer` (`answer_id`, `question_id`, `correct_answer`) VALUES
(19, 8, 'End-user'),
(20, 9, 'supercomputers'),
(22, 11, 'Computer mouse'),
(23, 12, 'Structured Query Language'),
(24, 13, 'Data Definition Language');

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_question_option`
--

CREATE TABLE `rw_bank_question_option` (
  `option_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `option_text` text NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_question_option`
--

INSERT INTO `rw_bank_question_option` (`option_id`, `question_id`, `option_text`, `is_correct`) VALUES
(43, 6, 'IBM System/360', 0),
(44, 6, 'CDC 6600', 1),
(45, 6, 'Cray', 0),
(46, 6, 'Apple II', 0),
(47, 7, 'True', 0),
(48, 7, 'False', 1),
(49, 10, 'CDC 6600 is a mainframe', 1),
(50, 10, 'Atari 800 is a microcomputer', 1),
(51, 10, 'VAX 780 is a minicomputer', 1),
(52, 10, 'IBM System/360 is a supercomputer', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rw_bank_topic`
--

CREATE TABLE `rw_bank_topic` (
  `topic_id` int(11) NOT NULL,
  `program_course_id` int(11) NOT NULL,
  `topic_name` varchar(200) NOT NULL,
  `no_of_questions` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rw_bank_topic`
--

INSERT INTO `rw_bank_topic` (`topic_id`, `program_course_id`, `topic_name`, `no_of_questions`) VALUES
(15, 9, 'Introduction to Information Management', 6),
(16, 11, 'Introduction to SQL', 2);

-- --------------------------------------------------------

--
-- Table structure for table `rw_flashcard`
--

CREATE TABLE `rw_flashcard` (
  `flashcard_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `term` varchar(255) NOT NULL,
  `definition` varchar(255) NOT NULL,
  `student_id` int(11) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_questions`
--

CREATE TABLE `rw_questions` (
  `rw_question_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `order_by` int(11) NOT NULL,
  `question_type` tinyint(1) NOT NULL,
  `total_points` int(11) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_question_identifications`
--

CREATE TABLE `rw_question_identifications` (
  `rw_identification_id` int(11) NOT NULL,
  `rw_question_id` int(11) NOT NULL,
  `identification_answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_question_opt`
--

CREATE TABLE `rw_question_opt` (
  `rw_option_id` int(11) NOT NULL,
  `option_text` text NOT NULL,
  `is_right` tinyint(1) NOT NULL,
  `rw_question_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_reviewer`
--

CREATE TABLE `rw_reviewer` (
  `reviewer_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `reviewer_code` varchar(25) DEFAULT NULL,
  `reviewer_name` varchar(255) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `reviewer_type` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_student_results`
--

CREATE TABLE `rw_student_results` (
  `rw_results_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `rw_submission_id` int(11) NOT NULL,
  `student_score` int(11) NOT NULL,
  `date_taken` date NOT NULL DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_student_submission`
--

CREATE TABLE `rw_student_submission` (
  `rw_submission_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `student_score` int(11) NOT NULL,
  `date_taken` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rw_student_todo`
--

CREATE TABLE `rw_student_todo` (
  `todo_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `todo_text` varchar(100) NOT NULL,
  `todo_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedule_assessments`
--

CREATE TABLE `schedule_assessments` (
  `schedule_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL,
  `date_scheduled` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `webmail` varchar(150) NOT NULL,
  `student_number` varchar(15) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` tinyint(1) NOT NULL DEFAULT 3,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `firstname`, `lastname`, `webmail`, `student_number`, `username`, `password`, `user_type`, `date_updated`) VALUES
(2, 'Cyrus', 'Severino', 'cyrus@iskolarngbayan.pup.edu.ph', '1235-40256-MN-0', 'cyrus', '$2y$10$uWksFt2wO7ElBhSb/.rwtO/NyiQAhMudcA8trqdWKuHskq9iZi6Gi', 3, '2025-11-09 14:08:05');

-- --------------------------------------------------------

--
-- Table structure for table `student_answer`
--

CREATE TABLE `student_answer` (
  `answer_id` int(11) NOT NULL,
  `answer_value` varchar(150) NOT NULL,
  `answer_type` text NOT NULL,
  `identification_id` int(11) DEFAULT NULL,
  `submission_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `time_elapsed` int(20) DEFAULT NULL,
  `answer_rank` int(11) DEFAULT NULL,
  `is_right` tinyint(1) NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_answer`
--

INSERT INTO `student_answer` (`answer_id`, `answer_value`, `answer_type`, `identification_id`, `submission_id`, `question_id`, `option_id`, `time_elapsed`, `answer_rank`, `is_right`, `date_updated`) VALUES
(8, 'data definition language', 'fill in the blank', 23, 2, 49, NULL, NULL, NULL, 1, '2025-11-09 19:08:48'),
(9, 'mouse', 'fill in the blank', NULL, 2, 50, NULL, NULL, NULL, 0, '2025-11-09 19:08:48'),
(10, 'cdc 6600 is a mainframe', 'multiple selection', NULL, 2, 51, 41, NULL, NULL, 1, '2025-11-09 19:08:48'),
(11, 'atari 800 is a microcomputer', 'multiple selection', NULL, 2, 51, 42, NULL, NULL, 1, '2025-11-09 19:08:48'),
(12, 'vax 780 is a minicomputer', 'multiple selection', NULL, 2, 51, 43, NULL, NULL, 1, '2025-11-09 19:08:48'),
(13, 'microcomputers', 'identification', NULL, 2, 52, NULL, NULL, NULL, 0, '2025-11-09 19:08:48'),
(14, 'it professional', 'fill in the blank', NULL, 2, 53, NULL, NULL, NULL, 0, '2025-11-09 19:08:48'),
(15, 'true', 'true or false', NULL, 2, 54, 45, NULL, NULL, 0, '2025-11-09 19:08:48'),
(16, 'ibm system/360', 'multiple choices', NULL, 2, 55, 47, NULL, NULL, 0, '2025-11-09 19:08:48');

-- --------------------------------------------------------

--
-- Table structure for table `student_enrollment`
--

CREATE TABLE `student_enrollment` (
  `studentEnrollment_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `reason` text DEFAULT NULL,
  `if_display` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_enrollment`
--

INSERT INTO `student_enrollment` (`studentEnrollment_id`, `class_id`, `student_id`, `status`, `reason`, `if_display`) VALUES
(1, 2, 2, 1, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `student_results`
--

CREATE TABLE `student_results` (
  `results_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `submission_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `total_score` int(3) NOT NULL,
  `score` int(3) NOT NULL,
  `remarks` text DEFAULT NULL,
  `rank` int(3) DEFAULT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_results`
--

INSERT INTO `student_results` (`results_id`, `assessment_id`, `submission_id`, `student_id`, `total_score`, `score`, `remarks`, `rank`, `date_updated`) VALUES
(2, 5, 2, 2, 12, 4, 'Failed', 0, '2025-11-09 19:08:48');

-- --------------------------------------------------------

--
-- Table structure for table `student_submission`
--

CREATE TABLE `student_submission` (
  `submission_id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `date_taken` datetime NOT NULL,
  `administer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_submission`
--

INSERT INTO `student_submission` (`submission_id`, `assessment_id`, `student_id`, `date_taken`, `administer_id`) VALUES
(2, 5, 2, '2025-11-09 12:08:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_reviewers`
--

CREATE TABLE `user_reviewers` (
  `shared_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `reviewer_name` varchar(255) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `reviewer_type` varchar(100) NOT NULL,
  `student_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administer_assessment`
--
ALTER TABLE `administer_assessment`
  ADD PRIMARY KEY (`administer_id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `program_id` (`program_id`),
  ADD KEY `administer_assessment_ibfk_3` (`class_id`);

--
-- Indexes for table `assessment`
--
ALTER TABLE `assessment`
  ADD PRIMARY KEY (`assessment_id`),
  ADD KEY `program_id` (`program_id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `assessment_uploads`
--
ALTER TABLE `assessment_uploads`
  ADD PRIMARY KEY (`upload_id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `faculty_id` (`faculty_id`),
  ADD KEY `program_id` (`program_id`);

--
-- Indexes for table `dashboard_settings`
--
ALTER TABLE `dashboard_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`faculty_id`);

--
-- Indexes for table `join_assessment`
--
ALTER TABLE `join_assessment`
  ADD PRIMARY KEY (`join_id`),
  ADD KEY `join_assessment_ibfk_1` (`student_id`),
  ADD KEY `join_assessment_ibfk_2` (`administer_id`);

--
-- Indexes for table `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`program_id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `assessment_id` (`assessment_id`);

--
-- Indexes for table `question_identifications`
--
ALTER TABLE `question_identifications`
  ADD PRIMARY KEY (`identification_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `question_options`
--
ALTER TABLE `question_options`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `rw_answer`
--
ALTER TABLE `rw_answer`
  ADD PRIMARY KEY (`rw_answer_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `rw_submission_id` (`rw_submission_id`),
  ADD KEY `rw_question_id` (`rw_question_id`),
  ADD KEY `rw_option_id` (`rw_option_id`);

--
-- Indexes for table `rw_bank_assessment`
--
ALTER TABLE `rw_bank_assessment`
  ADD PRIMARY KEY (`assessment_id`),
  ADD KEY `fk_rw_assessment_faculty` (`created_by`);

--
-- Indexes for table `rw_bank_assessment_question`
--
ALTER TABLE `rw_bank_assessment_question`
  ADD PRIMARY KEY (`assessment_question_id`),
  ADD KEY `fk_rw_aq_assessment` (`assessment_id`),
  ADD KEY `fk_question_id` (`question_id`);

--
-- Indexes for table `rw_bank_course`
--
ALTER TABLE `rw_bank_course`
  ADD PRIMARY KEY (`course_id`),
  ADD UNIQUE KEY `uq_course_name` (`course_name`),
  ADD KEY `fk_rw_course_faculty` (`created_by`);

--
-- Indexes for table `rw_bank_program`
--
ALTER TABLE `rw_bank_program`
  ADD PRIMARY KEY (`program_id`),
  ADD KEY `fk_rw_program_faculty` (`created_by`);

--
-- Indexes for table `rw_bank_program_course`
--
ALTER TABLE `rw_bank_program_course`
  ADD PRIMARY KEY (`program_course_id`),
  ADD KEY `fk_rw_pc_program` (`program_id`),
  ADD KEY `fk_rw_pc_course` (`course_id`);

--
-- Indexes for table `rw_bank_question`
--
ALTER TABLE `rw_bank_question`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `fk_rw_q_topic` (`topic_id`),
  ADD KEY `fk_rw_q_faculty` (`created_by`);

--
-- Indexes for table `rw_bank_question_answer`
--
ALTER TABLE `rw_bank_question_answer`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `fk_rw_qa_question` (`question_id`);

--
-- Indexes for table `rw_bank_question_option`
--
ALTER TABLE `rw_bank_question_option`
  ADD PRIMARY KEY (`option_id`),
  ADD KEY `fk_rw_qo_question` (`question_id`);

--
-- Indexes for table `rw_bank_topic`
--
ALTER TABLE `rw_bank_topic`
  ADD PRIMARY KEY (`topic_id`),
  ADD KEY `fk_rw_topic_pc` (`program_course_id`);

--
-- Indexes for table `rw_flashcard`
--
ALTER TABLE `rw_flashcard`
  ADD PRIMARY KEY (`flashcard_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `reviewer_id` (`reviewer_id`);

--
-- Indexes for table `rw_questions`
--
ALTER TABLE `rw_questions`
  ADD PRIMARY KEY (`rw_question_id`),
  ADD KEY `reviewer_id` (`reviewer_id`);

--
-- Indexes for table `rw_question_identifications`
--
ALTER TABLE `rw_question_identifications`
  ADD PRIMARY KEY (`rw_identification_id`),
  ADD KEY `rw_question_id` (`rw_question_id`);

--
-- Indexes for table `rw_question_opt`
--
ALTER TABLE `rw_question_opt`
  ADD PRIMARY KEY (`rw_option_id`),
  ADD KEY `rw_question_id` (`rw_question_id`);

--
-- Indexes for table `rw_reviewer`
--
ALTER TABLE `rw_reviewer`
  ADD PRIMARY KEY (`reviewer_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `rw_student_results`
--
ALTER TABLE `rw_student_results`
  ADD PRIMARY KEY (`rw_results_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `reviewer_id` (`reviewer_id`),
  ADD KEY `rw_submission_id` (`rw_submission_id`);

--
-- Indexes for table `rw_student_submission`
--
ALTER TABLE `rw_student_submission`
  ADD PRIMARY KEY (`rw_submission_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `reviewer_id` (`reviewer_id`);

--
-- Indexes for table `rw_student_todo`
--
ALTER TABLE `rw_student_todo`
  ADD PRIMARY KEY (`todo_id`);

--
-- Indexes for table `schedule_assessments`
--
ALTER TABLE `schedule_assessments`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `faculty_id` (`faculty_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_answer`
--
ALTER TABLE `student_answer`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `submission_id` (`submission_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `student_answer_ibfk_3` (`option_id`),
  ADD KEY `student_answer_ibfk_4` (`identification_id`);

--
-- Indexes for table `student_enrollment`
--
ALTER TABLE `student_enrollment`
  ADD PRIMARY KEY (`studentEnrollment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `student_enrollment_ibfk_1` (`class_id`);

--
-- Indexes for table `student_results`
--
ALTER TABLE `student_results`
  ADD PRIMARY KEY (`results_id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `submission_id` (`submission_id`);

--
-- Indexes for table `student_submission`
--
ALTER TABLE `student_submission`
  ADD PRIMARY KEY (`submission_id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `administer_id` (`administer_id`);

--
-- Indexes for table `user_reviewers`
--
ALTER TABLE `user_reviewers`
  ADD PRIMARY KEY (`shared_id`),
  ADD KEY `reviewer_id` (`reviewer_id`),
  ADD KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administer_assessment`
--
ALTER TABLE `administer_assessment`
  MODIFY `administer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `assessment`
--
ALTER TABLE `assessment`
  MODIFY `assessment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `assessment_uploads`
--
ALTER TABLE `assessment_uploads`
  MODIFY `upload_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dashboard_settings`
--
ALTER TABLE `dashboard_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `faculty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `join_assessment`
--
ALTER TABLE `join_assessment`
  MODIFY `join_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `program`
--
ALTER TABLE `program`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `question_identifications`
--
ALTER TABLE `question_identifications`
  MODIFY `identification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `question_options`
--
ALTER TABLE `question_options`
  MODIFY `option_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `rw_answer`
--
ALTER TABLE `rw_answer`
  MODIFY `rw_answer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_bank_assessment`
--
ALTER TABLE `rw_bank_assessment`
  MODIFY `assessment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rw_bank_assessment_question`
--
ALTER TABLE `rw_bank_assessment_question`
  MODIFY `assessment_question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `rw_bank_course`
--
ALTER TABLE `rw_bank_course`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `rw_bank_program`
--
ALTER TABLE `rw_bank_program`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `rw_bank_program_course`
--
ALTER TABLE `rw_bank_program_course`
  MODIFY `program_course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `rw_bank_question`
--
ALTER TABLE `rw_bank_question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `rw_bank_question_answer`
--
ALTER TABLE `rw_bank_question_answer`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `rw_bank_question_option`
--
ALTER TABLE `rw_bank_question_option`
  MODIFY `option_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `rw_bank_topic`
--
ALTER TABLE `rw_bank_topic`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `rw_flashcard`
--
ALTER TABLE `rw_flashcard`
  MODIFY `flashcard_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_questions`
--
ALTER TABLE `rw_questions`
  MODIFY `rw_question_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_question_identifications`
--
ALTER TABLE `rw_question_identifications`
  MODIFY `rw_identification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_question_opt`
--
ALTER TABLE `rw_question_opt`
  MODIFY `rw_option_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_reviewer`
--
ALTER TABLE `rw_reviewer`
  MODIFY `reviewer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_student_results`
--
ALTER TABLE `rw_student_results`
  MODIFY `rw_results_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_student_submission`
--
ALTER TABLE `rw_student_submission`
  MODIFY `rw_submission_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rw_student_todo`
--
ALTER TABLE `rw_student_todo`
  MODIFY `todo_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule_assessments`
--
ALTER TABLE `schedule_assessments`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_answer`
--
ALTER TABLE `student_answer`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `student_enrollment`
--
ALTER TABLE `student_enrollment`
  MODIFY `studentEnrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_results`
--
ALTER TABLE `student_results`
  MODIFY `results_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student_submission`
--
ALTER TABLE `student_submission`
  MODIFY `submission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_reviewers`
--
ALTER TABLE `user_reviewers`
  MODIFY `shared_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administer_assessment`
--
ALTER TABLE `administer_assessment`
  ADD CONSTRAINT `administer_assessment_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`assessment_id`),
  ADD CONSTRAINT `administer_assessment_ibfk_2` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  ADD CONSTRAINT `administer_assessment_ibfk_3` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`);

--
-- Constraints for table `assessment`
--
ALTER TABLE `assessment`
  ADD CONSTRAINT `assessment_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`),
  ADD CONSTRAINT `assessment_ibfk_2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`);

--
-- Constraints for table `assessment_uploads`
--
ALTER TABLE `assessment_uploads`
  ADD CONSTRAINT `assessment_uploads_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`assessment_id`),
  ADD CONSTRAINT `assessment_uploads_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`);

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`),
  ADD CONSTRAINT `class_ibfk_3` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`);

--
-- Constraints for table `join_assessment`
--
ALTER TABLE `join_assessment`
  ADD CONSTRAINT `join_assessment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  ADD CONSTRAINT `join_assessment_ibfk_2` FOREIGN KEY (`administer_id`) REFERENCES `administer_assessment` (`administer_id`);

--
-- Constraints for table `program`
--
ALTER TABLE `program`
  ADD CONSTRAINT `program_ibfk_1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`assessment_id`);

--
-- Constraints for table `question_identifications`
--
ALTER TABLE `question_identifications`
  ADD CONSTRAINT `question_identifications_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`);

--
-- Constraints for table `question_options`
--
ALTER TABLE `question_options`
  ADD CONSTRAINT `question_options_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`);

--
-- Constraints for table `rw_bank_assessment`
--
ALTER TABLE `rw_bank_assessment`
  ADD CONSTRAINT `fk_rw_assessment_faculty` FOREIGN KEY (`created_by`) REFERENCES `faculty` (`faculty_id`);

--
-- Constraints for table `rw_bank_assessment_question`
--
ALTER TABLE `rw_bank_assessment_question`
  ADD CONSTRAINT `fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `rw_bank_question` (`question_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rw_aq_assessment` FOREIGN KEY (`assessment_id`) REFERENCES `rw_bank_assessment` (`assessment_id`),
  ADD CONSTRAINT `fk_rw_aq_question` FOREIGN KEY (`question_id`) REFERENCES `rw_bank_question` (`question_id`);

--
-- Constraints for table `rw_bank_course`
--
ALTER TABLE `rw_bank_course`
  ADD CONSTRAINT `fk_rw_course_faculty` FOREIGN KEY (`created_by`) REFERENCES `faculty` (`faculty_id`);

--
-- Constraints for table `rw_bank_program`
--
ALTER TABLE `rw_bank_program`
  ADD CONSTRAINT `fk_rw_program_faculty` FOREIGN KEY (`created_by`) REFERENCES `faculty` (`faculty_id`);

--
-- Constraints for table `rw_bank_program_course`
--
ALTER TABLE `rw_bank_program_course`
  ADD CONSTRAINT `fk_rw_pc_course_fix` FOREIGN KEY (`course_id`) REFERENCES `rw_bank_course` (`course_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rw_pc_program_fix` FOREIGN KEY (`program_id`) REFERENCES `rw_bank_program` (`program_id`) ON DELETE CASCADE;

--
-- Constraints for table `rw_bank_question`
--
ALTER TABLE `rw_bank_question`
  ADD CONSTRAINT `fk_rw_q_faculty` FOREIGN KEY (`created_by`) REFERENCES `faculty` (`faculty_id`),
  ADD CONSTRAINT `fk_rw_q_topic_fix` FOREIGN KEY (`topic_id`) REFERENCES `rw_bank_topic` (`topic_id`) ON DELETE CASCADE;

--
-- Constraints for table `rw_bank_question_answer`
--
ALTER TABLE `rw_bank_question_answer`
  ADD CONSTRAINT `fk_rw_qa_question` FOREIGN KEY (`question_id`) REFERENCES `rw_bank_question` (`question_id`) ON DELETE CASCADE;

--
-- Constraints for table `rw_bank_question_option`
--
ALTER TABLE `rw_bank_question_option`
  ADD CONSTRAINT `fk_rw_qo_question` FOREIGN KEY (`question_id`) REFERENCES `rw_bank_question` (`question_id`) ON DELETE CASCADE;

--
-- Constraints for table `rw_bank_topic`
--
ALTER TABLE `rw_bank_topic`
  ADD CONSTRAINT `fk_rw_topic_pc_fix` FOREIGN KEY (`program_course_id`) REFERENCES `rw_bank_program_course` (`program_course_id`) ON DELETE CASCADE;

--
-- Constraints for table `rw_flashcard`
--
ALTER TABLE `rw_flashcard`
  ADD CONSTRAINT `rw_flashcard_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  ADD CONSTRAINT `rw_flashcard_ibfk_2` FOREIGN KEY (`reviewer_id`) REFERENCES `rw_reviewer` (`reviewer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
