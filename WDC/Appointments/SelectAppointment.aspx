<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectAppointment.aspx.cs" Inherits="Online.Appointments.SelectAppointment" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />


    <!-- Style Sheets -->

    <link href="../Content/main.css" rel="stylesheet" />

    <link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css' rel='stylesheet' />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>



    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>

    <script src="<%: ResolveUrl("~/Scripts/wdc.js")%>"></script>

    <script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>

    <script>
        var mydatetimeformat = 'DD MMM YYYY HH:mm';

        $(function () { // document ready



            $('#calendar').fullCalendar({
                loading: function (bool) {
                    $('#loading').toggle(bool);
                },
                defaultDate: '2018-08-01',
                columnHeaderFormat: 'ddd D MMM',

                allDaySlot: false,
                firstDay: 1,
                minTime: "09:00",
                maxTime: "16:00",
                weekends: false,
                slotDuration: '00:15:00',
                header: {
                    left: '',
                    center: 'title'
                },
                defaultView: 'agendaWeek',
                views: {
                    week: {
                        titleFormat: 'D MMM'
                    }
                },
                events: {
                    url: 'data.asmx/get_appointments?id=1&mode=',
                    error: function () {
                        alert('events.json');
                        $('#script-warning').show();
                    }
                },
                eventClick: function (event) {
                    parent.$('#hf_newappointmentreference').val(event.reference);
                    parent.$('#hf_newappointment').val(event.start.format(mydatetimeformat) + ' - ' + event.end.format("HH:mm"));
                    parent.$('.tb_appointment').val(event.start.format(mydatetimeformat) + ' - ' + event.end.format("HH:mm"));
                    parent.$.colorbox.close();

                } //eventClick
            }); //fullCalendar
        }); //document ready


    </script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
            font-size: 14px;
        }

        #script-warning {
            display: none;
            background: #eee;
            border-bottom: 1px solid #ddd;
            padding: 0 10px;
            line-height: 40px;
            text-align: center;
            font-weight: bold;
            font-size: 12px;
            color: red;
        }

        #loading {
            display: none;
            position: absolute;
            top: 10px;
            right: 10px;
        }
    </style>

</head>
<body>

    <div class="container" style="background-color: #FCF7EA">
        <form method="post" action="./" id="form1" class="form-horizontal" role="form">



            <div id='script-warning'>
                This page should be running from a webserver, to allow fetching from the <code>json/</code> directory.
            </div>

            <div id='loading'>loading...</div>

           
            <div id='calendar'></div>
        </form>
    </div>

</body>
</html>
