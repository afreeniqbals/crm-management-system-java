<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.crm.dao.ClientDAO, com.crm.model.Client" %>
<%@ page import="com.crm.dao.TaskDAO, com.crm.model.Task" %>

<%
String user = (String) session.getAttribute("userEmail");
if(user == null){
response.sendRedirect("login.jsp");
return;
}

ClientDAO dao = new ClientDAO();
TaskDAO taskDao = new TaskDAO();
String keyword = request.getParameter("keyword");
String status = request.getParameter("status");

if(keyword == null){
    keyword = "";
}

if(status == null){
    status = "All";
}

List<Task> tasks = taskDao.searchTasks(keyword, status);
int totalClients = dao.getTotalClients();
List<Client> recentClients = dao.getRecentClients();
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>CRM Dashboard</title>

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Chart -->

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Font -->

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #f1f5f9;
    margin: 0;
}

/* Sidebar */
.sidebar {
    width: 230px;
    height: 100vh;
    background: linear-gradient(180deg, #111827, #1f2937);
    position: fixed;
    color: white;
}

.sidebar h2 {
    text-align: center;
    padding: 20px;
}

.sidebar a {
    display: block;
    padding: 14px;
    color: #d1d5db;
    text-decoration: none;
    transition: 0.3s;
}

.sidebar a:hover,
.sidebar a.active {
    background: #374151;
    color: white;
    padding-left: 20px;
    border-left: 4px solid #3b82f6;
}

.sidebar i {
    margin-right: 10px;
}

/* Main */
.main {
    margin-left: 230px;
    padding: 25px;
}

/* Top bar */
.top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

/* Cards */
.card-box {
    border-radius: 12px;
    padding: 25px;
    color: white;
    box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    transition: 0.3s;
}

.card-box:hover {
    transform: translateY(-5px);
}

.blue { background: #3b82f6; }
.green { background: #10b981; }
.orange { background: #f59e0b; }

/* Table */
.table-box {
    background: white;
    padding: 20px;
    border-radius: 10px;
    margin-top: 30px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
}

.table-hover tbody tr:hover {
    background-color: #f9fafb;
}

canvas {
    max-height: 300px;
}

.table-box {
    transition: 0.3s;
}

.table-box:hover {
    transform: translateY(-2px);
}
</style>

</head>

<body>

<!-- Sidebar -->

<div class="sidebar">
    <h2>CRM</h2>

```
<a href="dashboard.jsp" class="active">
    <i class="fas fa-home"></i> Dashboard
</a>

<a href="viewClients.jsp">
    <i class="fas fa-users"></i> Clients
</a>

<a href="addClient.jsp">
    <i class="fas fa-user-plus"></i> Add Client
</a>

<a href="addTask.jsp">
    <i class="fas fa-tasks"></i> Tasks
</a>

<a href="LogoutServlet">
    <i class="fas fa-sign-out-alt"></i> Logout
</a>
```

</div>

<!-- Main -->

<div class="main">

```
<div class="top-bar">
    <h3>Dashboard</h3>
    <div>Welcome, <%= user %></div>
</div>

<!-- Cards -->
<div class="row">
    <div class="col-md-4">
        <div class="card-box blue">
            <h5>Total Clients</h5>
            <h2><%= totalClients %></h2>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card-box green">
            <h5>Active Users</h5>
            <h2>1</h2>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card-box orange">
            <h5>Tasks</h5>
            <h2><%= tasks.size() %></h2>
        </div>
    </div>
</div>

<!-- Chart -->
<div class="table-box mt-4">
    <h5>Client Analytics</h5>
    <canvas id="clientChart"></canvas>
</div>

<!-- Recent Clients -->
<div class="table-box">
    <h5>Recent Clients</h5>

    <table class="table table-hover">
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Company</th>
        </tr>

        <%
        for(Client c : recentClients){
        %>
        <tr>
            <td><%= c.getName() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getCompany() %></td>
        </tr>
        <%
        }
        %>
        

    </table>
</div>

<form method="get" class="row mb-3">

    <div class="col-md-5">
        <input type="text"
               name="keyword"
               class="form-control"
               placeholder="Search task..."
               value="<%= keyword %>">
    </div>

    <div class="col-md-3">

        <select name="status" class="form-select">

            <option <%= status.equals("All") ? "selected" : "" %>>
                All
            </option>

            <option <%= status.equals("Pending") ? "selected" : "" %>>
                Pending
            </option>

            <option <%= status.equals("Completed") ? "selected" : "" %>>
                Completed
            </option>

        </select>

    </div>

    <div class="col-md-2">
        <button class="btn btn-primary w-100">
            Search
        </button>
    </div>

</form>
<!-- task -->
<div class="table-box">
    <h5>Recent Tasks</h5>

    <table class="table table-hover">

        <tr>
            <th>Client ID</th>
            <th>Title</th>
            <th>Status</th>
            <th>Due Date</th>
        </tr>

        <%
        for(Task t : tasks){
        %>

        <tr>
<td><%= t.getClientName() %></td>
            <td><%= t.getTitle() %></td>
            <td>

<% if(t.getStatus().equals("Completed")) { %>

    <span class="badge bg-success">Completed</span>

<% } else { %>

    <span class="badge bg-warning text-dark">Pending</span>

    <br><br>

    <a href="UpdateTaskStatusServlet?id=<%= t.getId() %>"
       class="btn btn-sm btn-success">

       Mark Complete

    </a>

<% } %>

</td>
            <td><%= t.getDueDate() %></td>
        </tr>

        <%
        }
        %>

    </table>
</div>
```

</div>

<!-- Chart Script -->

<script>
new Chart(document.getElementById('clientChart'), {
    type: 'bar',
    data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [{
            label: 'Clients Growth',
            data: [5, 12, 9, 18, 25, 30],
            backgroundColor: ['#3b82f6','#10b981','#f59e0b','#ef4444','#8b5cf6','#06b6d4'],
            borderRadius: 6
        }]
    },
    options: {
        scales: {
            y: { beginAtZero: true }
        }
    }
});
</script>

</body>
</html>
