<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="BookingCalendarNew.aspx.cs" Inherits="UBC.BookingCalendarNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='Dependencies/fullcalendar/fullcalendar.min.css' rel='stylesheet' />
    <link href='Dependencies/fullcalendar/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <script src='Dependencies/fullcalendar/lib/moment.min.js'></script>
    <script src='Dependencies/fullcalendar/lib/jquery.min.js'></script>
    <script src='Dependencies/fullcalendar/fullcalendar.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js'></script>
    <script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js'></script>

    <script>

        $(document).ready(function () {

            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay,listWeek'
                },
                defaultDate: '2018-12-01',
                editable: true,
                navLinks: true, // can click day/week names to navigate views
                eventLimit: true, // allow "more" link when too many events
                eventRender: function (eventObj, $el) {
                    $el.popover({
                        title: eventObj.title,
                        content: eventObj.Contact_Details,
                        trigger: 'hover',
                        placement: 'top',
                        container: 'body'
                    });
                },
                events: {
                    url: 'data.asmx/get_hallbookings',
                    error: function () {
                        $('#script-warning').show();
                    }
                },
                loading: function (bool) {
                    $('#loading').toggle(bool);
                }
            });
        });

    </script>
    <style>
        body {
            margin: 40px 10px;
            padding: 0;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
            font-size: 14px;
        }

        #calendar {
            max-width: 900px;
            margin: 0 auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id='calendar'></div>
</asp:Content>
