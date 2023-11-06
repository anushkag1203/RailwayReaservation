<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

    
<%
String JDBC_DRIVER="com.mysql.cj.jdbc.Driver";
String DB_URL="jdbc:mysql://127.0.01:3306/jfstproject?autoReconnect=true&useSSL=false";
String USER="root";
String PASS="samg2212";
try {
Class.forName(JDBC_DRIVER);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
Connection connect = null;
Statement pstmt= null;
ResultSet rs= null;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display Train Details</title>
<link rel="stylesheet" href="css/bootstrap.css"></link>
<link rel="stylesheet" href="Train.css">
</head>
<body>

<h1 align="center">Train Details</h1>

<table align="center">
	<tr>
	<th>Train Name</th>
  	<th>Start Time</th>
  	<th>End Time</th> 
	</tr>

<%
 try {
		connect=DriverManager.getConnection(DB_URL,USER,PASS);
		pstmt=connect.createStatement();
		String query="select *from train";
		rs=pstmt.executeQuery(query);	
		while(rs.next()){
 %>
		<tr>
		<td><%=rs.getString(2)%></td>
		<td><%=rs.getString(3)%></td>
		<td><%=rs.getString(4)%></td>
					-
		</tr>	
		
 <%
 }connect.close();}
 catch(Exception ex){out.print(ex);}
 %>
</table>
<a href="Home.html"><button type="button" id="submit" class="btn btn-success">Back</button></a>
</body>
</html>