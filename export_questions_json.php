<?php
include('db_connect.php');

if (!isset($_GET['assessment_id'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Assessment ID not provided.']);
    exit;
}

$assessment_id = intval($_GET['assessment_id']);

// Fetch assessment details - updated to include time_limit, passing_rate, and max_warnings
$assessment_query = "SELECT assessment_name, time_limit, passing_rate, max_warnings FROM assessment WHERE assessment_id = ?";
$assessment_stmt = $conn->prepare($assessment_query);
$assessment_stmt->bind_param("i", $assessment_id);
$assessment_stmt->execute();
$assessment_result = $assessment_stmt->get_result();
$assessment = $assessment_result->fetch_assoc();
$assessment_stmt->close();

$exam_title = $assessment ? $assessment['assessment_name'] : '';

// Fetch questions
$query = "SELECT question_id, question, ques_type, total_points FROM questions WHERE assessment_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $assessment_id);
$stmt->execute();
$result = $stmt->get_result();

$type_map = [
    1 => 'Multiple Choice',
    2 => 'Checkbox',
    3 => 'True or False',
    4 => 'Identification',
    5 => 'Fill in the Blank'
];

$questions = [];
while ($row = $result->fetch_assoc()) {
    $question = [
        'question' => $row['question'],
        'type' => $type_map[intval($row['ques_type'])] ?? 'Unknown',
        'points' => intval($row['total_points']),
        'correct_answer' => null
    ];

    switch ($row['ques_type']) {
        case 1: // Multiple Choice
        case 2: // Checkbox
            $options = [];
            $correct_answers = [];
            $opt_query = "SELECT option_txt, is_right FROM question_options WHERE question_id = ?";
            $opt_stmt = $conn->prepare($opt_query);
            $opt_stmt->bind_param("i", $row['question_id']);
            $opt_stmt->execute();
            $opt_result = $opt_stmt->get_result();
            while ($opt_row = $opt_result->fetch_assoc()) {
                $options[] = $opt_row['option_txt'];
                if ($opt_row['is_right']) {
                    $correct_answers[] = $opt_row['option_txt'];
                }
            }
            $opt_stmt->close();

            $question['options'] = $options;
            $question['correct_answer'] = ($row['ques_type'] == 2) ? $correct_answers : ($correct_answers[0] ?? null);
            break;

        case 3: // True or False
            $opt_query = "SELECT option_txt, is_right FROM question_options WHERE question_id = ?";
            $opt_stmt = $conn->prepare($opt_query);
            $opt_stmt->bind_param("i", $row['question_id']);
            $opt_stmt->execute();
            $opt_result = $opt_stmt->get_result();
            $correct_answer = null;
            while ($opt_row = $opt_result->fetch_assoc()) {
                if ($opt_row['is_right']) {
                    $correct_answer = $opt_row['option_txt'];
                    break;
                }
            }
            $opt_stmt->close();
            $question['correct_answer'] = $correct_answer;
            break;

        case 4: // Identification
        case 5: // Fill in the Blank
            $ans_query = "SELECT identification_answer FROM question_identifications WHERE question_id = ?";
            $ans_stmt = $conn->prepare($ans_query);
            $ans_stmt->bind_param("i", $row['question_id']);
            $ans_stmt->execute();
            $ans_result = $ans_stmt->get_result();
            $answers = [];
            while ($ans_row = $ans_result->fetch_assoc()) {
                $answers[] = $ans_row['identification_answer'];
            }
            $ans_stmt->close();
            $question['correct_answer'] = (count($answers) > 1) ? $answers : ($answers[0] ?? null);
            break;
    }

    $questions[] = $question;
}

$output = [
    'exam_title' => $exam_title,
    'time_limit' => $assessment ? intval($assessment['time_limit']) : 0,
    'passing_rate' => $assessment ? floatval($assessment['passing_rate']) : 0,
    'max_warnings' => $assessment ? intval($assessment['max_warnings']) : 0,
    'questions' => $questions
];

// Sanitize exam title for filename
$filename = preg_replace('/[^A-Za-z0-9_\-]/', '_', $exam_title);
$filename = strtolower($filename);

header('Content-Type: application/json');
header('Content-Disposition: attachment; filename="' . $filename . '.json"');

echo json_encode($output, JSON_PRETTY_PRINT);
exit;