<?php
include 'db_connect.php';

// Get search query and type
$query = isset($_GET['query']) ? $_GET['query'] : '';
$type = isset($_GET['type']) ? $_GET['type'] : ''; // 'programs' or 'classes'

if ($type == 'programs') {
    // Search in programs
    $sql = "SELECT * FROM program 
            WHERE program_name LIKE ?
            ORDER BY program_name ASC";
    
    $stmt = $conn->prepare($sql);
    $searchTerm = "%" . $query . "%";
    $stmt->bind_param("s", $searchTerm);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result === false) {
        echo 'Error: ' . $stmt->error;
        exit;
    }
    
    $output = '';
    
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $program_id = $row['program_id'];
            $classCountQuery = $conn->query("SELECT COUNT(*) as classCount FROM class WHERE program_id = '$program_id'");
            $classCountRow = $classCountQuery->fetch_assoc();
            $classCount = $classCountRow['classCount'];
            
            $output .= '
            <div class="program-card">
                <div class="program-card-body">
                    <div class="meatball-menu-container">
                        <button class="meatball-menu-btn">
                            <i class="fas fa-ellipsis-v"></i>
                        </button>
                        <div class="meatball-menu">
                            <div class="arrow-up"></div>
                            <a href="#" class="edit_program" data-id="'.$row['program_id'].'" data-name="'.$row['program_name'].'">
                                <span class="material-symbols-outlined">Edit</span>Edit</a>
                            <a href="#" class="delete_program" data-id="'.$row['program_id'].'" data-name="'.$row['program_name'].'">
                                <span class="material-symbols-outlined">delete</span>Delete</a>
                        </div>
                    </div>
                    <div class="program-card-title">'.$row['program_name'].'</div>
                    <div class="program-card-text">'.$classCount.' Class(es)</div>
                    <div class="program-actions">
                        <button id="viewClasses" class="tertiary-button viewClasses" data-id="'.$row['program_id'].'" data-name="'.$row['program_name'].'" type="button">Classes</button>
                        <button id="viewProgramDetails" class="main-button" data-id="'.$row['program_id'].'" type="button">View Details</button>
                    </div>
                </div>
            </div>';
        }
    } else {
        $output = '<div class="no-records">No programs found matching your search.</div>';
    }
    
} else {
    // Search in classes for the current program
    $program_id = isset($_GET['program_id']) ? $_GET['program_id'] : 0;
    
    $sql = "SELECT * FROM class 
            WHERE program_id = ? 
            AND (class_name LIKE ? OR course_name LIKE ?)
            ORDER BY class_name ASC";
    
    $stmt = $conn->prepare($sql);
    $searchTerm = "%" . $query . "%";
    $stmt->bind_param("iss", $program_id, $searchTerm, $searchTerm);
    $stmt->execute();
    $result = $stmt->get_result();
    
    $output = '';
    
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $output .= '
            <div class="class-card">
                <div class="class-card-body">
                    <div class="meatball-menu-container">
                        <button class="meatball-menu-btn">
                            <i class="fas fa-ellipsis-v"></i>
                        </button>
                        <div class="meatball-menu">
                            <div class="arrow-up"></div>
                            <a href="#" class="edit_class" 
                                data-program-id="'.$row['program_id'].'"
                                data-class-id="'.$row['class_id'].'"
                                data-class-name="'.$row['class_name'].'"
                                data-course-name="'.$row['course_name'].'">
                                <span class="material-symbols-outlined">Edit</span>Edit</a>
                            <a href="#" class="delete_class"
                                data-program-id="'.$row['program_id'].'"
                                data-class-id="'.$row['class_id'].'"
                                data-class-name="'.$row['class_name'].'"
                                data-course-name="'.$row['course_name'].'">
                                <span class="material-symbols-outlined">delete</span>Delete</a>
                            <a href="#" class="get_code"
                                data-class-id="'.$row['class_id'].'"
                                data-class-name="'.$row['class_name'].'"
                                data-course-name="'.$row['course_name'].'">
                                <span class="material-symbols-outlined">key</span>Get Code</a>
                        </div>
                    </div>
                    <div class="class-card-title">'.$row['class_name'].'</div>
                    <div class="class-card-text">Course Name: '.$row['course_name'].'</div>
                    <div class="class-actions">
                        <button id="viewClassDetails" class="main-button" data-id="'.$row['class_id'].'" type="button">View Details</button>
                    </div>
                </div>
            </div>';
        }
    } else {
        $output = '<div class="no-records">No classes found matching your search.</div>';
    }
}

echo $output;
?>