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
PreparedStatement pstmt= null,pstmt1=null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null,pstmt7=null;
ResultSet rs= null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
String query=null,query1=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null;


String stName=null,endstName=null,trName;
int val=1;
int userdata=4;

try{
	
Class.forName(JDBC_DRIVER);
connect=DriverManager.getConnection(DB_URL, USER, PASS);
query="select number from passengerNoStore where no=?";
pstmt=connect.prepareStatement(query);
pstmt.setInt(1,val);
rs=pstmt.executeQuery();	
while(rs.next()) {
	userdata=rs.getInt(1);
}


int val1=userdata+1;
query1="update passengerNoStore set number=?";
pstmt1=connect.prepareStatement(query1);

pstmt1.setInt(1,val1);


int i=pstmt1.executeUpdate();
	
	if(i>0) {
		System.out.println("You are Successful!!!");
	}
	else {
		System.out.println("Unsuccessful!!!");
	}
	
}catch(Exception e) {
	System.out.println(e);
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
   String trID=null,stID=null,edID=null,startDt=null;
     String trainName=null,startName=null,endName=null,startTime=null,endTime=null;
     int pay=0;
	  try {
		  Class.forName(JDBC_DRIVER);
		  connect=DriverManager.getConnection(DB_URL, USER, PASS);
		  
		  query2="select trainID,startStationID,endStationID,startDt from booking where userNo=?";
		  pstmt2=connect.prepareStatement(query2);		  
		  pstmt2.setInt(1,userdata);
		  
		  rs1=pstmt2.executeQuery();
		  while(rs1.next()){
			  trID=rs1.getString(1);
			  stID=rs1.getString(2);
			  edID=rs1.getString(3);
			  startDt=rs1.getString(4);
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
		    
		    
		    query7="select payment from trainStatus where trainID=?" + " and startStationID=?" + " and endStationID=?"+" and startDt=?";
		    pstmt7=connect.prepareStatement(query7);
		    
		    pstmt7.setString(1,trID);
		    pstmt7.setString(2,stID);
		    pstmt7.setString(3,edID);
		    pstmt7.setString(4,startDt);
		    
		    rs7=pstmt7.executeQuery();
		    while(rs7.next()){
		    	pay=rs7.getInt(1);
		    }
		    
		    
	   
	  
   }
   catch(Exception e) {
	System.out.println(e);
    }

 %>
 <h2 style="margin-left: 600px; text-decoration-line: underline">Electronic Reservation Slip</h2>
 <img src="Image/img1.png">
 <img src="Image/75th_independence.jpg">
 
 <img src="Image/g20.png" style="margin-left:500px">
 <img src="Image/train_logo.jpg" style="height: 200px; width:280px; margin-left:1220px; margin-top:-21%">
 
 <div style=" display: flex; justify-content: space-between;">
 <h3 style="margin-left:200px; font-size: 30px;"> Booked From </h3>
 <img src="Image/right-arrow.png" style="width: 200px;margin-top:-3%;margin-left:-3%;">
 <h3 style="margin-right:300px;margin-top: 3%; font-size: 30px"> To </h3>
 </div>
 <div style=" display: flex; justify-content: space-between;">
<h4 style="margin-left:200px; font-size: 25px;margin-top:-5%"><%=startName %></h4>
<h4 style="margin-right:300px;font-size: 25px;margin-top:-4%"><%=endName %></h4>
 </div>
 
 <div style=" display: flex; justify-content: space-between;">
<h4 style="margin-left:200px; font-size: 25px;margin-top:-2.5%"><%=startTime %></h4>
<h4 style="margin-right:300px;font-size: 25px;margin-top:-1.5%"><%=endTime %></h4>
 </div>
<h5 style="margin-left:100px; font-size: 25px;margin-top:-2.5%"> Check Timings Before Boarding</h5>
<hr style="width:100%;text-align:left;margin-top:-2%">

<%


try {
	  Class.forName(JDBC_DRIVER);
	  connect=DriverManager.getConnection(DB_URL, USER, PASS);
	  
	  query6="select booking.passengerID,passengerFirstName,passengerLastName,passengerAge,passengerGender,seatNo,seatType from"+
	  " passenger,booking where booking.passengerID=passenger.passengerID and userNo=?";
	  pstmt6=connect.prepareStatement(query6);
	  
	  pstmt6.setInt(1,userdata);
	  rs6=pstmt6.executeQuery();
	  while(rs6.next()){
	%>
	
	<div style=" display: flex; justify-content: space-between;">
	<h3 style="margin-left:200px;font-size: 25px;">PNR</h3>
	<h3 style="margin-right:400px; font-size: 25px">Train No./ Name</h3>
	<h3 style="margin-right:300px; font-size: 25px">Class</h3>
	</div>
	
	<div style="display: flex; justify-content: space-between;">
	<h4 style="margin-left:200px; font-size: 20px;"><%=rs6.getInt(1)%></h4>
	<h3 style="margin-right:400px; font-size: 20px"><%=trainName %></h3>
	<h4 style="margin-right:300px; font-size: 20px"><%=rs6.getString(7) %></h4>
	</div>
	<br>
	<hr style="width:100%;text-align:left;margin-top:-2%">
	<h3 style="margin-left: 600px; text-decoration-line: underline">Passenger Details</h3>
	<div style="display: flex; justify-content: space-between;">
	<h3 style="margin-left:50px; font-size: 20px;">Name</h3>
	<h3 style="margin-left:100px; font-size: 20px">Age</h3>
	<h3 style="margin-left:150px; font-size: 20px">Gender</h3>
	<h3 style="margin-left:200px; font-size: 20px;">Seat No.</h3>
	<h3 style="margin-left:250px; font-size: 20px">Seat Type</h3>
	<h3 style="margin-left:300px; font-size: 20px">Payment</h3>
	</div >
	<div style="display: flex; justify-content: flex-start;">
	<h4 style="margin-left:50px;font-size: 15px;"><%=rs6.getString(2) %> &nbsp <%=rs6.getString(3) %></h4>
	<h4 style="margin-left:80px;font-size: 15px;"><%=rs6.getInt(4) %></h4>
	<h4 style="margin-left:130px;font-size: 15px;"><%=rs6.getString(5) %></h4>
	<h4 style="margin-left:190px; font-size: 15px;"><%=rs6.getInt(6) %></h4>
	<h4 style="margin-left:244px;font-size: 15px;"><%=rs6.getString(7) %></h4>  
	<h4 style="margin-left:310px;font-size: 15px;"><%=pay %></h4>
	</div>	  	  
	
	<div>
	<a href="userHome.html"><button style="background-color:white;border:3px solid black; height:20px; width:60px;margin-left:600px ;margin-top:20px">Okay</button></a>
	</div>
    <% 
	  }
	 
}
catch(Exception e) {
System.out.println(e);
}

    


%>

</body>
</html>