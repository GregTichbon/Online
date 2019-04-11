﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapBox2.aspx.cs" Inherits="Online.TestAndPlay.MapBox2" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8' />
    <title>Show drawn polygon area</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <script src='https://api.tiles.mapbox.com/mapbox-gl-js/v0.52.0/mapbox-gl.js'></script>
    <link href='https://api.tiles.mapbox.com/mapbox-gl-js/v0.52.0/mapbox-gl.css' rel='stylesheet' />
    <style>
        body { margin:0; padding:0; }
        #map { position:absolute; top:0; bottom:0; width:100%; }
    </style>
</head>
<body>

<style>
    .calculation-box {
        height: 75px;
        width: 150px;
        position: absolute;
        bottom: 40px;
        left: 10px;
        background-color: rgba(255, 255, 255, .9);
        padding: 15px;
        text-align: center;
    }

    p {
        font-family: 'Open Sans';
        margin: 0;
        font-size: 13px;
    }
</style>

<script src='https://api.tiles.mapbox.com/mapbox.js/plugins/turf/v3.0.11/turf.min.js'></script>
<script src='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.0.9/mapbox-gl-draw.js'></script>
<link rel='stylesheet' href='https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.0.9/mapbox-gl-draw.css' type='text/css'/>
<div id='map'></div>
<div class='calculation-box'>
    <p>Draw a polygon using the draw tools.</p>
    <div id='calculated-area'></div>
</div>

<script>
mapboxgl.accessToken = 'pk.eyJ1IjoiZ3JlZ3RpY2hib24iLCJhIjoiY2pvbml3NDk1MTg2bzNrbHNmeXM3NnZxaCJ9.IAFqv9AfM4u0NzYzZch6IA';
/* eslint-disable */
var map = new mapboxgl.Map({
    container: 'map', // container id
    style: 'mapbox://styles/mapbox/satellite-v9', //hosted style id
    center: [174.98993065679247, -39.93997483962218],
    zoom: 12 // starting zoom
});

var draw = new MapboxDraw({
    displayControlsDefault: false,
    controls: {
        polygon: true,
        trash: true
    }
});
map.addControl(draw);

map.on('draw.create', updateArea);
map.on('draw.delete', updateArea);
map.on('draw.update', updateArea);

    function updateArea(e) {
      alert(map.getCenter().wrap());
    var data = draw.getAll();
    var answer = document.getElementById('calculated-area');
    if (data.features.length > 0) {
        var area = turf.area(data);
        // restrict to area to 2 decimal points
        var rounded_area = Math.round(area*100)/100;
        answer.innerHTML = '<p><strong>' + rounded_area + '</strong></p><p>square meters</p>';
    } else {
        answer.innerHTML = '';
        if (e.type !== 'draw.delete') alert("Use the draw tools to draw a polygon!");
    }
    }

    alert(map.getCenter().wrap());

</script>

</body>
</html>