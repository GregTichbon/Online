<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UBC.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Dependencies/jquery-2.2.0.min.js"></script>
    <script src="Dependencies/fittext.js"></script>
    <script>
        $(document).ready(function () {
            $("#div_menu").fitText(1.1, {
                minFontSize: 50,
                maxFontSize: '75px'
            });


        });
    </script>

    <style>
        #div_menu {
            position: fixed;
            top: 50%;
            left: 50%;
            /* bring your own prefixes */
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="div_menu">
            <a href="people/Search.aspx">People Search</a>
            <br />
            <a href="people/List.aspx">People List</a>
            <br />
            <a href="people/EventList.aspx">Event List</a>
            <br />
            <a href="people/reports/CheckList.aspx">Check List</a>
            <br />
            <a href="people/reports/AttendanceMatrix.aspx">Attendance Matrix</a>
            <br />
            <a href="Training/ZoneTraining.aspx">Zone Training</a>
        </div>
    </form>
</body>
</html>
