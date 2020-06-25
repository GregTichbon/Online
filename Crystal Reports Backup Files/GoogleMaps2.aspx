<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoogleMaps2.aspx.cs" Inherits="TOHW.Pickups.GoogleMaps2" %>

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
    <script type="text/javascript">



        $(document).ready(function () {

        });

        function initMap() {
            var geocoder = new google.maps.Geocoder();
            document.getElementById('btn_map').addEventListener('click', function () {
                geocodeAddress(geocoder);
            });
        }




        function geocodeAddress(geocoder) {
            var address = "30 Totara St, Whanganui";
            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status === 'OK') {
                    alert(results[0].geometry.location);
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }

        /*

        $.getJSON('http://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&sensor=false', null, function (data) {
            var p = data.results[0].geometry.location
            var latlng = new google.maps.LatLng(p.lat, p.lng);


        });
        */





    </script>
</head>
<body>
    <form id="form1" runat="server">


        <input id="btn_map" type="button" value="Map" />

    </form>
</body>
</html>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDyvzeUN_sRFBm-t2w0YF0vkRCCYqVTOp8&callback=initMap">
</script>


