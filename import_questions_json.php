<?php
include('db_connect.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['json_file'])) {
    $assessment_id = intval($_POST['assessment_id']);
    $file_tmp = $_FILES['json_file']['tmp_name'];

    if (!file_exists($file_tmp)) {
        die(json_encode(['status' => 'error', 'message' => 'File not uploaded']));
    }

    $json_data = file_get_contents($file_tmp);
    $data = json_decode($json_data, true);

    if (!$data || !isset($data['questions'])) {
        die(json_encode(['status' => 'error', 'message' => 'Invalid JSON format']));
    }

    // Update assessment details if they exist in the JSON
    if (isset($data['time_limit']) || isset($data['passing_rate']) || isset($data['max_warnings'])) {
        $update_fields = [];
        $update_params = [];
        $types = '';
        
        if (isset($data['time_limit'])) {
            $update_fields[] = 'time_limit = ?';
            $update_params[] = intval($data['time_limit']);
            $types .= 'i';
        }
        
        if (isset($data['passing_rate'])) {
            $update_fields[] = 'passing_rate = ?';
            $update_params[] = floatval($data['passing_rate']);
            $types .= 'd';
        }
        
        if (isset($data['max_warnings'])) {
            $update_fields[] = 'max_warnings = ?';
            $update_params[] = intval($data['max_warnings']);
            $types .= 'i';
        }
        
        if (!empty($update_fields)) {
            $update_query = "UPDATE assessment SET " . implode(', ', $update_fields) . " WHERE assessment_id = ?";
            $update_params[] = $assessment_id;
            $types .= 'i';
            
            $update_stmt = $conn->prepare($update_query);
            $update_stmt->bind_param($types, ...$update_params);
            $update_stmt->execute();
            $update_stmt->close();
        }
    }

    $type_map = [
        'Multiple Choice' => 1,
        'Checkbox' => 2,
        'True or False' => 3,
        'Identification' => 4,
        'Fill in the Blank' => 5
    ];

    foreach ($data['questions'] as $q) {
        $question_text = $q['question'];
        $ques_type = $type_map[$q['type']] ?? null;
        $points = intval($q['points']);

        if (!$ques_type) continue;

        // Insert into questions table
        $stmt = $conn->prepare("INSERT INTO questions (question, assessment_id, ques_type, total_points, date_updated) VALUES (?, ?, ?, ?, NOW())");
        $stmt->bind_param("siii", $question_text, $assessment_id, $ques_type, $points);
        $stmt->execute();
        $question_id = $stmt->insert_id;
        $stmt->close();

        // Handle based on type
        switch ($ques_type) {
            case 1: // Multiple Choice
            case 2: // Checkbox
            case 3: // True or False
                if ($ques_type === 3 && empty($q['options'])) {
                    $q['options'] = ['True', 'False'];
                }

                if (!empty($q['options'])) {
                    foreach ($q['options'] as $opt) {
                        $is_right = (is_array($q['correct_answer']) && in_array($opt, $q['correct_answer'])) ||
                                    ($q['correct_answer'] === $opt) ? 1 : 0;
                        $opt_stmt = $conn->prepare("INSERT INTO question_options (option_txt, is_right, question_id) VALUES (?, ?, ?)");
                        $opt_stmt->bind_param("sii", $opt, $is_right, $question_id);
                        $opt_stmt->execute();
                        $opt_stmt->close();
                    }
                }
                break;

            case 4: // Identification
            case 5: // Fill in the Blank
                if (!empty($q['correct_answer'])) {
                    $answers = is_array($q['correct_answer']) ? $q['correct_answer'] : [$q['correct_answer']];
                    foreach ($answers as $ans) {
                        $ans_stmt = $conn->prepare("INSERT INTO question_identifications (identification_answer, question_id) VALUES (?, ?)");
                        $ans_stmt->bind_param("si", $ans, $question_id);
                        $ans_stmt->execute();
                        $ans_stmt->close();
                    }
                }
                break;
        }
    }

    echo json_encode(['status' => 'success', 'message' => 'Questions and assessment settings imported successfully']);
    exit;
}
?>