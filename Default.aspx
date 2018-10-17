<%@ Page Title="Cooperstown Stay Lodging & Weekly Family Rentals - Homes, Apartments, Cabins, Hotels" Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterLeftCol.master" CodeFile="Default.aspx.vb" Inherits="_Default" MetaDescription="Cooperstown NY rental homes and lodging accommodations. Over 350 family rentals to choose from. We help baseball teams find weekly lodging near Cooperstown Dreams Park and Oneonta.  Choose from house rentals, cabins, apartments, lakefront homes, hotel rooms and suites." %>
<%@ Register TagName="Callout" TagPrefix="uc" Src="~/Controls/Callout.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>" />
  <meta name="keywords" content="<%=MyUtils.SetPageKeywords("") %>"/>
  <!--meta name="description" content="Cooperstown NY rental homes and lodging. Connecting Dreams Park families to private homes, cottages, apartments, waterfront and lakefront homes, rooms and suites and more. Simplify your search. Personalized customer service.  Hassle free!"/-->
  <style type="text/css">
    .contentBox .col-sm-9 {
        margin: 0px 15px 0px -15px;
    }
    
    .callout, .callout-light, .callout-medium, .callout-dark, .callout-bright {margin: 0px;}
    .two-col-fluid {margin: 0px;}
    
    /*
    .whitesearchbox {
        background-color: rgba(255,255,255,.8);
        display: inline-block;
        float: right;
        width: 300px;
        padding: 40px 40px 25px;
        margin-top: 30px;
        margin-right: 20%;
    }
    */
    .darksearchbox, .lightearchbox {
        display: block;
        width: 300px;
        padding: 10px 40px 25px;
        margin-right: auto;
        margin-left: auto;
    }
    .darksearchbox h5, .lightsearchbox h5 {font-size:16px;font-weight:bold;margin-left:-10px;margin-right:-10px;padding-bottom:10px;text-align:center;}
    
    .lightsearchbox {background-color: rgba(255,255,255,.8);}
    .lightsearchbox h5 {color:#000;}
    
    .darksearchbox {background-color: rgba(0,0,0,.8);}   
    .darksearchbox h5 {color:#fff;}
    
    .parallax {
        /* The image used */
        background-image: url("/images/cooperstown-dreams-park.jpg");
        /*background-image: url(/images/baseball-in-the-infield.jpg);*/
        /*background-image: url(/images/cooperstown-ny-baseball-field.jpg);*/
        
        /* Set a specific height */
        min-height: 400px; 

        /* Create the parallax scrolling effect */
        background-attachment: scroll; /* "fixed" will make it stick and the other content scroll */
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
        margin:0px 15px;
    }
    @media only screen and (max-device-width: 1024px) {
        .parallax {
            background-attachment: scroll;
        }
    }


    /* search form */
  .search-br span {
    color: white;
    font-size: 14px;
    margin-top: -5px;
    display: block;
  }

  .search-br li {
    list-style: none;
    padding: 4px;
    margin-top: -3px;
    display: inline-block;
  }

  .search-br label {
    display: inline-block;
    /* margin-top: -5px; */
    padding: 0px 3px;
  }
  .search-br {
    margin-bottom: -5px;
  }
  .discounted-rates {
    white-space:nowrap;
    display: block;
    text-align: left;
    color: #ffd22c;
    
    text-transform: uppercase;
    display:inline-block;
  }
  .discounted-rates i 
  {
    display:inline-block;
    font-size: 20px;
    color:#555;
    margin:0px 5px;
  }

/* special message format styling */  
.yellowBox2 {
    color: #07203f;
}

.special-message a {
    font: inherit;
    color: white;
    background-color: #07203f;
    padding: 3px 7px;
    line-height: 30px;
    border-radius: 5px;
    font-weight: normal;
}

.special-message a:hover {
    text-decoration: none;
    background-color: #124d94;
}
.yellowBox2 h1, .yellowBox2 h2, .yellowBox2 h3, .yellowBox2 h4, .yellowBox2 h5, .yellowBox2 h6, .yellowBox2 h7 {
    color: #fff;
    font-weight: bold;
    background: #082140;
    padding: 10px 20px;
    display: inline-block;
    clear: both!important;
    clear: right!important;
    margin-bottom:-7px;
}
.yellowBox2 p {
    margin: 10px;
}

/* end: special message */
  
  #ctl00_phTop_cblSearchBedrooms {min-width: 250px;white-space:nowrap} /*fix wrapping bedrooms on mobile*/

    @media only screen and (max-device-width: 400px) 
    {
      .darksearchbox, .lightearchbox {
        padding: 10px 30px 25px;
      }
      .contentBox .col-sm-9 {
          margin: 0px 15px 0px 0px;
      }
      
    }
  
</style>

</asp:Content>
<asp:Content ID="ContentTop" ContentPlaceHolderID="phTop" runat="server">
<div class="container">
    <asp:Panel ID="pnlSpecialMessage" runat="server">
    <div class="yellowBox2 special-message"><asp:Literal ID="litDefault_SpecialMessage" runat="server"></asp:Literal></div>
    </asp:Panel>
    <div class="row">
    <div class="welcomeBox" style="margin:0px 15px">
        <div class="intro" id="search">
        <asp:Literal ID="litDefault_Welcome" runat="server"></asp:Literal>
        </div>
          
    </div>
        <div class="parallax">
                
    <div class="darksearchbox">
    <h5>Find Cooperstown Lodging</h5>
        <div class="row">
            <div class="form-group col-sm-12">
                <asp:DropDownList ID="ddlSearchTournamentWeek" runat="server" cssclass="form-control">
                <asp:ListItem Value="" style="display:none;">Tournament Week</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="row">
            <div class="form-group col-sm-12">
                <asp:DropDownList ID="ddlTournamentLocation" runat="server" cssclass="form-control">
                  <asp:ListItem Value="" style="display:none;">Tournament Location</asp:ListItem>
                  <asp:ListItem Value="CDP">Cooperstown Dreams Park</asp:ListItem>
                  <asp:ListItem Value="ASV">Other</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-sm-12">
              <div class="search-br"><span>How many bedrooms?</span>
                <asp:CheckBoxList ID="cblSearchBedrooms" runat="server" CssClass="form-control" RepeatLayout="UnorderedList">
                  <asp:ListItem Value="1">1</asp:ListItem>
                  <asp:ListItem Value="2">2</asp:ListItem>
                  <asp:ListItem Value="3">3</asp:ListItem>
                  <asp:ListItem Value="4">4</asp:ListItem>
                  <asp:ListItem Value="5">5</asp:ListItem>
                  <asp:ListItem Value="6">6+</asp:ListItem>
                </asp:CheckBoxList>
                <asp:DropDownList ID="ddlSearchBedrooms" runat="server" cssclass="form-control" Visible="false">
                  <asp:ListItem Value="1">1+ BR</asp:ListItem>
                  <asp:ListItem Value="2">2+ BR</asp:ListItem>
                  <asp:ListItem Value="3">3+ BR</asp:ListItem>
                  <asp:ListItem Value="4">4+ BR</asp:ListItem>
                  <asp:ListItem Value="5">5+ BR</asp:ListItem>
                  <asp:ListItem Value="6">6+ BR</asp:ListItem>
                </asp:DropDownList>
              </div><!--/search-br-->
            </div>
            <div class="form-group col-sm-5 col-md-offset-2" style="display:none;">
              <asp:DropDownList ID="ddlSearchBaths" runat="server" cssclass="form-control">
                <asp:ListItem Value="1">1+ BA</asp:ListItem>
                <asp:ListItem Value="2">2+ BA</asp:ListItem>
                <asp:ListItem Value="3">3+ BA</asp:ListItem>
              </asp:DropDownList>
            </div>
        </div>
        <div class="row">
            <div class="form-group col-sm-12">
              <asp:DropDownList ID="ddlSearchLodgingType" runat="server" cssclass="form-control">
                <asp:ListItem Value="">Lodging Type (Any)</asp:ListItem>
                <asp:ListItem Value="6,7,8,9,11">Private Homes</asp:ListItem>
                <asp:ListItem Value="3,4">Waterfront</asp:ListItem>
                <asp:ListItem Value="13">Water Access</asp:ListItem>
                <asp:ListItem Value="1">Apartments</asp:ListItem>
                <asp:ListItem Value="5">Rooms/Suites</asp:ListItem>
                <asp:ListItem Value="15">Group Lodging</asp:ListItem>
                <asp:ListItem Value="10">Oneonta Area Lodging</asp:ListItem>
              </asp:DropDownList>
            </div>
        </div>
        <div class="row" id="rowDiscountedRates" runat="server">
            <div class="form-group col-sm-12 discounted-rates"><i class="fa fa-lg fa-info-circle"></i> Some Rates Discounted</div>
        </div>
        <div class="row">
            <div class="form-group col-xs-6">
                <input type="button" value="Search Rentals" class="btn btn-primary" id="btnSearch" onclick="DoTopSearch()" />
            </div>
            <div class="form-group col-xs-6">
              <input type="button" value="Advanced Search" class="btn btn-default" id="btnAdvSearch" onclick="DoAdvancedSearch()" />
            </div>
        </div>
    </div>
        </div>
<uc:Callout ID="ucCallout" runat="server" />
    </div>
</div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LeftSideContent" runat="Server">
  
        <asp:Literal ID="litDefault_LeftColumn" runat="server">
        </asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBodyContent" runat="Server">

        <asp:Panel ID="pnlSeasonStart" runat="server">
        <div class="yellowBox2"><asp:Literal ID="litDefault_OpeningDay" runat="server"></asp:Literal></div>
        </asp:Panel>

        <div class="before visible-xs">
          <img src="/images/ask-coach.jpg" alt="Before you begin, ask your coach which tournament you're playing in" class="responsive"/>
        </div>
        <div class="clearfix imageblock">
          <div class="col-xs-4 wrapper"> <a href="/house-rentals">
            <div class="fixOverlayDiv"> <img class="img-responsive" src="/images/lodging-types/Private-Lodging-Cooperstown.jpg" alt="Private House for Rent"/>
              <div class="OverlayText">Private Homes</div>
            </div>
            </a></div>
          <div class="col-xs-4 wrapper"> <a href="/house-rentals-on-lake<%= Session("EditModeQS") %>">
            <div class="fixOverlayDiv"> <img class="img-responsive" src="/images/lodging-types/Waterfront-Rentals-Cooperstown.jpg" alt="Lake view from a private house rental"/>
              <div class="OverlayText">Waterfront</div>
            </div>
            </a></div>
          <div class="col-xs-4 wrapper"> <a href="/apartment-rentals<%= Session("EditModeQS") %>">
            <div class="fixOverlayDiv"> <img class="img-responsive" src="/images/lodging-types/Weekly-Apartment-Rentals-Cooperstown.jpg" alt="Apartment vacation rental"/>
              <div class="OverlayText">Apartments</div>
            </div>
            </a></div>
        </div>
        <div class="clearfix imageblock">
          <div class="col-xs-4 wrapper"> <a href="/oneonta-ny-lodging<%= Session("EditModeQS") %>">
            <div class="fixOverlayDiv"> <img class="img-responsive" src="/images/lodging-types/Oneonta-Lodging-Cooperstown.jpg" alt="Home in Oneonta"/>
              <div class="OverlayText">Oneonta Area Lodging</div>
            </div>
            </a></div>
          <div class="col-xs-4 wrapper"> <a href="/rooms-suites<%= Session("EditModeQS") %>">
            <div class="fixOverlayDiv"> <img class="img-responsive" src="/images/lodging-types/Room-Suite-Rentals-Cooperstown.jpg" alt="Private room for rent"/>
              <div class="OverlayText">Rooms & Suites</div>
            </div>
            </a></div>
          <div class="col-xs-4 wrapper"> <a href="/group-lodging<%= Session("EditModeQS") %>">
            <div class="fixOverlayDiv"> <img class="img-responsive" src="/images/lodging-types/Group-Lodging-Cooperstown.jpg" alt="Group Lodging"/>
              <div class="OverlayText">Group Lodging</div>
            </div>
            </a></div>
        </div>



        <div class="findproperty visible-xs">
          <h2>Find Specific Property</h2>

          <div class="form-group">
            <input type="text" id="txtSearchXS" class="form-control propSearchBox" maxlength="30" placeholder="Property Name"/>
            <button type="button" id="btnSearchXS" class="btn-Blue" onclick="DoPropertySearch()">Find</button>
          </div>

          <p>Enter property name or address</p>
        </div>

        <div class="callUs clearfix">
            <div class="col-xs-8 hp-callout-box">
                <p>
                    Reserve Online or Call us at<br />
                    <a href="tel:6075476260">607-547-6260</a><br />
                    for personalized help.
                </p>
            </div>
            <div class="col-xs-4">
                <a href="/area-map<%= Session("EditModeQS") %>">
                    <div class="fixOverlayDiv"> <img class="img-responsive" src="/images/cooperstown-area-map.jpg" alt="Map of Weekly Rentals in Cooperstown, NY"/>
                      <div class="OverlayText">Area Map</div>
                    </div>
                </a>
            </div>
        </div>

        <div class="dreamspark clearfix">
          <div class="col-sm-6 col-xs-12" style="background-color:white!important;"><a href="http://www.cooperstowndreamspark.com/" target="_blank" rel="nofollow"><img src="/images/cooperstown-dreams-park-logo-with-slogan.jpg" width="100%" alt="Dreams of Cooperstown Dreams Park Logo"/></a></div>
          <div class="col-sm-6 col-xs-12">
            <h3>Lodging Near Cooperstown, NY</h3>
            <p class="lead">We specialize in helping youth baseball teams and their families find <strong>weekly rentals</strong> near Cooperstown,&nbsp;NY and Oneonta.</p>
            <p class="lead">We know the area. Let us help you find the best lodging close to your tournament.</p>
            <ul>
                <li>Over <strong>350 Family Rentals</strong>.</li>
                <li>Availability Charts are <strong><em>Always</em> Current</strong>.</li>
                <li><strong>Local, Knowledgeable Staff</strong> Available by Phone Monday - Saturday</li>
                <li><strong>Reserve ONLINE</strong> at any time, 24&nbsp;x&nbsp;7.</li>
            </ul>
          </div>
        </div>
        <div class="yellowBox2 visible-xs">
        Cooperstown Stay specializes in weekly rentals for Cooperstown Dreams Park families and friends.
        </div>

    <div class="callout-dark">
        <div class="testimonial">
        <p><i class="fa fa-quote-left" aria-hidden="true"></i> <asp:Literal ID="litDefault_Testimonial" runat="server"></asp:Literal>"</p>
        <p class="author"><asp:Literal ID="litDefault_TestimonialSource" runat="server"></asp:Literal> | <a href="/testimonials.aspx"> more testimonials</a></p>
        </div>
    </div>

        <div class="serve">Local, Knowledgeable Staff Ready to Serve You...</div>
        <div class="serveBottom">
        <div class="clearfix">
            <div class="col-xs-4"><img src="/images/staff/lonetta-100.jpg" width="100%" title="Lonetta Swartout" alt="Lonetta Swartout"/></div>
            <div class="col-xs-8">
                <p class="quoteText">"Lonetta is a big asset to Cooperstown. It is people like her that keep your town so special."<br/>Lance A, Laguna Niguel CA</p>
                <p class="timeCall">607-547-6260  Mon - Sat</p>
                <div class="clearfix bottomTextBox hidden-xs">
                    <asp:Literal ID="litDefault_AboutLonetta" runat="server"></asp:Literal>
                    <p style="text-align:center"> "Enjoy our Cooperstown Hospitality!"</p>
                </div>
            </div>
        </div>
        </div>
        <div class="clearfix bottomTextBox visible-xs">
                    <asp:Literal ID="litDefault_AboutLonetta2" runat="server"></asp:Literal>
                    <p style="text-align:center"> "Enjoy our Cooperstown Hospitality!"</p>
                </div>
        <div class="col-sm-12">
              <asp:Literal ID="litDefault_Bottom" runat="server"></asp:Literal>
        </div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomScripts" runat="Server">
  <script type="text/javascript">
    function DoTopSearch() {

      var sSearch = "";
      var sWeek = document.getElementById("<%=ddlSearchTournamentWeek.ClientID%>").value;
      var sPark = document.getElementById("<%=ddlTournamentLocation.ClientID%>").value;
      if (sWeek + sPark == "") { alert("You must pick a Tournament Week and Location"); }
      else if (sWeek == "") { alert("You must pick a Tournament Week"); }
      else if (sPark == "") { alert("You must pick a Tournament Location"); }
      else {
        var sLodging = document.getElementById("<%=ddlSearchLodgingType.ClientID%>").value;
        var sBeds = GetCheckboxListValues("<%=cblSearchBedrooms.ClientID%>").replace("+", "");
        var sBaths = "1"; //var sBaths = document.getElementById("<%=ddlSearchBaths.ClientID%>").value;
        var sLocation = document.getElementById("<%=ddlTournamentLocation.ClientID%>").value;

        var sURL = "/Properties.aspx?Search=True&Term=" + encodeURI(sSearch) + "&Week=" + encodeURI(sWeek) + "&Lodging=" + encodeURI(sLodging) + "&Beds=" + encodeURI(sBeds) + "&Baths=" + encodeURI(sBaths) + "&Location=" + encodeURI(sLocation);
        window.location = sURL
      }
    }


    function DoAdvancedSearch() {

      var sSearch = "";
      var sWeek = document.getElementById("<%=ddlSearchTournamentWeek.ClientID%>").value;
      var sLocation = document.getElementById("<%=ddlTournamentLocation.ClientID%>").value;
      var sBeds = GetCheckboxListValues("<%=cblSearchBedrooms.ClientID%>").replace("+", "");
      var sLodging = document.getElementById("<%=ddlSearchLodgingType.ClientID%>").value;
      var sURL = "<%= MyUtils.GetAppSetting("ReservationWebsite") %>/Search.aspx?FromQS=True&QSWeek=" + encodeURI(sWeek) + "&QSBeds=" + encodeURI(sBeds) + "&QSLocation=" + encodeURI(sLocation) + "&QSLodging=" + encodeURI(sLodging);
        window.location = sURL
    }

    function GetCheckboxListValues(sElementId) {
      var sValues = [];
      $('#' + sElementId + ' input:checked').each(function () {
        sValues.push($("label[for='" + this.id + "']").text());
      });

      return sValues.join(",");

    }



  </script>
  <%=MyUtils.SetGoogleAdwordsConversionCode(Page, "1036267566", "jmZWCMKVggEQruCQ7gM")%>
</asp:Content>
