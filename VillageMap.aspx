<%@ Page Title="Village Map" Language="VB" MasterPageFile="~/MasterMinimal.master" AutoEventWireup="false" CodeFile="VillageMap.aspx.vb" Inherits="VillageMap" MetaDescription="Interactive Map of Lodging in Cooperstown, NY with Links to view more info about the Rentals and their Availability." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <title>Cooperstown Stay Village Map | Cooperstown Stay</title>
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/village-map" />
  <meta name="keywords" content="Cooperstown, Cooperstown, Cooperstown NY, Cooperstown rental homes, Cooperstown lodging, Cooperstown vacation rentals, Cooperstown accommodations, Cooperstown lodging, rentals in Cooperstown, lodging in Cooperstown, accomodations, rentals, weekly rentals, lodging, vacation rentals, Cooperstown Dreams Park, Dreams Park, Dreamspark, lodging for Cooperstown Dreams Rark families, Cooperstown Baseball World, Baseball World, Oneonta, NY, Baseball Hall of Fame, private homes, Cooperstown rentals, stay, apartments, waterfront, lakeside cottages, Otsego County Chamber of Commerce, Cooperstown Chamber, Lonetta, Lonetta Swartout">
  <meta name="description" content="Looking for Lodging near Cooperstown, NY?  Use our interactive rentals map with links to view more info about the rentals in Cooperstown and their availability. Or, call 607-547-6260 for personal assistance from knowledgeable staff that live in Cooperstown.">
  <link href="Styles/Maps.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" runat="Server">
  <script src="/jquery/jquery.scrollTo.js" type="text/javascript"></script>
  <script src="/Scripts/Maps.js" type="text/javascript"></script>
  <script src="/scripts/rwdImageMaps.js" type="text/javascript"></script>

  <script type="text/javascript">

    // BJR Todo - eventually figure out how to include this in Maps.js and have it still function
    //  This code is duplicated in AreaMap.aspx

    $(document).ready(function () {

      iOrigImgHeight = parseFloat($("#MapImage").attr("height"))
      iOrigImgWidth = parseFloat($("#MapImage").attr("width"))
      iPegHeight = 30
      iPegWidth = 20
      iOrigMapControlTop = parseInt($(".map-control").css("top"))
      iOrigMapKeyTop = parseInt($(".map-key").css("top")) 

      $("area").each(function (iIndex, eArea) {
        $(eArea).attr("origCoords", $(eArea).attr("coords"))
        $(eArea).attr("title", $(eArea).attr("alt"))
      });

      //      var oPropArr = jQuery.parseJSON($("#<%=hidPropertiesToMark.ClientID%>").attr("value"))
      var oHidProp = $("#<%=hidPropertiesToMark.ClientID%>").attr("value");
      var oPropArr = null;
      if (oHidProp) oPropArr = jQuery.parseJSON($("#<%=hidPropertiesToMark.ClientID%>").attr("value"));
      if (oPropArr) {
///                          alert($("#<%=hidPropertiesToMark.ClientID%> ").attr("value") + " : " + oPropArr.Props.length)
        var iPropsInitialized = 0
        var iXAvgMove = 0
        var iYAvgMove = 0

        for (var i = 0; i < oPropArr.Props.length; i += 1) {
          var sPropMatchValue = oPropArr.Props[i].toString()
          if (sPropMatchValue.indexOf("PropID") == -1) {
            var oProp = $("area[href$='" + oPropArr.Props[i].toString() + "']")
          } else {
            var oProp = $("area[href*='" + oPropArr.Props[i].toString() + "']")
          }
          if (oProp.length > 0) {
            var iCoords = $(oProp).attr("coords").split(",")
            var iArrLen = iCoords.length;
            var iXAvg = 0;
            var iYAvg = 0;
            for (var j = 0; j < iArrLen; j += 2) {
              iXAvg += parseInt(iCoords[j])
              iYAvg += parseInt(iCoords[j + 1])
            }

            iXAvg = parseInt(2 * iXAvg / iArrLen)
            iYAvg = parseInt(2 * iYAvg / iArrLen)
            iXAvgMove += iXAvg
            iYAvgMove += iYAvg - iPegHeight

            $("#MapWrap").prepend('<div class="MapPeg" id="MapPeg' + i + '" style="left:' + iXAvg + 'px; top:' + (iYAvg - iPegHeight) + 'px;"></div>')
            $("#MapPeg" + i).attr("origLeft", iXAvg)
            $("#MapPeg" + i).attr("origTop", (iYAvg - iPegHeight))
            iPropsInitialized += 1;
          }
        }

        AdjustPegsForIEOnInitailize()
   //     MapZoom(-1 * iImgSizeIncr, iOrigImgHeight, iOrigImgWidth, iSpeed)
        if (iPropsInitialized == 1) {
          MoveToPeg("#MapPeg0")
        } else {
          if (iPropsInitialized > 1) {
            iXAvgMove = parseInt(iXAvgMove / (iPropsInitialized))
            iYAvgMove = parseInt(iYAvgMove / (iPropsInitialized))
            MoveToPoint(iYAvgMove, iXAvgMove)
          }
        }
      }
      else {
   //     MapZoom(-2 * iImgSizeIncr, iOrigImgHeight, iOrigImgWidth, iSpeed)
        $("#MapDiv").scrollTo('+=' + iIncr + 'px', iSpeed, { axis: 'y', onAfter: MoveAreaMapPegs })

      }


      jQuery(".map-control a").click(function () {

        iLastScrollTop = parseInt($("#MapDiv").scrollTop());
        iLastScrollLeft = parseInt($("#MapDiv").scrollLeft());
        var iMapControlTop = parseInt($(".map-control").css("top"))
        var iMapControlRight = parseInt($(".map-control").css("right"))

        var iCurrImgHeight = parseFloat($("#MapImage").attr("height"))
        var iCurrImgWidth = parseFloat($("#MapImage").attr("width"))

        $(".MapPeg").css("visibility:hidden")
        if (this.className == "zoom") {
          MapZoom(iImgSizeIncr, iOrigImgHeight, iOrigImgWidth, iSpeed)
        } else if (this.className == "back") {
          MapZoom(-1 * iImgSizeIncr, iOrigImgHeight, iOrigImgWidth, iSpeed)
        } else if (this.className == "up") {
          $("#MapDiv").scrollTo('-=' + iIncr + 'px', iSpeed, { axis: 'y', onAfter: MoveAreaMapPegs })
        } else if (this.className == "down") {
          $("#MapDiv").scrollTo('+=' + iIncr + 'px', iSpeed, { axis: 'y', onAfter: MoveAreaMapPegs })
          iScrollTop = parseInt($("#MapDiv").scrollTop());
        } else if (this.className == "left") {
          $("#MapDiv").scrollTo('-=' + iIncr + 'px', iSpeed, { axis: 'x', onAfter: MoveAreaMapPegs })
        } else if (this.className == "right") {
          $("#MapDiv").scrollTo('+=' + iIncr + 'px', iSpeed, { axis: 'x', onAfter: MoveAreaMapPegs })
        } else if (this.className == "print") {
          $(".MapPeg").css("visibility:visible")
          window.open($("#printMap").attr("href"))
        } else if (this.className == "reset") {
          $("#MapDiv").scrollTo('0', 200)
          window.location.reload();
        } else if (this.className == "close") {
          window.close();
        }
        return false;
      });


      $(window).scroll(function () {
        var iWindowScrollTop = $(window).scrollTop();
        $(".map-control").animate({ top: iWindowScrollTop + iOrigMapControlTop }, 0, 'linear')
        $(".map-key").animate({ top: iWindowScrollTop + iOrigMapKeyTop }, 0, 'linear')
      });

      $('img[usemap]').rwdImageMaps();  // makes the imagemap links so they work in responsive mode
    });




  </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">
  <asp:Literal ID="litRedirectToAreaMap" runat="server"></asp:Literal>
  <div class="row">
    <div class="col-sm-12">
      <asp:HiddenField ID="hidPropertiesToMark" runat="server" Value="" />

  <table cellpadding="0" cellspacing="0" border="0" >
    <tr>
      <td align="left" valign="top">
        <div class="MapWrap" id="MapWrap">
          <div class="map-control">
            <a href="#left" class="left">Left</a> <a href="#right" class="right">Right</a> <a href="#up" class="up">Up</a> <a href="#down" class="down">Down</a> <a href="#zoom" class="zoom">Zoom</a> <a href="#zoom_out" class="back">Back</a><a href="/images/cstay-accomm-map.pdf" target="_blank" class="printMap" id="printMap"></a><a href="#print" class="print">Print</a><a href="#reset" class="reset">Reset</a><a href="#close" class="close">Close</a> <a href="#" onclick="window.close();" class="closeMap" id="closeMap"></a>
          </div>
		  <div class="map-key"></div>
          <div class="VillageMap" id="MapDiv">
            <img id="MapImage" src="/images/cstay-coop-village-map.jpg" width="900" height="1187" alt="Map of Cooperstown Village" usemap="#VillageMap" border="0" />
            <map name="VillageMap" id="MapDivCoords">
              <area shape="RECT" coords="132,427,252,452" alt="Bella Casa" href="/Details.aspx?PropID=338&GroupID=8" target="_blank">
              <area shape="RECT" coords="94,456,248,483" alt="New Hotel Pratt" href="/Details.aspx?PropID=282&GroupID=26" target="_blank">
              <area shape="RECT" coords="45,722,172,754" alt="All Aboard" href="/Details.aspx?PropID=652&GroupID=3" target="_blank">
              <area shape="RECT" coords="59,887,196,915" alt="Dunlop House" href="/Details.aspx?PropID=68&GroupID=0" target="_blank">
              <area shape="RECT" coords="209,1016,462,1048" alt="American Storybook Apts." href="/Details.aspx?PropID=742&GroupID=5" target="_blank">
              <area shape="RECT" coords="30,41,385,129" alt="Back to Main Website" href="Default.aspx">
              <area shape="RECT" coords="46,756,223,787" alt="Susquehanna House" href="/Details.aspx?PropID=779&GroupID=0" target="_blank">
              <area shape="RECT" coords="86,791,192,821" alt="Agaseto" href="/Details.aspx?PropID=812&GroupID=0" target="_blank">
              <area shape="RECT" coords="30,353,207,385" alt="Apartments at 2 Pine" href="/Details.aspx?PropID=736&GroupID=2" target="_blank">
              <area shape="RECT" coords="650,302,830,334" alt="Florence Cottage" href="/Details.aspx?PropID=847&GroupID=0" target="_blank">
              <area shape="RECT" coords="36,517,235,546" alt="21 Glengrove Place" href="/Details.aspx?PropID=852&GroupID=0" target="_blank">
              <area shape="RECT" coords="46,825,186,857" alt="Creamery" href="/Details.aspx?PropID=883&GroupID=47" target="_blank">
              <area shape="RECT" coords="306,980,466,1012" alt="Miss Marys" href="/Details.aspx?PropID=918&GroupID=0" target="_blank">
              <area shape="RECT" coords="47,916,235,947" alt="Dunlop Carriage House" href="/Details.aspx?PropID=931&GroupID=0">
              <area shape="RECT" coords="43,388,163,421" alt="Nelson Pines" href="/Details.aspx?PropID=941&GroupID=53" target="_blank">
              <area shape="RECT" coords="164,389,175,418" alt="Nelson Pines" href="/Details.aspx?PropID=942&GroupID=53" target="_blank">
              <area shape="RECT" coords="176,393,187,421" alt="Nelson Pines" href="/Details.aspx?PropID=943&GroupID=53">
              <area shape="RECT" coords="52,489,240,515" alt="Glen Avenue Suites" href="/Details.aspx?PropID=780&GroupID=29" target="_blank">
              <area shape="RECT" coords="239,488,252,516" alt="Glen Avenue Suites" href="/Details.aspx?PropID=781&GroupID=29">
              <area shape="RECT" coords="253,488,265,522" alt="Glen Avuenue Suites" href="/Details.aspx?PropID=782&GroupID=29" target="_blank">
              <area shape="RECT" coords="34,550,159,580" alt="Abbeys Cottage" href="/Details.aspx?PropID=1015&GroupID=0" target="_blank">
            </map>
          </div>
        </div>
      </td>
    </tr>
  </table>
    </div>
    <!--/col-->
  </div>
  <!--/row-->
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" runat="Server">
</asp:Content>
