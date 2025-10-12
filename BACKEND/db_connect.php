<?php
// db_connect.php

$host = "127.0.0.1";
$user = "root"; // your MySQL username
$pass = "#Nguono_22";     // your MySQL password (leave empty if none)
$dbname = "mydb"; // your database name

$conn = new mysqli($host, $user, $pass, $dbname);

if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Database connection failed: " . $conn->connect_error]));
}

$conn->set_charset("utf8mb4");
?>
