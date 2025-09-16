<?php
include('db_connect.php');
include('auth.php');

// Set content type to JSON
header('Content-Type: application/json');

if(isset($_POST['program_name'])){
    $program_id = isset($_POST['program_id']) ? $_POST['program_id'] : '';
    $faculty_id = $_POST['faculty_id'];
    $program_name = $_POST['program_name'];

    if (!empty($program_id)) {
        $qry = $conn->query("UPDATE program SET program_name='$program_name' WHERE program_id='$program_id' AND faculty_id='$faculty_id'");
    } else {
        echo json_encode(['status' => 0, 'msg' => 'Program ID is missing.']);
        exit;
    }

    if($qry){
        echo json_encode(['status' => 1]);
    } else {
        echo json_encode(['status' => 0, 'msg' => 'Failed to save program']);
    }
}
?>
