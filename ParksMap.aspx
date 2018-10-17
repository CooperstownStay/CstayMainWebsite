<%@ Page Title="Cooperstown Baseball Tournament Map" Language="VB" MasterPageFile="~/Master.master" AutoEventWireup="false" CodeFile="ParksMap.aspx.vb" Inherits="ParksMap" MetaDescription="Downloadable map of Cooperstown baseball tournaments: Cooperstown Dreams Park, Baseball World and All Star Village." %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <title>Cooperstown Rental Lodging - Parks Maps</title>
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/parks-map" />
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>" />
  <meta name="description" content="Maps of baseball parks in the Cooperstown area.  Maps to Cooperstown Dreams Park , Cooperstown Baseball World, and Cooperstown Village." />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="LeftSideContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" Runat="Server">

      

<div class="col-xs-12">
<div class="heading">Youth Baseball Tournament Locations in or near Cooperstown, NY</div>
<div class="well">
    <p class="lead">
    Click on the map to make it easier to read. Feel free to download the map and print out!
    </p>
    <!--p style="font-weight:bold;">Baseball Parks included in the map:</p>
    <ul>
        <li>Cooperstown Dreams Park</li>
        <li>Cooperstown Baseball World</li>
        <li>Cooperstown All Star Village</li>
    </ul-->
</div><!--/well-->
<a href="/images/cstay-map-parks.pdf" target="_blank" title="Cooperstown NY Dreams Park Baseball World Map" ><img src="/images/cstay-ny-map-parks3.jpg" alt="Cooperstown NY Dreams Park Baseball World Map" class="responsive" /></a>


</div>
          
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="RightSideContent" Runat="Server">
        
            <div class="acrobat-dld"><a href="http://get.adobe.com/reader/"><img src="/images/getacrobat.gif" alt width="88" height="31" border="0"><br />Get Acrobat Reader</a></div>
        
            <div class="heading">More Area Resources</div>
            <ul class="nav nav-pills nav-stacked">
              <li role="presentation"><a href="/cooperstown-ny-map">Cooperstown Map</a></li>
              <li role="presentation"><a href="/things-to-do">Things To Do</a></li>
              <li role="presentation"><a href="/cooperstown-photos">Area Photos</a></li>
            </ul>


</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" Runat="Server">
</asp:Content>

