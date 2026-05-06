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
<title>Add Task</title>

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font -->

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

body{
    font-family:'Poppins',sans-serif;
    background:#f1f5f9;
}

/* Form Box */
.form-box{
    width:500px;
    margin:60px auto;
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 6px 15px rgba(0,0,0,0.1);
}

h2{
    margin-bottom:20px;
}

</style>

</head>

<body>

<div class="container">

```
<a href="dashboard.jsp" class="btn btn-dark mt-4">
    ← Dashboard
</a>

<div class="form-box">

    <h2>Add Task</h2>

    <form action="AddTaskServlet" method="post">

        <div class="mb-3">
            <label>Client ID</label>
            <input type="number"
                   name="client_id"
                   class="form-control"
                   required>
        </div>

        <div class="mb-3">
            <label>Task Title</label>
            <input type="text"
                   name="title"
                   class="form-control"
                   required>
        </div>

        <div class="mb-3">
            <label>Status</label>

            <select name="status" class="form-select">

                <option>Pending</option>
                <option>Completed</option>

            </select>
        </div>

        <div class="mb-3">
            <label>Due Date</label>

            <input type="date"
                   name="due_date"
                   class="form-control">
        </div>

        <button type="submit"
                class="btn btn-primary w-100">

            Add Task

        </button>

    </form>

</div>
```

</div>

</body>
</html>
