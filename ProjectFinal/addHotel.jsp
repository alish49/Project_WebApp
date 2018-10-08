<%@ page language="java" import="com.mongodb.*"
	import="java.net.UnknownHostException" import="java.util.*"
	import="java.text.*" import="connection.*"
	import="java.sql.Array"
import="beans.HotelBean"
import="java.util.ArrayList"
	%>


<!DOCTYPE html>
<html lang="en">
<head>
  <title>HotelDeals|Hotels</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" type="image/png" href="images/icon.png" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="css/bootstrap.min.css" rel="stylesheet"></link>
  <link href="css/simple-sidebar.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link href="style.css" rel="stylesheet" type="text/css">
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
<%
	String emailId = (String) session.getAttribute("user");
%>
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#myPage">HotelDeals.com</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
		<li><a href="admin.jsp">HOME</a></li>
		<li class="dropdown"><a class="dropdown-toggle"
		data-toggle="dropdown" href="#">ACCOUNT<b class="caret"></b></a>
		<%
			if (emailId != null) {
		%>
		<ul class="dropdown-menu">
		<LI><a href="logOut.jsp">Logout</a></LI>
		</ul> <%
			} else {
		%>
		<UL class="dropdown-menu">
		<li><a href="#signIn" data-toggle="modal" id="signInButton">SIGN-IN</a></li>
		<li><a href="#signUp" data-toggle="modal" id="signUpButton">SIGN-UP</a></li>
		</UL>
		<%
								 	}
								 %></li>
      </ul>
    </div>
  </div>
</nav>

