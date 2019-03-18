<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="Online.WMC.Calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />

    <link href='<%: ResolveUrl("~/scripts/fullcalendar/fullcalendar.css")%>' rel='stylesheet' />
    <link href='<%: ResolveUrl("~/scripts/fullcalendar/fullcalendar.print.css")%>' rel='stylesheet' media='print' />

    <style>
        #loading {
            display: none;
            position: absolute;
            top: 10px;
            right: 10px;
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

        #calendar {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 10px;
        }

        #mainttable {
            width: 100%;
        } 

        #mainttable td {
             padding: 15px;
        }

        .status_Unavailable,
        .status_Unavailable div,
        .status_Unavailable span {
            background: #fb3939 !important;
        }

        .status_Partiallyavailable,
        .status_Partiallyavailable div,
        .status_Partiallyavailable span {
            background: #FF9966 !important;
        }


        /*.fc-event-container {display: none;}*/
    </style>

    <script src="<%: ResolveUrl("~/Scripts/fullcalendar/fullcalendar.min.js")%>"></script>

    <script>

        $(document).ready(function () {

            var Calendar = $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                defaultDate: moment(),
                editable: true,
                eventLimit: true, // allow "more" link when too many events
                events: {
                    url: '../functions/data.asmx/WMCCalendar',
                    error: function () {
                        $('#script-warning').show();
                    } /*,
                    color: 'red'*//*,
                    success: function () {
                        alert('success');
                        $('[data-blank]').parent().css("background-color", "yellow");
                    }*/
                },
                loading: function (bool) {
                    $('#loading').toggle(bool);
                },
                eventRender: function (event, element) {
                    element.attr('href', 'javascript:void(0);');
                    if (event.type == 'day') {
                        //if (event.title == '') {
                        element.attr('data-blank', 'true');
                        //$('[data-blank]').parent().hide();
                        //$().parent().css("background-color", "green");
                        //$('[data-blank]').parent().hide();
                        //$("#debug").append("<br>" + xx.class);
                        //}
                        var dateString = moment(event.start).format('YYYY-MM-DD');
                        $('td[data-date="' + dateString + '"]').addClass('status_' + event.status);
                    }
                    element.click(function () {
                        if (event.allday == "True") {
                            $("#mod_time").html("Whole day event");
                        } else {
                            $("#mod_time").html(moment(event.start).format('D MMM h:mmA') + ' - ' + moment(event.end).format('D MMM h:mmA'));
                        }
                        $("#eventInfo").html(event.description);
                        $("#eventLink").attr('href', event.url);
                        $("#eventContent").dialog({ modal: true, title: event.title, width: 350 });
                    });
                }, /*
                eventAfterRender: function ( event, element, view ) { 
                    //$('[data-blank]').parent().css("background-color", "yellow");
                    $('[data-blank]').parent().hide(); //works but is probably doing all
                    $("#debug").append("<br>" + 1);
                    //alert('eventAfterRender');
                }, */

                eventAfterAllRender: function (view) {
                    $('[data-blank]').parent().hide();
                    $("#debug").append("<br>" + 2);
                },

                dayClick: function (date, event, view) {
                    var wWidth = $(window).width();
                    var dWidth = wWidth * 0.8;
                    var wHeight = $(window).height();
                    var dHeight = wHeight * 0.8;
                    $("#eventMaint").dialog({ modal: true, title: event.title, width: dWidth });


                }

                /*,
            dayRender: function (date, cell) {
                alert(date);
                cell.css("background-color", "red");
            }*/
            });
            /*
            var event = { id: 1, title: 'New event', start: new Date('2016-03-02') };
            Calendar.fullCalendar('renderEvent', event, true);
            */
            /*
                $('#calendar').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay'
                    },
                    editable: true,
                    eventLimit: true, // allow "more" link when too many events
                    events: {
                        url: '/calendardata.asp',
                        error: function() {
                            alert('Data error');
                            $('#script-warning').show();
                        }
                    },
                    loading: function(bool) {
                        $('#loading').toggle(bool);
                    }
                });
                */

            $("#dd_type").change(function () {
                var de = $(this).val();
                if (de == 'Day') {
                    var newOptions = ["Unavailable", "Partially Available"];

                    $("#td_startdate").html("Date");
                    $(".em_event").hide();
                    $(".em_day").show();

                } else {
                    var newOptions = ["Enquiry", "Tentative", "Confirmed"];

                    $("#td_startdate").html("Start (Date and Time");
                    $(".em_day").hide();
                    $(".em_event").show();
                }

                var $el = $("#dd_status");
                $el.empty(); // remove old options
                $.each(newOptions, function (index, value) {
                    $el.append($("<option>" + value + "</option>"));
                });
            });

            $("#cb_allday").change(function () {
                var ad = $(this).is(":checked");
                if (ad == true) {
                    $("#td_startdate").html("Date")
                    $("#tr_enddate").hide();
                    $('#div_startdate').datetimepicker('setDate', new Date);
                    startdate.datetimepicker('option', 'format', 'D MMM YYYY');
                } else {
                    $("#td_startdate").html("Start (Date and Time");
                    $("#tr_enddate").show();
                    $('#div_startdate').datetimepicker('option', 'format', 'D MMM YYYY LT');
                }
            });

            $('#btnMaint').on("click", function () {
                alert('hello');
            });

            var startdate = $('#div_startdate').datetimepicker({
                format: 'D MMM YYYY LT',
                showClear: true,
                viewDate: false,
                stepping: 30,
                minDate: moment().add(1, 'day'),
                maxDate: moment().add(10, 'year'),
                useCurrent: false,
                sideBySide: true

            });

            var enddate = $('#div_enddate').datetimepicker({
                format: 'D MMM YYYY LT',
                showClear: true,
                viewDate: false,
                stepping: 30,
                minDate: moment().add(1, 'day'),
                maxDate: moment().add(10, 'year'),
                useCurrent: false,
                sideBySide: true
            });

        });



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




    <div id='loading'>loading...</div>
    <div id='script-warning'>
        Service must be running.
    </div>
    <div id='calendar'></div>
    <div id="debug">Debug</div>


    <div id="eventContent" title="Event Details" style="display: none;">
        <p id="mod_time"></p>
        <p id="eventInfo"></p>
        <p><strong><a id="eventLink" href="" target="_blank">Read More</a></strong></p>
    </div>

    <div id="eventMaint" title="Event Maintenance" style="display: none">
        <table id="mainttable">
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

            <tr>
                <td style="text-align:right" id="td_startdate">Start (Date and Time)</td>
                <td>
                    <div class="input-group date" id="div_startdate">
                        <input id="tb_startdate" name="tb_startdate" type="date" value="" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </td>
            </tr>
            <tr id="tr_enddate" class="em_event">
                <td style="text-align:right">End (Date and Time)</td>
                <td>                    <div class="input-group date" id="div_enddate">
                        <input id="tb_enddate" name="tb_enddate" type="date" value="" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div></td>
            </tr>
            <tr>
                <td style="text-align:right">Status</td>
                <td>
                    <select id="dd_status" name="dd_status" class="form-control" required>
                        <option>Enquiry</option>
                        <option>Tentative</option>
                        <option>Confirmed</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">Title</td>
                <td>
                    <input type="text" id="tb_title" name="tb_title" class="form-control" maxlength="100" value="" />
                </td>
            </tr>
            <tr>
                <td style="text-align:right">Description (Internal)</td>
                <td>
                    <textarea id="tb_description" name="tb_description" class="form-control" maxlength="200" rows="3"></textarea>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">Notes (Internal)</td>
                <td>
                    <textarea id="tb_notes" name="tb_notes" class="form-control" maxlength="500" rows="3"></textarea></td>
            </tr>
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
            <tr>
                <td></td>
                <td>
                      <input id="btnMaint" type="button" value="Submit" /></td>

            </tr>



        </table>


    </div>







</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
