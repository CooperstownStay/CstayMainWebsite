<%@ Page Title="Cooperstown House Rentals" Language="VB" MasterPageFile="~/MasterLeftCol.master" AutoEventWireup="false" CodeFile="Weekly-House-Rentals.aspx.vb" Inherits="HouseRentals" MetaDescription="House Rentals near Cooperstown, NY and the Dreams Park.  Simplify your search with Friendly, Local Customer Service and Online Booking!" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <title>Cooperstown House Rentals and Vacation Homes | Cooperstown Stay</title>
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/house-rentals" />
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />
  <style type="text/css">
  
        .inline-menu {
            margin: 0px;
            padding: 0px;
        }

        .inline-menu li {
            list-style-type: none;
            margin-left: 0px;
        }

        .inline-menu li a {
            background-color: #ffd22c;
            margin: 10px auto;
            display: block;
            /* width: 75%; */
            text-align: left;
            padding: 10px 20px;
            color: #000;
            /* font-weight: bold; */
        }

        .inline-menu a span {
            font-weight: bold;
            font-size: larger;
            white-space:nowrap;
        }
        
        @media (max-width:767px) {
         .inline-menu li a {text-align:center}   
        }
  
        ul.feature-bullets {
          align-items: left!important;
          text-align: left;
          color: #fff;
          background-color: #334377;
          padding: 30px;
        }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">

<!---- Over 350 Homes -->

<div class="row callout-light">
    <div class="col-sm-6 col-xs-12 content-inner">
    <ul class="inline-menu">
              
        <li><a href="/house-rentals/1-2-bedrooms<%= Session("EditModeQS") %>">House Rentals with <span>1-2 BRs</span></a></li>
        <li><a href="/house-rentals/3-bedrooms<%= Session("EditModeQS") %>">House Rentals with <span>3 BRs</span></a></li>      
        <li><a href="/house-rentals/4-bedrooms<%= Session("EditModeQS") %>">House Rentals with <span>4 BRs</span></a></li>
              
    </ul>
    </div><div class="col-sm-6 col-xs-12 content-inner">
    <ul class="inline-menu">
              
        <li><a href="/house-rentals/5-bedrooms<%= Session("EditModeQS") %>">House Rentals with <span>5 BRs</span></a></li>
        <li><a href="/house-rentals/6-bedrooms<%= Session("EditModeQS") %>">House Rentals with <span>6+ BRs</span></a></li>
        <li><a href="<%= MyUtils.GetAppSetting("ReservationWebsite")%>" rel="nofollow"><span>Search</span> House Rentals</a></li>
              
    </ul>
    </div>
          
<p style="clear:both">We will help you find the weekly rental that best meets your specific needs. Please call <a href="tel:6075476260"><strong>607-547-6260</strong></a> or, use the links above for private house rentals in Cooperstown.

</p></div>


<!---  WATERFRONT ---->

<section class="two-col-fluid">
    <div class="outer-box clearfix">
        <!--Image Column-->
        <div class="image-column" style="background-image:url('/images/creekside-cottages-cooperstown.jpg');"></div>
            
        <!--Content Column-->
        <div class="content-column">
            <div class="content-inner">
            <h3>Check out more Options</h3><p class="lead">We also have:</p>
            <ul>
              <li><a href="/group-lodging<%= Session("EditModeQS") %>">Group Lodging</a></li>
              <li><a href="/apartment-rentals<%= Session("EditModeQS") %>">Apartments</a></li>
              <li><a href="/rooms-suites<%= Session("EditModeQS") %>">Rooms and Suites</a></li>
              <li><a href="/house-rentals-on-lake<%= Session("EditModeQS") %>">Waterfront</a></li>
            </ul>
            <p>If your team is playing in <span style="font-weight:bold;white-space:nowrap">Oneonta, NY</span>, check out <a href="/oneonta-ny-lodging<%= Session("EditModeQS") %>">Oneonta Lodging</a>.</p>
            <!--div class="hdr-btn" style="margin: 15px 0px;"><a href="/house-rentals-on-lake" class="btn btn-info">Waterfront Rentals</a></div></div-->
        </div>
            
    </div>
</section>

<!-------  ADVANCED SEARCH -------------->

<div class="callout-medium">
    <h3>Find the Best House Rentals in Cooperstown for your Family</h3>
    <p>Use our advanced house rental search tool to narrow your search even more. Search by tournament week, tournament location, rental type, rental features like swimming pool, and more.</p>
    <div class="hdr-btn" style="margin: 15px 0px;"><a href="<%= MyUtils.GetAppSetting("ReservationWebsite")%>" rel="nofollow" class="btn btn-default">Advanced Search</a></div>
</div>

<!----------- BEST STAFF -------------->

<div class="row callout-light">
    <h2 style="margin-bottom:30px;">Local, Knowledgeable House Rental Staff</h2><div class="col-sm-4" style="text-align:center">
    <img src="/images/cstay-pto-lonetta3.jpg" style="margin: 10px; border: solid 5px #fff;">
    </div><div class="col-sm-8">
    <p class="lead">
        Our friendly staff is here to help you! 
    </p>
    <div class="hdr-btn" style="margin: 15px 0px;"><a href="tel:6075476260" class="btn btn-primary">Call 607-547-6260</a></div>
    <p>
    We specialize in meeting the private lodging needs of youth baseball tournament families. Our service is rooted in the philosophy of giving Personalized Customer Service.  We listen to your priorities and respect your different tastes and different size wallets. 
    </p>
    <p>
    <em>We answer the phone and listen to YOU.</em>
    </p>
    <ul class="feature-bullets">
      <li>We live in the area.</li>
      <li>We know the properties and will spend time helping you make the best choice.</li>
      <li>We work as a team.</li>
      <li>Our goal is to help our visiting guests “make a good match”!</li>
    </ul>
    
          
</div>




</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" runat="Server">
</asp:Content>
