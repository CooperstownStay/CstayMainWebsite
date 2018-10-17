<%@ Page Language="VB" MasterPageFile="~/MasterMinimal.master" AutoEventWireup="false" CodeFile="AreaMap.aspx.vb" Inherits="AreaMap" Title="Cooperstown Area Map" MetaDescription="Interactive Map of Lodging near Cooperstown Dreams Park with Links to view more info about the Rentals and their Availability." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  <title>Cooperstown Area Map of Rentals | Cooperstown Stay</title>
  <link rel="canonical" href="<%= MyUtils.GetAppSetting("MainWebsite") %>/area-map" />
  <meta name="keywords" content="Cooperstown, Cooperstown, Cooperstown NY, Cooperstown rental homes, Cooperstown lodging, Cooperstown vacation rentals, Cooperstown accommodations, Cooperstown lodging, rentals in Cooperstown, lodging in Cooperstown, accomodations, rentals, weekly rentals, lodging, vacation rentals, Cooperstown Dreams Park, Dreams Park, Dreamspark, lodging for Cooperstown Dreams Rark families, Cooperstown Baseball World, Baseball World, Oneonta, NY, Baseball Hall of Fame, private homes, Cooperstown rentals, stay, apartments, waterfront, lakeside cottages, Otsego County Chamber of Commerce, Cooperstown Chamber, Lonetta, Lonetta Swartout">
  <meta name="description" content="Looking for Lodging near Cooperstown Dreams Park?  Use our interactive rentals map with links to view more info about the rentals in Cooperstown and their availability.">
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
        //        alert($("#<%=hidPropertiesToMark.ClientID%> ").attr("value") + " : " + oPropArr.Props.length)
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

            //                                       alert($(oProp).attr("href") + " : " + iXAvg + " : " + iYAvg )
            $("#MapWrap").prepend('<div class="MapPeg" id="MapPeg' + i + '" style="left:' + iXAvg + 'px; top:' + (iYAvg - iPegHeight) + 'px;"></div>')
            $("#MapPeg" + i).attr("origLeft", iXAvg)
            $("#MapPeg" + i).attr("origTop", (iYAvg - iPegHeight))
            iPropsInitialized += 1;
          }
        }
        AdjustPegsForIEOnInitailize()
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
        //MapZoom(-2 * iImgSizeIncr, iOrigImgHeight, iOrigImgWidth, iSpeed)
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

        <div class="row">
          <div class="col-sm-12">
  <asp:HiddenField ID="hidPropertiesToMark" runat="server" Value="" />
  <table cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td align="left" valign="top" >
      <div class="MapWrap" id="MapWrap">
          <div class="map-control">
            <a href="#left" class="left">Left</a> <a href="#right" class="right">Right</a> <a href="#up" class="up">Up</a> <a href="#down" class="down">Down</a> <a href="#zoom" class="zoom">Zoom</a> <a href="#zoom_out" class="back">Back</a><a href="#print" class="print">Print</a><a href="#reset" class="reset">Reset</a><a href="#close" class="close">Close</a> <a href="/images/cstay-accomm-map.pdf" target="_blank" class="printMap" id="printMap"></a><a href="#" onclick="window.close();" class="closeMap" id="closeMap"></a>
        </div>
        <div class="map-key"></div>
          <div class="AreaMap" id="MapDiv" >
    <img id="MapImage" src="images/cstay-accomm-map.jpg" width="1225" height="1605" alt="Map of Cooperstown Area" usemap="#AreaMap" border="0" />
          <map name="AreaMap" id="AreaMapCoords">

            <area shape="POLY" coords="61,1397,73,1397,73,1339,61,1339" alt="Gardenview - click for details!" title="Gardenview - click for details!" href="/Details.aspx?PropID=728&GroupID=0" target="_blank">
            <area shape="RECT" coords="419,161,484,175" alt="Awesome View - click for details!" title="Awesome View - click for details!" href="/Details.aspx?PropID=702&GroupID=0" target="_blank">
            <area shape="RECT" coords="337,215,388,225" alt="Knoll Top - click for details!" title="Knoll Top - click for details!" href="/Details.aspx?PropID=669&GroupID=0" target="_blank">
            <area shape="RECT" coords="450,190,518,202" alt="Morgan Farm - click for details!" title="Morgan Farm - click for details!" href="/Details.aspx?PropID=143&GroupID=0" target="_blank">
            <area shape="RECT" coords="427,242,518,251" alt="Cherry Lane Cottages - click for details!" title="Cherry Lane Cottages - click for details!" href="/Details.aspx?PropID=679&GroupID=19" target="_blank">
            <area shape="RECT" coords="284,307,358,317" alt="Sunrise Chalet - click for details!" title="Sunrise Chalet - click for details!" href="/Details.aspx?PropID=628&GroupID=0" target="_blank">
            <area shape="RECT" coords="387,347,442,358" alt="Oaks Creek - click for details!" title="Oaks Creek - click for details!" href="/Details.aspx?PropID=491&GroupID=0" target="_blank">
            <area shape="POLY" coords="415,358,415,369,510,369,510,358" alt="Adventure Woodlands - click for details!" title="Adventure Woodlands - click for details!" href="/Details.aspx?PropID=503&GroupID=0" target="_blank">
            <area shape="RECT" coords="258,386,338,400" alt="Drexel Park - click for details!" title="Drexel Park - click for details!" href="/Details.aspx?PropID=120&GroupID=0" target="_blank">
            <area shape="POLY" coords="368,532,372,543,429,521,425,510" alt="Donnybrook - click for details!" title="Donnybrook - click for details!" href="/Details.aspx?PropID=454&GroupID=10" target="_blank">
            <area shape="RECT" coords="309,549,358,561" alt="Pine Grove - click for details!" title="Pine Grove - click for details!" href="/Details.aspx?PropID=754&GroupID=0" target="_blank">
            <area shape="RECT" coords="597,372,662,391" alt="Sleeping Lion - click for details!" title="Sleeping Lion - click for details!" href="/Details.aspx?PropID=295&GroupID=20" target="_blank">
            <area shape="RECT" coords="579,396,652,409" alt="Camp Champion - click for details!" title="Camp Champion - click for details!" href="/Details.aspx?PropID=685&GroupID=0" target="_blank">
            <area shape="RECT" coords="425,214,485,224" alt="Windcrest - click for details!" title="Beaver Creek - click for details!" href="/Details.aspx?PropID=1022&GroupID=0" target="_blank">
            <area shape="RECT" coords="379,591,450,603" alt="Fly Creek House - click for details!" title="Fly Creek House - click for details!" href="/Details.aspx?PropID=147&GroupID=0" target="_blank">
            <area shape="RECT" coords="698,409,784,419" alt="Camp All Aboard - click for details!" title="Camp All Aboard - click for details!" href="/Details.aspx?PropID=642&GroupID=0" target="_blank">
            <area shape="POLY" coords="455,758,461,767,540,749,540,738" alt="Amys Schoolhouse - click for details!" title="Hemlock Haven - click for details!" href="/Details.aspx?PropID=808&GroupID=0" target="_blank">
            <area shape="RECT" coords="756,487,838,496" alt="Whitehill Cottage - click for details!" title="Whitehill Cottage - click for details!" href="/Details.aspx?PropID=723&GroupID=0" target="_blank">
            <area shape="RECT" coords="806,477,870,487" alt="Barnum Acres - click for details!" title="Barnum Acres - click for details!" href="/Details.aspx?PropID=674&GroupID=0" target="_blank">
            <area shape="RECT" coords="736,496,801,504" alt="Bavarian Farm - click for details!" title="Bavarian Farm - click for details!" href="/Details.aspx?PropID=164&GroupID=0" target="_blank">
            <area shape="RECT" coords="732,504,812,512" alt="Bavarian Farm Apt. - click for details!" title="Bavarian Farm Apt. - click for details!" href="/Details.aspx?PropID=486&GroupID=0" target="_blank">
            <area shape="RECT" coords="732,513,824,522" alt="Bavarian Farm Studio - click for details!" title="Bavarian Farm Studio - click for details!" href="/Details.aspx?PropID=528&GroupID=0" target="_blank">
            <area shape="RECT" coords="735,525,851,535" alt="Bavarian Farm Schoolhouse - click for details!" title="Bavarian Farm Schoolhouse - click for details!" href="/Details.aspx?PropID=547&GroupID=0" target="_blank">
            <area shape="RECT" coords="726,537,826,547" alt="Deer Meadow Farm Studio - click for details!" title="Deer Meadow Farm Studio - click for details!" href="/Details.aspx?PropID=655&GroupID=0" target="_blank">
            <area shape="RECT" coords="720,548,795,557" alt="Deer Meadow Farm - click for details!" title="Deer Meadow Farm - click for details!" href="/Details.aspx?PropID=654&GroupID=0" target="_blank">
            <area shape="RECT" coords="631,735,689,746" alt="Cornish Hill - click for details!" title="Cornish Hill - click for details!" href="/Details.aspx?PropID=632&GroupID=0" target="_blank">
            <area shape="RECT" coords="642,749,704,760" alt="Embassy Hill - click for details!" title="Embassy Hill - click for details!" href="/Details.aspx?PropID=675&GroupID=0" target="_blank">
            <area shape="RECT" coords="1077,430,1132,439" alt="All Aboard - click for details!" title="All Aboard - click for details!" href="/Details.aspx?PropID=652&GroupID=3" target="_blank">
            <area shape="RECT" coords="1076,385,1140,395" alt="Dunlop House - click for details!" title="Dunlop House - click for details!" href="/Details.aspx?PropID=68&GroupID=0" target="_blank">
            <area shape="RECT" coords="1078,461,1130,470" alt="Bella Casa - click for details!" title="Bella Casa - click for details!" href="/Details.aspx?PropID=338&GroupID=8" target="_blank">
            <area shape="RECT" coords="1079,516,1136,526" alt="New Hotel Pratt - click for details!" title="New Hotel Pratt - click for details!" href="/Details.aspx?PropID=282&GroupID=26" target="_blank">
            <area shape="RECT" coords="1077,439,1171,449" alt="American Story Book - click for details!" title="American Story Book - click for details!" href="/Details.aspx?PropID=742&GroupID=5" target="_blank">
            <area shape="POLY" coords="664,880,663,889,716,896,717,887" alt="Evergreen - click for details!" title="Evergreen - click for details!" href="/Details.aspx?PropID=185&GroupID=0" target="_blank">
            <area shape="RECT" coords="638,893,688,904" alt="Bucks Run - click for details!" title="Bucks Run - click for details!" href="/Details.aspx?PropID=522&GroupID=0" target="_blank">
            <area shape="RECT" coords="702,815,765,836" alt="Hidden Valley Pond - click for details!" title="Hidden Valley Pond - click for details!" href="/Details.aspx?PropID=333&GroupID=15" target="_blank">
            <area shape="RECT" coords="697,858,771,868" alt="Westford Haven - click for details!" title="Westford Haven - click for details!" href="/Details.aspx?PropID=562&GroupID=0" target="_blank">
            <area shape="RECT" coords="272,603,314,624" alt="Country Hideaway - click for details!" title="Country Hideaway - click for details!" href="/Details.aspx?PropID=497&GroupID=0" target="_blank">
            <area shape="RECT" coords="327,684,387,695" alt="Amish Barn - click for details!" title="Amish Barn - click for details!" href="/Details.aspx?PropID=586&GroupID=6" target="_blank">
            <area shape="POLY" coords="352,713,355,721,407,704,404,696" alt="High Valley - click for details!" title="High Valley - click for details!" href="/Details.aspx?PropID=151&GroupID=0" target="_blank">
            <area shape="POLY" coords="459,619,463,628,512,608,508,599" alt="Brookside - click for details!" title="Brookside - click for details!" href="/Details.aspx?PropID=271&GroupID=0" target="_blank">
            <area shape="POLY" coords="421,664,424,673,472,659,469,649" alt="Day House - click for details!" title="Day House - click for details!" href="/Details.aspx?PropID=488&GroupID=0" target="_blank">
            <area shape="RECT" coords="447,685,499,695" alt="Jrs Place - click for details!" title="Jrs Place - click for details!" href="/Details.aspx?PropID=726&GroupID=0" target="_blank">
            <area shape="RECT" coords="305,732,363,742" alt="Valley View - click for details!" title="Valley View - click for details!" href="/Details.aspx?PropID=616&GroupID=0" target="_blank">
            <area shape="RECT" coords="223,785,304,795" alt="Changing Seasons - click for details!" title="Changing Seasons - click for details!" href="/Details.aspx?PropID=329&GroupID=0" target="_blank">
            <area shape="POLY" coords="363,818,368,827,432,792,427,783" alt="Butts Mountain - click for details!" title="Butts Mountain - click for details!" href="/Details.aspx?PropID=630&GroupID=0" target="_blank">
            <area shape="RECT" coords="429,779,527,787" alt="Cooperstown Cottage - click for details!" title="Cooperstown Cottage - click for details!" href="/Details.aspx?PropID=571&GroupID=0" target="_blank">
            <area shape="RECT" coords="456,789,518,797" alt="Alans Corner - click for details!" title="Alans Corner - click for details!" href="/Details.aspx?PropID=234&GroupID=0" target="_blank">
            <area shape="RECT" coords="456,798,508,807" alt="1819 House - click for details!" title="1819 House - click for details!" href="/Details.aspx?PropID=335&GroupID=0" target="_blank">
            <area shape="RECT" coords="443,809,509,817" alt="102 Trolley Line - click for details!" title="102 Trolley Line - click for details!" href="/Details.aspx?PropID=684&GroupID=0" target="_blank">
            <area shape="RECT" coords="372,822,428,831" alt="Heron Cove - click for details!" title="Heron Cove - click for details!" href="/Details.aspx?PropID=487&GroupID=0" target="_blank">
            <area shape="RECT" coords="360,862,416,872" alt="Grandview - click for details!" title="Grandview - click for details!" href="/Details.aspx?PropID=638&GroupID=0" target="_blank">
            <area shape="RECT" coords="335,899,382,910" alt="Edgewood - click for details!" title="Edgewood - click for details!" href="/Details.aspx?PropID=504&GroupID=0" target="_blank">
            <area shape="POLY" coords="436,851,438,860,503,850,501,841" alt="1814 Farmhouse - click for details!" title="1814 Farmhouse - click for details!" href="/Details.aspx?PropID=718&GroupID=0" target="_blank">
            <area shape="POLY" coords="446,858,447,865,501,859,500,850" alt="Green Hills - click for details!" title="Green Hills - click for details!" href="/Details.aspx?PropID=673&GroupID=0" target="_blank">
            <area shape="POLY" coords="428,889,430,898,491,890,491,881" alt="Terrace Lawn - click for details!" title="Terrace Lawn - click for details!" href="/Details.aspx?PropID=140&GroupID=0" target="_blank">
            <area shape="RECT" coords="549,783,615,792" alt="Dream Catcher - click for details!" title="Dream Catcher - click for details!" href="/Details.aspx?PropID=478&GroupID=0" target="_blank">
            <area shape="POLY" coords="0,0,0,0,0,0,0,0" alt="Kenwood - click for details!" title="Kenwood - click for details!" href="/Details.aspx?PropID=291&GroupID=0" target="_blank">
            <area shape="RECT" coords="500,825,572,835" alt="Heritage Cottage - click for details!" title="Heritage Cottage - click for details!" href="/Details.aspx?PropID=641&GroupID=0" target="_blank">
            <area shape="POLY" coords="491,880,493,887,555,864,553,857" alt="Sunnyside Apt - click for details!" title="Sunnyside Apt - click for details!" href="/Details.aspx?PropID=302&GroupID=18" target="_blank">
            <area shape="RECT" coords="710,930,768,942" alt="Hawks View - click for details!" title="Hawks View - click for details!" href="/Details.aspx?PropID=626&GroupID=0" target="_blank">
            <area shape="RECT" coords="119,954,173,966" alt="Dreamview - click for details!" title="Dreamview - click for details!" href="/Details.aspx?PropID=682&GroupID=0" target="_blank">
            <area shape="RECT" coords="286,945,344,955" alt="Knotty Pine - click for details!" title="Knotty Pine - click for details!" href="/Details.aspx?PropID=550&GroupID=0" target="_blank">
            <area shape="RECT" coords="253,1014,317,1025" alt="Hilltop House - click for details!" title="Hilltop House - click for details!" href="/Details.aspx?PropID=142&GroupID=0" target="_blank">
            <area shape="RECT" coords="210,1032,278,1042" alt="Cottage House - click for details!" title="Cottage House - click for details!" href="/Details.aspx?PropID=83&GroupID=0" target="_blank">
            <area shape="RECT" coords="463,952,515,962" alt="Spruce Hill - click for details!" title="Spruce Hill - click for details!" href="/Details.aspx?PropID=372&GroupID=0" target="_blank">
            <area shape="RECT" coords="311,969,405,979" alt="The Loft at Oak Shores - click for details!" title="The Loft at Oak Shores - click for details!" href="/Details.aspx?PropID=695&GroupID=0" target="_blank">
            <area shape="RECT" coords="456,979,514,989" alt="Kessler Apt - click for details!" title="Kessler Apt - click for details!" href="/Details.aspx?PropID=200&GroupID=0" target="_blank">
            <area shape="POLY" coords="513,939,515,948,624,927,622,918" alt="Breezy Meadow One and Two - click for details!" title="Breezy Meadow One and Two - click for details!" href="/Details.aspx?PropID=604&GroupID=0" target="_blank">
            <area shape="RECT" coords="522,950,567,958" alt="Best Bet - click for details!" title="Best Bet - click for details!" href="/Details.aspx?PropID=734&GroupID=0" target="_blank">
            <area shape="RECT" coords="592,982,652,991" alt="Country Daze - click for details!" title="Country Daze - click for details!" href="/Details.aspx?PropID=656&GroupID=0" target="_blank">
            <area shape="RECT" coords="600,995,640,1005" alt="Sky View - click for details!" title="Sky View - click for details!" href="/Details.aspx?PropID=514&GroupID=0" target="_blank">
            <area shape="RECT" coords="548,1016,606,1026" alt="Curry Court - click for details!" title="Curry Court - click for details!" href="/Details.aspx?PropID=206&GroupID=0" target="_blank">
            <area shape="RECT" coords="552,1027,631,1037" alt="Country Meadow - click for details!" title="Country Meadow - click for details!" href="/Details.aspx?PropID=469&GroupID=0" target="_blank">
            <area shape="RECT" coords="561,1037,613,1046" alt="Apple Tree - click for details!" title="Apple Tree - click for details!" href="/Details.aspx?PropID=175&GroupID=7" target="_blank">
            <area shape="POLY" coords="475,997,473,1006,531,1015,533,1006" alt="Tuscan Hills - click for details!" title="Tuscan Hills - click for details!" href="/Details.aspx?PropID=320&GroupID=0" target="_blank">
            <area shape="RECT" coords="710,390,803,399" alt="Cardinal Cottage - click for details!" title="Maple Cottage - click for details!" href="/Details.aspx?PropID=811&GroupID=0" target="_blank">
            <area shape="POLY" coords="473,1096,477,1103,546,1075,535,1068" alt="Bungalow 23 - click for details!" title="Bungalow 23 - click for details!" href="/Details.aspx?PropID=582&GroupID=0" target="_blank">
            <area shape="RECT" coords="405,1058,451,1066" alt="Creekside - click for details!" title="Creekside - click for details!" href="/Details.aspx?PropID=513&GroupID=0" target="_blank">
            <area shape="RECT" coords="392,1178,452,1190" alt="Victory Hill - click for details!" title="Victory Hill - click for details!" href="/Details.aspx?PropID=537&GroupID=0" target="_blank">
            <area shape="RECT" coords="543,1302,605,1313" alt="Stokes Lodge - click for details!" title="Stokes Lodge - click for details!" href="/Details.aspx?PropID=186&GroupID=0" target="_blank">
            <area shape="RECT" coords="88,1366,130,1387" alt="Bellvue Ranch - click for details!" title="Bellvue Ranch - click for details!" href="/Details.aspx?PropID=672&GroupID=0" target="_blank">
            <area shape="RECT" coords="223,1332,298,1341" alt="West Anne Duplex - click for details!" title="West Anne Duplex - click for details!" href="/Details.aspx?PropID=707&GroupID=25" target="_blank">
            <area shape="RECT" coords="225,1343,297,1351" alt="West Anne House - click for details!" title="West Anne House - click for details!" href="/Details.aspx?PropID=715&GroupID=0" target="_blank">
            <area shape="RECT" coords="203,1311,299,1320" alt="Columbia House - click for details!" title="Columbia House - click for details!" href="/Details.aspx?PropID=716&GroupID=0" target="_blank">
            <area shape="RECT" coords="241,1355,296,1363" alt="76 Elm Apt - click for details!" title="76 Elm Apt - click for details!" href="/Details.aspx?PropID=709&GroupID=22" target="_blank">
            <area shape="RECT" coords="222,1321,298,1330" alt="Pioneer Cottage - click for details!" title="Pioneer Cottage - click for details!" href="/Details.aspx?PropID=510&GroupID=0" target="_blank">
            <area shape="RECT" coords="228,1302,296,1310" alt="Clinton House - click for details!" title="Clinton House - click for details!" href="/Details.aspx?PropID=449&GroupID=0" target="_blank">
            <area shape="RECT" coords="498,1497,558,1517" alt="Charlotte Creek - click for details!" title="Charlotte Creek - click for details!" href="/Details.aspx?PropID=662&GroupID=0" target="_blank">
            <area shape="RECT" coords="958,741,1031,758" alt="Summer Wind - click for details!" title="Summer Wind - click for details!" href="/Details.aspx?PropID=314&GroupID=0" target="_blank">
            <area shape="RECT" coords="1111,798,1160,810" alt="Riverview - click for details!" title="Riverview - click for details!" href="/Details.aspx?PropID=446&GroupID=0" target="_blank">
            <area shape="RECT" coords="1005,823,1059,833" alt="Beau Rivage - click for details!" title="Beau Rivage - click for details!" href="/Details.aspx?PropID=468&GroupID=0" target="_blank">
            <area shape="RECT" coords="997,837,1049,847" alt="Blue Heron - click for details!" title="Blue Heron - click for details!" href="/Details.aspx?PropID=696&GroupID=0" target="_blank">
            <area shape="POLY" coords="986,781,982,791,1077,831,1081,822" alt="Canoe and Kayak Rentals" title="Canoe and Kayak Rentals" href="http://www.canoeandkayakrentals.com" target="_blank">
            <area shape="RECT" coords="1013,887,1077,898" alt="Point of View - click for details!" title="Point of View - click for details!" href="/Details.aspx?PropID=493&GroupID=0" target="_blank">
            <area shape="RECT" coords="1086,870,1140,879" alt="Big Willows - click for details!" title="Big Willows - click for details!" href="/Details.aspx?PropID=664&GroupID=0" target="_blank">
            <area shape="RECT" coords="1085,881,1135,890" alt="Riverhaven - click for details!" title="Riverhaven - click for details!" href="/Details.aspx?PropID=371&GroupID=0" target="_blank">
            <area shape="RECT" coords="989,918,1059,928" alt="Country Breeze - click for details!" title="Country Breeze - click for details!" href="/Details.aspx?PropID=605&GroupID=0" target="_blank">
            <area shape="POLY" coords="937,953,934,961,1003,975,1005,968" alt="Lakeshore Lodge - click for details!" title="Lakeshore Lodge - click for details!" href="/Details.aspx?PropID=459&GroupID=0" target="_blank">
            <area shape="POLY" coords="907,947,918,955,957,913,948,903" alt="Waterview - click for details!" title="Waterview - click for details!" href="/Details.aspx?PropID=342&GroupID=0" target="_blank">
            <area shape="POLY" coords="1083,898,1076,906,1128,946,1135,938" alt="Bonnies Cove - click for details!" title="Bonnies Cove - click for details!" href="/Details.aspx?PropID=163&GroupID=0" target="_blank">
            <area shape="POLY" coords="1078,908,1073,918,1136,968,1144,960" alt="Harriets Hideaway - click for details!" title="Harriets Hideaway - click for details!" href="/Details.aspx?PropID=349&GroupID=0" target="_blank">
            <area shape="POLY" coords="912,976,910,987,986,1002,988,991" alt="Great Catch Cabin - click for details!" title="Great Catch Cabin - click for details!" href="/Details.aspx?PropID=353&GroupID=0" target="_blank">
            <area shape="POLY" coords="912,1031,913,1038,982,1023,981,1015" alt="Lakeview Cottage - click for details!" title="Lakeview Cottage - click for details!" href="/Details.aspx?PropID=272&GroupID=0" target="_blank">
            <area shape="RECT" coords="779,1118,874,1128" alt="A Lakeview Paradise - click for details!" title="A Lakeview Paradise - click for details!" href="/Details.aspx?PropID=306&GroupID=0" target="_blank">
            <area shape="POLY" coords="934,1088,937,1098,976,1082,973,1072" alt="Birch Cove - click for details!" title="Birch Cove - click for details!" href="/Details.aspx?PropID=606&GroupID=0" target="_blank">
            <area shape="POLY" coords="858,1106,861,1118,933,1101,930,1089" alt="Friendship Lodge - click for details!" title="Friendship Lodge - click for details!" href="/Details.aspx?PropID=276&GroupID=0" target="_blank">
            <area shape="RECT" coords="1027,1166,1077,1174" alt="Sandy Cove - click for details!" title="Sandy Cove - click for details!" href="/Details.aspx?PropID=374&GroupID=0" target="_blank">
            <area shape="POLY" coords="897,1084,900,1093,957,1082,955,1072" alt="Garth Newell - click for details!" title="Garth Newell - click for details!" href="/Details.aspx?PropID=729&GroupID=0" target="_blank">
            <area shape="POLY" coords="999,1149,1002,1156,1053,1134,1050,1126" alt="Cliffside - click for details!" title="Cliffside - click for details!" href="/Details.aspx?PropID=343&GroupID=0" target="_blank">
            <area shape="POLY" coords="562,1048,555,1054,594,1093,598,1084" alt="The Shire - click for details!" title="The Shire - click for details!" href="/Details.aspx?PropID=370&GroupID=0" target="_blank">
            <area shape="POLY" coords="552,1079,545,1086,576,1118,584,1111" alt="Parkside - click for details!" title="Parkside - click for details!" href="/Details.aspx?PropID=473&GroupID=0" target="_blank">
            <area shape="POLY" coords="408,1011,407,1020,469,1023,471,1015" alt="The Weathervane - click for details!" title="The Weathervane - click for details!" href="/Details.aspx?PropID=376&GroupID=0" target="_blank">
            <area shape="POLY" coords="416,1021,416,1029,467,1032,467,1024" alt="Luckys Place - click for details!" title="Luckys - click for details!" href="/Details.aspx?PropID=450&GroupID=0" target="_blank">
            <area shape="POLY" coords="422,1029,421,1039,490,1043,489,1034" alt="Tir Na Grainne - click for details!" title="Tir Na Grainne - click for details!" href="/Details.aspx?PropID=657&GroupID=0" target="_blank">
            <area shape="POLY" coords="397,1037,396,1045,483,1052,483,1043" alt="1860 Spencer House - click for details!" title="1860 Spencer House - click for details!" href="/Details.aspx?PropID=719&GroupID=0" target="_blank">
            <area shape="POLY" coords="1051,1372,1047,1381,1101,1407,1104,1399" alt="Woodhaven - click for details!" title="Woodhaven - click for details!" href="/Details.aspx?PropID=337&GroupID=0" target="_blank">
            <area shape="RECT" coords="244,358,296,368" alt="Pops Place - click for details!" title="Pops Place - click for details!" href="/Details.aspx?PropID=609&GroupID=0" target="_blank">
            <area shape="RECT" coords="464,579,520,588" alt="Cider House - click for details!" title="Cider House - click for details!" href="/Details.aspx?PropID=761&GroupID=0" target="_blank">
            <area shape="POLY" coords="677,622,684,628,733,576,725,571" alt="Quiet Time Farm - click for details!" title="Quiet Time Farm - click for details!" href="/Details.aspx?PropID=745&GroupID=0" target="_blank">
            <area shape="POLY" coords="423,924,437,927,509,910,506,903" alt="Moonlight Graham - click for details!" title="Moonlight Graham - click for details!" href="/Details.aspx?PropID=764&GroupID=0" target="_blank">
            <area shape="RECT" coords="171,840,250,850" alt="Hartwick Cottage - click for details!" title="Hartwick Cottage - click for details!" href="/Details.aspx?PropID=660&GroupID=0" target="_blank">
            <area shape="RECT" coords="288,317,363,326" alt="Fishers Landing - click for details!" title="Fishers Landing - click for details!" href="/Details.aspx?PropID=765&GroupID=0" target="_blank">
            <area shape="RECT" coords="473,42,1181,148" alt="Back to Main Website" title="Back to Main Website" href="Default.aspx">
            <area shape="RECT" coords="279,826,349,836" alt="Country Charm - click for details!" title="Country Charm - click for details!" href="/Details.aspx?PropID=773&GroupID=0" target="_blank">
            <area shape="RECT" coords="1078,491,1165,502" alt="Susquehanna House - click for details!" title="Susquehanna House - click for details!" href="/Details.aspx?PropID=779&GroupID=0" target="_blank">
            <area shape="POLY" coords="465,629,465,640,561,632,561,621" alt="1890 Fly Creek Cottage - click for details!" title="1890 Fly Creek Cottage - click for details!" href="/Details.aspx?PropID=784&GroupID=0" target="_blank">
            <area shape="RECT" coords="306,796,372,806" alt="August Garden - click for details!" title="August Garden - click for details!" href="/Details.aspx?PropID=785&GroupID=0" target="_blank">
            <area shape="RECT" coords="412,290,482,301" alt="Thors Landing - click for details!" title="Thors Landing - click for details!" href="/Details.aspx?PropID=622&GroupID=" target="_blank">
            <area shape="RECT" coords="266,498,319,512" alt="42 North - click for details!" title="42 North - click for details!" href="/Details.aspx?PropID=786&GroupID=" target="_blank">
            <area shape="RECT" coords="344,980,395,991" alt="For Ease - click for details!" title="For Ease - click for details!" href="/Details.aspx?PropID=787&GroupID=0" target="_blank">
            <area shape="RECT" coords="391,930,460,939" alt="Partridge Pond - click for details!" title="Partridge Pond - click for details!" href="/Details.aspx?PropID=500&GroupID=0" target="_blank">
            <area shape="POLY" coords="438,999,436,1009,535,1027,536,1017" alt="Milford Manor Farmhouse - click for details!" title="Milford Manor Farmhouse - click for details!" href="/Details.aspx?PropID=793&GroupID=0" target="_blank">
            <area shape="RECT" coords="1077,364,1166,375" alt="Cooperstown House - click for details!" title="Cooperstown House - click for details!" href="/Details.aspx?PropID=800&GroupID=0" target="_blank">
            <area shape="POLY" coords="575,1047,568,1053,610,1096,617,1089" alt="Almost Home - click for details!" title="Almost Home - click for details!" href="/Details.aspx?PropID=797&GroupID=0" target="_blank">
            <area shape="RECT" coords="419,1220,484,1230" alt="Summer Wind - click for details!" title="Summer Wind - click for details!" href="/Details.aspx?PropID=314&GroupID=0" target="_blank">
            <area shape="RECT" coords="1104,810,1169,821" alt="Waters Edge - click for details!" title="Waters Edge - click for details!" href="/Details.aspx?PropID=799&GroupID=0" target="_blank">
            <area shape="RECT" coords="471,1363,569,1375" href="/Details.aspx?PropID=766&GroupID=0" alt="Redwood Inn and Suites - click for details!" title="Redwood Inn and Suites - click for details!" target="_blank">
            <area shape="RECT" coords="100,1354,157,1365" alt="Black Moose - click for details" title="Black Moose - click for details" href="/Details.aspx?PropID=805&GroupID=0" target="_blank">
            <area shape="RECT" coords="323,565,391,575" alt="Mugsys Place - click for details!" title="Mugsys Place - click for details!" href="/Details.aspx?PropID=817&GroupID=0" target="_blank">
            <area shape="RECT" coords="410,638,468,647" alt="Creek Island - click for details!" title="Creek Island - click for details!" href="/Details.aspx?PropID=831&GroupID=0" target="_blank">
            <area shape="POLY" coords="923,960,921,969,1006,985,1008,976" alt="Commissioners Coup - click for details!" title="Commissioners Coup - click for details!" href="/Details.aspx?PropID=810&GroupID=0" target="_blank">
            <area shape="RECT" coords="1077,421,1130,430" href="/Details.aspx?PropID=812&GroupID=0" alt="Agaseto - click for details!" target="_blank" title="Agaseto - click for details!" target="_blank">
            <area shape="RECT" coords="366,1519,448,1531" alt="The Guest Cottage - click for details!" title="The Guest Cottage - click for details!" href="/Details.aspx?PropID=788&GroupID=0">
            <area shape="POLY" coords="893,1060,895,1070,945,1063,943,1053" alt="Eagle View - click for details!" title="Eagle View - click for details!" href="/Details.aspx?PropID=833&GroupID=0" target="_blank">
            <area shape="RECT" coords="997,947,1055,956" alt="Avonmora - click for details!" title="Avonmora - click for details!" href="/Details.aspx?PropID=836&GroupID=0" target="_blank">
            <area shape="RECT" coords="319,650,376,661" alt="Rabbit Run - click for details!" title="Rabbit Run - click for details!" href="/Details.aspx?PropID=835&GroupID=0" target="_blank">
            <area shape="POLY" coords="1030,782,1025,792,1084,822,1089,812" alt="Eagle River - click for details!" title="Eagle River - click for details!" href="/Details.aspx?PropID=832&GroupID=0" target="_blank">
            <area shape="POLY" coords="814,821,807,833,868,865,875,856" alt="Springhouse - click for details!" title="Springhouse - click for details!" href="/Details.aspx?PropID=841&GroupID=0" target="_blank">
            <area shape="RECT" coords="423,230,501,241" alt="Heron Landing - click for details!" title="Heron Landing - click for details!" href="/Details.aspx?PropID=860&GroupID=0" target="_blank">
            <area shape="RECT" coords="420,263,497,274" alt="Sunset Lake Lodge - click for details!" title="Sunset Lake Lodge - click for details!" href="/Details.aspx?PropID=846&GroupID=0" target="_blank">
            <area shape="RECT" coords="405,302,483,314" alt="Wide Waterview - click for details!" title="Wide Waterview - click for details!" href="/Details.aspx?PropID=856&GroupID=0" target="_blank">
            <area shape="RECT" coords="565,323,645,337" alt="Rum Hill Manor - click for details!" title="Rum Hill Manor - click for details!" href="/Details.aspx?PropID=857&GroupID=0" target="_blank">
            <area shape="POLY" coords="934,1017,936,1025,1035,1002,1034,994" alt="Cooperstown Junction - click for details!" title="Cooperstown Junction - click for details!" href="/Details.aspx?PropID=866&GroupID=0" target="_blank">
            <area shape="RECT" coords="1075,409,1168,420" alt="21 Glengrove Place - click for details!" title="21 Glengrove Place - click for details!" href="/Details.aspx?PropID=852&GroupID=0" target="_blank">
            <area shape="RECT" coords="247,369,321,380" alt="Hard Rock Ridge - click for details!" title="Hard Rock Ridge - click for details!" href="/Details.aspx?PropID=854&GroupID=0">
            <area shape="RECT" coords="336,743,403,753" alt="Birch Meadow - click for details!" title="Birch Meadow - click for details!" href="/Details.aspx?PropID=853&GroupID=0" target="_blank">
            <area shape="RECT" coords="307,1084,363,1095" alt="Als Ranch - click for details!" title="Als Ranch - click for details!" href="/Details.aspx?PropID=859&GroupID=0" target="_blank">
            <area shape="POLY" coords="594,1043,586,1051,623,1091,633,1081" alt="Green Acres - click for details!" title="Green Acres - click for details!" href="/Details.aspx?PropID=844&GroupID=0" target="_blank">
            <area shape="POLY" coords="462,1130,468,1142,529,1113,523,1101" alt="Red Hill Farm - click for details!" title="Red Hill Farm - click for details!" href="/Details.aspx?PropID=850&GroupID=0" target="_blank">
            <area shape="RECT" coords="383,1252,451,1265" alt="Springhouse - click for details!" title="Springhouse - click for details!" href="/Details.aspx?PropID=841&GroupID=0" target="_blank">
            <area shape="RECT" coords="776,1105,860,1118" alt="Maple Lakehouse - click for details!" title="Maple Lakehouse - click for details!" href="/Details.aspx?PropID=848&GroupID=0" target="_blank">
            <area shape="RECT" coords="101,1345,160,1354" alt="Phoenix Hill - click for details!" title="Phoenix Hill - click for details!" href="/Details.aspx?PropID=861&GroupID=0" target="_blank">
            <area shape="POLY" coords="485,618,486,629,571,615,570,604" href="/Details.aspx?PropID=868&GroupID=0" alt="Wheelhouse - click for details!" title="Wheelhouse - click for details!" target="_blank">
            <area shape="POLY" coords="936,1099,940,1109,981,1092,977,1082" alt="Big Pines - click for details!" title="Big Pines - click for details!" href="/Details.aspx?PropID=874&GroupID=0" target="_blank">
            <area shape="POLY" coords="822,1144,825,1155,890,1136,886,1124" alt="Rose Cottage - click for details!" title="Rose Cottage - click for details!" href="/Details.aspx?PropID=873&GroupID=0" target="_blank">
            <area shape="POLY" coords="506,882,509,891,561,883,554,873" alt="Park View - click for details!" title="Park View - click for details!" href="/Details.aspx?PropID=778&GroupID=0" target="_blank">
            <area shape="RECT" coords="460,733,518,742" alt="Bridge Creek - click for details!" title="Bridge Creek - click for details!" href="/Details.aspx?PropID=878&GroupID=0" target="_blank">
            <area shape="RECT" coords="1077,450,1167,460" alt="Apartments at 2 Pine - click for details!" title="Apartments at 2 Pine - click for details!" href="/Details.aspx?PropID=736&GroupID=2" target="_blank">
            <area shape="RECT" coords="1078,470,1145,480" alt="Creamery - click for details!" title="Creamery - click for details!" href="/Details.aspx?PropID=883&GroupID=47" target="_blank">
            <area shape="POLY" coords="445,868,447,876,501,868,500,860" alt="Dandy-Li Inn - click for details!" title="Dandy-Li Inn - click for details!" href="/Details.aspx?PropID=880&GroupID=0" target="_blank">
            <area shape="RECT" coords="511,815,557,824" alt="Kenwood - click for details!" title="Kenwood - click for details!" href="/Details.aspx?PropID=291&GroupID=0" target="_blank">
            <area shape="POLY" coords="153,1386,143,1393,207,1424,212,1415" alt="Shagbark Hill - click for details!" title="Shagbark Hill - click for details!" href="/Details.aspx?PropID=869&GroupID=0" target="_blank">
            <area shape="RECT" coords="226,1425,301,1434" alt="River Street Apt - click for details!" title="River Street Apt - click for details!" href="/Details.aspx?PropID=705&GroupID=0" target="_blank">
            <area shape="POLY" coords="990,1378,988,1390,1088,1412,1080,1399" alt="Redwood Inn and Suites - click for details!" title="Redwood Inn and Suites - click for details!" href="/Details.aspx?PropID=818&GroupID=45" target="_blank">
            <area shape="POLY" coords="943,1113,948,1125,1011,1096,1006,1084" alt="Sunset Waters - click for details!" title="Sunset Waters - click for details!" href="/Details.aspx?PropID=851&GroupID=0" target="_blank">
            <area shape="RECT" coords="1104,761,1160,775" alt="Bass Haven" href="/Details.aspx?PropID=877&GroupID=0" target="_blank">
            <area shape="POLY" coords="440,862,437,869,446,866,447,859" href="/Details.aspx?PropID=881&GroupID=0" alt="Dandy-Li Inn Apt - click for details!">
            <area shape="RECT" coords="625,917,629,927" alt="Breezy Meadow One and Two - click for details!" href="/Details.aspx?PropID=749&GroupID=0" target="_blank">
            <area shape="POLY" coords="514,844,515,855,590,843,589,832" href="/Details.aspx?PropID=895&GroupID=0" alt="Diamond Dreams" target="_blank">
            <area shape="RECT" coords="402,762,455,773" alt="Thistle Hill" href="/Details.aspx?PropID=900&GroupID=0" target="_blank">
            <area shape="RECT" coords="67,1306,137,1317" alt="Peterson Place" href="/Details.aspx?PropID=903&GroupID=0" target="_blank">
            <area shape="POLY" coords="53,1428,53,1436,129,1427,128,1419" alt="Butternut Cottage" href="/Details.aspx?PropID=902&GroupID=0" target="_blank">
            <area shape="RECT" coords="553,1269,605,1283" alt="Groveside" href="/Details.aspx?PropID=896&GroupID=0" target="_blank">
            <area shape="POLY" coords="131,1383,136,1394,206,1361,201,1350" alt="Blue Cottage" href="/Details.aspx?PropID=893&GroupID=0" target="_blank">
            <area shape="POLY" coords="314,600,317,609,398,587,395,578" href="/Details.aspx?PropID=904&GroupID=49" alt="Creekside Cottages" target="_blank">
            <area shape="POLY" coords="453,895,454,903,504,895,503,887" href="/Details.aspx?PropID=915&GroupID=0" alt="La Virginia" target="_blank">
            <area shape="POLY" coords="457,926,458,934,510,923,507,915" alt="Applewood" href="/Details.aspx?PropID=899&GroupID=0" target="_blank">
            <area shape="POLY" coords="438,1049,438,1057,489,1060,496,1055" alt="Beaver Pond" href="/Details.aspx?PropID=912&GroupID=0" target="_blank">
            <area shape="RECT" coords="212,1395,296,1404" alt="Escape House" href="/Details.aspx?PropID=913&GroupID=50" target="_blank">
            <area shape="RECT" coords="699,557,784,567" href="/Details.aspx?PropID=934&GroupID=0" alt="Crabapple Cottage" target="_blank">
            <area shape="RECT" coords="1076,395,1145,406" alt="Miss Marys" href="/Details.aspx?PropID=918&GroupID=0" target="_blank">
            <area shape="RECT" coords="1076,375,1178,385" alt="Dunlop Carriage House" href="/Details.aspx?PropID=931&GroupID=0">
            <area shape="POLY" coords="550,941,551,948,615,940,612,930" alt="Farmhouse 33" href="/Details.aspx?PropID=917&GroupID=0">
            <area shape="RECT" coords="325,777,410,787" alt="Home Run Cabins" href="/Details.aspx?PropID=922&GroupID=51" target="_blank">
            <area shape="RECT" coords="462,818,508,826" alt="Casa Vista" href="/Details.aspx?PropID=929&GroupID=0" target="_blank">
            <area shape="RECT" coords="574,699,629,710" alt="Miss Marys" href="/Details.aspx?PropID=918&GroupID=0">
            <area shape="POLY" coords="219,878,225,885,281,838,277,831" alt="Dennis Place" href="/Details.aspx?PropID=2020&GroupID=0" target="_blank">
            <area shape="POLY" coords="193,1471,204,1478,225,1426,215,1421" alt="Goose Pond" href="/Details.aspx?PropID=901&GroupID=0" target="_blank">
            <area shape="RECT" coords="334,183,412,193" alt="Bronx Bungalow" href="/Details.aspx?PropID=951&GroupID=0" target="_blank">
            <area shape="RECT" coords="316,204,390,214" alt="Lucky Catch Cove" href="/Details.aspx?PropID=946&GroupID=0" target="_blank">
            <area shape="RECT" coords="514,428,568,442" alt="Apple Hill" href="/Details.aspx?PropID=950&GroupID=0" target="_blank">
            <area shape="RECT" coords="1078,526,1138,537" alt="Nelson Pines" href="/Details.aspx?PropID=941&GroupID=53" target="_blank">
            <area shape="RECT" coords="1078,480,1162,490" alt="Florence Cottage" href="/Details.aspx?PropID=847&GroupID=0" target="_blank">
            <area shape="RECT" coords="446,713,516,725" alt="Vintage House" href="/Details.aspx?PropID=944&GroupID=55" target="_blank">
            <area shape="RECT" coords="517,712,523,726" alt="Vintage House" href="/Details.aspx?PropID=945&GroupID=55" target="_blank">
            <area shape="RECT" coords="520,794,596,806" alt="Cedarwood Apts" href="/Details.aspx?PropID=201&GroupID=9" target="_blank">
            <area shape="POLY" coords="456,876,456,885,501,877,500,868" alt="Ingleside" href="/Details.aspx?PropID=619&GroupID=0" target="_blank">
            <area shape="POLY" coords="961,950,959,958,1017,970,1021,961" alt="Grassy Waters" href="/Details.aspx?PropID=947&GroupID=0" target="_blank">
            <area shape="RECT" coords="815,955,893,965" alt="Castaway Cottage" href="/Details.aspx?PropID=949&GroupID=0" target="_blank">
            <area shape="RECT" coords="160,1211,228,1227" alt="Spruce Ridge" href="/Details.aspx?PropID=608&GroupID=0" target="_blank">
            <area shape="RECT" coords="206,1289,295,1301" alt="Park Ave Apt" href="/Details.aspx?PropID=911&GroupID=0" target="_blank">
            <area shape="RECT" coords="287,297,363,307" alt="Morning Glory" href="/Details.aspx?PropID=1002&GroupID=0" target="_blank">
            <area shape="RECT" coords="189,422,279,438" alt="Angel Hill Retreat" href="/Details.aspx?PropID=994&GroupID=0" target="_blank">
            <area shape="RECT" coords="1079,503,1153,513" alt="Glen Ave Suites" href="/Details.aspx?PropID=780&GroupID=29" target="_blank">
            <area shape="POLY" coords="417,534,407,539,452,579,459,571" alt="Gentle Hills" href="/Details.aspx?PropID=1005&GroupID=0" target="_blank">
            <area shape="POLY" coords="397,534,390,542,447,586,452,580" alt="1880 Schoolhouse" href="/Details.aspx?PropID=997&GroupID=0" target="_blank">
            <area shape="POLY" coords="528,790,532,796,566,773,560,764" alt="Gillrose" href="/Details.aspx?PropID=954&GroupID=0" target="_blank">
            <area shape="RECT" coords="349,939,413,950" alt="Burdick View" href="/Details.aspx?PropID=988&GroupID=0" target="_blank">
            <area shape="POLY" coords="441,953,444,963,521,926,517,917" alt="South Meadow Apts" href="/Details.aspx?PropID=999&GroupID=61" target="_blank">
            <area shape="RECT" coords="599,1006,667,1016" alt="Winding River" href="/Details.aspx?PropID=953&GroupID=0" target="_blank">
            <area shape="POLY" coords="543,1054,537,1061,572,1099,580,1092" alt="Doyles House" href="/Details.aspx?PropID=1011&GroupID=0" target="_blank">
            <area shape="POLY" coords="472,1108,475,1118,543,1089,540,1081" alt="Gracious House" href="/Details.aspx?PropID=987&GroupID=0" target="_blank">
            <area shape="RECT" coords="530,1163,602,1176" alt="Amazing Valley" href="/Details.aspx?PropID=676&GroupID=0" target="_blank">
            <area shape="POLY" coords="526,1237,535,1245,570,1205,556,1201" alt="The Lodge" href="/Details.aspx?PropID=962&GroupID=0" target="_blank">
            <area shape="RECT" coords="196,1239,248,1251" alt="Millstone" href="/Details.aspx?PropID=989&GroupID=0" target="_blank">
            <area shape="RECT" coords="448,1475,506,1489" alt="Fleur De Lis" href="/Details.aspx?PropID=995&GroupID=0" target="_blank">
            <area shape="RECT" coords="84,1495,177,1509" alt="2016 Rockefeller Tree" href="/Details.aspx?PropID=992&GroupID=0" target="_blank">
            <area shape="RECT" coords="231,1364,297,1374" alt="Backstop Apt" href="/Details.aspx?PropID=959&GroupID=0" target="_blank">
            <area shape="RECT" coords="210,1375,298,1384" alt="Chestnut St Players" href="/Details.aspx?PropID=981&GroupID=60" target="_blank">
            <area shape="RECT" coords="302,1375,306,1384" alt="Chestnut St Players" target="_blank">
            <area shape="RECT" coords="310,1375,314,1384" alt="Chestnut St Players" href="/Details.aspx?PropID=983&GroupID=60" target="_blank">
            <area shape="RECT" coords="251,1385,295,1394" alt="City Fox" href="/Details.aspx?PropID=976&GroupID=58" target="_blank">
            <area shape="RECT" coords="301,1385,305,1393" href="/Details.aspx?PropID=977&GroupID=58" target="_blank">
            <area shape="RECT" coords="307,1384,311,1394" href="/Details.aspx?PropID=984&GroupID=58" target="_blank">
            <area shape="RECT" coords="315,1384,319,1394" href="/Details.aspx?PropID=985&GroupID=58" target="_blank">
            <area shape="RECT" coords="221,1405,295,1415" alt="Miller Street Apts" href="/Details.aspx?PropID=978&GroupID=59" target="_blank">
            <area shape="RECT" coords="300,1405,304,1414" href="/Details.aspx?PropID=979&GroupID=59" target="_blank">
            <area shape="RECT" coords="307,1405,311,1415" href="/Details.aspx?PropID=980&GroupID=59" target="_blank">
            <area shape="RECT" coords="222,1414,298,1424" alt="Park Avenue Apt" href="/Details.aspx?PropID=706&GroupID=0" target="_blank">
            <area shape="RECT" coords="302,1416,306,1424" href="/Details.aspx?PropID=911&GroupID=0" target="_blank">
            <area shape="POLY" coords="29,1385,39,1385,41,1293,31,1293" alt="Beaver Bungalow" href="/Details.aspx?PropID=964&GroupID=0" target="_blank">
            <area shape="POLY" coords="48,1341,58,1341,58,1274,48,1274" alt="Possum Lodge" href="/Details.aspx?PropID=1009&GroupID=0" target="_blank">
            <area shape="POLY" coords="87,1342,92,1351,145,1324,138,1316" alt="Phoenix Pond" href="/Details.aspx?PropID=974&GroupID=57" target="_blank">
            <area shape="POLY" coords="96,1400,97,1411,134,1404,132,1394" alt="Aprita" href="/Details.aspx?PropID=1008&GroupID=0" target="_blank">
            <area shape="POLY" coords="136,1339,142,1345,189,1300,180,1293" alt="Awesome Hills" href="/Details.aspx?PropID=991&GroupID=0" target="_blank">
            <area shape="RECT" coords="159,1553,219,1567" alt="Twin Maples" href="/Details.aspx?PropID=963&GroupID=0" target="_blank">
            <area shape="RECT" coords="788,1166,888,1188" alt="Adirondack Waterfront Compound" href="/Details.aspx?PropID=986&GroupID=0" target="_blank">
            <area shape="POLY" coords="1014,1162,1018,1170,1078,1142,1074,1134" alt="Anglewoods" href="/Details.aspx?PropID=789&GroupID=0" target="_blank">
            <area shape="RECT" coords="933,1044,1012,1052" alt="Goodyear Retreat" href="/Details.aspx?PropID=996&GroupID=0" target="_blank">
            <area shape="POLY" coords="914,1040,916,1047,975,1036,972,1027" alt="Lakeside Suite" href="/Details.aspx?PropID=1003&GroupID=0" target="_blank">
            <area shape="POLY" coords="926,991,924,1000,965,1010,967,1001" alt="Mi-An-Ro" href="/Details.aspx?PropID=1006&GroupID=0" target="_blank">
            <area shape="POLY" coords="837,934,836,944,903,956,904,946" alt="Barb's Lakeside" href="/Details.aspx?PropID=965&GroupID=0" target="_blank">
            <area shape="POLY" coords="882,907,889,914,944,862,938,855" alt="Hidden Treasure" href="/Details.aspx?PropID=967&GroupID=0" target="_blank">
            <area shape="POLY" coords="946,954,952,959,1001,904,992,900" alt="Avivas Lakehouse" href="/Details.aspx?PropID=955&GroupID=0" target="_blank">
            <area shape="POLY" coords="831,768,839,774,880,730,870,724" alt="Smiling Pines" href="/Details.aspx?PropID=961&GroupID=0" target="_blank">
            <area shape="RECT" coords="704,765,776,777" alt="Middlefield Hill" href="/Details.aspx?PropID=2027&GroupID=0" target="_blank">
            <area shape="RECT" coords="689,777,778,788" alt="Middlefield Hill Apt" href="/Details.aspx?PropID=2028&GroupID=0" target="_blank">
            <area shape="RECT" coords="16,1311,30,1385" alt="Anderson Acres" href="/Details.aspx?PropID=1021&GroupID=0" target="_blank">
            <area shape="RECT" coords="142,1252,190,1264" alt="Blue Spruce" href="/Details.aspx?PropID=2021&GroupID=0" target="_blank">
            <area shape="RECT" coords="645,1548,724,1564" alt="Augusta Woods" href="/Details.aspx?PropID=1016&GroupID=0" target="_blank">
            <area shape="RECT" coords="223,1433,296,1443" alt="All Stars Retreat" href="/Details.aspx?PropID=2023&GroupID=0" target="_blank">
            <area shape="POLY" coords="594,1501,601,1512,661,1473,654,1462" alt="5 Acres Cottage" href="/Details.aspx?PropID=2026&GroupID=0" target="_blank">
            <area shape="POLY" coords="606,1510,613,1520,654,1492,647,1482" alt="5 Acre Pines" href="/Details.aspx?PropID=2025&GroupID=0" target="_blank">
            <area shape="POLY" coords="211,1528,204,1537,249,1571,256,1561" alt="Rose Glen" href="/Details.aspx?PropID=3029&GroupID=0" target="_blank">
            <area shape="POLY" coords="556,803,554,815,624,830,627,818" alt="Munson Manor" href="/Details.aspx?PropID=2029&GroupID=0" target="_blank">
            <area shape="RECT" coords="333,883,415,895" alt="Double Play Cabins" href="/Details.aspx?PropID=2022&GroupID=62" target="_blank">
            <area shape="RECT" coords="298,328,355,340" alt="Bluewaters" href="/Details.aspx?PropID=776&GroupID=0" target="_blank">
            <area shape="RECT" coords="380,1099,474,1113" alt="Carols Kitchen Huddle" href="/Details.aspx?PropID=1012&GroupID=0" target="_blank">
            <area shape="RECT" coords="505,1434,580,1449" alt="25 Sean Retreat" href="/Details.aspx?PropID=3037&GroupID=0" target="_blank">
            <area shape="RECT" coords="193,1251,250,1262" alt="Vale Haven" href="/Details.aspx?PropID=3039&GroupID=0" target="_blank">
            <area shape="POLY" coords="74,1434,75,1445,146,1437,145,1426" alt="Calhoun Place" href="/Details.aspx?PropID=3038&GroupID=0" target="_blank">
            <area shape="POLY" coords="46,1417,47,1427,119,1420,118,1410" alt="Athletes Place" href="/Details.aspx?PropID=3033&GroupID=0" target="_blank">
            <area shape="RECT" coords="1074,351,1154,363" alt="Abbeys Cottage" href="/Details.aspx?PropID=1015&GroupID=0" target="_blank">
            <area shape="POLY" coords="1004,1156,1008,1164,1072,1135,1068,1127" alt="Beautiful Bay" href="/Details.aspx?PropID=3040&GroupID=0" target="_blank">
            <area shape="RECT" coords="327,192,327,192">
            <area shape="RECT" coords="334,194,393,204" alt="Trout Brook" href="/Details.aspx?PropID=3042&GroupID=63" target="_blank">
            <area shape="RECT" coords="319,195,325,201" alt="Trout Brook" href="/Details.aspx?PropID=3043&GroupID=63" target="_blank">
            <area shape="RECT" coords="269,275,352,288" alt="Arrowhead Cottage" href="/Details.aspx?PropID=3035&GroupID=0" target="_blank">
            <area shape="RECT" coords="263,286,362,297" alt="Arrowhead Bungalow" href="/Details.aspx?PropID=3036&GroupID=0" target="_blank">
            <area shape="POLY" coords="628,720,633,731,716,692,711,681" alt="Bateman Cottage" href="/Details.aspx?PropID=3044&GroupID=0" target="_blank">
            <area shape="POLY" coords="319,587,321,596,381,582,379,573" alt="White Horse" href="/Details.aspx?PropID=3045&GroupID=0" target="_blank">
            <area shape="RECT" coords="423,252,494,263" alt="Decked Out" href="/Details.aspx?PropID=3041&GroupID=0" target="_blank">
            <area shape="RECT" coords="311,1070,396,1083" alt="Dutch Hill Manor" href="/Details.aspx?PropID=3046&GroupID=0" target="_blank">
            <area shape="RECT" coords="298,1070,305,1083" alt="Dutch Hill Manor" href="/Details.aspx?PropID=3047&GroupID=0" target="_blank">
            <area shape="POLY" coords="443,907,444,915,501,903,500,895" alt="Doc Graham" href="/Details.aspx?PropID=3034&GroupID=0" target="_blank">
            <area shape="RECT" coords="49,1478,123,1494" alt="Flying Changes" href="/Details.aspx?PropID=3048&GroupID=0" target="_blank">
            <area shape="POLY" coords="472,1079,477,1089,541,1059,536,1049" alt="Over the Moon" href="/Details.aspx?PropID=958&GroupID=0" target="_blank">
            <area shape="RECT" coords="445,798,452,805" href="/Details.aspx?PropID=585&GroupID=0" alt="1819 Carriage House">
            <area shape="POLY" coords="886,1072,887,1084,959,1072,958,1060" alt="American Eagle" href="/Details.aspx?PropID=3050&GroupID=0" target="_blank">
            <area shape="POLY" coords="77,1392,78,1402,136,1394,135,1384" alt="Nepa Valley" href="/Details.aspx?PropID=3049&GroupID=0" target="_blank">
          </map>
        </div>
      </div>
      </td>
    </tr>
  </table>
  
          </div><!--/col-->
        </div><!--/row-->
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomScripts" runat="Server">
</asp:Content>
