<%@ page language="java" 
import="com.mongodb.*"
import="java.net.UnknownHostException"
import="java.util.*"
import="java.text.*"
import="connection.*"
import="beans.RoomBean"
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
		<li><a href="index.jsp">HOME</a></li>
		<LI><a href="addHotel.jsp">ADD HOTEL</a></LI>
		<LI><a href="danalysis">DATA ANALYTICS</a></LI>
        <li><a href="managerPage.jsp">VIEW BOOKINGS</a></li>
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
		
		<div class="mt container-fluid bdy">

<%
int i=0;
ArrayList<HotelBean> hotels = (ArrayList<HotelBean>)session.getAttribute("hotels");
if (hotels == null){
	request.getRequestDispatcher("adminPage").forward(request,response);
}
else if(hotels.size() == 0) {%>
	<h2> No Hotels found </h2>
<% 
} else {
for(HotelBean hotel : hotels) {
	i++;
%>
	<div class="bdy">
	<DIV class="sortList">
	<div class="row">
	<DIV class="col-lg-3 col-md-6 col-sm-12">
		
			<div class="row">
					<div class="col-lg-12">
			<div data-interval="false" id="myCarousel<%=i%>"
										class="carousel slide" data-ride="carousel">

										<!-- Wrapper for slides -->
										<div class="carousel-inner" role="listbox">
										
										<div class="item active">	
												<img class="smallImgSz img-responsive" src="<%=hotel.getImages().get(0)%>"
													alt="hotelpedia">
										</div>
										<%
										for(int j=1;j<(hotel.getImages().size()-1);j++) { 
										%>
										<div class="item">	
												<img class="smallImgSz img-responsive" src="<%=hotel.getImages().get(j)%>"
													alt="hotelpedia">
										</div>
										<%} %>
										
										</div>

										<!-- Left and right controls -->
										<a class="left carousel-control" href="#myCarousel<%=i%>"
											role="button" data-slide="prev"> <span
											class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a> <a class="right carousel-control" href="#myCarousel<%=i%>"
											role="button" data-slide="next"> <span
											class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
								</div>
							</div>  	
							<!-- end of corousel -->   
		
	</DIV>
	<DIV class="col-lg-2 col-md-4">
		<H1 class="bl"> <%=hotel.getHotelName()%> </H1>
  		<small class="bl"><%=hotel.getCity() %></small>
  		<h3 class="bl"> Rating: <%=hotel.getRating()%>/5.0 </H3>  		
  	</DIV>
  	<DIV CLASS="col-lg-2">

  		<h3>Features: </h3>
  		<% for(int j=1;j<(hotel.getFeatures().size()-1);j++) 
  		{ if(i > 2)
  			break;%>
  		
  			<p class="bl">
								<span class="glyphicon glyphicon-ok" style="color: green"></span>
								<%=hotel.getFeatures().get(j) %>
							</p>
					<%} %>
							<SMALL>and more.</SMALL>

  	</DIV>
	<DIV class="col-lg-3">
		<h3 class="bl cmt"> Price: $<%=hotel.getMinPrice()%> <SMALL class="bl">per night</SMALL></H3>
		<h5 class=""><b>Rooms available: <%=hotel.getTotalRooms() %></b></h5>
  	</DIV>
  	<div class="col-lg-1">
  	<form action="addHotel.jsp">
  	<input type="hidden" name="hotelId" value="<%=hotel.getHotelId() %>" />
  	<input type="submit" class="btn btn-danger cmt" name="update" value="UPDATE" /><br/><br/>
  	</form>
  	<a class="btn btn-danger" href="removeHotel?hotelId=<%=hotel.getHotelId() %>" >REMOVE</a>
  	</div>
	</div>
	</DIV>
<%
}
}
%>
</DIV>
</div>

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

</body>
</html>