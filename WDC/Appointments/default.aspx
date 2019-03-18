<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Online.Appointments._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css' rel='stylesheet' />

    <script src='https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.js'></script>


    <script>

        var mydatetimeformat = 'DD MMM YYYY HH:mm';

        $(function () { // document ready

            var colorboxwidth = $(window).width() * .9;
            if (colorboxwidth > 810) {
                colorboxwidth = 810;
            }
            var colorboxheight = $(window).height() * .9;

            $("#pagehelp").colorbox({ href: "AppointmentSelectHelp.html", iframe: true, height: colorboxheight, width: colorboxwidth, overlayClose: false, escKey: false });


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
                    url: 'data.asmx/get_appointments?id=1<%=mode%>',
                    error: function () {
                        alert('events.json');
                        $('#script-warning').show();
                    }
                },
                eventClick: function (event) {
                   
                    if (event.title == 'Available') {
                        $.colorbox({
                            href: "Details.aspx?reference=" + event.reference + "&appointment=" + event.start.format(mydatetimeformat) + ' - ' + event.end.format("HH:mm"),
                            "title": "",  //shows at bottom of window
                            iframe: true,
                            height: colorboxheight,
                            width: colorboxwidth,
                            overlayClose: false,
                            escKey: false,
                            onClosed: function () {
                                $('#calendar').fullCalendar('refetchEvents');
                            }
                        });
                    } else {
                        window.open("maintenance.aspx?reference=" + event.reference,"appointmentmaintenance");
                    }

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id='script-warning'>
        This page should be running from a webserver, to allow fetching from the <code>json/</code> directory.
    </div>

    <div id='loading'>loading...</div>

    <div id="testing">Test</div>
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>

    <div id='calendar'></div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
