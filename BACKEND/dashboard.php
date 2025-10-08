<?php
session_start();

// Redirect to login if user not logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Sports Tracker - Dashboard</title>
  <link rel="stylesheet" href="style1.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f5f7fa;
      margin: 0;
      padding: 0;
    }
    header {
      background: #1f2b3a;
      color: white;
      padding: 15px;
      text-align: center;
    }
    .container {
      max-width: 800px;
      margin: 30px auto;
      background: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .profile-card {
      background: #e9f0f9;
      padding: 20px;
      border-radius: 10px;
      text-align: center;
      margin-bottom: 20px;
    }
    .profile-card h2 {
      margin: 10px 0;
      color: #1f2b3a;
    }
    .logout-btn {
      background: #c0392b;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      cursor: pointer;
      transition: 0.3s;
    }
    .logout-btn:hover {
      background: #e74c3c;
    }
  </style>
</head>
<body>
  <header>
    <h1>Sports Tracker Dashboard</h1>
  </header>

  <div class="container">
    <div class="profile-card">
      <h2>Welcome, <?php echo htmlspecialchars($_SESSION['name']); ?> 👋</h2>
      <p><strong>Email:</strong> <?php echo htmlspecialchars($_SESSION['email']); ?></p>
    </div>

    <button class="logout-btn" onclick="logout()">Logout</button>
  </div>

  <script>
    function logout() {
      fetch("../BACKEND/logout.php")
        .then(res => res.json())
        .then(data => {
          if (data.status === "success") {
            window.location.href = "login.html";
          }
        });
    }
  </script>
</body>
</html>
