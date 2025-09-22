<?php
$conn = new mysqli('localhost:3307', 'root', '', 'quilana');

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
