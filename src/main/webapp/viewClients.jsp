<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, com.crm.DBConnection" %>

<!DOCTYPE html>

<html>
<head>
    <title>Clients List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

```
<style>
    body {
        background-color: #f5f7fa;
    }

    .card-box {
        background: white;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
</style>
```

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

<div class="container mt-5">

```
<div class="card-box">

    <!-- Header -->
    <div class="header">
        <h3>Clients</h3>

        <form method="get" action="viewClients.jsp" class="d-flex">
            <input type="text" name="search" class="form-control me-2"
                   placeholder="Search..."
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <button class="btn btn-dark btn-sm">Search</button>
        </form>
    </div>

    <!-- Success Message -->
    <%
    String msg = request.getParameter("msg");
    if("success".equals(msg)) {
    %>
        <div class="alert alert-success">Client Added Successfully ✅</div>
    <%
    }
    %>

    <!-- Add Button -->
    <a href="addClient.jsp" class="btn btn-success btn-sm mb-3">+ Add Client</a>

    <!-- Table -->
    <table class="table table-hover">
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Company</th>
            <th>Action</th>
        </tr>

        <%
        String search = request.getParameter("search");

        Connection con = DBConnection.getConnection();
        PreparedStatement ps;

        if (search != null && !search.trim().isEmpty()) {
            ps = con.prepareStatement(
                "SELECT * FROM clients WHERE name LIKE ? OR email LIKE ?"
            );
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
        } else {
            ps = con.prepareStatement("SELECT * FROM clients");
        }

        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
        %>

        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("company") %></td>
            <td>
                <a href="editClient.jsp?id=<%= rs.getInt("id") %>" 
                   class="btn btn-primary btn-sm">Edit</a>

                <a href="DeleteClientServlet?id=<%= rs.getInt("id") %>" 
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>

        <%
        }
        %>

    </table>

</div>
```

</div>

</body>
</html>
