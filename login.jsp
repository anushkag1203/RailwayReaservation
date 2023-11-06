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
PreparedStatement  pstmt= null,pstmt1=null;
Statement st=null;
ResultSet rs= null;
String query=null,query1=null;

String user=request.getParameter("username");
String pass1=request.getParameter("password");

String password=null;



try{
	
	Class.forName(JDBC_DRIVER);
	connect=DriverManager.getConnection(DB_URL, USER, PASS);
	query="select userPassword from user where userName=?";
	pstmt=connect.prepareStatement(query);
	
	pstmt.setString(1,user);
	
	rs=pstmt.executeQuery();
	while(rs.next()){
		password=rs.getString(1);
	}

}
catch(Exception e) {
	System.out.println(e);
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Check page</title>
<script>
function myFunction() {
 alert("Wrong password");
}
</script>
</head>
<body>

<%
try{
	int val=1;
	
	
	if(password.equals(pass1)){
	query1="update user set status=?"+" where userName=?";
	pstmt1=connect.prepareStatement(query1);
	
	pstmt1.setInt(1,val);
	pstmt1.setString(2,user);
	
	

    int i=pstmt1.executeUpdate();
	
	if(i>0) {
		System.out.println("You are Successful!!!");
	}
	else {
		System.out.println("Unsuccessful!!!");
	}
	
	 response.sendRedirect("userHome.html"); 
	}
	
	
	else{
		%>
		<script type="text/javascript" language="JavaScript">
		myFunction();
      </script>
		
		<%
		 response.sendRedirect("RailwayLoginPage.html"); 
	}
	
}catch(Exception e) {
	System.out.println(e);
}



%>



</body>
</html>