package com.crm;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.crm.dao.TaskDAO;
import com.crm.model.Task;

@WebServlet("/AddTaskServlet")
public class AddTaskServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int clientId = Integer.parseInt(request.getParameter("client_id"));
        String title = request.getParameter("title");
        String status = request.getParameter("status");
        String dueDate = request.getParameter("due_date");

        Task t = new Task();
        t.setClientId(clientId);
        t.setTitle(title);
        t.setStatus(status);
        t.setDueDate(dueDate);

        TaskDAO dao = new TaskDAO();
        dao.addTask(t);

        response.sendRedirect("dashboard.jsp");
    }
}