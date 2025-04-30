<%@page import="java.sql.*" %>
<%@page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
</head>
<body>

<%
if(request.getMethod().equalsIgnoreCase("post")) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String phone = request.getParameter("phone");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/ecommerce", "root", "");

        // Using PreparedStatement to prevent SQL injection
        String sql = "INSERT INTO user (name, email, password, phone) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        pstmt.setString(4, phone);
        
        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            out.println("<script>alert('Registration Successful! Redirecting to Login...');</script>");
            response.sendRedirect("login.html"); // Redirect to login page
        } else {
            out.println("<p style='color:red;'>Registration failed. Try again.</p>");
        }

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
}
%>

</body>
</html>
