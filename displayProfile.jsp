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
PreparedStatement pstmt= null;
ResultSet rs= null;
String query=null;
int val=1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="displayprofile.css">
</head>
<body>
	<div id="header">
        <h1> &nbsp; Train Reservation System</h1>
    </div>
    <div id="Menubar">
        <div class="options"><a href="userHome.html">Home</a></div>
        <div class="options"><a href="TrainSearch.jsp">Search Train</a></div>
        <div class="options"><a href="userAllBooking.jsp" >Booking</a></div>
        <div class="options"><a href="displayProfile.jsp">My Profile</a></div>

        <div class="options"><a href="userContactus.html">Contact us</a></div>
	</div>
<%
try {
	connect=DriverManager.getConnection(DB_URL,USER,PASS);
    query="select *from user where status=?";
    pstmt=connect.prepareStatement(query);
    
    pstmt.setInt(1,val);
	rs=pstmt.executeQuery();	
	while(rs.next()){
%>
    <div class="wrapper">
    	<div class="left">
    		<img src="Image/myprofile.png" class="img">
    		<h3 style="text-align: center"><%=rs.getString(1) %></h3>
    	</div>
    	
    	<div class="right">
    		<h3 style="margin-bottom: 20px;"><%=rs.getString(2) %> <%=rs.getString(3) %></h3>
    	   	
    	   	<div class="info">
    	   	<div class="info_data"> 		
    				<div class="data">
    					<h4> Gender </h4>
    					<p><%=rs.getString(4) %><p>
    				</div>
    				
    				<div class="data">
    					<h4> DOB </h4>
     					<p><%=rs.getString(5) %><p>
    				</div>
    		</div>
    	   	</div>
    		
    		<div class="Personal_data">
    			<div class="info_data"> 
    				<div class="data">
    					<h4> Email </h4>
    					<p><%=rs.getString(6) %><p>
    				</div>
    				
    				<div class="data">
    					<h4>Phone No</h4>
     					<p><%=rs.getString(7) %><p>
    				</div>
    			</div>
    		</div>
    		
    	</div>
    </div>
	
<% 
}connect.close();}
catch(Exception ex){out.print(ex);}
%>
<form action="logout" method="post">
<button>Log out</button>
</form>
</body>
</html>