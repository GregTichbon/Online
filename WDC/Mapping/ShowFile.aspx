<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowFile.aspx.cs" Inherits="Online.Mapping.ShowFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script src='http://wdc.whanganui.govt.nz/eservices/Scripts/wdc.js'></script>
    <script>
        var colourindex = 0;

        function colourselector(n) {
            var z = 'hsl(' + (n * 30) + ',100%,50%)';
            return z
        }
    </script>
</head>
<body>

    <div id="map"></div>
    <script>
        var mapinfo = $("<div/>").html('<%:mapinfo%>').text();

        // This example creates a simple polygon 
        // When the user clicks on the polygon an info window opens, showing
        // information about the polygon's coordinates.

        //    /Mapping/ShowFile.aspx?p=-39.9330677,175.04865760000007,14

        var zindex = 0;
        var map;
        var infoWindow;

        //var params = GetQueryStringParams('p').split(',');
        //var lat = parseFloat(params[0]);
        //var lng = parseFloat(params[1]);
        //var zoom = parseFloat(params[2]);
        var lat = -39.9330677;
        var lng = 175.04865760000007;
        var zoom = 14;

        //alert(lat);
        //alert(lng);

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                zoom: zoom,
                center: { lat: lat, lng: lng },
                mapTypeId: google.maps.MapTypeId.HYBRID
            });

            // Define the LatLng coordinates for the polygon.

            //var areas = [];
            //areas[0] = 'BC123/2016,-39.93020846782817, 175.04868507385254, -39.93178806423581, 175.0489854812622, -39.93096536232208, 175.05374908447266, -39.92767445578548, 175.0541353225708';
            //areas[1] = 'BC206/2016,-39.93120846782817, 175.04968507385254, -39.93278806423581, 175.0499854812622, -39.93196536232208, 175.05474908447266, -39.92867445578548, 175.0551353225708';
            //areas[2] = 'BC153/2016,-39.93320846782817, 175.04468507385254, -39.93878806423581, 175.0429854812622, -39.93196536232208, 175.05474908447266, -39.92867445578548, 175.0551353225708';

            areas = $.parseJSON(mapinfo);
            //areas = $.parseJSON('[{"title":"CRM16/0101318","location":"211321","coords":"-39.9330677,175.04865760000007,15,-39.92891317155352,175.04746842358145,-39.93180353097726,175.04672212577134,-39.931059479942,175.05011801651562","colour":1,"pr_ctr":"231099","description":"Business Name"}]');

            for (var j = 0; j < areas.length; j += 1) {
                coords = areas[j].coords.split(',');

                var myCoords = [];
                for (var i = 3; i < coords.length; i += 2) {
                    lat = parseFloat(coords[i]);
                    lng = parseFloat(coords[i + 1]);
                    myCoords.push(new google.maps.LatLng(lat, lng));
                }

                // Construct the polygon.
                var myarea = new google.maps.Polygon({
                    paths: myCoords,
                    strokeColor: colourselector(colourindex),
                    strokeOpacity: 0.8,
                    strokeWeight: 3,
                    fillColor: colourselector(colourindex),
                    fillOpacity: 0.35,
                    mytitle: areas[j].title,
                    pr_ctr: areas[j].pr_ctr
                });

                myarea.setMap(map);
                google.maps.event.addListener(myarea, 'click', showInfo);

                google.maps.event.addListener(myarea, 'rightclick', sendback);

                colourindex += 1;
            }



            //// Add a listener for the click event.



            infoWindow = new google.maps.InfoWindow;
        }

        function sendback(event) {
            this.set('zIndex', --zindex);
        }

        ///** @this {google.maps.Polygon} */
            function showInfo(event) {
                // Since this polygon has only one path, we can call getPath() to return the
                // MVCArray of LatLngs.

                //alert(this.get("mytitle"));
               
                var vertices = this.getPath();


                //var contentString = '<b>My polygon</b><br>Clicked location: <br>' + event.latLng.lat() + ',' + event.latLng.lng() + '<br>';// + myarea.get("mytitle");

                var url = "cilink://proprod/action=sfun&f=$P1.REG.APPLPROC.MNT&fhk=" + this.get("pr_ctr")

                var contentString = '<a href="' + url + '">' + this.get("mytitle") + '</a>';

                /*

                // Iterate over the vertices.
                for (var i = 0; i < vertices.getLength() ; i++) {
                    var xy = vertices.getAt(i);
                    contentString += '<br>' + 'Coordinate ' + i + ':<br>' + xy.lat() + ',' + xy.lng();
                }
               
            */

                // Replace the info window's content and position.
                infoWindow.setContent(contentString);
                infoWindow.setPosition(event.latLng);

                infoWindow.open(map);
            }

    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?signed_in=true&callback=initMap"></script>




</body>
</html>
