
function EditContent(URL, width, height) {
  var wf = "";
  width = 500; 
	wf = wf + "width=" + width ;
	wf = wf + ",height=" + height;
	wf = wf + ",resizable=yes";
	wf = wf + ",scrollbars=yes";
	wf = wf + ",menubar=no";
	wf = wf + ",toolbar=no";
	wf = wf + ",directories=no";
	wf = wf + ",location=no";
	wf = wf + ",status=no";
	window.open(URL, "", wf);
}


function ImageSlideshow(URL) {
	var wf = "";
	wf = wf + "width=500" ;
	wf = wf + ",height=500" ;
	wf = wf + ",resizable=no";
	wf = wf + ",scrollbars=no";
	wf = wf + ",menubar=no";
	wf = wf + ",toolbar=no";
	wf = wf + ",directories=no";
	wf = wf + ",location=no";
	wf = wf + ",status=no";
	window.open(URL, "", wf);
}

function getAnchorPosition(anchorName) {
  for (var i = 0; i < window.document.anchors.length; i++) {
    if (window.document.anchors[i].name == anchorName) var anchor = window.document.anchors[i];
  }
  if (document.layers) {
    return { x: anchor.x, y: anchor.y };
  }
  else if (document.getElementById) {
    var coords = { x: 0, y: 0 };
    while (anchor) {
      coords.x += anchor.offsetLeft;
      coords.y += anchor.offsetTop;
      anchor = anchor.offsetParent;
    }
    return coords;
  }
}
function ScrollMeTo(link) {
  var coords = getAnchorPosition(link.hash.substring(1));
  scrollTo(coords.x, coords.y);
}


function ReloadPage(sAnchor, oWindow) {
  oWindow.location.href = sAnchor;
//  oWindow.document.DoScroll()
  oWindow.location.reload(true);
}


var sTagRoot = 'ctl00_cphMaster_'

function MyGetElementById(sID) {
	var oObj = document.getElementById(sID)
	if (oObj == null) {
		sID = sTagRoot + sID
		oObj = document.getElementById(sID)
	}
	//            alert(sID + " : " + oObj)
	return oObj;
}
function MyGetElementByPartialId(partialid, tagname) {

	// Find an element by it's ID even if the ID has been extended by Master Pages or other means
	var re = new RegExp(partialid, 'g');
	if (tagname == '' || tagname == null) tagname = '*';
	var elems = document.getElementsByTagName(tagname), i = 0, el;
	while (el = elems[i++]) {
		if (el.id.match(re)) {
			return el;
			break;
		}
	}
	// If didn't get it by limiting to tagname, try 'em all
	if (tagname != "*") {
		tagname = "*";
		var elems = document.getElementsByTagName(tagname), i = 0, el;
		while (el = elems[i++]) {
			if (el.id.match(re)) {
				return el;
				break;
			}
		}
	}
	return null;
}

var lastLayerDisplayed = null;

function DisplayLayer(on, id) {
	if (on == 1) {
		if (lastLayerDisplayed != null && lastLayerDisplayed != id) MyGetElementById(lastLayerDisplayed).style.display = "none";
		MyGetElementById(id).style.display = "block";
		lastLayerDisplayed = id;
	}
	else
		MyGetElementById(id).style.display = "none";
}

function ShowBalloon(id, url, alt) {

	try {
		var img = MyGetElementById(id + '_balloon')
		if (url) {
			img.src = url;
			DisplayLayer(1, id);
		}
		else
			DisplayLayer(0, id);
	}
	catch (ex) { }
}

function scrollToAnchor(aid) {
  var aTag = $("a[name='" + aid + "']");
  $('html,body').animate({ scrollTop: $("a[name='" + aid + "']").offset().top }, 'slow');
}