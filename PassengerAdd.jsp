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


String trainID=request.getParameter("trainID");
String startStID=session.getAttribute("startStID").toString();
String endStID=session.getAttribute("endStID").toString();
String date=session.getAttribute("startDt").toString();


session.setAttribute("trID",trainID);
session.setAttribute("stID",startStID);
session.setAttribute("edID",endStID);
session.setAttribute("dt",date);

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add passenger</title>
<link rel="stylesheet" href="passenger.css">
</head>
<body>
<div>
<p Style="font-size: 40px ; width:100%; background-color: rgb(0, 69, 91); color:white;padding-left:10px">INDIAN RAILWAYS</p>
<p Style="font-size: 30px ; width:100% ;background-color: rgb(0, 69, 91); color:white;padding-left:10px">Safety | Security | Punctuality</p>
</div>

<div class="main">
    <div class="register">
      <h2>Add Passenger</h2>
      <form id="register" action="addBooking.jsp" method="post" autocomplete="off" onsubmit="return validateForm();">
        <div class="form-group">
          <label for="Firstname">First Name:</label>
          <input type="text" name="firstname" id="Firstname" placeholder="Enter First name" style=" box-shadow: inset 1px 1px 5px rgba(0, 0, 0, 0.3);" required>
        </div>
        <div class="form-group">
          <label for="Lastname">Last Name:</label>
          <input type="text" name="lastname" id="Lastname" placeholder="Enter Last name" style="box-shadow: inset 1px 1px 5px rgba(0, 0, 0, 0.3);" required>
        </div>
        <div class="form-group">
          <label for="age">Age:</label>
          <input type="number" name="age" id="age" placeholder="Enter age" style="box-shadow: inset 1px 1px 5px rgba(0, 0, 0, 0.3);" required>
        </div>
        <div class="form-group">
          <label>Gender:</label>
          <div class="gender-options">
            <input type="radio" name="gender" id="male" value="Male">
            <label for="male">Male</label>
            <input type="radio" name="gender" id="female" value="Female">
            <label for="female">Female</label>
            
          </div>
        </div>
        <div class="form-group">
          <label for="phNo">Phone No:</label>
          <input type="tel" id="phone" class="phone" name="phNo" placeholder="Enter 10-digit phone number" style="box-shadow: inset 1px 1px 5px rgba(0, 0, 0, 0.3);" required>
        </div>
        <div class="form-group">
          <label for="email">Email:</label>
          <input type="email" name="email" id="email" placeholder="Enter email" style="box-shadow: inset 1px 1px 5px rgba(0, 0, 0, 0.3);" required>
          <label>Type of seat</label>
          <select name="seatType">
          <option value="AC">AC</option>
           <option value="NONAC">NON-AC</option>
          </select>
        </div>
        <button  type="submit" id="submit">Save</button>
      </form>
      
    
    </div><!--end register-->
  </div><!--end main-->
  <script>
    function validateForm() {
      var firstname = document.getElementById("Firstname").value;
      var lastname = document.getElementById("Lastname").value;
      var age = document.getElementById("age").value;
      var gender = document.querySelector('input[name="gender"]:checked');
      var phone = document.getElementById("phone").value;
      var email = document.getElementById("email").value;

      if (!firstname || !lastname || !age || !gender || !phone || !email) {
        alert("Please fill in all fields.");
        return false;
      }

      if (phone.length !== 10 || isNaN(phone)) {
        alert("Phone number should be 10 digits without any special characters.");
        return false;
      }

      if (!validateEmail(email)) {
        alert("Please enter a valid email address.");
        return false;
      }

      return true;
    }

    function validateEmail(email) {
      var re = /\S+@\S+\.\S+/;
      return re.test(email);
    }
    
  
  </script>



</body>
</html>