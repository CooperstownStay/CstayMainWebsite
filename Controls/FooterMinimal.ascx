<%@ Control Language="VB" AutoEventWireup="false" CodeFile="FooterMinimal.ascx.vb" Inherits="Controls_FooterMinimal" %>
<footer>
<div class="container">
<div class="footerTop">

<div class="footerTopMainHead">Weekly Lodging in Cooperstown, NY.  <span>Call 607-547-6260</span> or
<div class="footerTopMainHeadBTN"><a href="<%= MyUtils.GetAppSetting("ReservationWebsite") %>" rel="nofollow" >Book Online</a></div>
</div>
<div style="clear:both;"></div>
</div>

<!--footer-->
<div class="footer hidden-print">
    <div class="row">

        <div class="col-sm-4">

            <div class="logoBottom"><a href="/"><img src="/images/logo.jpg" alt="Cooperstown Stay"/></a></div>
            

        </div>

        <div class="col-sm-8 text-center" style="margin:20px 0px">
        
            <ul class="FooterUlMain1">
                <li><a href="/<%= Session("EditModeQS") %>">Home</a></li>
                <li><a href="<%= MyUtils.GetAppSetting("ReservationWebsite") %>" rel="nofollow">Search</a></li>
                <li><a href="/contact<%= Session("EditModeQS") %>">Contact</a></li>
            </ul>

        </div>

    </div>

</div><!--/footer-->

<div class="footerBottom">
<div class="container">
<div class="row">
<div class="CopyRightBox">2018 &copy; Cooperstown Stay, Inc. All rights reserved. <a href="/privacy">Privacy</a></div>

<ul class="FooterNav">
<li><a href="/<%= Session("EditModeQS") %>">Home</a></li>
<li><a href="/contact<%= Session("EditModeQS") %>">Contact</a></li>
</ul>

</div>
</div>
</div>

</div>
</footer>