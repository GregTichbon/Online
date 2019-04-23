<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="iti.ninja.x._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
            @import url(http://fonts.googleapis.com/css?family=Open+Sans:300,400);

            body {
                background: #363f48;
                color: white;
                font: normal 12px 'Open Sans', sans-serif;
                margin-top: 20px;
            }

            ul.countdown {
                list-style: none;
                margin: 75px 0;
                padding: 0;
                display: block;
                text-align: center;
            }

            ul.countdown li {
                display: inline-block;
            }

            ul.countdown li span {
                font-size: 80px;
                font-weight: 300;
                line-height: 80px;
            }

            ul.countdown li.seperator {
                font-size: 80px;
                line-height: 70px;
                vertical-align: top;
            }

            ul.countdown li p {
                color: #a7abb1;
                font-size: 14px;
            }
          
    </style>
</head>
<body>
    <form id="form1" runat="server">
<ul class="countdown">
        <li>
            <span class="days">00</span>
            <p class="days_ref">days</p>
        </li>
        <li class="seperator">.</li>
        <li>
            <span class="hours">00</span>
            <p class="hours_ref">hours</p>
        </li>
        <li class="seperator">:</li>
        <li>
            <span class="minutes">00</span>
            <p class="minutes_ref">minutes</p>
        </li>
        <li class="seperator">:</li>
        <li>
            <span class="seconds">00</span>
            <p class="seconds_ref">seconds</p>
        </li>
    </ul>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="../dependencies/downcount/jquery.downCount.js"></script>

    <script type="text/javascript">
        $('.countdown').downCount({
            date: '06/10/2019 12:00:00',
            offset: +10
        }, function () {
            alert('WOOT WOOT, done!');
        });
    </script>
    </form>
</body>
</html>
