<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test1.aspx.cs" Inherits="Online.Facilities.Test1" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    <meta charset='utf-8' />

    <link href='../../Scripts/fullcalendar-scheduler/lib/fullcalendar.min.css' rel='stylesheet' />
    <link href='../../Scripts/fullcalendar-scheduler/lib/fullcalendar.print.min.css' rel='stylesheet' media='print' />
    <link href='../../Scripts/fullcalendar-scheduler/scheduler.min.css' rel='stylesheet' />

    <script src='../../Scripts/fullcalendar-scheduler/lib/moment.min.js'></script>
    <script src='../../Scripts/fullcalendar-scheduler/lib/jquery.min.js'></script>
    <script src='../../Scripts/fullcalendar-scheduler/lib/fullcalendar.min.js'></script>
    <script src='../../Scripts/fullcalendar-scheduler/scheduler.min.js'></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

    <script>

        var mydatetimeformat = 'DD MMM YYYY HH:mm:ss';

        $(function () { // document ready

            $('#calendar').fullCalendar({
                loading: function (bool) {
                    $('#loading').toggle(bool);
                },
                now: '2017-11-22',
                editable: false, // enable draggable events
                //aspectRatio: 1.1,
                height: $(window).height() - 120,
                scrollTime: '19:00', // undo default 6am scrollTime
                resourceAreaWidth : "20%",
                header: {
                    left: 'today prev,next',
                    center: 'title',
                    right: 'timelineDay,timelineThreeDays,agendaWeek,month,'
                },
                defaultView: 'timelineDay',
                views: {
                    timelineThreeDays: {
                        type: 'timeline',
                        duration: { days: 3 }
                    }
                },
                resourceLabelText: 'People',
                /*
                resources: { // you can also specify a plain string like 'json/resources.json'
                    url: 'venues.json',
                    error: function () {
                        alert('venues.json');
                        $('#script-warning').show();
                    }
                },
                */
                resources: [
                  {
                      "id": "greg&judy",
                      "title": "Greg & Judy",
                      "eventColor": "pink",
                  },
                 {
                     "id": "jordi&nate",
                     "title": "Jordi & Nate",
                     "eventColor": "red",
                 },
                ],
               <% if(1==2) { %>
                events: {
                    url: '../../facilities/data.asmx/get_events',
                    error: function () {
                        alert('events.json');
                        $('#script-warning').show();
                    }
                },
               
<%} else { %>
                events: [
                    { id: '1', resourceId: 'greg&judy', start: '2017-11-22T20:00:00', end: '2017-11-23T00:00:00', title: 'Confirmed' },
                    { id: '2', resourceId: 'greg&judy', start: '2017-11-23T20:00:00', end: '2017-11-24T00:00:00', title: 'Tentative' },
                    { id: '3', resourceId: 'jordi&nate', start: '2017-11-22T20:00:00', end: '2017-11-23T00:00:00', title: 'Confirmed' },
                    { id: '4', resourceId: 'jordi&nate', start: '2017-11-23T20:00:00', end: '2017-11-24T00:00:00', title: 'Tentative' },

                ],
              <%}%>

                eventClick: function (event) {
                    //alert('to do');
                    //$('#calendar').fullCalendar('updateEvent', event);
                    //process_event('Update', event);
                    $('#calendar').fullCalendar('unselect');
                },
                eventMouseover: function (event) {
                    $('#testing').text('Mouseover: ' + event.id + ' - ' + event.title + ' - ' + event.description);
                    return false;
                },
                eventMouseout: function (event) {
                    $('#testing').text('Test');
                    return false;
                },
                selectable: true,
                select: function (start, end, event, view, resource) {
         /*
                    $("#tb_title").val(event.title);
                   
                    var eventData = {
                        start: start, 
                        end: end, 
                        resourceId: resource.id,
                        title: $("#tb_title").val()
                    };

                
                    $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
                    process_event('Create', eventData);
      */
                   
                }, businessHours: {
                    // days of week. an array of zero-based day of week integers (0=Sunday)
                    dow: [1, 2, 3, 4, 5, 6], // Monday - Thursday

                    start: '20:00', // a start time (10am in this example)
                    end: '23:00', // an end time (6pm in this example)
                }
               
            });

            $(window).resize(function () {
                $('#calendar').fullCalendar('option', 'height', $(window).height() - 120);
            });

            function process_event(mode, event) {

                var myevent = {};
                myevent['id'] = event.id;
                myevent['mode'] = mode;

                if (mode != 'Delete') {
                    myevent['startdatetime'] = moment(event.start).format(mydatetimeformat);
                    myevent['enddatetime'] = moment(event.end).format(mydatetimeformat);
                    myevent['resourceId'] = event.resourceId;
                    myevent['Status'] = ''; //event.Status;
                }


                var arForm = JSON.stringify(myevent);




                var formData = "{formVars: '" + arForm + "'}"

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: '../../facilities/posts.asmx/process_event', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {

                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }

                })
            }
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

        #calendar {
            /*max-width: 900px;*/
            margin: 50px auto;
        }
    </style>

</head>


<body>
    <form id="form1" runat="server">
        <div id='script-warning'>
            This page should be running from a webserver, to allow fetching from the <code>json/</code> directory.
        </div>

        <div id='loading'>loading...</div>

        <div id="testing">Test</div>
        <div id='calendar'></div>


    </form>
</body>
</html>
