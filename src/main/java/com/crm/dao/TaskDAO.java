package com.crm.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.crm.model.Task;
import com.crm.DBConnection;

public class TaskDAO {

    public boolean addTask(Task t) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO tasks(client_id, title, status, due_date) VALUES (?, ?, ?, ?)"
            );

            ps.setInt(1, t.getClientId());
            ps.setString(2, t.getTitle());
            ps.setString(3, t.getStatus());
            ps.setString(4, t.getDueDate());

            status = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public List<Task> getTasksByClient(int clientId) {
        List<Task> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM tasks WHERE client_id=?"
            );

            ps.setInt(1, clientId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                Task t = new Task();
                t.setId(rs.getInt("id"));
                t.setTitle(rs.getString("title"));
                t.setStatus(rs.getString("status"));
                t.setDueDate(rs.getString("due_date"));

                list.add(t);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Task> getAllTasks() {
        List<Task> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM tasks");

            while(rs.next()) {

                Task t = new Task();

                t.setId(rs.getInt("id"));
                t.setClientId(rs.getInt("client_id"));
                t.setTitle(rs.getString("title"));
                t.setStatus(rs.getString("status"));
                t.setDueDate(rs.getString("due_date"));

                list.add(t);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean updateTaskStatus(int id, String status) {

        boolean result = false;

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE tasks SET status=? WHERE id=?"
            );

            ps.setString(1, status);
            ps.setInt(2, id);

            result = ps.executeUpdate() > 0;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public List<Task> searchTasks(String keyword, String status) {

        List<Task> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "SELECT tasks.*, clients.name " +
            "FROM tasks " +
            "JOIN clients ON tasks.client_id = clients.id " +
            "WHERE title LIKE ?";

            if(status != null && !status.equals("All")) {
                sql += " AND status=?";
            }

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");

            if(status != null && !status.equals("All")) {
                ps.setString(2, status);
            }

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Task t = new Task();

                t.setId(rs.getInt("id"));
                t.setClientId(rs.getInt("client_id"));
                t.setClientName(rs.getString("name"));
                t.setTitle(rs.getString("title"));
                t.setStatus(rs.getString("status"));
                t.setDueDate(rs.getString("due_date"));

                list.add(t);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}