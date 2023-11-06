<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost:3306/jfstproject?autoReconnect=true&useSSL=false";
String USER = "root";
String PASS = "samg2212";

try {
	Class.forName(JDBC_DRIVER);
} catch (ClassNotFoundException e) {
	e.printStackTrace();
}
Connection connect = null;
PreparedStatement pstmt = null;
ResultSet rs = null, rs1 = null,rs2=null;
String query = null, query2 = null;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Displaying user searched Train</title>
<link rel="stylesheet" href="Bootstrap/bootstrap-4.4.1-dist/css/bootstrap.css"></link>
<link rel="stylesheet" href="SearchTrain.css">
</head>
<body>
			<div class="header">
			<h1 align="center">Train Available</h1>
			</div>
			
			<div>
			<img src="Image/trainimg.jpg" style="width: 500px;margin-top:10px;margin-left:5px;">
			</div>
	<%
	String startStation = request.getParameter("startStation");
	String endStation = request.getParameter("endStation");
	String date = request.getParameter("startDate");
	String startStationID = null, endStationID = null;
	int acAvailableSeat = 0, nonacAvailableSeat = 0;
	try {
		connect = DriverManager.getConnection(DB_URL, USER, PASS);
		query = "select * from station where stationName=?";
		pstmt = connect.prepareStatement(query);
		pstmt.setString(1, startStation);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			startStationID = rs.getString(1);
		}
		session.setAttribute("startStID",startStationID);
		query2 = "select * from station where stationName=?";
		pstmt = connect.prepareStatement(query2);
		pstmt.setString(1, endStation);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			endStationID = rs.getString(1);
		}
		session.setAttribute("endStID",endStationID);
		session.setAttribute("startDt",date);

		query = "select trainName, trainStartTime, trainEndTime, endDt, ACseatno, NONACseatno,trainStatus.trainID from train, trainstatus where startStationID=?"
		+ "and endStationID=?" + " and startDt=?" + " and trainstatus.trainID=train.trainID";
		pstmt = connect.prepareStatement(query);
		pstmt.setString(1, startStationID);
		pstmt.setString(2, endStationID);
		pstmt.setString(3, date);
		rs = pstmt.executeQuery();
		rs2=rs;
		if (rs==null) {%>
		<h1 style="margin-left: 520px; margin-top:-30% ; width:60% ">No Train Available</h1>
		<% }
		else{
			while (rs.next()) {
				acAvailableSeat = 30 - rs.getInt(5);
				nonacAvailableSeat = 60 - rs.getInt(6);
			%>
	<div style="margin-left: 520px; margin-top:-30% ; width:60% ">
		<div class="trainhearder" style="margin-top:10px">
			<h2 style="margin-left: 5px;"><%=rs.getString(1)%></h2>
		</div>
		<div class="info2" style="flex-direction: row;font-weight: bold;">
			<div class="details" style="justify-content: flex-start;padding-left: 5px;"><%=rs.getString(2)%><p style="font-weight: bold;"> &nbsp | &nbsp</p><%=startStation%><p style="font-weight: bold;"> &nbsp |&nbsp </p><%=date%>
			</div>
			<div class="details" style="justify-content: flex-end;padding-right: 10px;"><%=rs.getString(3)%><p style="font-weight: bold;">&nbsp | &nbsp</p><%=endStation%><p style="font-weight: bold;">&nbsp | &nbsp</p><%=rs.getString(4)%>
			</div>
		</div>
		<div class = "info" style="font-weight: bold;">
		<div class="details" style="justify-content: flex-start; padding-left: 5px;">
			<p>AC Seats Available : &nbsp</p><%=acAvailableSeat%>
		</div>
		<div class="details" style="justify-content: flex-end ;padding-right: 10px;">
			<p>NON-AC Seats Available : &nbsp</p><%=nonacAvailableSeat%>
		</div>
		</div>
	</div>
	<div> 
        <a href="PassengerAdd.jsp?trainID=<%=rs.getString(7)%>"><button type="button" class="btn btn-outline-info">Book Ticket</button></a> 
    </div>

	<%  } }

	}catch (Exception ex) {
	out.print(ex);
	}
	%>
</body>
</html>