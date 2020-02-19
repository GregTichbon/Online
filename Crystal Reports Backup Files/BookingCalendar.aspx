<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="BookingCalendar.aspx.cs" Inherits="UBC.BookingCalendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }

        table {
            table-layout: fixed;
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: solid;
            vertical-align: top;
        }

        .date {
            background-color: lightgreen;
            padding: 5px;
            margin: 2px
        }

        .who {
            padding: 10px;
            color: red;
        }

        .booking {
            background-color: aquamarine;
            position:relative;
            border: solid;
            border-color: green;
            padding: 5px;
            margin: 2px;
        }
        .wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }
    </style>



    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script type="text/javascript">

        var attend;
        $(document).ready(function () {

            $('.who').tooltip({
                content: function () {
                    var element = $(this);
                    return element.attr("title");
                }
            });
            $('.date').click(function () {
                if ($(this).attr('admin') == 'True') {
                    window.open("booking.aspx?id=new", 'Booking');
                }
            })
            $('.booking').click(function () {
                id = $(this).attr('id').substring(8);
                if ($(this).attr('admin') == 'True') {
                    window.open("booking.aspx?id=" + id, 'Booking');
                }
            })

        }); //document ready
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" /> 


    <%= html%>
        
   
</asp:Content>
