<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LeftColumnMenu.ascx.vb" Inherits="Controls_LeftColumnMenu" %>
              <div class="left-menu">
                <ul class="nav nav-stacked" id="accordion1">
	              <li class="panel"> <a data-toggle="collapse" data-parent="#accordion1" href="#firstLink">Private Homes</a>

		              <ul id="firstLink" class="collapse submenu">
                        <li><a href="/house-rentals/1-2-bedrooms<%= Session("EditModeQS") %>">1 or 2 Bedrooms</a></li>
                        <li><a href="/house-rentals/3-bedrooms<%= Session("EditModeQS") %>">3 Bedrooms</a></li>
                        <li><a href="/house-rentals/4-bedrooms<%= Session("EditModeQS") %>">4 Bedrooms</a> </li>
                        <li><a href="/house-rentals/5-bedrooms<%= Session("EditModeQS") %>">5 Bedrooms</a> </li>
                        <li><a href="/house-rentals/6-bedrooms<%= Session("EditModeQS") %>">6+ Bedrooms</a> </li>
		              </ul>
	  
	              </li>
                  <li><a href="/apartment-rentals<%= Session("EditModeQS") %>">Apartments</a></li>
                  <li><a href="/house-rentals-on-lake<%= Session("EditModeQS") %>">Waterfront</a></li>
                  <li><a href="/rooms-suites<%= Session("EditModeQS") %>">Rooms & Suites</a></li>
	              <li><a href="/group-lodging<%= Session("EditModeQS") %>">Group Lodging</a></li>
                  <li><a href="/oneonta-ny-lodging<%= Session("EditModeQS") %>">Oneonta Area Lodging</a></li>
                </ul>
              </div>