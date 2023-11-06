<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
PreparedStatement  pstmt= null,pstmt2=null,pstmt3=null,pstmt4=null,pstmt5=null,pstmt6=null;
Statement st=null,st1=null;
ResultSet rs= null;
ResultSet rs2= null,rs3=null,rs4=null,rs5=null;
String query=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null;


	
String tr=session.getAttribute("trID").toString();
String std=session.getAttribute("stID").toString();
String ed=session.getAttribute("edID").toString();
String dte=session.getAttribute("dt").toString();

int passID=0,seatNo=0;
int actype=0,nonactype=0;
String firstName=request.getParameter("firstname");
String lastName=request.getParameter("lastname");
int age=Integer.parseInt(request.getParameter("age"));
String gender=request.getParameter("gender");	
Long phoneNo=Long.parseLong(request.getParameter("phNo"));	
String email=request.getParameter("email");
String seatTp=request.getParameter("seatType");
int userWhoaddpass=0,val=1;;
String userName=null;


try{
	Class.forName(JDBC_DRIVER);
	connect=DriverManager.getConnection(DB_URL, USER, PASS);
	
	//get the passenger ID
	st=connect.createStatement();
	query="select count(*) from passenger";
	rs=st.executeQuery(query);	
	while(rs.next()) {
		passID=Integer.parseInt(rs.getString(1));
		passID=passID+1;
	}
	
	
	//adding the passenger
	query="insert into passenger(passengerID,passengerFirstName,passengerLastName,passengerAge,passengerGender,passengerPhNo,passengerEmail) values(?,?,?,?,?,?,?)";
	pstmt=connect.prepareStatement(query);
	pstmt.setInt(1,passID);
	pstmt.setString(2,firstName);
	pstmt.setString(3,lastName);
	pstmt.setInt(4,age);
	pstmt.setString(5,gender);
	pstmt.setLong(6,phoneNo);
	pstmt.setString(7,email);
	
	
	//get the seat nos
	query2= "select ACseatno, NONACseatno from trainStatus where trainID=?"+ " and startStationID=?"
			+ "and endStationID=?" + " and startDt=?";
	pstmt2 = connect.prepareStatement(query2);
	pstmt2.setString(1,tr);
	pstmt2.setString(2,std);
	pstmt2.setString(3,ed);
	pstmt2.setString(4,dte);
	rs2 = pstmt2.executeQuery();
	
	while(rs2.next()) {
		actype=rs2.getInt(1);
		nonactype=rs2.getInt(2);
	}
	if(seatTp.equals("AC")){
		seatNo=actype;
	}
	else{
		seatNo=nonactype;
	}
	seatNo=seatNo+1;
	
	
	//Getting the user who add the passenger
	st1=connect.createStatement();
	query3="select number from passengerNoStore";
	rs3=st1.executeQuery(query3);	
	while(rs3.next()) {
		userWhoaddpass=rs3.getInt(1);
	}
	
int i=pstmt.executeUpdate();
	
	if(i>0) {
		System.out.println("You are Successful!!!");
	}
	else {
		System.out.println("Unsuccessful!!!");
	}
	
	
}catch(Exception e) {
	System.out.println(e);
}

//END OF ! TRY
try{
	
Class.forName(JDBC_DRIVER);
connect=DriverManager.getConnection(DB_URL, USER, PASS);
query4="insert into booking(passengerID,trainID,startStationID,endStationID,startDt,seatNo,seatType,userNo) values(?,?,?,?,?,?,?,?)";
pstmt3=connect.prepareStatement(query4);

pstmt3.setInt(1,passID);
pstmt3.setString(2,tr);
pstmt3.setString(3,std);
pstmt3.setString(4,ed);
pstmt3.setString(5,dte);
pstmt3.setInt(6,seatNo);
pstmt3.setString(7,seatTp);
pstmt3.setInt(8,userWhoaddpass);


int i=pstmt3.executeUpdate();
	
	if(i>0) {
		System.out.println("You are Successful!!!");
	}
	else {
		System.out.println("Unsuccessful!!!");
	}
	
}catch(Exception e) {
	System.out.println(e);
}


//END OD ANOTHER TRY
try{
	
Class.forName(JDBC_DRIVER);
connect=DriverManager.getConnection(DB_URL, USER, PASS);
if(seatTp.equals("AC")){
	query5="update trainStatus set ACseatno=?"+" where trainID=?"+" and startDt=?";	
}
else{
	query5="update trainStatus set NONACseatno=?"+" where trainID=?"+" and startDt=?";	
}
pstmt4=connect.prepareStatement(query5);

pstmt4.setInt(1,seatNo);
pstmt4.setString(2,tr);
pstmt4.setString(3,dte);


int i=pstmt4.executeUpdate();
	
	if(i>0) {
		System.out.println("You are Successful!!!");
	}
	else {
		System.out.println("Unsuccessful!!!");
	}
	
}catch(Exception e) {
	System.out.println(e);
}


//END OF ANOTHER TRYYYY
try{
	
Class.forName(JDBC_DRIVER);
connect=DriverManager.getConnection(DB_URL, USER, PASS);
query6="select userName from user where status=?";
pstmt5=connect.prepareStatement(query6);
pstmt5.setInt(1,val);
rs5=pstmt5.executeQuery();
while(rs5.next()){
	userName=rs5.getString(1);
}

query7="insert into ticket(userName,passengerID,startDt) values(?,?,?)";
pstmt6=connect.prepareStatement(query7);

pstmt6.setString(1,userName);
pstmt6.setInt(2,passID);
pstmt6.setString(3,dte);



int i=pstmt6.executeUpdate();
	
	if(i>0) {
		System.out.println("You are Successful!!!");
	}
	else {
		System.out.println("Unsuccessful!!!");
	}
	
}catch(Exception e) {
	System.out.println(e);
}

   //add info to booking		
 response.sendRedirect("displayTicket.jsp"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=userWhoaddpass %>

</body>
</html>