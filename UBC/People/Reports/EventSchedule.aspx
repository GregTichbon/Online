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

        .person, .attendance {
            padding: 10px;
        }

        .wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }

       .attendNotGoing, .attendGoing, .attendMaybe {
            position: absolute;
            top: 0;
            right: 2px;
            cursor: pointer;
        }

        .attendMaybe:before {
            content: url(../../Dependencies/Images/qm1.png);
        }

        .attendGoing:before {
            content:url(../../Dependencies/Images/tick1.png);
        }

        .attendNotGoing:before {
            content:url(../../Dependencies/Images/cross1.png);
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

        var attend;
        $(document).ready(function () {

            //$('body').on('touchstart', function() {});

            $('.others').hide();

            $("#div_information").dialog({
                resizable: false,
                width: 800,
                    modal: true
                });

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
            //$('.event:not(.past)').dblclick(function () {
            $('.event:not(.past)').click(function () {
                attend = $(this);
                personnote = $(this).attr('data-personnote');
                $('#personnote').val(personnote);

                $("#div_attendance").dialog({
                    resizable: false,
                    modal: true
                });

            })
            /*
            $('.event').click(function () {
                $( this ).tooltip( "open" );
                //alert(1);
            });
            */


            $('.attendance').click(function () {
                attendance = $(this).text();
                event_id = $(attend).attr('id');
                $('#attend_' + event_id).attr('class', 'attend' + attendance.replace(' ', ''));
                personnote = $('#personnote').val();
                $(attend).attr('data-personnote',personnote);
                $("#div_attendance").dialog('close');

                var arForm = [{ "name": "person_id", "value": "<%=person_id%>" }, { "name": "event_id", "value": event_id.substring(6) }, { "name": "attendance", "value": attendance }, { "name": "personnote", "value": personnote }];

                var formData = JSON.stringify({ formVars: arForm });

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    contentType: "application/json; charset=utf-8",
                    url: '../posts.asmx/update_event_person', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    //success: function (result) {
                    //    window.location.href = 'default.aspx';
                    //},
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                });
            });

        }); //document ready
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <input type="button" id="show" value="Show all" />



    <%= html%>
        <div id="div_attendance" title="Select attendance option" style="display: none">
        <%= attendance_html %>
            <textarea rows="4" style="width:100%" id="personnote"></textarea>
    </div>

    <div id="div_event" title="Event" style="display: none; width: 800px"></div>
    <div id="div_information" title="Information">
        <p>Events in the same category that you are registered in show by default.</p>
        <p>You may see other events by using the &quot;Show All&quot; button at the top left of the screen.</p>
        <p>You can also hide these other events with the same button.</p>
        <p>Mouse over an event description to see more detail, if it has been loaded.</p>
        <p>Click on the title to select whether you are intending to attend or not, &quot;maybe&quot; is also an option.&nbsp; This is very useful for planning of events.&nbsp; You may return and change your attendance &quot;status&quot; as often as you like.</p>
        <p>CLOSE THIS WINDOW TO CONTINUE</p>
    </div>
</asp:Content>
