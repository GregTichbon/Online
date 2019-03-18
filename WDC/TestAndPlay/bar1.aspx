<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bar1.aspx.cs" Inherits="Online.TestAndPlay.bar1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</head>
<body style="height: 1500px">
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">WebSiteName</a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#">Page 1</a></li>
                <li><a href="#">Page 2</a></li>
                <li><a href="#">Page 3</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#"><span class="glyphicon glyphicon-user"></span>Sign Up</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-log-in"></span>Login</a></li>
            </ul>
        </div>
    </nav>


    <div>
    </div>
    <div class="container">
        <h1>
            <img style="margin-top: 50px;" src="/images/wdclogo.png" />

            Online Services</h1>

        <h3>Fixed Navbar</h3>
        <div class="rowz">
            <div class="col-md-4">
                <p>Line 1 A.</p>
                <p>Line 2 A.</p>
            </div>
            <div class="col-md-4">
                <p>Line 1 B.</p>
                <p>Line 2 B.</p>
            </div>
            <div class="col-md-4">
                <p>Line 1 C.</p>
                <p>Line 2 C.</p>
            </div>
        </div>

    </div>

</body>
</html>
