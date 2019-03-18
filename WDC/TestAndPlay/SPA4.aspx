<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SPA4.aspx.cs" Inherits="Online.TestAndPlay.SPA4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.3/angular.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.3/angular-route.min.js">   </script>
<script>
    var app = angular.module('single-page-app', ['ngRoute']);
    app.config(function ($routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'SPA4A.html'
            })
            .when('/SPA4B', {
                templateUrl: 'SPA4B.html'
            });
    });
    app.controller('cfgController', function ($scope) {

        /*      
        Here you can handle controller for specific route as well.
        */
    });
</script>

</head>
<body ng-app="single-page-app">
    <div ng-controller="cfgController">
        <div>
            <nav>
                <ul>
                    <li><a href="#/">SPA4A</a></li>
                    <li><a href="#/SPA4B">SPA4B</a></li>
                </ul>
            </nav>
        </div>
        <br />
        <div ng-view>
            <!--
     This DIV loads templates depending upon route.
 -->
        </div>
    </div>
</body>
</html>
