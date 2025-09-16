<?php
include('db_connect.php');
include('auth.php');

// Set content type to JSON
header('Content-Type: application/json');

if(isset($_POST['class_name'])){
    $class_id = isset($_POST['class_id']) ? $_POST['class_id'] : '';
    $faculty_id = $_POST['faculty_id'];
    $class_name = $_POST['class_name'];
    $course_name = $_POST['course_name'];

    if (!empty($class_id)) {
        $qry = $conn->query("UPDATE class SET class_name='$class_name', course_name='$course_name' WHERE class_id='$class_id' AND faculty_id='$faculty_id'");
    } else {
        echo json_encode(['status' => 0, 'msg' => 'Class ID is missing.']);
        exit;
    }

    if($qry){
        echo json_encode(['status' => 1]);
    } else {
        echo json_encode(['status' => 0, 'msg' => 'Failed to save class']);
    }
}
?>
