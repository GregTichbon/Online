<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="Online.Administration.Facilities.Calendar" %>

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
                //now: '2017-10-07',
                firstDay: 1,
                editable: true, // enable draggable events
                //aspectRatio: 1.1,
                height: $(window).height() - 120,
                scrollTime: '08:00', // undo default 6am scrollTime
                resourceAreaWidth: "20%",

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
                resourceLabelText: 'Rooms',
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
                      "id": "WMC",
                      "title": "War Memorial Centre",
                      "children": [
                        {
                            "id": "WMC-MH",
                            "title": "Main Hall"
                        },
                        {
                            "id": "WMC-PR",
                            "title": "Pioneer Room"
                        },
                        {
                            "id": "WMC-CC",
                            "title": "Concert Chamber"
                        },

                        {
                            "id": "WMC-K",
                            "title": "Kitchen"
                        },
                        {
                            "id": "WMC-FC",
                            "title": "Forecourt"
                        },
                        {
                            "id": "WMC-UF",
                            "title": "Upstairs Foyer"
                        },
                        {
                            "id": "WMC-DF",
                            "title": "Downstairs Foyer"
                        }
                      ]
                  },
                  {
                      "id": "CG",
                      "title": "Cooks Gardens",
                      "children": [
                        {
                            "id": "CG-FC",
                            "title": "Full Function Centre"
                        },
                        {
                            "id": "CG-EC",
                            "title": "End Cooks' Room"
                        },
                        {
                            "id": "CG-MF",
                            "title": "Main Field"
                        },
                        {
                            "id": "CG-V",
                            "title": "Velodrome"
                        },
                        {
                             "id": "CG-CB",
                             "title": "Corporate Box unspecified"
                         },
                         {
                            "id": "CG-CB1",
                            "title": "Corporate Box 1"
                        },
                        {
                            "id": "CG-CB2",
                            "title": "Corporate Box 2"
                        },
                        {
                            "id": "CG-CB3",
                            "title": "Corporate Box 3"
                        },
                        {
                            "id": "CG-CB4",
                            "title": "Corporate Box 4"
                        },
                        {
                            "id": "CG-CB5",
                            "title": "Corporate Box 5"
                        },
                        {
                            "id": "CG-CB6",
                            "title": "Corporate Box 6"
                        },
                        {
                            "id": "CG-CB7",
                            "title": "Corporate Box 7"
                        },
                        {
                            "id": "CG-CB8",
                            "title": "Corporate Box 8"
                        },
                        {
                            "id": "CG-CB9",
                            "title": "Corporate Box 9"
                        },
                        {
                            "id": "CG-CB10",
                            "title": "Corporate Box 10"
                        },
                        {
                            "id": "CG-CB11",
                            "title": "Corporate Box 11"
                        },
                        {
                            "id": "CG-CB12",
                            "title": "Corporate Box 12"
                        }
                      ]
                  },
                  {
                      "id": "OH",
                      "title": "Royal Whanganui Opera House",
                      "children": [
                        {
                            "id": "OH-T",
                            "title": "Full Theatre"
                        },
                        {
                            "id": "OH-AU",
                            "title": "Auditorium"
                        },
                        {
                            "id": "OH-AN",
                            "title": "Annex"
                        },

                        {
                            "id": "OH-LB",
                            "title": "Lounge/Bar"
                        }
                      ]
                  }
                ],
               <% if (1 == 1)
        { %>
                events: {
                    url: '../../facilities/data.asmx/get_events',
                    error: function () {
                        alert('events.json');
                        $('#script-warning').show();
                    }
                },

<%}
        else
        { %>
                events: [
                    { id: '1', resourceId: 'WMC-PR', start: '2017-10-07T02:00:00', end: '2017-10-07T07:00:00', title: 'Event 1 - Confirmed', description: 'xxxxxxxxxxxxxxx' },
                    { id: '2', resourceId: 'WMC-CC', start: '2017-10-07T05:00:00', end: '2017-10-07T22:00:00', title: 'Event 2 - Tentative' },
                    { id: '3', resourceId: 'CG-CB1', start: '2017-10-06', end: '2017-10-08', title: 'Event 3 - Enquiry' },
                    { id: '4', resourceId: 'CG-CB2', start: '2017-10-07T03:00:00', end: '2017-10-07T08:00:00', title: 'Event 4' },
                    { id: '5', resourceId: 'CG-CB1', start: '2017-10-07T00:30:00', end: '2017-10-07T02:30:00', title: 'Event 5' },
                    { id: '6', resourceId: 'WMC', start: '2017-10-07T09:00:00', end: '2017-10-07T08:00:00', Event: 'event 6' }
                ],
              <%}%>

                eventClick: function (event) {
                    $("#tb_title").val(event.title);
                    $("#tb_description").val(event.description);
                    $("#tb_notes").val(event.notes);
                    $("#tb_startdate").val(event.start.format(mydatetimeformat));
                    $("#tb_enddate").val(event.end.format(mydatetimeformat));
                    $("#eventMaint").dialog({
                        modal: true,
                        title: event.title,
                        width: 600,
                        buttons: {
                            "Update": function () {

                                event.title = $("#tb_title").val();
                                event.description = $("#tb_description").val();
                                event.notes = $("#tb_notes").val();
                                event.start = $("#tb_startdate").val();
                                event.end = $("#tb_enddate").val();
                                $(this).dialog("close");
                                //alert(event.start + ' - ' + event.end);

                                $('#calendar').fullCalendar('updateEvent', event);
                                process_event('Update', event);


                                //$('#calendar').fullCalendar('updateEvent', eventToUpdate);
                            },
                            "Delete": function () {
                                if (confirm("do you really want to delete this event?")) {
                                    $(this).dialog("close");
                                    $('#calendar').fullCalendar('removeEvents', event.id);
                                    process_event('Delete', event);
                                }
                            }
                        }
                    });
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
                    <%if (1 == 1)
        {%>
                    $("#tb_title").val(event.title);
                    $("#tb_description").val(event.description);
                    $("#tb_notes").val(event.notes);
                    $("#tb_startdate").val(moment(start).format(mydatetimeformat));
                    $("#tb_enddate").val(moment(end).utc().format(mydatetimeformat));
                    $("#eventMaint").dialog({
                        modal: true,
                        title: 'Create Event',
                        width: 600,
                        buttons: {
                            "Create": function () {
                                //alert($("#tb_startdate").val());
                                //alert(moment($("#tb_startdate").val()).format());
                                var eventData = {
                                    start: start, //$("#tb_startdate").val(),
                                    end: end, //$("#tb_enddate").val(),
                                    resourceId: resource.id,
                                    title: $("#tb_title").val(),
                                    description: $("#tb_description").val(),
                                    notes: $("#tb_notes").val()
                                };

                                $(this).dialog("close");
                                $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
                                process_event('Create', eventData);
                            }
                        }
                    });
                    <% }
        else
        {%>
                    var title = prompt('Event Title: '); // + start + ' - ' + end);
                    var eventData;
                    if (title) {
                        eventData = {
                            title: title,
                            start: start,
                            resourceId: resource.id,
                            end: end
                        };
                        $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true

                    }
                    <%}%>
                    $('#calendar').fullCalendar('unselect');
                }
                /*
                ,
                viewRender: function (view, element) {
                    alert('viewRender');
                    //$('#calendar').fullCalendar('refetchEventSources', "[{ id: '6', resourceId: 'WMC', start: '2017-10-07T09:00:00', end: '2017-10-07T08:00:00', Event: 'event 6' }]");
                    $('#calendar').fullCalendar('refetchEventSources', "../../facilities/dataX.asmx/get_events?term=1");
                }
                */
                , eventResize: function (event, delta, revertFunc) {
                    process_event('Update', event);
                    //alert(event.title + " is now " + event.start.format() + ' to ' + event.end.format());
                    //if (!confirm("is this okay?")) {
                    //    revertFunc();
                    //}
                }
                , eventDrop: function (event, delta, revertFunc) {
                    process_event('Update', event);
                    //alert(event.title + " is now " + event.start.format() + ' to ' + event.end.format());
                    //if (!confirm("Are you sure about this change?")) {
                    //    revertFunc();
                    //}
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
                    //myevent['mode'] = mode;
                    //alert(event.start);
                    //alert(moment(event.start).utc().format('DD-MMM-YYYY hh:mm:ss'));
                    //myevent['startdatetime'] = event.start.format(mydatetimeformat);
                    //myevent['enddatetime'] = event.end.format(mydatetimeformat);



                    myevent['startdatetime'] = moment(event.start).format(mydatetimeformat);
                    myevent['enddatetime'] = moment(event.end).format(mydatetimeformat);
                    //alert(event.start + '=' + myevent['startdatetime'] + '\n' + event.end + '=' + myevent['enddatetime']);
                    myevent['resourceId'] = event.resourceId;
                    myevent['Title'] = event.title;
                    myevent['Description'] = event.description;
                    myevent['URL'] = ''; //event.URL;
                    myevent['PublicDescription'] = ''; //event.PublicDescription;
                    myevent['Notes'] = event.notes;
                    myevent['Status'] = ''; //event.Status;
                }


                /*
                var myevent = new Object();
                myevent.id = event.id;
                myevent.start = event.start;
                myevent.end = event.end;
                myevent.title = event.title;
                myevent.description = event.title;
                */

                //console.log(myevent)
                //console.log(JSON.stringify(myevent));

                //var formData = JSON.stringify(myevent);
                //var formData = JSON.stringify({ 'xxxx': myevent });
                //var formData = JSON.stringify(event.id);



                //var formData = JSON.stringify({ formVars: myevent });
                //alert(formData);

                //var list = ["a", "b", "c", "d"];
                //var formData = JSON.stringify({ list: list });

                /*  THIS WORKS
                var arForm = $("#form1")
                    .find("input,textarea,select,hidden")
                    .not("[id^='__']")
                    .serializeArray();
                var formData = JSON.stringify({ formVars: arForm });
                // {"formVars":[{"name":"test1","value":"111111"},{"name":"test2","value":"222222"}]}
                */

                //var arForm = jQuery.makeArray(myevent);
                //var formData = JSON.stringify({ formVars: arForm });

                //var arForm = "{\"customer\":" + JSON.stringify({ Name: "Name of  Customer", Title: "President" }) + ",\"address\":" + JSON.stringify({ Street: "Street", City: "", Zip: "" }) + "}";    WORKS
                //var arForm = JSON.stringify({ Name: "Name of  Customer", Title: "President" }) + ",\"address\":" + JSON.stringify({ Street: "Street", City: "", Zip: "" });

                //var arForm = '{"customerx":' + JSON.stringify({ Name: "Greg", Title: "President" }) + ',address:' + JSON.stringify({ Street: "Street", City: "", Zip: "" }) + "}"; //WORKS
                //var arForm = '{' + JSON.stringify({ Name: "Greg", Title: "President" }) + ',address:' + JSON.stringify({ Street: "Street", City: "", Zip: "" }) + "}"; //DOESN'T WORKS
                //var arForm = JSON.stringify({ Name: "Greg", Title: "President" }) + ',address:' + JSON.stringify({ Street: "Street", City: "", Zip: "" }); //DOESN'T WORKS


                //var arForm = JSON.stringify({ Name: "Greg", Title: "President" }); // WORKS
                var arForm = JSON.stringify(myevent);


                //alert(arForm);

                var formData = "{formVars: '" + arForm + "'}"

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: '../../facilities/posts.asmx/process_event', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        //alert(result);
                        //$('.form_result').html('Saved');
                        //details = $.parseJSON(result.d);
                        //alert(details.status);
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



        <div id="eventMaint" title="Event Maintenance" style="display: none">
            <table id="mainttable">
                <!--
            <tr>
                <td style="text-align:right">Type</td>
                <td>
                    <select id="dd_type" name="dd_type" class="form-control" required>
                        <option selected>Event</option>
                        <option>Day</option>
                    </select>
                </td>
            </tr>

            <tr class="em_event">
                <td style="text-align:right">All day</td>
                <td><input id="cb_allday" name="cb_allday" type="checkbox" /></td>
            </tr>
            -->
                <tr>
                    <td style="text-align: right" id="td_startdate">Start (Date and Time)</td>
                    <td>
                        <div class="input-group date" id="div_startdate">
                            <input id="tb_startdate" name="tb_startdate" type="text" value="" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </td>
                </tr>
                <tr id="tr_enddate" class="em_event">
                    <td style="text-align: right">End (Date and Time)</td>
                    <td>
                        <div class="input-group date" id="div_enddate">
                            <input id="tb_enddate" name="tb_enddate" type="text" value="" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right">Status</td>
                    <td>
                        <select id="dd_status" name="dd_status" class="form-control" required>
                            <option>Enquiry</option>
                            <option>Tentative</option>
                            <option>Confirmed</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td style="text-align: right">Title</td>
                    <td>
                        <input type="text" id="tb_title" name="tb_title" class="form-control" maxlength="100" value="" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Description (Internal)</td>
                    <td>
                        <textarea id="tb_description" name="tb_description" class="form-control" maxlength="200" rows="3"></textarea>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right">Notes (Internal)</td>
                    <td>
                        <textarea id="tb_notes" name="tb_notes" class="form-control" maxlength="500" rows="3"></textarea></td>
                </tr>
                <!--
           <tr class="em_event">
                <td style="text-align:right">Private</td>
                <td><input id="cb_private" name="cb_private" type="checkbox" /></td>
            </tr>
            <tr class="em_day" style="display: none">
                <td style="text-align:right">Public Description</td>
                <td>
                    <textarea id="tb_publicdescription" name="tb_publicdescription" class="form-control" maxlength="200" rows="3"></textarea></td>
            </tr>
            <tr class="em_day" style="display: none">
                <td style="text-align:right">Link</td>
                <td>
                    <input type="text" id="tb_url" name="tb_url" class="form-control" maxlength="100" value="" /></td>

            </tr>
           -->



            </table>


        </div>

    </form>
</body>
</html>
