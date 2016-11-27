<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowLocation.aspx.cs" Inherits="Online.Mapping.ShowLocation" %>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Whanganui District Council - Show Location</title>
  <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
    </style>
            <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/wdc.js'></script>
</head>
<body>
<div id="map"></div>
    <script>

        // This example creates a simple polygon 
        // When the user clicks on the polygon an info window opens, showing
        // information about the polygon's coordinates.

        //    /Mapping/ShowLocation.aspx?p=-39.9330677,175.04865760000007,10,-39.93020846782817,175.04868507385254,-39.93178806423581,175.0489854812622,-39.93096536232208,175.05374908447266,-39.92767445578548,175.0541353225708


        var map;
        var infoWindow;
        var params = GetQueryStringParams('p').split(',');
        var lat = parseFloat(params[0]);
        var lng = parseFloat(params[1]);
        var zoom = parseFloat(params[2]);

        //alert(lat);
        //alert(lng);

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                zoom: zoom,
                center: { lat: lat, lng: lng },
                mapTypeId: google.maps.MapTypeId.HYBRID
            });

            // Define the LatLng coordinates for the polygon.

            var myCoords = [];
            for (var i = 3; i < params.length - 1; i += 2) {
                lat = parseFloat(params[i]);
                lng = parseFloat(params[i+1]);
                myCoords.push(new google.maps.LatLng(lat, lng));
            }

            // Construct the polygon.
            var myarea = new google.maps.Polygon({
                paths: myCoords,
                strokeColor: '#FF0000',
                strokeOpacity: 0.8,
                strokeWeight: 3,
                fillColor: '#FF0000',
                fillOpacity: 0.35
            });
            myarea.setMap(map);

            //// Add a listener for the click event.
            //myarea.addListener('click', showArrays);

            //infoWindow = new google.maps.InfoWindow;
        }

        ///** @this {google.maps.Polygon} */
        //function showArrays(event) {
        //    // Since this polygon has only one path, we can call getPath() to return the
        //    // MVCArray of LatLngs.
        //    var vertices = this.getPath();

        //    var contentString = '<b>My polygon</b><br>' +
        //        'Clicked location: <br>' + event.latLng.lat() + ',' + event.latLng.lng() +
        //        '<br>';

        //    // Iterate over the vertices.
        //    for (var i = 0; i < vertices.getLength() ; i++) {
        //        var xy = vertices.getAt(i);
        //        contentString += '<br>' + 'Coordinate ' + i + ':<br>' + xy.lat() + ',' +
        //            xy.lng();
        //    }

        //    // Replace the info window's content and position.
        //    infoWindow.setContent(contentString);
        //    infoWindow.setPosition(event.latLng);

        //    infoWindow.open(map);
        //}

    </script>
       <script async defer src="https://maps.googleapis.com/maps/api/js?signed_in=true&callback=initMap"></script>


</body>
</html>
