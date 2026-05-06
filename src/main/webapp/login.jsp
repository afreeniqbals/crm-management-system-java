<!DOCTYPE html>

<html>
<head>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <title>CRM Login</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f6f9;
        }
        .login-box {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background: white;
            box-shadow: 0px 0px 10px gray;
            border-radius: 10px;
        }
        h2 {
            text-align: center;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            border: none;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>CRM Login</h2>
    <form action="LoginServlet" method="post">
        <input type="email" name="email" placeholder="Enter Email" required>
        <input type="password" name="password" placeholder="Enter Password" required>
        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>
