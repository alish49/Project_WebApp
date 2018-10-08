<%@ page language="java" import="com.mongodb.*"
	import="java.net.UnknownHostException" import="java.util.*"
	import="java.text.*" import="connection.*"
	import="beans.RoomBean"
import="java.sql.Array"
import="beans.*"
import="controllers.*"
import="java.util.ArrayList"
	%>
<!DOCTYPE HTML>
<HTML>
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
  <script src="js/javascript.js"></script>
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
        <li><a href="#deals">DEALS</a></li>
		<li class="dropdown"><a class="dropdown-toggle"
		data-toggle="dropdown" href="#">ACCOUNT<b class="caret"></b></a>
		<%
			if (emailId != null) {
		%>
		<ul class="dropdown-menu">
		<LI><a href="profile.jsp">Profile</a></LI>
		<LI><a href="getBookings">My Bookings</a></LI>
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
	ArrayList<HotelBean> hotels = (ArrayList<HotelBean>)session.getAttribute("hotels");
	int hotelId = Integer.parseInt(request.getParameter("hotelId"));
	HotelBean hotel = new HotelBean();
	for(HotelBean Thotel : hotels) {
		if(Thotel.getHotelId() == hotelId)
			hotel = Thotel;
	}
	%>

	<div class="container-fluid">
		<div class="row">
			<DIV class="bdy container-fluid mt">
				<div class="col-lg-12">

				

						<div class="col-lg-7">

							<DIV class="row">
								<DIV class="col-md-8">
									<h1 class="bl"><%=hotel.getHotelName() %></h1>
									<h5 class="bl"><%=hotel.getCity() %></h5>
								</DIV>
							</DIV>
							<DIV class="row">
								<DIV class="col-md-12">

									<div id="myCarousel" data-interval="false"
										class="carousel slide" data-ride="carousel">

										<!-- Wrapper for slides -->
										<div class="carousel-inner" role="listbox">
										
											<div class="item active">
												<img class="imgSz" src="<%=hotel.getImages().get(0)%>"
													alt="Congress">
											</div>
									<%for(int j=1;j<(hotel.getImages().size()-1);j++) { %>
											<div class="item">
												<img class="imgSz" src="<%=hotel.getImages().get(j)%>" alt="Congress">
											</div>
									<%} %>

										</div>

										<!-- Left and right controls -->
										<a class="left carousel-control" href="#myCarousel"
											role="button" data-slide="prev"> <span
											class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a> <a class="right carousel-control" href="#myCarousel"
											role="button" data-slide="next"> <span
											class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
									<!-- end of corousel -->

								</DIV>
							</DIV>

						</div>

						<div class="col-lg-5">
							<div class="row cmt">
								<h3 class="bl">Hotel Description:</h3>
							</div>
							<div class="row">
								<div class="col-md-10">
									<p><%=hotel.getDescription() %></p>
								</div>
							</div>

							<div class="row">
								<h3 class="bl cmt">Average Rating: <%=hotel.getRating() %>/5.0</H3>
							</div>
							<div class="row">
								<h3 class="bl cmt">Customer Rating:</H3>
							</div>

							<div class="row bl containerfluid">
								<div class="col-md-2">
									<p class="text-right">5 star:</p>
								</div>
								<div class="col-md-6">
									<div class="progress">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: <%=session.getAttribute("star5") %>%"><%=session.getAttribute("star5") %>%</div>
									</div>
								</div>
							</div>

							<div class="row bl containerfluid">
								<div class="col-md-2">
									<p class="text-right">4 star:</p>
								</div>
								<div class="col-md-6">
									<div class="progress">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: <%=session.getAttribute("star4") %>%"><%=session.getAttribute("star4") %>%</div>
									</div>
								</div>
							</div>

							<div class="row bl containerfluid">
								<div class="col-md-2">
									<p class="text-right">3 star:</p>
								</div>
								<div class="col-md-6">
									<div class="progress">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: <%=session.getAttribute("star3") %>%"><%=session.getAttribute("star3") %>%</div>
									</div>
								</div>
							</div>

							<div class="row bl containerfluid">
								<div class="col-md-2">
									<p class="text-right">2 star:</p>
								</div>
								<div class="col-md-6">
									<div class="progress">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: <%=session.getAttribute("star2") %>%"><%=session.getAttribute("star2") %>%</div>
									</div>
								</div>
							</div>

							<div class="row bl containerfluid">
								<div class="col-md-2">
									<p class="text-right">1 star:</p>
								</div>
								<div class="col-md-6">
									<div class="progress">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: <%=session.getAttribute("star1") %>%"><%=session.getAttribute("star1") %>%</div>
									</div>
								</div>
							</div>
						
						<a href="writeReview.jsp?hotelId=<%=hotel.getHotelId() %>" class="cmt ml1 btn btn-success">WRITE REVIEW</a>
						
						</div>
					</div>

					<div class="row containerfluid">

						<div class="col-sm-12">

							<DIV class="cmt row">
								<DIV class="col-md-12">
									<H3 class="bl">Types of rooms available:</H3>
								</DIV>
							</DIV>

							<%
							ArrayList<RoomBean> rooms = (ArrayList<RoomBean>)hotel.getRooms();
									int i=0;
									for(RoomBean room : rooms) {
										i++;
							%>
							<div class="row containerfluid">
								<div class="col-lg-10">
									<DIV class="sortList">

										<DIV class="ml row">
											<DIV class="col-lg-4">

												<div class="row">
													<div class="col-lg-9">
														<div data-interval="false" id="myCarousel<%=i%>"
															class="carousel slide" data-ride="carousel">

															<!-- Wrapper for slides -->
															<div class="carousel-inner" role="listbox">
																<div class="item active">
												<img class="smallImgSz" src="<%=room.getImages().get(0)%>" />
											</div>
									<%for(int j=1;j<(room.getImages().size());j++) { %>
											<div class="item">
												<img class="smallImgSz" src="<%=room.getImages().get(j)%>" />
											</div>
									<%} %>

															</div>

															<!-- Left and right controls -->
															<a class="left carousel-control" href="#myCarousel<%=i%>"
																role="button" data-slide="prev"> <span
																class="glyphicon glyphicon-chevron-left"
																aria-hidden="true"></span> <span class="sr-only">Previous</span>
															</a> <a class="right carousel-control"
																href="#myCarousel<%=i%>" role="button" data-slide="next">
																<span class="glyphicon glyphicon-chevron-right"
																aria-hidden="true"></span> <span class="sr-only">Next</span>
															</a>
														</div>
													</div>
												</div>
												<!-- end of corousel -->

											</DIV>
											<DIV class="col-lg-4">
												<DIV class="row">
													<H3 class="bl">
														<b><%=room.getTypeName() %></b>
													</H3>
												</DIV>
												<div class="row">
													<h4>Features:</h4>
													<div class="col-lg-6">
												<%
												String[] Feature = new String[7];
												i = 0;
												Set set = room.getFeatures().entrySet();
									    	    Iterator iterator = set.iterator();
									      		while(iterator.hasNext()) 
									      		{
									         		Map.Entry mentry = (Map.Entry)iterator.next();
													Feature[i] = (String)mentry.getKey();
													i++;      
												}
												for(int j=0;j<3;j++) {
												if(room.getFeatures().get(Feature[j]) != null) {
												%>
														<p class="bl">
															<span class="glyphicon glyphicon-ok" style="color: green"></span>
															<%=Feature[j] %>
														</p>
												<%}
												} %>
													</div>
													<div class="col-lg-6">
														<% for(int j=3;j<room.getFeatures().size();j++) 
														{
															System.out.println("J:"+j);
															if(room.getFeatures().get(Feature[j]) != null) 
															{
														%>
														<p class="bl">
															<span class="glyphicon glyphicon-ok" style="color: green"></span>
															<%=Feature[j] %>
														</p>
												<% }
												} %>
													</DIV>
												</div>
											</DIV>
											<DIV class="col-lg-4">
												<form action="bookRoom.jsp">
												<div class="row">
												
												</div>
												<br/>
												<div class="row ml">
												<div class="col-lg-12">
													<h4 class="bl">
														Price: $<%=room.getPrice() %>&nbsp;<small>per night</small>
													</h4>
												</div>
												</div>
												<div class="row ml">
													<H4 class="bl">
														<input class="btn btn-primary ml" type="button" value="-" 
															onclick="changeRoom('r<%=room.getRoomId()%>',-1)">
														<input class="wid1" type="number" value=1 min=1 max=<%=hotel.getNumberOfRooms().get(room.getTypeName()) %>
														 readonly id="r<%=room.getRoomId()%>" name="r<%=room.getRoomId()%>"/>
														<input class="btn btn-primary" type="button" value="+"
															onclick="changeRoom('r<%=room.getRoomId()%>',+1)">
													</H4>
												</div>
												<div class="row ml">
												<div class="col-lg-11">
												<h5><b>Rooms Available: <%=hotel.getNumberOfRooms().get(room.getTypeName()) %></b></h5>
												</div>
												</div>
												<div class="row ml3 mt1">
												<%if(emailId == null){ %>
													<a href="#signIn" data-toggle="modal" class="ml btn btn-success">BOOK</a>
												<%} else{ %>
												<input class="ml btn btn-success" type="submit"
														value="BOOK" />
												<%} %>
												</div>
												<input type="hidden" id="hotelId" name="hotelId" value="<%=hotelId %>">
												<input type="hidden" id="roomId" name="roomId" value="<%=room.getRoomId() %>"> 
												</form>
											</DIV>
										</DIV>

									</DIV>
								</div>
							</div>
							<%
								}
							%>

						</div>

					</div>

					<div class="ml row cmt container-fluid">

						<div class="col-md-12">

							<h3>Customer Reviews:</h3>

						</div>

					</div>
					<%
					ArrayList<ReviewsBean> reviews = (ArrayList<ReviewsBean>)session.getAttribute("reviews");
					if(reviews.size() == 0){ %>
					<h4>No Reviews</h4>
					<%	
					} else {
					int k=0;
					String check1 = " ";
					String check2 = " ";
					String check3 = " ";
					String check4 = " ";
					String check5 = " ";
					
					for(ReviewsBean review: reviews){
						int rvHID = review.getHotelId();
						if(rvHID == hotelId){
							k++;
							int rrtng = Math.round(review.getReviewRating());
							switch(rrtng){
							case 1: check1 = "checked";
								break;
							case 2: check2 = "checked";
							break;
							case 3: check3 = "checked";
							break;
							case 4: check4 = "checked";
							break;
							case 5: check5 = "checked";
							break;
							}
							
					%>
					<div class="ml row containerfluid">
						<div class="col-lg-12">
							<h4 class="mb">
								Review#<%=k%>:
							</h4>
							<ul class="sidebar-nav1">
								<li class="nm"><div class="rating">
										<input type="radio" id="star5<%=k%>" name="rating<%=k%>"
											value="5" disabled <%=check5 %> /><label for="star5<%=k%>" title="Rocks!">&#9733;</label>
										<input type="radio" id="star4<%=k%>" name="rating<%=k%>"
											value="4" disabled <%=check4 %> /><label for="star4<%=k%>"
											title="Pretty good">&#9733;</label> <input type="radio"
											id="star3<%=k%>" name="rating<%=k%>" value="3" disabled <%=check3 %> /><label
											for="star3<%=k%>" title="Meh">&#9733;</label> <input
											type="radio" id="star2<%=k%>" name="rating<%=k%>" value="2"
											disabled <%=check2 %> /><label for="star2<%=k%>" title="Kinda bad">&#9733;</label>
										<input type="radio" id="star1<%=k%>" name="rating<%=k%>"
											value="1" disabled <%=check1 %> /><label for="star1<%=k%>"
											title="Sucks big time">&#9733;</label>
									</div></li>

							</ul>
							<h3 class="ml">
								<b><%=review.getReviewtitle()%></b>
							</h3>
							<h4 class="ml">
								<b><%=review.getReviewText()%></b>
							</h4>
						</div>
					</div>
					<div class="ml row containerfluid">
						<div class="col-md-12 ml">
							<h4>By: <%=review.getUserName()%></h4>
							<hr />
						</div>
					</div>

					<%
					}
					}
					}
		%>

				</DIV>
			</div>
		</div>
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