<DIV class="modal fade mt" id="signIn" role="dialog">
			<DIV class="modal-dialog">
				<DIV class="modal-content">
					<form action="user">
						<DIV class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<H4 class="text-center">
								Sign In As: <small><select name="userType">
										<option value="customer">Customer</option>
										<option value="manager">Manager</option>
										<option value="admin">Admin</option></select></small>
							</H4>
						</DIV>
						<DIV class="modal-body">
							<div class="form-group">
									<h3 style="color: red;font: verdana;" id="signInMessage"></h3>
							</div>
							<div class="form-group">
								<label for="emailid">Email ID:</label> <input type="email"
									class="form-control" id="emailid" name="emailId" required
									placeholder="example@example.com" />
							</div>
							<div class="form-group">
								<label for="password">Password:</label> <input type="password"
									class="form-control" id="password" name="password"
									pattern=".{4,}" required placeholder="minimum length 4" />
							</div>
						</DIV>
						<DIV class="modal-footer">
							 <input
								type="submit" class="btn btn-primary" name="signIn"
								value="LOGIN" />
						</DIV>
					</form>
				</DIV>
			</DIV>
		</DIV>
		
		<DIV class="modal fade mt" id="signUp" role="dialog">
			<DIV class="modal-dialog">
				<DIV class="modal-content">
					<form action="user" method="post" id="signupForm" onsubmit="return verifyPassword()">
						<DIV class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<H4 class="text-center">Customer Sign Up</H4>
						</DIV>
						<DIV class="modal-body">
							<div class="form-group">
									<h3 style="color: red;font: verdana;" id="signUpMessage"></h3>
							</div>
							<div class="form-group">
								<label for="emailid1">Email ID:</label> <input type="email"
									class="form-control" id="emailid1" name="emailId" required
									placeholder="example@example.com" />
							</div>
							<div class="form-group">
								<h3 id="errorMessage" style="color: red;font: verdana;"></h3>
							</div>
							<div class="form-group">
								<label for="name">Full Name:</label> <input type="text"
									class="form-control" id="name" name="fullName" required
									placeholder="First Name Last Name" />
							</div>
							<div class="form-group">
								<label for="phone">Phone Number:</label> <input type="number"
									class="form-control" id="phone" name="phoneNumber" placeholder="Enter phone number" />
							</div>
							<div class="form-group">
								<label for="age">Age:</label> <input type="number"
									class="form-control" id="age" name="age" placeholder="Enter age" />
							</div>
							<div class="form-group">
								<label for="gender">Gender:</label>
								<select class="form-control" id="gender" name="gender">
								<option value="male">Male</option>
								<option value="female">Female</option>
								</select>
							</div>
							<div class="form-group">
								<label for="occupation">Occupation:</label> <input type="text"
									class="form-control" id="occupation" name="occupation" placeholder="Enter occupation" />
							</div>
							<div class="form-group">
								<label for="password1">Password:</label> <input type="password"
									class="form-control" id="password1" name="password"
									pattern=".{4,}" required placeholder="minimum length 4" />
							</div>
							<div class="form-group">
								<label for="rpassword">Retype Password:</label> <input
									type="password" class="form-control" id="rpassword"
									name="rpassword" pattern=".{4,}" required
									placeholder="minimum length 4" />
							</div>
							<div class="form-group">
								<h3 id="passwordMessage" style="color: red;font: verdana;"></h3>
							</div>
						</DIV>
						<DIV class="modal-footer">
							<input type="submit" class="btn btn-primary" name="signUp" value="Sign Up" />
						</DIV>
					</form>
				</DIV>
			</DIV>
		</DIV>
	
	<%
		String hotelName = "";
		String city = "";
		String zip = "";
		String address = "";
		String url = "";
		String roomTypes = "";
		String hotelDescription = "";
		int i = 0;
		ArrayList<String> features = null;
		ArrayList<String> images = null;
		
	if(request.getParameter("update") != null){
		ArrayList<HotelBean> hotels = (ArrayList<HotelBean>)session.getAttribute("hotels");
		int hotelId = Integer.parseInt(request.getParameter("hotelId"));
		HotelBean hotel = new HotelBean();
		for(HotelBean Thotel : hotels) {
			if(Thotel.getHotelId() == hotelId){
				hotel = Thotel;
			}
		}
		hotelName = "value='"+hotel.getHotelName()+"'";
		city = "value='"+hotel.getCity()+"'";
		zip = "value='"+hotel.getZip()+"'";
		address = "value='"+hotel.getAddress()+"'";
		url = "value='"+hotel.getUrl()+"'";
		roomTypes = "value='"+hotel.getNumberOfRooms().size()+"'";
		hotelDescription = "value='"+hotel.getDescription()+"'";
		features = (ArrayList<String>)hotel.getFeatures();	
		images = (ArrayList<String>)hotel.getImages();
				
	}
	%>

	<DIV class="img-responsive bdy container-fluid mt inputForm row1">

		<div class="rowb">
			<div class="col-sm-4 col-sm-offset-4">

				<h3>Add a Hotel:</h3>

				<form action="addHotel" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="hotelName">Hotel Name: </label> <input type="text"
							class="form-control" id="hotelName" name="hotelName" required
							placeholder="Enter Hotel Name" <%=hotelName %> />
					</div>

					<div class="form-group">
						<label for="hotelCity">City: </label>
						<div id="hotelCity">
							<input type="text" class="form-control" name="city" id="cityName"
								onkeypress="loadJSON()" list="cityNameList" autocomplete="off"
								required placeholder="Enter City name" <%=city %> />
								<datalist id="cityNameList">
							</datalist>
						</div>
					</div>

					<div class="form-group">
						<label for="hotelZip">Zip Code: </label> <input type="number"
							class="form-control" id="hotelZip" name="zip" required
							placeholder="Enter zip code" <%=zip %> />
					</div>

					<div class="form-group">
						<label for="hotelAddress">Address: </label> <input type="text"
							class="form-control" id="hotelAddress" name="address" required
							placeholder="Enter address" <%=address %> />
					</div>

					<div class="form-group">
						<label for="url">URL: </label> <input type="text"
							class="form-control" id="url" name="url" required
							placeholder="Enter URL" <%=url %> />
					</div>

					<div class="form-group">
						<label for="cancellation">Cancellation Policy: </label> <select
							class="form-control" id="cancellation" name="cancellation">
							<option value="24">24Hrs</option>
							<option value="36">36Hrs</option>
							<option value="48">48Hrs</option>
						</select>
					</div>

					<div class="form-group">
						<label for="rooms">Types of Rooms Available: </label> <input
							type="number" class="form-control" id="rooms" name="typeCount"
							required placeholder="Enter number of room types" <%=roomTypes %> />
					</div>

					<div class="form-group">
						<label for="desc">Hotel Description: </label>
						<textarea class="form-control" id="desc" name="description" <%=hotelDescription %>></textarea>
					</div>

					<div class="form-group">
						<label for="featureDiv">Features: </label>						
						<%
						if(request.getParameter("update") != null){
							for(i=0;i<features.size();i++){
						%>
						<div class='row'><div class='col-sm-10'>
						<input type='text' class='form-control' value="<%=features.get(i) %>" readonly
						<% i++; %>
						name="f<%=i %>" id="f<%=i %>" />
						</div><div class='com-sm-2'>
						<button type='button' class='btn btn-warning' id='b<%=i %>' 
						onclick='removeFeature("<%=i%>")'>
						<span class='glyphicon glyphicon-remove'></span></button></div></div><br/>
						<%} }%>
						
						<div id="featureDiv">
							<input type="text" class="form-control"
								placeholder="Enter feature" name="f1" id="f1" />
						</div>
						<input type="button" onclick='addFeature()' value="ADD FEATURE"
							class="btn btn-warning" /> <input type='hidden' value='0'
							id='featureCount' name='featureCount' />
					</div>


					<div class="form-group">
						<label for="pics">Upload Hotel Images: </label> 
						<input type="file"
							class="form-control" accept="image/*" id="pics" name="images"
							multiple required value="<%=images%>"/>
							<br />
					</div>

					<input class="btn btn-warning" type="submit" name="addHotel"
						value="ADD HOTEL" />

				</form>

			</div>
		</div>

	</DIV>

<footer class="container-fluid text-center">
  <a href="#myPage" title="To Top">
    <span class="glyphicon glyphicon-chevron-up"></span>
  </a>
  <p>&copy;<a href="#mypage" title="Visit">HotelDeals.com</a></p>
</footer>

<script>
$(document).ready(function(){
  // Add smooth scrolling to all links in navbar + footer link
  $(".navbar a, footer a[href='#myPage']").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 900, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
  
  $(window).scroll(function() {
    $(".slideanim").each(function(){
      var pos = $(this).offset().top;

      var winTop = $(window).scrollTop();
        if (pos < winTop + 600) {
          $(this).addClass("slide");
        }
    });
  });
})
</script>
<script src="js/javascript.js"></script>
	<script src="js/CityNameAutoFill.js"></script>
</body>
<%
	if(request.getParameter("type") != null)
	{
		if(request.getParameter("type").equals("login"))
		{
			if(request.getParameter("status").equals("false"))
			{
				%>
					<script>
						document.getElementById("signInMessage").innerHTML = "Credentials Don't Match";
						document.getElementById("signInButton").click();
					</script>
				<% 
			}
		}
		else
		{
			if(request.getParameter("status").equals("false"))
			{
				%>
					<script>
						document.getElementById("signUpMessage").innerHTML = "EmailId Already Exists";
						document.getElementById("signUpButton").click();
					</script>
				<% 
			}
		}
	}
	else
	{
		
	}
%>
</HTML>