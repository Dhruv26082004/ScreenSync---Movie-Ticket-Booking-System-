<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
    <script>
        function showAlert(message) {
            alert(message);
            window.location.href = "login.html";
        }
    </script>
</head>
<body>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || password == null) {
            throw new IllegalArgumentException("Email and password are required");
        }
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3308/ecommerce", "root", "");
        
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            session.setAttribute("userEmail", email); 
            response.sendRedirect("index.html"); 
        } else {
%>
            <script>
                showAlert("Invalid email or password");
	        	response.sendRedirect("login.html");
            </script>
<%
        }
        
    } catch (SQLException e) {
        out.println("<p>Database error: " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        out.println("<p>Database driver not found: " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<p>Error closing database connection: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
