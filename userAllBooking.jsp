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
PreparedStatement pstmt= null,pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null;
ResultSet rs= null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
String query=null,query1=null,query2=null,query3=null,query4=null,query5=null,query6=null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="userbookingcss.css">
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
    
    <img src="">

<% 

String userName=null;
int val=1,passID=0,seatNo=0;
String trID=null,stID=null,edID=null,startDt=null,seatType=null;
String startName=null,endName=null,trainName=null,startTime=null,endTime=null;
  try{
	  Class.forName(JDBC_DRIVER);
	  connect=DriverManager.getConnection(DB_URL, USER, PASS);
	  
	  query="select userName from user where status=?";
	  pstmt=connect.prepareStatement(query);

	  pstmt.setInt(1,val);
	  rs=pstmt.executeQuery();
	  while(rs.next()){
		  userName=rs.getString(1);
	  }
	  
	  
	  query1="select passengerID from ticket where userName=?";
	  pstmt1=connect.prepareStatement(query1);

	  pstmt1.setString(1,userName);
	  rs1=pstmt1.executeQuery();	  
	  while(rs1.next()){
		  passID=rs1.getInt(1);	
		  
		  query2="select * from booking where passengerID=?";
		  pstmt2=connect.prepareStatement(query2);		  
		  pstmt2.setInt(1,passID);
		  
		  rs2=pstmt2.executeQuery();
		  while(rs2.next()){
			  trID=rs2.getString(2);
			  stID=rs2.getString(3);
			  edID=rs2.getString(4);
			  startDt=rs2.getString(5);
			  seatNo=rs2.getInt(6);
			  seatType=rs2.getString(7);
		  }
		  
		  query3 ="select stationName from station where stationID=?";
			pstmt3 = connect.prepareStatement(query3);
			pstmt3.setString(1,stID);
			rs3 = pstmt3.executeQuery();
			while (rs3.next()) {
				startName = rs3.getString(1);
			}
			
			
			query4 = "select stationName from station where stationID=?";
			pstmt4 = connect.prepareStatement(query4);
			pstmt4.setString(1,edID);
			rs4= pstmt4.executeQuery();
			while (rs4.next()) {
				endName = rs4.getString(1);
			}
			
			query5="select *from train where trainID=?";
		    pstmt5=connect.prepareStatement(query5);
		    
		    pstmt5.setString(1,trID);
		    rs5=pstmt5.executeQuery();
		    while(rs5.next()){
		    	trainName=rs5.getString(2);
		    	startTime=rs5.getString(3);
		    	endTime=rs5.getString(4);
		    }
		    
		    %>
		    
		    <div class="container">
		    
		    <h2><%= trainName%></h2>
		    <hr style="width:100%;text-align:left;color: black;height:4px;background-color:black;">
		    
		    <div style="justify-content: space-between; display:flex">
		    <h3 style="margin-left:30px"> From : <%= startName%></h3>
		    <h3 style="margin-right:40px"> To: <%= endName%></h3>	
		    </div>
		    
		    <div style="justify-content: space-between;display:flex">
		    <h3 style="margin-left:30px"> Arrival Time: <%= startTime%></h3>	   
		    <h3 style="margin-right:40px">Date: <%= startDt%></h3>	
		    </div>
		    
		    <div style="justify-content: space-between;display:flex">
		    <h3 style="margin-left:30px"> seat No: <%= seatNo%></h3>	
		    <h3 style="margin-right:40px"> Class : <%= seatType%></h3>	
		    </div>
		    	  		    		   		    
		    <% 
		  
		    
		    query6="select passengerFirstName, passengerLastName,passengerAge,passengerGender from passenger where passengerID=?";
		    pstmt6=connect.prepareStatement(query6);		  
			pstmt6.setInt(1,passID);
			  
			rs6=pstmt6.executeQuery();
		    while(rs6.next()){
		    	%>
		    	
		    	<br>
		    	<h2>Passenger Details</h2>
		    	<hr style="width:100%;text-align:left;color: black;height:4px;background-color:black;">
		    	
		    	<br>
		    	<div style="justify-content: space-between;display:flex">
		    	<h3 style="margin-left:30px"> Name: <%=rs6.getString(1) %> &nbsp <%=rs6.getString(2) %></h3>
		    	</div>
		    	
		    	<div style="justify-content: space-between;display:flex">
		    	<h3 style="margin-left:30px"> Age : <%=rs6.getInt(3) %></h3>
		    	<h3 style="margin-right:40px">Gender : <%=rs6.getString(4) %></h3>
		    	</div>	
		    	</div> 		   		    			    	
		    	<%
		    }
		  
	  }//end of while for each passenger
  
  }catch(Exception e) {
	System.out.println(e);
}

%>    

</body>
</html>