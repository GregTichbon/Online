<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="EventSchedule.aspx.cs" Inherits="UBC.People.Reports.EventSchedule" %>

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
            background-color: lightcoral;
            padding: 5px;
            margin: 2px
        }

        .title {
            padding: 10px;
            color: red;
        }

        .event {
            border: solid;
            border-color: red;
            padding: 5px;
            margin: 2px;
        }

        .Training {
            border-color: greenyellow;
            background-color: greenyellow;
        }

        .Regatta {
            border-color: lightskyblue;
            background-color: lightskyblue;
        }

        .SocialRow {
            border-color: orchid;
            background-color: orchid;
        }

        .CommitteeMeeting {
            border-color:pink;
            background-color: pink;
        }

        .person, .coach {
            padding: 10px;
        }
        /*
            .mine {
            border-width:20px;
        }
*/

    </style>



    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>


    <script type="text/javascript">


        $(document).ready(function () {

            $('.others').hide();


            $('.title').tooltip({
                content: function () {
                    var element = $(this);
                    return element.attr("title");
                }
            });

            $('#show').click(function () {
                if ($(this).val() == 'Show all') {
                    $(this).val('Show mine');
                    $('.others').show();
                } else {
                    $(this).val('Show all');
                    $('.others').hide();

                }

            });




        }); //document ready
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <input type="button" id="show" value="Show all" />


    <%= html%>

    <div id="div_event" title="Event" style="display: none; width: 800px"></div>
</asp:Content>
