<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SPA5.aspx.cs" Inherits="Online.TestAndPlay.SPA5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <meta charset="utf-8" />
    <title>AngularJS Plunker</title>
    <script>document.write('<base href="' + document.location + '" />');</script>
    <link rel="stylesheet" href="style.css" />
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" />
    <script data-require="angular.js@1.0.x" src="http://code.angularjs.org/1.0.7/angular.min.js" data-semver="1.0.7"></script>
<script>
    var app = angular.module('plunker', []);

    app.config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
        $routeProvider.
            when('/SPA4A', { templateUrl: 'SPA4A.html', controller: SPA4ACtrl }).
            when('/SPA4B', { templateUrl: 'SPA4B.html', controller: SPA4BCtrl }).
            otherwise({ redirectTo: '/SPA4A' });

        // make this demo work in plunker
        $locationProvider.html5Mode(false);
    }]);

    function TabsCtrl($scope, $location) {
        $scope.tabs = [
            { link: '#/SPA4A', label: 'SPA4A' },
            { link: '#/SPA4B', label: 'SPA4B' }
        ];

        $scope.selectedTab = $scope.tabs[0];
        $scope.setSelectedTab = function (tab) {
            $scope.selectedTab = tab;
        }

        $scope.tabClass = function (tab) {
            if ($scope.selectedTab == tab) {
                return "active";
            } else {
                return "";
            }
        }
    }

    function SPA4ACtrl($scope) {

    }

    function SPA4BCtrl($scope) {

    }

</script>

</head>
  <body>
    <ul class="nav nav-tabs" ng-controller="TabsCtrl">
      <li ng-class="tabClass(tab)" ng-repeat="tab in tabs" tab="tab"><a href="{{tab.link}}" ng-click="setSelectedTab(tab)">{{tab.label}}</a></li>
    </ul>
    <div ng-view></div>
  </body>
</html>
