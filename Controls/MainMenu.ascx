<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MainMenu.ascx.vb" Inherits="Controls_MainMenu" %>

<!-- MENU  REF: http://jsfiddle.net/apougher/ydcMQ/ -->
<div class="navbar navbar-default navbar-static-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
			<li><a href="/<%= Session("EditModeQS") %>">Home</a></li>
			<li class="dropdown menu-large">
				<a href="#" class="dropdown-toggle em" data-toggle="dropdown">Lodging <b class="caret"></b></a>				
				<ul class="dropdown-menu megamenu row">
					<li class="col-sm-3">
						<ul>
							<li class="dropdown-header">Lodging Types</li>
                            <li><a href="/house-rentals<%= Session("EditModeQS") %>">Private Homes</a></li>
                            <li><a href="/apartment-rentals<%= Session("EditModeQS") %>">Apartments</a></li>
                            <li><a href="/house-rentals-on-lake<%= Session("EditModeQS") %>">Waterfront</a></li>
                            <li><a href="/rooms-suites<%= Session("EditModeQS") %>">Rooms & Suites</a></li>
                            <li><a href="/group-lodging<%= Session("EditModeQS") %>">Group Lodging</a></li>
                            <li><a href="/oneonta-ny-lodging<%= Session("EditModeQS") %>">Oneonta Area Lodging</a></li>

						</ul>
					</li>
					<li class="col-sm-3">
						<ul id="phmm">
							<li class="dropdown-header">Private Homes</li>
                            <li><a href="/house-rentals/1-2-bedrooms<%= Session("EditModeQS") %>">1-2 Bedrooms</a></li>
                            <li><a href="/house-rentals/3-bedrooms<%= Session("EditModeQS") %>">3 Bedrooms</a></li>
                            <li><a href="/house-rentals/4-bedrooms<%= Session("EditModeQS") %>">4 Bedrooms</a></li>
                            <li><a href="/house-rentals/5-bedrooms<%= Session("EditModeQS") %>">5 Bedrooms</a></li>
                            <li><a href="/house-rentals/6-bedrooms<%= Session("EditModeQS") %>">6+ Bedrooms</a></li>
						</ul>
					</li>
					<li class="col-sm-6 hidden-xs">
						<ul>
							<li class="em-big"><a href="<%= MyUtils.GetAppSetting("ReservationWebsite") %>" rel="nofollow"><i class="fa fa-lg fa-search"></i>&nbsp;Search All Rental Properties</a></li>
						</ul>
                        <div class="searchbox"></div>
					</li>
					
				</ul>

			</li>
			<li class="dropdown menu">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Rental Info <b class="caret"></b> </a>
                  <ul class="dropdown-menu">
                    <li><a href="/rental-info<%= Session("EditModeQS") %>">Payment Options</a></li>
                    <li><a href="/rental-info#cancel<%= Session("EditModeQS") %>">Cancellation Policy</a></li>
                    <li><a href="/rental-agreement<%= Session("EditModeQS") %>">Rental Agreement</a></li>
                  </ul>
            </li>
            <li><a href="/faq<%= Session("EditModeQS") %>">FAQ</a></li>
			<li class="dropdown menu">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown"> Area Info <b class="caret"></b> </a>
                  <ul class="dropdown-menu">
                    <li><a href="/cooperstown-ny-map<%= Session("EditModeQS") %>">Area Maps</a></li>
                    <!--li><a href="/parks-map<%= Session("EditModeQS") %>">Map of Tournaments</a></li-->
                    <li><a href="/things-to-do<%= Session("EditModeQS") %>">Things To Do</a></li>
                    <li><a href="/cooperstown-photos<%= Session("EditModeQS") %>">Area Photos</a></li>
                  </ul>
            </li>
            <li class="dropdown menu">
                  <a href="#" class="dropdown-toggle em" data-toggle="dropdown"> Search <b class="caret"></b> </a>
                  <ul class="dropdown-menu">
                    <li><a href="/#search<%= Session("EditModeQS") %>">Quick Search</a></li>
                    <li><a href="<%= MyUtils.GetAppSetting("ReservationWebsite") %>">Advanced Search</a></li>
                    <li class="specific">
                    Find a Specific Property
                    <input type="text" id="txtMnuSearch" class="form-control propSearchBox" maxlength="30" placeholder="Property Name"/>
                    <button type="button" id="btnMnuSearch" class="btn-Blue" onclick="DoPropertySearch()">Find</button>
                    </li>
                  </ul>
            </li>
            <li><a href="<%= MyUtils.GetAppSetting("ReservationWebsite") %>/payments.aspx" rel="nofollow">Make Payment</a></li>
            <li><a href="/contact<%= Session("EditModeQS") %>">Contact</a></li>
		</ul>
		</div>
      </div>
    </div>
<!-- /MENU -->