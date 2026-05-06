<%@ page contentType="text/html;charset=UTF-8" %>

<%
String user = (String) session.getAttribute("userEmail");
if(user == null){
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Add Client</title>

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font -->

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #f1f5f9;
}

/* Form Card */
.form-box {
    width: 500px;
    margin: 60px auto;
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
}

h2 {
    margin-bottom: 20px;
}

body {
    margin: 0;
}

.form-box, .container {
    margin-top: 30px;
}
</style>

</head>

<body>

<div style="background:#111827; color:white; padding:12px 20px; display:flex; justify-content:space-between; align-items:center;">

    <!-- Left -->
    <div>
        <a href="dashboard.jsp" style="color:white; text-decoration:none; font-weight:500;">
            ← Dashboard
        </a>
    </div>

    <!-- Center -->
    <div style="font-weight:600;">
        CRM System
    </div>

    <!-- Right -->
    <div>
        <a href="LogoutServlet" style="color:white; text-decoration:none;">
            Logout
        </a>
    </div>

</div>

<div class="form-box">

```
<h2>Add Client</h2>

<form action="AddClientServlet" method="post">

    <div class="mb-3">
        <label>Name</label>
        <input type="text" name="name" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Email</label>
        <input type="email" name="email" class="form-control" required>
    </div>

    <div class="mb-3">
        <label>Phone</label>
        <input type="text" name="phone" class="form-control">
    </div>

    <div class="mb-3">
        <label>Company</label>
        <input type="text" name="company" class="form-control">
    </div>

    <button type="submit" class="btn btn-success w-100">Add Client</button>

    <a href="viewClients.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>

</form>
```

</div>

</body>
</html>
