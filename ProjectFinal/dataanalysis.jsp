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
  <script type='text/javascript' src='js/loader.js'></script>
  <% ArrayList<HotelBean> hotels = (ArrayList<HotelBean>)session.getAttribute("hotels"); %>
  <script>
  alert("hello");
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {
	  var data = new google.visualization.DataTable();
	  data.addColumn('string', 'Product Name');
	  data.addColumn('number', 'Quantity');
	  data.addRows([
	  for each(HotelBean hotel:hotels) {
		  ['"+hotel.getHotelName().substring(0,5)+"', "+hotel.getTotalRooms()+"],
	  }]);
	  var options = {
        title: 'Population of Largest U.S. Cities',
        chartArea: {width: '50%',height:'50%'},
      };
	  var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
  chart.draw(data, options); }
</script>
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
		<LI><a href="dataanalysis.jsp">DATA ANALYTICS</a></LI>
        <li><a href="#deals">DEALS</a></li>
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

<div id="chart_div"></div>

<div><h2> I'm in</h2></div>
<div><h2> I'm </h2></div>
		
	

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