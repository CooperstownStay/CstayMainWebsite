<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/MasterProperty.master" CodeFile="Details.aspx.vb" MaintainScrollPositionOnPostback="true" Inherits="Details" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <asp:Literal ID="litTitle" runat="server" />
  <meta name="keywords" content="<%=Session("DetailsPropertyKeywords") %>" />
  <meta name="description" content="<%=Session("DetailsPropertyDescription") %>" />
  <asp:Literal runat="server" ID="litCanonicalPageLink" ></asp:Literal>
  <asp:Literal runat="server" ID="litOpenGraphTags" ></asp:Literal>

  <!-- COPIED FROM PROPERTIES.ASPX ------------------------------------------------------------------------------------>
  <style type="text/css">
 
    .btn-more-info
    {
        background: #aeb9dd;
        color: #fff;
        display: inline-block;
        font-size: 14px;
        font-weight: bold;
        padding: 6px 10px;
        text-decoration: none;
        margin-top:70px;
    }
    
    .property-photo img 
    {
        width:100%;
        z-index:0;
    }
    
    img.view-more-photos {
        position: absolute;
        z-index: 1;
        top: 0px;
        left:0px;
    }
    
    .property-photo {
        height:100%; /*height: 250px;*/
        max-height: 450px;
        overflow-y: hidden;
    }
    
    .property-detail-btn {
        background: #ffd22c;
        color: #333!important;
        text-decoration: none;
        display: inline-block;
        padding: 8px 15px;
        margin: -47px 10px 0px 0px;
        text-transform: uppercase;
        float: right;
        font-weight: bold;
    }
    a.btn.property-detail-btn:hover {
        background-color: #ECB700;
    }
    .property-price {
        margin-top: -50px;
        display: block;
        padding: 10px 20px;
        color: #fff;
        font-size: 19px;
    }
    
    .property-photo:after {
        content: "";
        display: block;
        height: 60%;
        width: 100%;
        position: absolute;
        left: 0;
        bottom: 0;
        right: 0;
        background-image: -webkit-linear-gradient(top, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-image: -o-linear-gradient(top, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-image: -webkit-gradient(linear, left top, left bottom, from(transparent), to(rgba(0,0,0,0.7)));
        background-image: -moz-linear-gradient(top, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-image: linear-gradient(to bottom, transparent 0%, rgba(0,0,0,0.7) 100%);
        background-repeat: repeat-x;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00000000', endColorstr='#B3000000', GradientType=0);
    }
    
    .prop-br, .prop-ba, .prop-sleeps {
        font-size: 15px;
        font-weight: bold;
        display: inline-block;
        padding: 0px 10px 10px 0px;
    }
    .prop-dist {
        font-size: 12px;
        padding-top: 3px;
    }
    
    
    .prop-meta {padding: 15px 15px 15px 30px;}
    
    .prop-dist span {
        display: inline-block;
        width: 40px;
        text-align: center;
        background-color: #fff;
        margin-right: 3px;
        font-weight:bold;
    }

    .PropHold {background-color:#669966;}
        
    .propertyBox h1 
    {
        padding: 15px 10px;
        text-align: center;
        display: block;
        background: #334377;
        color: #fff;
        font-size: 1.5em;
        margin: 10px 0px 0px;
    }
    
    .tab-pane {
        background-color: #f6f7fc;
        margin-top: 0px;
        padding: 20px 0px 0px;
    }
    
    .tab-content>.active {
        padding: 15px;
        min-height: 100px;
        color:#000;
        font-size:15px;
    }
    
    #mobile-rates td, #mobile-rates th {font-size: 12px;}
    #RATES td, #RATES th {font-size: 13px;}
    
    
    
    div#AVAILABILITY {padding:15px 0px;}
    
    .rate-discounted {
        color: red;
    }
 
    a.btn-rates-avail {
        background: green;
        padding: 4px 6px;
        border-radius: 3px;
        color: #fff;
        font-weight: normal!important;
        font-size: 15px;
    }
    a.btn-rates-avail:hover {
        background: darkgreen;
    }
    
    H3.ImageSectionTitle {font-weight: normal;}
    
    @media (max-width: 767px){
        .row {margin-right: 0px;margin-left: 0px;}
    
        .prop-meta {padding: 15px;}
    }
    
    /*
    @media (max-width: 767px)
    {
      .gallery1FirstImage {
          display: none;
      }
    }
    */
    
    .click4more {
        display: inline-block;
        margin-top: 30px;
        text-align: center;
    }
    .click4more a.btn.btn-xs.btn-info {
        margin: 3px 0px;
    }
    
    /* prop-special for waterfront */
    
    .propertyBox .prop-special {
        display: block;
        background-color: #F2D46F;
        padding: 3px 3px;
        text-align: center;
        font-weight: bold;
    }
    
    .rightbox .details {text-align: right;margin-right: 30px;} /* removed other buttons - photos,reviews - so pushed this to the right */
    
    /**** Styles for amenities expand/collapse ***/
    
    
        .extra button:after {
            font-family:'FontAwesome';
            content:"\f068";
            float: right;
            color: #000;
        }
        .extra button.collapsed:after {
            content:"\f067";
        }
        
        .extra button {display:block;}
        
        .extra button.btn.btn-link {
            display: block!important;
            width: 100%;
            text-align: left;
            background-color: #f2f2f2;
            font-weight: bold;
            color: #000;
            margin: 10px 0px;
        }
        .extra button.btn.btn-link:hover {background-color:#e2e2e2;text-decoration:none;}
        
        .btn-link:focus, .btn-link:active, .btn-link:hover {outline: none!important;text-decoration:none;}
 
        .row.detail-addr {
            background-color: #f6f7fc;
            margin: 0px;
        }
        .feat-key .row {
            margin-bottom: 10px!important;
        }

    /*** end: amenities */
  </style>
  <!-- END: COPIED FROM PROPERTIES.ASPX ------------------------------------------------------------------------------------>

  <style type="text/css">
     div#DETAILS {font-family: arial!important;}
      .note-text label {font-weight: bold;color:rgb(204, 0, 0);text-transform: uppercase;font-size: 11px;font-family:arial black,arial,verdana;}
      .note-text p {font-size: 11px;}
      
    .feat-key-value {
      font-size: 15px;
      padding: 5px;
    }
       
    .search-buttons {
        margin: 20px 0px;
        background-color: #eee;
        padding: 20px;
    }
    
    #lnkShare i.fa.fa-share-alt {
      display: inline-block;
      margin: -3px 4px -4px 4px;
      color: white;
    }

    #lnkShare span {
      float: left;
      margin-right: 5px;
    }
    
    @media (max-width: 991px){
        #lnkShare span {display:none;}
        .nav > li > a {padding: 10px 10px!important;}
        #lnkShare i.fa.fa-share-alt {color: #334377;}
    }
  </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="LeftSideContent" runat="Server">
  <!----------------------------------------- NEW -->
  <!-- LEFT CONTENT -->

  <div class="rightMAinSecBox LestMAinSecBox">
    <div class="MorePropertyPhotosHED MorePropertyPhotosHED2">Property Photos</div>
    <ul class="enlarge2">
      <!--left side column Start-->
      <asp:Literal ID="litExteriorImages" runat="server"></asp:Literal>





    </ul>

  <hr />
  <div class="extra">
    <div class="StandardAmenities" >
    <h4>Standard Amenities</h4>
    <asp:Literal ID="litStandardAmenities" runat="server"></asp:Literal></div>
  </div>

    <!--left side column End-->
  </div>
  <!-- /LEFT CONTENT -->
  <!-- /NEW ----------------------------------------->

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainBodyContent" runat="Server">
<div class="search-buttons" id="divSearchNav" runat="server" visible="false">
    <a href="#" class="btn btn-success" onclick="window.history.back(1); return false;" runat="server" id="lnkBack">Back to Search Results</a>
    <a href="#" class="btn btn-success" onclick="window.close();" runat="server" id="lnkClose">Close</a>
    <a href="/?ModifySearch=True" class="btn btn-primary" runat="server" id="lnkModfiy">Modify Search</a>
    <a href="/" class="btn btn-default" runat="server" id="lnkNewSearch">New Search</a>
</div>

  <!----------------------------------------- NEW -->

  <div class="mainHEdDet">
    <asp:Literal ID="litCategoryTitle" runat="server" /></div>

<%--  ************************************************************ BELOW IS TO MAKE DETAIL LOOK LIKE LIST PAGE ******************************************************************  --%>


<!-- hidden xs and sm -->
<div class="propertyBox hidden-xs hidden-sm">
<h1><asp:Literal ID="litPropertyName" runat="server" /></h1>
<div class="propertyImg">
    <div class="clearfix"><asp:Literal ID="litPropertySpecial" runat="server"/><asp:Literal ID="litMasterImage" runat="server" />
        <div class="col-xs-7">
            <div class="property-price <%= GetDiscounted() %>">$<asp:Literal ID="litRate" runat="server" /></div>
        </div>
        <div class="col-xs-5"><a class="btn property-detail-btn" href="#" data-toggle="modal" data-target=".avail-cal">BOOK RENTAL</a></div>
        <asp:Literal runat="server" ID="litDiscountedCode" />
    </div><!--/row-->
</div><!--/propertyImg-->
<div class="rightbox">
<div class="clearfix">
<div class="counder">
<ul>
 <li>BR <span><asp:Literal ID="litBR" runat="server" /></span></li>
 <li>BA <span><asp:Literal ID="litBA" runat="server" /></span></li>
 <li>Sleeps <span><asp:Literal ID="litSleeps" runat="server" /></span></li>
</ul>
<asp:Literal ID="litPropertyCategory" runat="server" />
</div><!--/counder-->
</div><!--/clearfix-->
<div class="distancepark">
<h2>miles to tournament</h2>
<div class="prop-dist"><span><asp:Literal ID="litDistToDP" runat="server" /></span> mi to <strong>Dreams Park</strong></div>
<div class="prop-dist"><span><asp:Literal ID="litDistToBW" runat="server" /></span> mi to <strong>Baseball World</strong></div>
<div class="prop-dist"><span><asp:Literal ID="litDistToAV" runat="server" /></span> mi to <strong>All Star Village</strong></div>
</div><!--/distancepark-->
</div><!--/rightbox-->
&nbsp;

<!-- Description and calendar were here -->

</div><!--/ hidden xs and sm -->

<!-- visible xs and sm -->

<div class="propertyBox visible-xs visible-sm">
<h1><asp:Literal ID="litMobilePropertyName" runat="server" /></h1>
    <div class="clearfix"><asp:Literal ID="litMobilePropertySpecial" runat="server"/><asp:Literal ID="litMobileMasterImage" runat="server" />
    <div class="col-xs-7">
            <div class="property-price <%= GetDiscounted() %>">$<asp:Literal ID="litRateMobile" runat="server" /></div>
        </div>
        <div class="col-xs-5">
            <a class="btn property-detail-btn" href="#" data-toggle="modal" data-target=".avail-cal">BOOK RENTAL</a>
        </div>
        <asp:Literal runat="server" ID="litDiscountedCodeMobile" />
    </div><!--/row-->
    <div class="row clearfix">
        <div class="col-xs-7 prop-meta">
            <span class="prop-br"><asp:Literal ID="litMobileBR" runat="server" />br</span>
            <span class="prop-ba"><asp:Literal ID="litMobileBA" runat="server" />ba</span>
            <span class="prop-sleeps">Sleeps <asp:Literal ID="litMobileSleeps" runat="server" /></span>
            <div class="prop-dist"><span><asp:Literal ID="litMobileDistToDP" runat="server" /></span> mi to <strong>Dreams Park</strong></div>
            <div class="prop-dist"><span><asp:Literal ID="litMobileDistToBW" runat="server" /></span> mi to <strong>Baseball World</strong></div>
            <div class="prop-dist"><span><asp:Literal ID="litMobileDistToAV" runat="server" /></span> mi to <strong>All Star Village</strong></div>
        </div><!--/col-->
        <div class="col-xs-4 click4more">
<strong>For Help</strong><br><a class="btn btn-xs btn-info" href="tel:6075476260">Call 607-547-6260</a> or <a class="btn btn-xs btn-info"  target="_blank" href="/contact?p=" id="lnkSubmitQuestion" runat="server">Email Us</a>
        </div>
    </div><!--/row-->
</div>

<!-- /visible xs and sm -->

<div class="row detail-addr">
  <div class="col-xs-6 detaddresSec">
    <asp:Literal ID="litAddress" runat="server" /><br />
    <span>GPS:
      <asp:Literal ID="litGPS" runat="server" /></span>

      
        <!--div class="mainToeBTNMap">
          <div class="col-sm-6">
            <div class="mapBatn">
              <asp:Literal ID="litAreaMap" runat="server" /></div>
          </div>
          <div class="col-sm-6">
            <div class="mapBatn">
              <asp:Literal ID="litGoogleMap" runat="server" /></div>
          </div>
          <div style="clear: both;"></div>
        </div-->

  </div>

  <div class="col-xs-6 ">
  
    <!-- remove maindetstar b/c Lonetta said showing the stars may be an issue since some properties are new and won't have any stars -->
      <div class="maindetstar">
        <div class="col-sm-8">
          <asp:Literal ID="litReviewsRating" runat="server" />
        </div>
        <div class="col-sm-4">
          <div class="reviewsBox mobileHide"><a href="#TabScroll" onclick="$('a[href=\'#REVIEWS\']').trigger('click'); scrollToAnchor('TabScroll'); return false;" data-toggle="tab">
            <asp:Literal ID="litReviewsCount" runat="server" /></a></div>
          <div class="reviewsBox mobileshow"><a href="#MobileTabScroll" onclick="$('a[href=\'#mobile-reviews\']').trigger('click'); scrollToAnchor('MobileTabScroll'); return false;" data-toggle="tab">
            <asp:Literal ID="litMobileReviewsCount" runat="server" /></a></div>
        </div>
        <div style="clear: both;"></div>
      </div><!--/maindetstar-->

      <asp:Literal ID="litAmenitiesList" runat="server" />
      <ul class="iconUL">
        <li <%=Details.sDisplayWheelchairIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/wheelchair.jpg" alt="Wheelchair Access" title="Wheelchair Access"/></a></li>
        <li <%=Details.sDisplayWaterfrontIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/waterfront.jpg" alt="Waterfront" title="Waterfront"/></a></li>
        <li <%=Details.sDisplayACIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/ac.jpg" alt="Air Conditioning" title="Air Conditioning"/></a></li>
        <li <%=Details.sDisplayWasherDryerIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/washerdryer.jpg" alt="Washer/Dryer" title="Washer/Dryer"/></a></li>
        <li <%=Details.sDisplayDishwasherIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/dishwasher.jpg" alt="Dishwasher" title="Dishwasher"/></a></li>
        <li <%=Details.sDisplayPhoneIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/phone.jpg" alt="Telephone" title="Telephone"/></a></li>
        <li <%=Details.sDisplayInternetIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/internet.jpg" alt="Broadband Internet" title="Broadband Internet"/></a></li>
        <li <%=Details.sDisplayWifiIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/wifi.jpg" alt="Wi-Fi Internet" title="Wi-Fi Internet"/></a></li>
        <li <%=Details.sDisplayTVIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/tv.jpg" alt="Cable/Satellite TV" title="Cable/Satellite TV"/></a></li>
        <li <%=Details.sDisplayDvdIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/dvd.jpg" alt="DVD Player" title="DVD Player"/></a></li>
        <li <%=Details.sDisplayWateraccessIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/wateraccess.jpg" alt="Water Access" title="Water Access"/></a></li>
        <li <%=Details.sDisplayPoolIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/pool.jpg" alt="Pool" title="Pool"/></a></li>
        <li <%=Details.sDisplayPartiesIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/parties.jpg" alt="Team Parties" title="Team Parties" /></a></li>
        <li <%=Details.sDisplayGrillIcon%>><a href="#" data-toggle="modal" data-target=".feat-key">
          <img src="/images/features/grill.jpg" alt="BBQ Grill" title="BBQ Grill"/></a></li>
      </ul>
      <div style="clear: both;"></div>
    </div><!--/mainiconWhiteSec-->

</div>
<div class="questionbox clearfix hidden-xs hidden-sm" style="padding-bottom:0px"><h2>For Help: <a class="btn btn-xs btn-info" href="tel:6075476260">Call 607-547-6260</a> or <a class="btn btn-xs btn-info" target="_blank" href="/ContactUs.aspx?p=" id="lnkSubmitQuestion3" runat="server">Email Us</a></h2></div><!--/questionbox-->
  <div class="">
    <a id="TabScroll" name="TabScroll"></a>

    <ul id="myTab" class="nav nav-tabs">
      <li><a href="#" class="avail-tab" data-toggle="modal" data-target=".avail-cal">AVAILABILITY</a></li>
      <li class="active"><a href="#DETAILS" data-toggle="tab">DETAILS</a></li>
      <li runat="server" id="liRatesTab" visible="false"><a href="#RATES" data-toggle="tab">RATES</a></li>
      <li><a href="#REVIEWS" data-toggle="tab">REVIEWS</a></li>
      <li><a href="#MAPS" data-toggle="tab">MAPS</a></li>
      <li><a href="#SHARE" data-toggle="tab" id="lnkShare"><span>SHARE</span> <i class="fa fa-share-alt" aria-hidden="True" title="share this rental property"></i></a></li>
    </ul>
    <div id="myTabContent" class="tab-content">
      <div class="tab-pane fade in active" id="DETAILS">
        <!-- DETAILS-->
        <asp:Literal ID="litDetails" runat="server" />
        <div class="note-text">
          <div class="col-xs-1"><label>Note</label></div>
          <div class="col-xs-11"><asp:Literal ID="litDamageDepositWarning" runat="server"></asp:Literal></div>
        </div>
        <!--/DETAILS-->
        <!--accordion end-->
      </div>
      <div class="tab-pane fade in active" id="RATES">
        <asp:Literal ID="litRates" runat="server" />
      </div>
      <div class="tab-pane fade" id="REVIEWS">
        <!-- REVIEWS-->
        <asp:Literal ID="litReviews" runat="server" />
        <!--/REVIEWS-->
        <!--accordion end-->
      </div>
      <div class="tab-pane fade" id="MAPS">
        <div class="mappDettab">
          <asp:Literal runat="server" ID="litGoogleMapEmbed"/>
        </div>

        <!--accordion end-->
      </div>
      <div class="tab-pane fade" id="SHARE">
      <p>Use the buttons below to share this property</p>
      <asp:Literal runat="server" ID="litAddThis" />
      </div>
    </div>
  </div>
  <div class="mobileshow tab">
    <a id="MobileTabScroll" name="MobileTabScroll"></a>
    <!--only for mobile start-->
    <ul id="myTab2" class="nav nav-tabs">
      <li><a href="#" class="avail-tab" data-toggle="modal" data-target=".avail-cal"><i class="fa fa-calendar" aria-hidden="true"></i></a></li>
      <li class="active"><a href="#mobile-info" data-toggle="tab"><i class="fa fa-info-circle" aria-hidden="true"></i></a></li>
      <li runat="server" id="liMobileRatesTab" visible="false"><a href="#mobile-rates" data-toggle="tab"><i class="fa fa-list" aria-hidden="true"></i></a></li>
      <li><a href="#mobile-reviews" data-toggle="tab"><i class="fa fa-comment" aria-hidden="true"></i></a></li>
      <li><a href="#mobile-maps" data-toggle="tab"><i class="fa fa-map" aria-hidden="true"></i></a></li>
      <li class="gallery-item"><asp:Literal runat="server" ID="litMobilePhotoButton" /></li>
      <li><a href="#mobile-share" data-toggle="tab"><i class="fa fa-share-alt" aria-hidden="True" title="share this rental property"></i></a></li>
    </ul>
    <div id="myTabContent2" class="tab-content">
      <div class="tab-pane fade in active" id="mobile-info">
        <asp:Literal ID="litMobileDetails" runat="server" />
        <div class="note-text">
          <label>Note</label>
          <div><asp:Literal ID="litDamageDepositWarningMobile" runat="server"></asp:Literal></div>
        </div>
        <div class="extra">
        <button type="button" class="btn btn-link collapsed" data-toggle="collapse" data-target="#amenities">Standard Amenities</button>
        <div id="amenities" class="collapse"><div class="StandardAmenities" ><asp:Literal ID="litStandardAmenitiesMobile" runat="server"></asp:Literal></div></div>
        </div>
        <!--accordion end-->
      </div>
      <div class="tab-pane fade" id="mobile-rates">
        <asp:Literal ID="litMobileRates" runat="server" />
        <!--accordion end-->
      </div>
      <div class="tab-pane fade" id="mobile-reviews">
        <asp:Literal ID="litMobileReviews" runat="server" />
        <!--accordion end-->
      </div>
      <div class="tab-pane fade clearfix" id="mobile-maps">
        <asp:Literal ID="litMobileMaps" runat="server" />
        <!--accordion end-->
      </div>
      <div class="tab-pane fade clearfix" id="mobile-share">
        <p>Use the buttons below to share this property</p>
        <asp:Literal ID="litMobileShare" runat="server" />
        <!--accordion end-->
      </div>
    </div>
  </div>
  <div class="mobileshow" style="display:none;">
    <div class="detlsImgBottomSecmain">
      <div class="detaddresSec">
        <asp:Literal ID="litMobileAddress" runat="server" /><br />
        <span>GPS:
          <asp:Literal ID="litMobileGPS" runat="server" /></span>
      </div>
      <div style="clear: both;"></div>
      <div style="clear: both;"></div>
      <div class="mainToeBTNMap">

        <div class="mapBatn">
          <asp:Literal ID="litMobileAreaMap" runat="server" /></div>

        <div class="mapBatn">
          <asp:Literal ID="litMobileGoogleMap" runat="server" /></div>

        <div style="clear: both;"></div>
      </div>
    </div>
  </div>
  <!--only for mobile End-->
  <div class="row" style="padding:20px 0px 0px">
  <div class="col-xs-5 text-right"><a href="#" class="btn btn-sm btn-primary" data-toggle="modal" data-target=".avail-cal">BOOK NOW</a></div>
  <div class="col-xs-5 col-xs-offset-2 text-left"><a href="#" class="btn btn-sm btn-primary" data-toggle="modal" data-target=".avail-cal">AVAILABILITY</a></div>
  </div>
   
  <div class="questionbox clearfix">
  <h2>Questions?  Looking for Something in Particular?</h2>
  <p>For assistance, call <a href="tel:6075476260">607-547-6260</a> or <a href="/contact?p=" id="lnkSubmitQuestion2" runat="server">send us an email</a></p>
  </div><!--/questionbox-->
  
  <asp:Literal ID="litContact" runat="server"></asp:Literal>

  <!--- /NEW --------------------------------------->
  <asp:Panel ID="pnlRedwoodInnMap" runat="server">
    <a id="RedwoodInnMap"></a>
    <br />
    <a href="/images/cstay-map-redwood-inn.pdf" target="_blank" title="View enlarged PDF" alt="View enlarged PDF"><b>View/Print Enlarged PDF Version</b><br />
      <br />
      <img src="/images/cstay-map-redwood-inn.jpg" alt="Map of Redwood Inn Rentals in Cooperstown, NY" style="width: 100%; border: 0px;" /></a>

  </asp:Panel>

  <asp:Panel ID="pnlHomeRunCabinsMap" runat="server">

    <a name="HomeRunCabinsMap"></a>
    <br />
    <a href="/images/home-run-cabins-map.pdf" target="_blank" title="View enlarged PDF" alt="View enlarged PDF"><b>View/Print Enlarged PDF Version</b><br />
      <br />
      <img src="/images/home-run-cabins-map.jpg" alt="Map of Home Run Rental Cabins in Cooperstown, NY" style="width: 100%; border: 0px;" /></a>

  </asp:Panel>
  <asp:Panel ID="pnlCreeksideCottagesMap" runat="server">
    <a name="CreeksideCottagesMap"></a>
    <br />
    <a href="/images/creekside-cottages-map.pdf" target="_blank" title="View enlarged PDF" alt="View enlarged PDF"><b>View/Print Enlarged PDF Version</b><br />
      <br />
      <img src="/images/creekside-cottages-map.jpg" alt="Map of Creekside Cottage rentals in Cooperstown, NY" style="width: 100%; border: 0px;" /></a>
  </asp:Panel>
  <div class="modal fade avail-cal">
  <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h4 class="modal-title" id="H3">Rental Availability Calendar</h4>
        </div>
        <div class="modal-body">
          <asp:Literal ID="litAvailabilityModal" runat="server" />
        </div><!--modal-body-->
        <div class="modal-footer">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="float:none;">close</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!--/modal-dialog-->
  </div><!--/modal-->
  
  <div class="modal fade feat-key">
  <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h4 class="modal-title" id="H1">Features Key</h4>
        </div>
        <div class="modal-body">
          


          
          <div class="row">
            <div class="col-sm-6">
            
                  <div class="row" <%=Details.sDisplayWheelchairIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/wheelchair.jpg" alt="Wheelchair Access" title="Wheelchair Access" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Wheelchair Accessible</div>
                  </div>
                  <div class="row" <%=Details.sDisplayWaterfrontIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/waterfront.jpg" alt="Waterfront" title="Waterfront" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Waterfront</div>
                  </div>
                  <div class="row" <%=Details.sDisplayACIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/ac.jpg" alt="Air Conditioning" title="Air Conditioning" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Air Conditioning</div>
                  </div>
                  <div class="row" <%=Details.sDisplayWasherDryerIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/washerdryer.jpg" alt="Washer/Dryer" title="Washer/Dryer" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Washer/Dryer</div>
                  </div>
                  <div class="row" <%=Details.sDisplayDishwasherIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/dishwasher.jpg" alt="Dishwasher" title="Dishwasher" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Dishwasher</div>
                  </div>
                  <div class="row" <%=Details.sDisplayPhoneIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/phone.jpg" alt="Telephone" title="Telephone" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Telephone</div>
                  </div>
                  <div class="row" <%=Details.sDisplayInternetIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/internet.jpg" alt="Broadband Internet" title="Broadband Internet" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Broadband Internet</div>
                  </div>
            </div>
          
            <div class="col-sm-6">
            
                  <div class="row" <%=Details.sDisplayWifiIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/wifi.jpg" alt="Wi-Fi Internet" title="Wi-Fi Internet" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Wi-Fi Internet</div>
                  </div>
                  <div class="row" <%=Details.sDisplayTVIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/tv.jpg" alt="Cable/Satellite TV" title="Cable/Satellite TV" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Cable/Satellite TV</div>
                  </div>
                  <div class="row" <%=Details.sDisplayDvdIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/dvd.jpg" alt="DVD Player" title="DVD Player" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">DVD Player</div>
                  </div>
                  <div class="row" <%=Details.sDisplayWateraccessIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/wateraccess.jpg" alt="Water Access" title="Water Access" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Water Access</div>
                  </div>
                  <div class="row" <%=Details.sDisplayPoolIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/pool.jpg" alt="Pool" title="Pool" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Pool</div>
                  </div>
                  <div class="row" <%=Details.sDisplayPartiesIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/parties.jpg" alt="Team Parties" title="Team Parties" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">Team Parties</div>
                  </div>
                  <div class="row" <%=Details.sDisplayGrillIcon%>>
                    <div class="col-xs-3 text-right"><img src="/images/features/grill.jpg" alt="BBQ Grill" title="BBQ Grill" /></div>
                    <div class="col-xs-8 col-xs-offset-1 text-left feat-key-value">BBQ Grill</div>
                  </div>
            </div>
          </div>

          

        </div><!--modal-body-->
        <div class="modal-footer">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="float:none;">close</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!--/modal-dialog-->
  </div><!--/modal-->
</asp:Content>
<asp:Content ContentPlaceHolderID="RightSideContent" ID="content5" runat="server">

  <!----------------------------------------- NEW -->
  <!---- RIGHT COLUMN -->


  <div class="MorePropertyPhotosHED">More Property Photos</div>
  <div>
    <!--btnTakeOffline-->
    <asp:Button ID="btnTakeOffline" CssClass="CloseButtons" Font-Size="10px" runat="server" Visible="false" Text="Go Offline" />
    <!--btnDeleteAllImages-->
    <asp:Button ID="btnDeleteAllImages" CssClass="CloseButtons" OnClientClick="return confirm('Are you sure you want to delete ALL the images for this property?');" Font-Size="10px" runat="server" Text="Del Images" />
    <!--lblDeleteImagesResult-->
    <asp:Label ID="lblDeleteImagesResult" ForeColor="Red" Font-Size="14px" Font-Bold="true" runat="server" Text=""></asp:Label>
  </div>
  <ul class="enlarge">
    <!--litInteriorImages-->
    <asp:Literal ID="litInteriorImages" runat="server"></asp:Literal></ul>
  <!-- /RIGHT COLUMN -->
  <!-- /NEW ----------------------------------------->


</asp:Content>
<asp:Content ID="Content41" ContentPlaceHolderID="BottomScripts" runat="Server">

  <script type="text/javascript" src="/jquery/nivo-lightbox.min.js"></script>
  <script type="text/javascript" src="/jquery/custom.js"></script>

  <script type="text/javascript" charset="utf-8">
    // BJR TODO - is this obsolete?

    // Enlarged ImagePopup

      this.imagePreview = function ()
      {
        /* CONFIG */
        xOffset = 550;
        yVal = 0;
        yOffset = 200;
        yValComp = 10;

        // these 2 variable determine popup's distance from the cursor
        // you might want to adjust to get the right result

        /* END CONFIG */
        $("a.preview").hover(function (e)
        {
          //        alert(this.rel)
          xOffset = 550
          if (this.rel == "Left")
          {
            xOffset = -50
          }
          //alert(e.screenX + " - " + e.screenY + " - " + e.pageX + " - " + e.pageY + " - " + e.clientX + " - " + e.clientY)
          //this.t = e.screenX + " - " + e.screenY + " - " + e.pageX + " - " + e.pageY + " - " + e.clientX + " - " + e.clientY
          this.t = this.title;
          this.title = "";
          var c = (this.t != "") ? "<div id='PreviewTitle' >" + this.t + "</div>" : "";
          //          var c = (this.t != "") ? "<br/>" + this.t : "";
          yVal = e.clientY - yOffset;
          if (yVal <= yValComp) { yVal = yValComp }
          sAppend="<div id='preview'><img src='" + this.href + "' alt='Image preview' />" + c + "</div>";
          $("body").append(sAppend);
          //alert(sAppend)
          $("#preview")
			.css("top", yVal + "px")
			.css("left", (e.pageX - xOffset) + "px")
			.fadeIn("fast");
        },





	function ()
	{
	  this.title = this.t;
	});
        $("a.preview").mouseout(function (e)
        {
          $("#preview").remove();
        });
      };


    function ChangeSectionTitle(iPropID, iGroupID, iImageID, sTitleLocation) {
      var sNewTitle = prompt("What is the new title you want to use for this Section?", "")
//      if (sNewTitle && sNewTitle != "") {
        var sURL = "Details.aspx?EditType=EditSectionTitle&PropID=" + iPropID + "&GroupID=" + iGroupID + "&ImageID=" + iImageID + "&NewTitle=" + encodeURIComponent(sNewTitle) + "&NewTitleLocation=" + sTitleLocation
        document.location.href = sURL
//      }
    }
    function ChangeSectionSequence(iPropID, iGroupID, iImageID) {
      var sNewSeq = prompt("In what sequence # do you want this Section to appear?", "")
      if (sNewSeq && sNewSeq != "" ) {
        var sURL = "Details.aspx?EditType=EditSectionSequence&PropID=" + iPropID + "&GroupID=" + iGroupID + "&ImageID=" + iImageID + "&NewSeq=" + sNewSeq
        document.location.href = sURL
      }
    }

  </script>

  <script type="text/javascript" language="javascript">

    // HACK this is a hack fix to prevent user from seeing master image twice when clicking image tab on mobile version.
    $(document).ready(function () {
      SetFirstImageVisibility();
      $(window).resize(function () {
        SetFirstImageVisibility();
      });
    });

    function SetFirstImageVisibility() {
        if ($(window).width() > 450) {
          //for some reason, setting it back even on first load on desktop causes lightbox not to work on desktop... so commenting out for now. If anyone goes from small screen to large screen, lightbox will not work.
          /*
          var sOld;
          sOld = $(".gallery1FirstImage").parent().html();
          $(".gallery1FirstImage").replaceWith(sOld.replace("gallery3", "gallery1"));
          */
          
        } else {
          var sOld;
          sOld = $(".gallery1FirstImage").parent().html();
          //alert(sOld);
          $(".gallery1FirstImage").replaceWith(sOld.replace("gallery1", "gallery3"));
        }
      }

      // END: HACK 


  </script>
  <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5bae70daa1bb6efc"></script>
</asp:Content>
