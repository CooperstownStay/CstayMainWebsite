<%@ Page Language="VB" MasterPageFile="~/MasterMinimal.master" AutoEventWireup="false" CodeFile="GoogleMap.aspx.vb" Inherits="GoogleMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" Runat="Server">
  <asp:Literal ID="litCanonical" runat="server" />
  <asp:Literal ID="litTitle" runat="server" />
<style type="text/css">
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #mapTopCenter 
      {
        display:block;margin-top:-40px;
      }
      #map {
        height: 500px;
        width:500px;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      #right-panel {
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

      #right-panel select, #right-panel input {
        font-size: 15px;
      }

      #right-panel select {
        width: 100%;
      }

      #right-panel i {
        font-size: 12px;
      }
      #right-panel {
        height: 100%;
        float: left; /* scott float:right;*/
        width: 410px;
        overflow: auto;
      }
      #map {
        margin-right: 10px;
        float:left; /* scott - wasn't float before */
      }
      #floating-panel {
        background: #fff;
        padding: 5px;
        font-size: 14px;
        font-family: Arial;
        border: 1px solid #ccc;
        box-shadow: 0 2px 2px rgba(33, 33, 33, 0.4);
        display: none;
      }
      @media print {
        #map {
          height: 500px;
          margin: 0;
        }
        #right-panel {
          float: none;
          width: auto;
        }
      }
 
      .adp-summary span {
          padding: 3px 2px;
          background-color: yellow;
      }
      
      
      @media screen and (max-width:768px) 
      {
        #right-panel {
            height:auto;
            float:none;
            width: 100%;
            overflow: auto;
            display: block;
        }
        #map 
        {
          width:100%;
        }
        #mapTopCenter {margin-top:0px;}
      }
      
      .contentBox>.row {
        margin: 0px!important;
      }
      
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TopScripts" Runat="Server">
  <asp:Literal ID="litAutoZoomJS" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="MainBodyContent" runat="Server">
        <div class="row" style="padding:20px;">
          <div class="col-xs-2"><%= GetBackButton()%></div>
          <div class="col-xs-2 col-xs-offset-7 col-sm-offset-8 text-right"><a href="#" class="btn btn-default hidden-print" onclick="window.print();"><i class="fa fa-print" aria-hidden="True" title="Print Map"></i> Print</a></div>
        </div><!--/row-->

        <div class="row" style="padding:0 20px 20px;">
          <div class="col-sm-8 col-sm-offset-2 text-center"><div id="mapTopCenter">Map created by Google&copy; Maps. <span style="font-weight: bold; color: #cc0000">We cannot be responsible for its accuracy.<br /><asp:Literal runat="server" ID="litDirFromAnywhere" /></div></div>
        </div>

        
        <div class="row">
          <div class="col-xs-12">
            <!-- Map  ---------------------->
            <div id="floating-panel">
              <strong>Start:</strong>
              <select id="start">
                <option value="0" selected><%= LocationName %></option>
                <option value="-1"><hr /></option>
                <option value="1">Dreams Park</option>
                <option value="2">All Star Village</option>
                <option value="3">Baseball World</option>
                <option value="-1"><hr /></option>
                <option value="4">Cooperstown, NY</option>
                <option value="-1"><hr /></option>
                <option value="5">Albany Airport</option>
                <option value="6">Syracuse Airport</option>
                <option value="7">Newark Airport</option>
                <option value="8">Boston Airport</option>
                <option value="9">Buffalo Airport</option>
                <option value="10">LaGuardia Airport</option>
                <option value="11">JFK Airport</option>
              </select>
              <br/>
              <strong>End:</strong>
              <select id="end">
                <option value="0"><%= LocationName %></option>
                <option value="-1"><hr /></option>
                <option value="1" <%= IIf(Request("Place") = "CDP" Or Request("Place") = "","selected","") %>>Dreams Park</option>
                <option value="2" <%= IIf(Request("Place") = "ASV","selected","") %>>All Star Village</option>
                <option value="3" <%= IIf(Request("Place") = "BW","selected","") %>>Baseball World</option>
                <option value="-1"><hr /></option>
                <option value="4">Cooperstown, NY</option>
                <option value="-1"><hr /></option>
                <option value="5">Albany Airport</option>
                <option value="6">Syracuse Airport</option>
                <option value="7">Newark Airport</option>
                <option value="8">Boston Airport</option>
                <option value="9">Buffalo Airport</option>
                <option value="10">LaGuardia Airport</option>
                <option value="11">JFK Airport</option>
              </select>
            </div><!--/floating-panel-->
            <div id="map"></div><!--/map-->
            
            <div id="right-panel"></div><!--/right-panel-->
          </div>
        </div><!--/row-->

    <script language="javascript" type="text/javascript">
      /********************************
      ** REFERENCES used to set this up 
      *********************************
      ** to get the framework of the map with dynamic directions:
      ** https://developers.google.com/maps/documentation/javascript/examples/directions-panel
      ** 
      ** to replace direction markers with custom marker icons:
      ** https://stackoverflow.com/questions/4813728/change-individual-markers-in-google-maps-directions-api-v3
      ** 
      ** to setup info windows
      ** https://developers.google.com/maps/documentation/javascript/examples/infowindow-simple
      ** 
      ** to delete markers
      ** https://developers.google.com/maps/documentation/javascript/examples/marker-remove
      **
      ****/


      var map;
      var markers = [];

      /*
      function MapLocation(title, lat, lng, info) {
        this.Title = title;
        this.LAT = lat;
        this.LNG = lng;
        this.LatLng = new google.maps.LatLng(lat,lng);
        this.Info = info;
      }
      */
      
      function MapLocation(title, addr, info) {
        this.Title = title;
        this.Address = addr;
        this.Info = info;
      }

      function initMap() {
        var directionsDisplay = new google.maps.DirectionsRenderer({ suppressMarkers: true });
        var directionsService = new google.maps.DirectionsService;
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 7,
          center: { lat: 41.85, lng: -87.65 }
        });
        
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('right-panel'));

        var control = document.getElementById('floating-panel');
        control.style.display = 'block';
        map.controls[google.maps.ControlPosition.TOP_CENTER].push(control);

        var onChangeHandler = function () {
          calculateAndDisplayRoute(directionsService, directionsDisplay);
        };
        document.getElementById('start').addEventListener('change', onChangeHandler);
        document.getElementById('end').addEventListener('change', onChangeHandler);

        onChangeHandler();  // call this to make have the map go ahead and render the directions on load

      }

      function calculateAndDisplayRoute(directionsService, directionsDisplay) {

        // unable to define loc as a global array for some reason.  So, need to define it twice.
        /*
        var loc = [
                  new MapLocation("<%= LocationTitle %>", <%= LocationLat %>, <%= LocationLng %>, "<%= LocationInfo %>"),
                  new MapLocation("Cooperstown Dreams Park", 42.639084, -74.962572, "<span style=\"font-size:16px; color:#990000; font-weight:bold\" >Cooperstown Dreams Park</span><br />4550 State Highway 28<BR/>Milford,NY 13807"),
                  new MapLocation("All Star Village", 42.468718, -75.102845, "<h4>All Star Village</h4>Route 23 & Route 205<BR/>Oneonta,NY 13820"),
                  new MapLocation("Baseball World", 42.466622, -75.066343, "<h4>Baseball World</h4>Ravine Parkway<BR/>Oneonta,NY 13820"),

                  new MapLocation("Cooperstown Village", 42.7002297, -74.948042, "<h4>Cooperstown Village</h4>Cooperstown, NY"),

                  new MapLocation("Albany Airport", 42.7487124, -73.8054981, "<h4>Albany International Airport</h4>Albany Shaker Rd<br/>Colonie, NY"),
                  new MapLocation("Syracuse Airport", 43.1139301, -76.1101888, "<h4>Syracuse Hancock International Airport</h4>1000 Col Eileen Collins Blvd<br/>Syracuse, NY 13212"),
                  new MapLocation("Newark Airport", 40.6895314, -74.1744624, "<h4>Newark Liberty International Airport</h4>3 Brewster Rd<br/>Newark, NJ 07114"),
                  new MapLocation("Boston Airport", 42.3656132, -71.0095602, "<h4>Boston Logan International Airport</h4>1 Harborside Dr<br/>Boston, MA 02128"),
                  new MapLocation("Buffalo Airport", 42.9397059, -78.7295067, "<h4>Buffalo Niagara International Airport</h4>4200 Genesee St<br/>Buffalo, NY 14225"),
                  new MapLocation("LaGuardia Airport", 40.7769271, -73.8739659, "<h4>LaGuardia Airport</h4>Queens, NY 11371"),
                  new MapLocation("JFK Airport", 40.6413111, -73.7781391, "<h4>John F. Kennedy International Airport</h4>Queens, NY 11430")
                ];
        */
        var loc = [
                  new MapLocation("<%= LocationTitle %>", "<%= LocationAddress %>", "<%= LocationInfo %>"),
                  new MapLocation("Cooperstown Dreams Park", "Cooperstown+Dreams+Park%2C4550+NY-28%2C+Milford%2C+NY+13807", "<span style=\"font-size:16px; color:#990000; font-weight:bold\" >Cooperstown Dreams Park</span><br />4550 State Highway 28<BR/>Milford,NY 13807"),
                  new MapLocation("All Star Village", "Cooperstown+All+Star+Village%2C+4158+NY-23%2C+Oneonta%2C+NY+13820", "<h4>All Star Village</h4>Route 23 & Route 205<BR/>Oneonta,NY 13820"),
                  new MapLocation("Baseball World", "Cooperstown+Baseball+World%2C+1+Blodgett+Dr%2C+Oneonta%2C+NY+13820", "<h4>Baseball World</h4>Ravine Parkway<BR/>Oneonta,NY 13820"),

                  new MapLocation("Cooperstown Village", "73+Main+Street%2C+Cooperstown%2C+NY+13326", "<h4>Cooperstown Village</h4>Cooperstown, NY"),

                  new MapLocation("Albany Airport", "Albany+International+Airport%2C+Albany+Shaker+Rd%2C+Colonie%2C+NY", "<h4>Albany International Airport</h4>Albany Shaker Rd<br/>Colonie, NY"),
                  new MapLocation("Syracuse+Hancock+International+Airport%2C+1000+Col+Eileen+Collins+Blvd%2C+Syracuse%2C+NY+13212", "", "<h4>Syracuse Hancock International Airport</h4>1000 Col Eileen Collins Blvd<br/>Syracuse, NY 13212"),
                  new MapLocation("Newark Airport", "Newark+Liberty+International+Airport%2C+3+Brewster+Rd%2C+Newark%2C+NJ+07114", "<h4>Newark Liberty International Airport</h4>3 Brewster Rd<br/>Newark, NJ 07114"),
                  new MapLocation("Boston Airport", "Boston+Logan+International+Airport%2C+1+Harborside+Dr%2C+Boston%2C+MA+02128", "<h4>Boston Logan International Airport</h4>1 Harborside Dr<br/>Boston, MA 02128"),
                  new MapLocation("Buffalo Airport", "Buffalo+Niagara+International+Airport%2C+4200+Genesee+St%2C+Buffalo%2C+NY+14225", "<h4>Buffalo Niagara International Airport</h4>4200 Genesee St<br/>Buffalo, NY 14225"),
                  new MapLocation("LaGuardia Airport", "LaGuardia+Airport%2C+Queens%2C+NY+11371", "<h4>LaGuardia Airport</h4>Queens, NY 11371"),
                  new MapLocation("JFK Airport", "John+F.+Kennedy+International+Airport%2C+Queens%2C+NY+11430", "<h4>John F. Kennedy International Airport</h4>Queens, NY 11430")
                ];

        var startLocIndex = document.getElementById('start').value;
        var endLocIndex = document.getElementById('end').value;

        var startAddress = loc[startLocIndex].Address;
        var endAddress = loc[endLocIndex].Address;

        directionsService.route({
          origin: startAddress,
          destination: endAddress,
          travelMode: 'DRIVING'
        }, function (response, status) {


          // unable to define loc as a global array for some reason.  So, need to define it twice.
          /*
          var loc = [
                      new MapLocation("<%= LocationTitle %>", <%= LocationLat %>, <%= LocationLng %>, "<%= LocationInfo %>"),
                      new MapLocation("Cooperstown Dreams Park", 42.639084, -74.962572, "<span style=\"font-size:16px; color:#990000; font-weight:bold\" >Cooperstown Dreams Park</span><br />4550 State Highway 28<BR/>Milford,NY 13807"),
                      new MapLocation("All Star Village", 42.468718, -75.102845, "<h4>All Star Village</h4>Route 23 & Route 205<BR/>Oneonta,NY 13820"),
                      new MapLocation("Baseball World", 42.466622, -75.066343, "<h4>Baseball World</h4>Ravine Parkway<BR/>Oneonta,NY 13820"),

                      new MapLocation("Cooperstown Village", 42.7002297, -74.948042, "<h4>Cooperstown Village</h4>Cooperstown, NY"),

                      new MapLocation("Albany Airport", 42.7487124, -73.8054981, "<h4>Albany International Airport</h4>Albany Shaker Rd<br/>Colonie, NY"),
                      new MapLocation("Syracuse Airport", 43.1139301, -76.1101888, "<h4>Syracuse Hancock International Airport</h4>1000 Col Eileen Collins Blvd<br/>Syracuse, NY 13212"),
                      new MapLocation("Newark Airport", 40.6895314, -74.1744624, "<h4>Newark Liberty International Airport</h4>3 Brewster Rd<br/>Newark, NJ 07114"),
                      new MapLocation("Boston Airport", 42.3656132, -71.0095602, "<h4>Boston Logan International Airport</h4>1 Harborside Dr<br/>Boston, MA 02128"),
                      new MapLocation("Buffalo Airport", 42.9397059, -78.7295067, "<h4>Buffalo Niagara International Airport</h4>4200 Genesee St<br/>Buffalo, NY 14225"),
                      new MapLocation("LaGuardia Airport", 40.7769271, -73.8739659, "<h4>LaGuardia Airport</h4>Queens, NY 11371"),
                      new MapLocation("JFK Airport", 40.6413111, -73.7781391, "<h4>John F. Kennedy International Airport</h4>Queens, NY 11430")
                    ];
          */
          var loc = [
                  new MapLocation("<%= LocationTitle %>", "<%= LocationAddress %>", "<%= LocationInfo %>"),
                  new MapLocation("Cooperstown Dreams Park", "Cooperstown+Dreams+Park%2C4550+NY-28%2C+Milford%2C+NY+13807", "<span style=\"font-size:16px; color:#990000; font-weight:bold\" >Cooperstown Dreams Park</span><br />4550 State Highway 28<BR/>Milford,NY 13807"),
                  new MapLocation("All Star Village", "Cooperstown+All+Star+Village%2C+4158+NY-23%2C+Oneonta%2C+NY+13820", "<h4>All Star Village</h4>Route 23 & Route 205<BR/>Oneonta,NY 13820"),
                  new MapLocation("Baseball World", "Cooperstown+Baseball+World%2C+1+Blodgett+Dr%2C+Oneonta%2C+NY+13820", "<h4>Baseball World</h4>Ravine Parkway<BR/>Oneonta,NY 13820"),

                  new MapLocation("Cooperstown Village", "73+Main+Street%2C+Cooperstown%2C+NY+13326", "<h4>Cooperstown Village</h4>Cooperstown, NY"),

                  new MapLocation("Albany Airport", "Albany+International+Airport%2C+Albany+Shaker+Rd%2C+Colonie%2C+NY", "<h4>Albany International Airport</h4>Albany Shaker Rd<br/>Colonie, NY"),
                  new MapLocation("Syracuse+Hancock+International+Airport%2C+1000+Col+Eileen+Collins+Blvd%2C+Syracuse%2C+NY+13212", "", "<h4>Syracuse Hancock International Airport</h4>1000 Col Eileen Collins Blvd<br/>Syracuse, NY 13212"),
                  new MapLocation("Newark Airport", "Newark+Liberty+International+Airport%2C+3+Brewster+Rd%2C+Newark%2C+NJ+07114", "<h4>Newark Liberty International Airport</h4>3 Brewster Rd<br/>Newark, NJ 07114"),
                  new MapLocation("Boston Airport", "Boston+Logan+International+Airport%2C+1+Harborside+Dr%2C+Boston%2C+MA+02128", "<h4>Boston Logan International Airport</h4>1 Harborside Dr<br/>Boston, MA 02128"),
                  new MapLocation("Buffalo Airport", "Buffalo+Niagara+International+Airport%2C+4200+Genesee+St%2C+Buffalo%2C+NY+14225", "<h4>Buffalo Niagara International Airport</h4>4200 Genesee St<br/>Buffalo, NY 14225"),
                  new MapLocation("LaGuardia Airport", "LaGuardia+Airport%2C+Queens%2C+NY+11371", "<h4>LaGuardia Airport</h4>Queens, NY 11371"),
                  new MapLocation("JFK Airport", "John+F.+Kennedy+International+Airport%2C+Queens%2C+NY+11430", "<h4>John F. Kennedy International Airport</h4>Queens, NY 11430")
                ];


          if (status === 'OK') {
            directionsDisplay.setDirections(response);

            // put info windows on the pins

            var leg = response.routes[0].legs[0];

            var startLocIndex = document.getElementById('start').value;
            var endLocIndex = document.getElementById('end').value;

            deleteMarkers();

            makeMarker(leg.start_location, loc[startLocIndex].Title, loc[startLocIndex].Info, "A");
            makeMarker(leg.end_location, loc[endLocIndex].Title, loc[endLocIndex].Info, "B");

          } else {
            window.alert('Directions request failed due to ' + status);
          }
        });
      }


      // Sets the map on all markers in the array.
      function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(map);
        }
      }

      // Removes the markers from the map, but keeps them in the array.
      function clearMarkers() {
        setMapOnAll(null);
      }

      // Deletes all markers in the array by removing references to them.
      function deleteMarkers() {
        clearMarkers();
        markers = [];
      }


      function makeMarker(position,  title, info, label) {
        

        var infowindow = new google.maps.InfoWindow({
          content: info
        });

        var marker = new google.maps.Marker({
          position: position,
          map: map,
          title: title,
          label: {
            text: label,
            color: 'white',
            fontWeight: 'bold'
          }
        });

        marker.addListener('click', function () {
          infowindow.open(map, marker);
        });

        markers.push(marker);

      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBNa06bfYAX8zS1nMXCvuQM1rKXqJw6_DY&callback=initMap">
    </script>


    <!----------------------/ Map  -->
    
        <div class="row" style="padding:20px 20px 0px;">
          <div class="col-sm-8 col-sm-offset-2 text-center">Map created by Google&copy; Maps. <span style="font-weight: bold; color: #cc0000">We cannot be responsible for its accuracy.</div>
        </div>

        <div class="row hidden-print" style="padding:20px;">
          <div class="col-xs-2"><%= GetBackButton()%></div>
          <div class="col-xs-2 col-xs-offset-8 text-right"><a href="#" class="btn btn-default hidden-print" onclick="window.print();"><i class="fa fa-print" aria-hidden="True" title="Print Map"></i> Print</a></div>
        </div><!--/row-->

</asp:Content>

