<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Footer.ascx.vb" Inherits="Controls_Footer" %>
<footer>
<div class="container">
<div class="footerTop">

<div class="footerTopMainHead">Weekly Lodging in Cooperstown, NY.  <span>Call 607-547-6260</span> or
<div class="footerTopMainHeadBTN"><a href="<%= MyUtils.GetAppSetting("ReservationWebsite") %>" rel="nofollow"  >Book Online</a></div>
</div>
<div style="clear:both;"></div>
</div>


<!--footer-->
<div class="footer">
    <div class="row">

        <div class="col-sm-4">

            <div class="logoBottom"><a href="/"><img src="/images/logo.jpg" alt="Cooperstown Stay"/></a></div>
            <div class="FooterLogoText">Cooperstown Stay specializes in weekly house rentals and lodging in Cooperstown, NY for families attending Cooperstown Dreams Park and other youth baseball tournaments in the area.</div>

        </div>

        <div class="col-sm-4 mobileHide">

            <ul class="FooterUlMain">
                <li><a href="<%= MyUtils.GetAppSetting("ReservationWebsite") %>" rel="nofollow" >Search by Week</a></li>
                <li><a href="/cooperstown-ny-map<%= Session("EditModeQS") %>">Area Maps</a></li>
                <li><a href="/things-to-do<%= Session("EditModeQS") %>">Area Links</a></li>
                <li><a href="/rental-info<%= Session("EditModeQS") %>">Reservation Info</a></li>
            </ul>

        </div>

        <div class="col-sm-4">

            <ul class="FooterUlMain1">
                <li><a href="/house-rentals<%= Session("EditModeQS") %>">Private House Rentals</a></li>
                <li><a href="/apartment-rentals<%= Session("EditModeQS") %>">Apartment Rentals</a></li>
                <li><a href="/house-rentals-on-lake<%= Session("EditModeQS") %>">Waterfront</a></li>
                <li><a href="/rooms-suites<%= Session("EditModeQS") %>">Lodging Rooms & Suites</a></li>
                <li><a href="/group-lodging<%= Session("EditModeQS") %>">Group Lodging</a></li>
                <li><a href="/oneonta-ny-lodging<%= Session("EditModeQS") %>">Oneonta Area Lodging</a></li>
            </ul>

        </div>

    </div>

</div><!--/footer-->

<div class="footerBottom">
<div class="container">
<div class="row">
<div class="CopyRightBox">2018 &copy; Cooperstown Stay, Inc. All rights reserved. <a href="/privacy">Privacy</a></div>

<ul class="FooterNav">
<li><a href="/<% =Session("EditModeQS") %>">Home</a></li>
<li><a href="/contact<%= Session("EditModeQS") %>">Contact</a></li>
</ul>

</div>
</div>
</div>

</div>
</footer>