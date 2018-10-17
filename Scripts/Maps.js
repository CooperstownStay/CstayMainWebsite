var iImgScaleH = 0
var iImgScaleW = 0
var iYScrollZoom = 0;
var iXScrollZoom = 0;
var iOrigMapControlTop = 0;
var iLastScrollTop = 0;
var iLastScrollLeft = 0;

var iIncr = 250;
var iSpeed = 400;
var iImgSizeIncr = 150;
var iPropsInitialized = 0
var iOrigImgHeight =0
var iOrigImgWidth = 0
var iPegHeight = 0
var iPegWidth = 0
  var iImgScaleH = 0
  var iImgScaleW = 0


function MapZoom(iInIncr, iInOrigImgHeight, iInOrigImgWidth, iInSpeed) {
  var iCurrImgHeight = parseFloat($("#MapImage").height())
  var iCurrImgWidth = parseFloat($("#MapImage").width())
  iImgScaleH = parseFloat(iCurrImgHeight + iInIncr) / parseFloat(iInOrigImgHeight)
  iImgScaleW = parseFloat(iCurrImgWidth + iInIncr) / parseFloat(iInOrigImgWidth)
  //console.log(iCurrImgHeight + " : " + iCurrImgWidth + " : " + iImgScaleH + " : " + iImgScaleW + " : " + iInIncr)
  $("#MapImage").animate({ width: iCurrImgWidth + iInIncr }, { queue: false, duration: iInSpeed })
  $("#MapImage").animate({ height: iCurrImgHeight + iInIncr }, { queue: false, duration: iInSpeed })
  window.setTimeout(AfterMapZoom,iInSpeed)
}


function AfterMapZoom() {
  AdjustAreaMapCoords(iImgScaleH, iImgScaleW)
  AdjustAreaMapPegs(iImgScaleH, iImgScaleW)
  MoveAreaMapPegs()
}

function AdjustAreaMapCoords(iScaleH, iScaleW) {

  $("area").each(function (iIndex, eArea) {
    var iOrigCoords = $(eArea).attr("origCoords").split(",")
    var iCoords = $(eArea).attr("coords").split(",")
    var iArrLen = iCoords.length;
    for (var i = 0; i < iArrLen; i += 2) {
      iCoords[i] = parseInt(parseInt(iOrigCoords[i]) * iScaleW)
      iCoords[i + 1] = parseInt(parseInt(iOrigCoords[i + 1]) * iScaleH)
    }
    $(eArea).attr("coords", iCoords.join(","))
  });


}

function AdjustAreaMapPegs(iScaleH, iScaleW) {

  var iCurrScrollTop = $("#MapDiv").scrollTop();
  var iCurrScrollLeft = $("#MapDiv").scrollLeft();
  $(".MapPeg").each(function (iIndex, ePeg) {

    if (($(ePeg).attr("id") != '') && ($(ePeg).attr("id") != 'SampleMapPeg')) {
//      alert($(ePeg).attr("id") + " : " + $(ePeg).attr("origLeft") + " : " + $(ePeg).attr("origTop") + " : " + $(ePeg).css("left") + " : " + $(ePeg).css("top") + " : " + iScaleW + " : " + iScaleH + " : " + iCurrScrollLeft + " : " + iCurrScrollTop)
      //          var iNewLeft = (iScaleW * (parseInt($(ePeg).css("left")) + iPegWidth)) - iPegWidth
      var iOrigLeft = parseInt($(ePeg).attr("origLeft"))
      var iOrigTop = parseInt($(ePeg).attr("origTop")) + iPegHeight
      var iNewLeft = parseInt(iScaleW * iOrigLeft)
      var iNewTop = parseInt(iScaleH * iOrigTop) - iPegHeight
//      alert($(ePeg).attr("id") + " : " + iOrigLeft + " : " + iOrigTop + " : " + iNewLeft + " : " + iNewTop + " : " + iCurrScrollLeft + " : " + iCurrScrollTop)
      $(ePeg).css("left", iNewLeft - iCurrScrollLeft)
      $(ePeg).css("top", iNewTop - iCurrScrollTop)
      //            alert($(ePeg).css("left") + " : " + $(ePeg).css("top") )
                        SetMapPegVisibility(ePeg, iNewLeft, iNewTop)
    }
  });
}

