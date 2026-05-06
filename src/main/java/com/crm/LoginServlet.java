package com.crm;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        System.out.println("LoginServlet called");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Login Success");

                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);

                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
            } else {
                System.out.println("Login Failed");
                response.getWriter().println("Invalid Login ❌");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}