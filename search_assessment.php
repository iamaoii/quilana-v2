<?php
include 'db_connect.php';

$query = isset($_GET['query']) ? $_GET['query'] : '';
$faculty_id = isset($_GET['faculty_id']) ? $_GET['faculty_id'] : '';

$sql = "SELECT a.*, p.program_name 
        FROM assessment a 
        JOIN program p ON a.program_id = p.program_id 
        WHERE a.faculty_id = ? 
        AND (a.assessment_name LIKE ? 
            OR a.course_name LIKE ? 
            OR a.topic LIKE ?
            OR p.program_name LIKE ?)
        ORDER BY p.program_name, a.course_name, a.assessment_name ASC";

$stmt = $conn->prepare($sql);
$searchTerm = "%" . $query . "%";
$stmt->bind_param("issss", $faculty_id, $searchTerm, $searchTerm, $searchTerm, $searchTerm);
$stmt->execute();
$result = $stmt->get_result();

$output = '';
$current_program = '';
$current_course_name = '';

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $program_name = htmlspecialchars($row['program_name']);
        $course_name = htmlspecialchars($row['course_name']);
        $assessment_name = htmlspecialchars($row['assessment_name']);
        $topic = htmlspecialchars($row['topic']);
        $assessment_id = $row['assessment_id'];

        // Start new program section if program changes
        if ($program_name !== $current_program) {
            if ($current_program !== '') {
                $output .= '</div></div>';
            }
            $output .= '<div class="program-section"><h2>' . $program_name . '</h2>';
            $current_program = $program_name;
            $current_course_name = '';
        }

        // Start new course_name section if course_name changes
        if ($course_name !== $current_course_name) {
            if ($current_course_name !== '') {
                $output .= '</div>';
            }
            $output .= '<div class="content-separator">
                        <span class="content-name">' . $course_name . '</span>
                        <hr class="separator-line">
                    </div>
                    <div class="assessment-container">';
            $current_course_name = $course_name;
        }

        // Add assessment card
        $output .= '<div class="assessment-card">
            <div class="assessment-card-body">
                <div class="meatball-menu-container">
                    <button class="meatball-menu-btn">
                        <i class="fas fa-ellipsis-v"></i>
                    </button>
                    <div class="meatball-menu">
                        <div class="arrow-up"></div>
                        <a href="#" class="edit_assessment" data-id="' . $assessment_id . '">
                            <span class="material-symbols-outlined">Edit</span>
                            Edit
                        </a>
                        <a href="#" class="delete_assessment" 
                            data-id="' . $assessment_id . '"
                            data-name="' . $assessment_name . '"
                            data-course-name="' . $course_name . '">
                            <span class="material-symbols-outlined">delete</span>
                            Delete
                        </a>
                    </div>
                </div>
                <div class="assessment-card-title">' . $assessment_name . '</div>
                <div class="assessment-card-topic">Topic: ' . $topic . '</div>
                <div class="assessment-actions">
                    <a id="manage" class="tertiary-button" href="manage_assessment.php?assessment_id=' . $assessment_id . '">Manage</a>
                    <button id="administer" class="main-button" 
                        data-program-id="' . $row['program_id'] . '" 
                        data-program-name="' . $row['program_name'] . '" 
                        data-course-name="' . htmlspecialchars($row['course_name']) . '" 
                        data-mode="' . htmlspecialchars($row['assessment_mode']) . '" 
                        data-id="' . $row['assessment_id'] . '"
                        data-assessment-name="' . htmlspecialchars($row['assessment_name']) . '">
                        Administer
                    </button>
                </div>
            </div>
        </div>';
    }
    
    // Close the last containers
    if ($current_program !== '') {
        $output .= '</div></div>';
    }
} else {
    $output = '<div class="no-records">No assessments found matching your search.</div>';
}

echo $output;
?>