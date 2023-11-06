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
ResultSet rs1= null;
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="RailwaySearchTrain.css">
    <title>SearchTrain</title>
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
    <br>
    <div class="container">
        <img src="Image/seachtrainimage (2).jpg" class="img">
        <div class="centeredright">
            <button class="pnrbutton" type="button">PNR Status</button>
            <div>
                <img src="Image/img1.png" class="logo" style="margin-right: 500px;">
                <p
                    style="color: black; margin: 10px; font-size: 25px; font-weight: bold; text-align: left; margin-left: 150px; margin-top: -15%;">Book Ticket</p>

                <img src="Image/g20.png" class="logo" style="margin-left: 300px; margin-top: -10%;">
            </div>

            <div>
                <form action="TrainSearchUser.jsp" method="post" autocomplete="off">
                    <p style="color: black; font-size: 25px; text-align: left; padding-top: 5px; padding-left: 15px;">Start Station</p>
                    <div class="custom-dropdown">
                        <input type="search" name="startStation" style="margin-left: -50%; height: 25px;" class="custom-dropdown-select" placeholder="Select Station" required>
                        <div class="custom-dropdown-list">
                            <!-- here the options are displayed in drop down menu  -->
                            <% 
                               try{
		                    	connect=DriverManager.getConnection(DB_URL,USER,PASS);
		                     	pstmt=connect.createStatement();
			                    String query="select stationName from station";
     		                    rs=pstmt.executeQuery(query);
		                    	while(rs.next()){
		                    %>
		                 <div class="custom-dropdown-list-item"><%=rs.getString(1)%></div>
		
		                 <%
			                }			
		                  }
		                 catch(Exception ex){out.print(ex);}
				
		                 %>
                                                   
                        </div>
                    </div>
                    <p style="color: black; font-size: 25px; text-align: left; padding-top: 20px; padding-left: 15px;">End Station</p>
                    <div class="custom-dropdown2">
                        <input type="search" name="endStation" style="margin-left: -50%; height: 25px;" class="custom-dropdown-select2" placeholder="Select Station" required>
                        <div class="custom-dropdown-list2">
                           <% 
                               try{
		                    	connect=DriverManager.getConnection(DB_URL,USER,PASS);
		                     	pstmt=connect.createStatement();
			                    String query1="select stationName from station";
     		                    rs1=pstmt.executeQuery(query1);
		                    	while(rs1.next()){
		                    %>
		                 <div class="custom-dropdown-list-item2"><%=rs1.getString(1)%></div>
		
		                 <%
			                }			
		                  }
		                 catch(Exception ex){out.print(ex);}
				
		                 %>
                        </div>
                    </div>
                    <p style="color: black; font-size: 25px; text-align: left; padding-top: 20px; padding-left: 15px;">Date</p>
                    <div>
                        <input type="date" name="startDate" style="margin-left: -68%;" required>
                    </div>
                    
                    <a href="TrainSearchUser.jsp"><button type="submit" style="height: 40px;background-color: rgb(11, 71, 71); width: 55px; color: #fff; border-radius: 5px;">Search</button></a>
                    <br>
                    <br>
                    <p style="color: brown;">
                        Tejas Express Train 82501/82502 is cancelled for journey date 12.11.2023 (Sunday) on the occassion of Diwali. Train will run on journey date 14.11.2023 (Tuesday).
                    </p>
                </form>
            </div>
        </div>
    </div>

    <script>
        const selectInput = document.querySelector(".custom-dropdown-select");
        const dropdownList = document.querySelector(".custom-dropdown-list");
        const listItems = document.querySelectorAll(".custom-dropdown-list-item");

        // Show the dropdown when the input is clicked
        selectInput.addEventListener("click", function () {
            dropdownList.style.display = "block";
        });

        // Handle item selection
        listItems.forEach(function (item) {
            item.addEventListener("click", function () {
                selectInput.value = item.textContent;
                dropdownList.style.display = "none";
            });
        });

        // Filter items based on input
        selectInput.addEventListener("input", function () {
            const filter = selectInput.value.toLowerCase();

            listItems.forEach(function (item) {
                const text = item.textContent.toLowerCase();
                if (text.includes(filter)) {
                    item.style.display = "block";
                } else {
                    item.style.display = "none";
                }
            });

            dropdownList.style.display = "block";
        });

        // Close the dropdown when clicking outside of it
        window.addEventListener("click", function (e) {
            if (!selectInput.contains(e.target)) {
                dropdownList.style.display = "none";
            }
        });
    </script>
     <script>
        const selectInput1 = document.querySelector(".custom-dropdown-select2");
        const dropdownList1 = document.querySelector(".custom-dropdown-list2");
        const listItems1 = document.querySelectorAll(".custom-dropdown-list-item2");

        // Show the dropdown when the input is clicked
        selectInput1.addEventListener("click", function () {
            dropdownList1.style.display = "block";
        });

        // Handle item selection
        listItems1.forEach(function (item) {
            item.addEventListener("click", function () {
                selectInput1.value = item.textContent;
                dropdownList1.style.display = "none";
            });
        });

        // Filter items based on input
        selectInput1.addEventListener("input", function () {
            const filter = selectInput1.value.toLowerCase();

            listItems1.forEach(function (item) {
                const text = item.textContent.toLowerCase();
                if (text.includes(filter)) {
                    item.style.display = "block";
                } else {
                    item.style.display = "none";
                }
            });

            dropdownList1.style.display = "block";
        });

        // Close the dropdown when clicking outside of it
        window.addEventListener("click", function (e) {
            if (!selectInput1.contains(e.target)) {
                dropdownList1.style.display = "none";
            }
        });
    </script>
    
</body>

</html>