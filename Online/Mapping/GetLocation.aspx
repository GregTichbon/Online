<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetLocation.aspx.cs" Inherits="Online.Mapping.GetLocation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Whanganui District Council - Get Location</title>
    <link href='../Scripts/colorbox/colorbox.css' rel="stylesheet" />
    <link href='../Scripts/ToolTipster/css/tooltipster.css' rel="stylesheet" />
        
    <style>
	html, body {
		height: 100%;
		margin: 0;
		padding: 0;
	}
	.controls {
		margin-top: 10px;
		border: 1px solid transparent;
		border-radius: 2px 0 0 2px;
		box-sizing: border-box;
		-moz-box-sizing: border-box;
		height: 32px;
		outline: none;
		box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
	}
	
	#pac-input {
		background-color: #fff;
		font-family: Roboto;
		font-size: 15px;
		font-weight: 300;
		margin-left: 12px;
		padding: 0 11px 0 13px;
		text-overflow: ellipsis;
		width: 300px;
	}
	
	#pac-input:focus {
		border-color: #4d90fe;
	}
	
	.pac-container {
		font-family: Roboto;
	}
	
	#type-selector {
		color: #fff;
		background-color: #4d90fe;
		padding: 5px 11px 0px 11px;
	}
	
	#type-selector label {
		font-family: Roboto;
		font-size: 13px;
		font-weight: 300;
	}
	#target {
		width: 345px;
	}
	
	div#map{
		width:100%;
		height:86%;
		float:left;
	}
	
	
	.message-box { text-align: center; padding: 5px; color:#545454; width:80%;  margin:5px auto; font-size:12px;}
	.clean { background-color: #efefef; border-top: 2px solid #dedede; border-bottom: 2px solid #dedede; }
	.info  { background-color: #f7fafd; border-top: 2px solid #b5d3ff; border-bottom: 2px solid #b5d3ff; }
	.ok    { background-color: #d7f7c4; border-top: 2px solid #82cb2f; border-bottom: 2px solid #82cb2f; }
	.alert { background-color: #fef5be; border-top: 2px solid #fdd425; border-bottom: 2px solid #fdd425; }
	.error { background-color: #ffcdd1; border-top: 2px solid #e10c0c; border-bottom: 2px solid #e10c0c; }	  
	  
	  
	  
</style>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/jquery-2.1.4.min.js'></script>
    <!--<script src='http://wdc.whanganui.govt.nz/eservices/Scripts/polygon/polygon.min.js'></script>-->
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/polygon/polygon.min.js'></script>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/wdc.js'></script>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/ToolTipster/js/jquery.tooltipster.min.js'></script>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/colorbox/jquery.colorbox-min.js'></script>

      <script type="text/javascript">

          $(document).ready(function () {
              //alert('Loaded');
              $("#pagehelp").colorbox({ href: "getlocationhelp.html", iframe: true, height: "400", width: "400", overlayClose: false, escKey: false });
          });

    </script>

</head>
<body>

    <table width="100%" border="0" cellpadding="5" cellspacing="0">
  <tr>
    <td nowrap style="width:10px">Please enter a short description of the location:
    </td>
    <td>
    <input id="location" type="text" name="location" maxlength="50" style="width:99%" /> 
    </td>
    <td nowrap style="width:1px" id="instructions"><a id="pagehelp"><img src="http://wdc.whanganui.govt.nz/online/images/questionsmall.png" /></a></td> 
  </tr>
</table>


<input id="pac-input" class="controls" type="text" placeholder="Search Box">

<div id="map"></div>
<script>
    // This adds a search box to a map, using the Google Place Autocomplete
    // feature. People can enter geographical searches. The search box will return a
    // pick list containing a mix of places and predicted search terms.

    function initAutocomplete() {

        $('#location').val(GetQueryStringParams('location'),'');

        var p = GetQueryStringParams('p','');

        if (p == "") {
            p = '-39.9330677,175.04865760000007,15';
        }

        //var p = '-39.9330677,175.04865760000007,15,-39.93020846782817,175.04868507385254,-39.93178806423581,175.0489854812622,-39.93096536232208,175.05374908447266,-39.92767445578548,175.0541353225708';
        var params = p.split(',');
        var lat = parseFloat(params[0]);
        var lng = parseFloat(params[1]);
        var zoom = parseFloat(params[2]);

        var map = new google.maps.Map(document.getElementById('map'), {
            center: { lat: lat, lng: lng },
            zoom: zoom,
            mapTypeId: google.maps.MapTypeId.HYBRID
        });


        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

         // using this method for now.  Means that, if a pre-defined area is displayed the user can 

        var coords = '';
        if (params.length >= 5) {

            var myCoords = [];
            comma = '';

            for (var i = 3; i < params.length - 1; i += 2) {
                lat = parseFloat(params[i]);
                lng = parseFloat(params[i + 1]);
                myCoords.push(new google.maps.LatLng(lat, lng));
                coords = coords + comma + lat + ',' + lng;
                comma = ',';
            }


            myarea = new google.maps.Polygon({
                paths: myCoords,
                strokeColor: '#FF0000',
                strokeOpacity: 0.8,
                strokeWeight: 3,
                fillColor: '#FF0000',
                fillOpacity: 0.35
            });

            myarea.setMap(map);

        } else {
            myarea = new google.maps.Polygon();
            myarea.setMap(null);
        }



        var creator = new PolygonCreator(map);

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        if (1 == 2) {

            //draw option

            for (var i = 3; i < params.length - 1; i += 2) {
                lat = parseFloat(params[i]);
                lng = parseFloat(params[i + 1]);
                flag = new google.maps.LatLng(lat, lng);  
                creator.pen.draw(flag);   
            }
            lat = parseFloat(params[3]);  
            lng = parseFloat(params[4]);  

            flag = new google.maps.LatLng(lat, lng);   

            creator.pen.setCurrentDot(flag);

            creator.pen.draw(flag); 
        } 

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        if (1 == 2) {

            //drawPloygon option

            var myCoords = [];  

            for (var i = 3; i < params.length - 1; i += 2) {
                lat = parseFloat(params[i]);
                lng = parseFloat(params[i + 1]);
                myCoords.push(new google.maps.LatLng(lat, lng)); 
            }

            creator.pen.drawPloygon(myCoords); 

        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        //alert(myarea.getType());

        //reset
        $('#reset').click(function () {
            if (myarea.map != null) {
                myarea.setMap(null);
            }
            creator.destroy();
            creator = null;
            creator = new PolygonCreator(map);
        });

        //show paths
        $('#selectData').click(function () {
            var location = $('#location').val();
            if (location == '') {
                alert('Please enter a short description of the location');
                return;
            } 

            if (myarea.map != null) {
                coords = map.getCenter() + ',' + map.getZoom() + ',' + coords;
            }
            else {
                if (null == creator.showData()) {
                    alert('Please draw an area');
                    return;
                } 
                var path = creator.showData();
                path = path.replace(/\)\(/g, ',');
                coords = map.getCenter() + ',' + map.getZoom() + ',' + path;
            }
            var line = GetQueryStringParams('line','');
            coords = coords.replace(/\(|\)| /g, '');
            window.parent.passlocation(line, location, coords);
        });

        // Create the search box and link it to the UI element.
        var input = document.getElementById('pac-input');
        var searchBox = new google.maps.places.SearchBox(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        // Bias the SearchBox results towards current map's viewport.
        map.addListener('bounds_changed', function () {
            searchBox.setBounds(map.getBounds());
        });

        var markers = [];
        // [START region_getplaces]
        // Listen for the event fired when the user selects a prediction and retrieve
        // more details for that place.
        searchBox.addListener('places_changed', function () {
            var places = searchBox.getPlaces();

            if (places.length == 0) {
                return;
            }

            // Clear out the old markers.
            markers.forEach(function (marker) {
                marker.setMap(null);
            });
            markers = [];

            // For each place, get the icon, name and location.
            var bounds = new google.maps.LatLngBounds();
            places.forEach(function (place) {
                var icon = {
                    url: place.icon,
                    size: new google.maps.Size(71, 71),
                    origin: new google.maps.Point(0, 0),
                    anchor: new google.maps.Point(17, 34),
                    scaledSize: new google.maps.Size(25, 25)
                };

                // Create a marker for each place.
                markers.push(new google.maps.Marker({
                    map: map,
                    icon: icon,
                    title: place.name,
                    position: place.geometry.location
                }));

                if (place.geometry.viewport) {
                    // Only geocodes have viewport.
                    bounds.union(place.geometry.viewport);
                } else {
                    bounds.extend(place.geometry.location);
                }
            });

            map.fitBounds(bounds);
        });
        // [END region_getplaces]
    }
    </script>

    <br />
<table width="100%" border="0" cellpadding="5" cellspacing="0">
  <tr>
    <td><input id="reset" value="Reset" type="button" style="width:100%" />
    </td>
    <td>
    <input id="selectData"  value="Select" type="button" style="width:100%" />
    </td>
  </tr>
</table>
    <script>
        $('[title]').tooltipster();    </script>
 
    <script src="https://maps.googleapis.com/maps/api/js?libraries=places&callback=initAutocomplete" async defer></script>   


</body>
</html>