function AdjustPegsForIEOnInitailize() {
  // BJR horrible kluge to handle IE not getting scroll position the way others do
  // 11.8.11 - for some reason don;t need this now...
  //if ($.browser.msie && false) {
  //  $(".MapPeg").each(function (iIndex, ePeg) {
  //    if ($(ePeg).attr("id") != '') {
  //      var iCurrTop = parseInt($(ePeg).css("top"))
  //      var iOrigTop = parseInt($(ePeg).attr("origTop"))
  //      $(ePeg).css("top", iCurrTop - 18)
  //      $(ePeg).attr("origTop", iOrigTop - 18)
  //    }

  //  });
  //}
}


function MoveAreaMapPegs() {
  var iScrollX = 0
  var iScrollY = 0
  var iCurrScrollTop = $("#MapDiv").scrollTop();
  var iCurrScrollLeft = $("#MapDiv").scrollLeft();
  //        var oMapPos = $("#MapDiv").offset()

  iScrollY = iLastScrollTop - iCurrScrollTop
  iScrollX = iLastScrollLeft - iCurrScrollLeft
  //        alert(iLastScrollTop + " : " + iCurrScrollTop + " : " + iLastScrollLeft + " : " + iCurrScrollLeft)

  $(".MapPeg").each(function (iIndex, ePeg) {

    if ($(ePeg).attr("id") != '') {
      var iOrigLeft = parseInt($(ePeg).attr("origLeft"))
      var iOrigTop = parseInt($(ePeg).attr("origTop"))
      var iCurrLeft = parseInt($(ePeg).css("left"))
      var iCurrTop = parseInt($(ePeg).css("top"))
      var iNewLeft = iCurrLeft + iScrollX
      var iNewTop = iCurrTop + iScrollY
      SetMapPegVisibility(ePeg, iNewLeft, iNewTop)
      $(ePeg).css("left", iNewLeft)
      $(ePeg).css("top", iNewTop)
      $(ePeg).css("origLeft", iOrigLeft + iScrollX)
      $(ePeg).css("origTop", iOrigTop + iScrollY)
    }
  });
}

function SetMapPegVisibility(ePeg, iNewLeft, iNewTop) {

  var iMapDivRight = parseInt($("#MapDiv").css("width"))
  var iMapDivBottom = parseInt($("#MapDiv").css("height"))
  if (iNewLeft < 0 || iNewLeft > iMapDivRight || iNewTop < 0 || iNewTop > iMapDivBottom) {
    $(ePeg).css("visibility", "hidden")
  } else {
    $(ePeg).css("visibility", "visible")
  }
}

function MoveToPeg(sPeg) {
  var iPegTop = parseInt($(sPeg).css("top"))
  var iPegLeft = parseInt($(sPeg).css("left"))
  MoveToPoint(iPegTop, iPegLeft)
}

function MoveToPoint(iPegTop, iPegLeft) {

  iLastScrollTop = $("#MapDiv").scrollTop();
  iLastScrollLeft = $("#MapDiv").scrollLeft();

//  var iPegTop = parseInt($(sPeg).css("top"))
//  var iPegLeft = parseInt($(sPeg).css("left"))
  var iMapWidth = parseInt($("#MapImage").css("width"))
  var iMapHeight = parseInt($("#MapImage").css("height"))
  var iMapDivWidth = parseInt($("#MapDiv").css("width")) / 2
  var iMapDivHeight = parseInt($("#MapDiv").css("height")) / 4
  if (iPegTop > iMapDivHeight) { iYScrollZoom = iPegTop - iMapDivHeight }
  if (iPegLeft > iMapDivWidth) { iXScrollZoom = iPegLeft - iMapDivWidth }

  iLastScrollTop = $("#MapDiv").scrollTop();
  iLastScrollLeft = $("#MapDiv").scrollLeft();
//          alert(iPegTop + ":" + iPegLeft + ":" + iYScrollZoom + ":" + iXScrollZoom + ":" + iMapDivHeight + ":" + iMapDivWidth)
  $("#MapDiv").scrollTo('+=' + iYScrollZoom + 'px', 200, { axis: 'y', onAfter: XScrollAfterYScroll })

}
function XScrollAfterYScroll() {

  MoveAreaMapPegs()
  iLastScrollTop = $("#MapDiv").scrollTop();
  iLastScrollLeft = $("#MapDiv").scrollLeft();
  $("#MapDiv").scrollTo('+=' + iXScrollZoom + 'px', 200, { axis: 'x', onAfter: MoveAreaMapPegs })

}




