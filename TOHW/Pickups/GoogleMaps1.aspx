<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoogleMaps1.aspx.cs" Inherits="TOHW.Pickups.GoogleMaps1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
      #map {
        height: 600px;
        width: 100%;
        display: none;
      }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4EiyE4AE79M4SpyzGYG7KAB6trfGUdsI"></script>
    <script type="text/javascript">
        //&callback=initMap

        var map;
        var markers = [];

        $(document).ready(function () {
            $("#btn_map").click(function () {
                if ($('#map').is(":visible")) {
                    hideMap();
                } else {
                    showMap();
                }

            });
        });

        function htmlDecode(input) {
            var e = document.createElement('div');
            e.innerHTML = input;
            return e.childNodes[0].nodeValue;
        }

        var delay = 200;

        var locations = [
         'New Delhi, India',
         'Mumbai, India',
         'Bangaluru, Karnataka, India',
         'Hyderabad, Ahemdabad, India',
         'Gurgaon, Haryana, India',
         'Cannaught Place, New Delhi, India',
         'Bandra, Mumbai, India',
         'Nainital, Uttranchal, India',
         'Guwahati, India',
         'West Bengal, India',
         'Jammu, India',
         'Kanyakumari, India',
         'Kerala, India',
         'Himachal Pradesh, India',
         'Shillong, India',
         'Chandigarh, India',
         'Dwarka, New Delhi, India',
         'Pune, India',
         'Indore, India',
         'Orissa, India',
         'Shimla, India',
         'Gujarat, India'
        ];

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
                center: { lat: 21.0000, lng: 78.0000 },
                zoom: 5
            });
        }

        function showMap() {
            if (typeof map == 'undefined') {
                initMap();
            }
            //var marker = new google.maps.Marker({
            //    position: { lat: -39.9360085, lng: 175.0140384 },
            //    map: map
            //});
            addMarker({ lat: 21.0000, lng: 78.0000 });

  
            var geocoder = new google.maps.Geocoder();
            var myaddress;

            $.each( locations, function( i, value ) {
                myaddress = value;
                //delay = delay + 200;
                //geocodeAddress(geocoder, map, myaddress);
                //setTimeout(geocodeAddress, delay, geocoder, map, myaddress);

                geocodeAddress(geocoder, map, myaddress);




            });
            /*
            var nextAddress = 0;

            function theNext() {
                if (nextAddress < locations.length) {
                //setTimeout('geocodeAddress("'+locations[nextAddress]+'",theNext)', delay);
                console.log(locations[nextAddress]);
                nextAddress++;
*/
/*
            $('#tbl_data > tbody  > tr').each(function () {
                myaddress = $(this).find(".address").val();
                //alert('1. ' + myaddress)
                if (myaddress != null && myaddress != "") {
                    myaddress = myaddress + ',Whanganui'
                    //alert('2. ' + myaddress)

                    //setTimeout(function () {
                    //alert('3. ' + myaddress)
                    sleep(500);
                    geocodeAddress(geocoder, map, myaddress);
                    //}, 1000);
                }
            });
            */

            $('#map').show();
        }

        function hideMap() {
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];
            $('#map').hide();
        }

        //var geocodeAddress = function(geocoder, resultsMap, address) {
        function geocodeAddress(geocoder, resultsMap, address) {
            var currentTime = new Date().getTime();
            console.log(address + ' ' + currentTime);
            //alert(address);
            //var address = '47 Somerset Rd, Whanganui';
            /*
            geocoder.geocode({ 'address': address }, function (results, status) {
                //alert(address + ' - ' + status);
                if (status === 'OK') {
                    //resultsMap.setCenter(results[0].geometry.location);
                    //var marker = new google.maps.Marker({
                    //    map: resultsMap,
                    //    position: results[0].geometry.location
                    //});
                    addMarker(results[0].geometry.location);
                    //} else if (status == 'OVER_QUERY_LIMIT') {
                    //   alert('OVER_QUERY_LIMIT');
                } else {
                    //alert('Geocode was not successful for *' + address + '* ' + status);
                    var currentTime = new Date().getTime();
                    delay = delay + 200;
                    console.log(address + ' ' + currentTime + " Retry: " + delay);
                    setTimeout(geocodeAddress, delay, geocoder, resultsMap, address);

                }
            });
            */
            $.getJSON('http://maps.googleapis.com/maps/api/geocode/json?address=' + address+ '&sensor=false', null, function (data) {
                var p = data.results[0].geometry.location
                var latlng = new google.maps.LatLng(p.lat, p.lng);
                new google.maps.Marker({
                    position: latlng,
                    map: map
                });

            });

        }

        function addMarker(location) {
            var marker = new google.maps.Marker({
                position: location,
                title: 'xx',
                map: map
            });
            markers.push(marker);
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="map"></div>
 
            <input id="btn_map" type="button" value="Map" />
        
           </form>
</body>
</html>


