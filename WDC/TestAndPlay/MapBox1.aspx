<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapBox1.aspx.cs" Inherits="Online.TestAndPlay.MapBox1" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>Display a satellite map</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.tiles.mapbox.com/mapbox-gl-js/v0.51.0/mapbox-gl.js'></script>
    <link href='https://api.tiles.mapbox.com/mapbox-gl-js/v0.51.0/mapbox-gl.css' rel='stylesheet' />
    <style>
        body { margin:0; padding:0; }
        #map { position:absolute; top:0; bottom:0; width:100%; }
    </style>
</head>
<body>

<div id='map'></div>
<script>
mapboxgl.accessToken = 'pk.eyJ1IjoiZ3JlZ3RpY2hib24iLCJhIjoiY2pvbml3NDk1MTg2bzNrbHNmeXM3NnZxaCJ9.IAFqv9AfM4u0NzYzZch6IA';
var map = new mapboxgl.Map({
    container: 'map',
    zoom: 15,
    center: [137.9150899566626, 36.25956997955441],
    style: 'mapbox://styles/mapbox/satellite-v9'
});
</script>

</body>
</html>