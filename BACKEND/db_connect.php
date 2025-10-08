<?php
// db_connect.php

$host = "localhost";
$user = "root"; // your MySQL username
$pass = "";     // your MySQL password (leave empty if none)
$dbname = "sports_tracker"; // your database name

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Database connection failed: " . $conn->connect_error]));
}

$conn->set_charset("utf8mb4");
?>
