<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalendarGrid1.aspx.cs" Inherits="Online.TestAndPlay.CalendarGrid1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        }

        table {
            table-layout: fixed;
            width: 14%;
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
            margin: 2px
        }

        .person {
            padding: 10px;
        }

        .greg {
            background-color: lightblue;
        }

        .roanna {
            background-color: lightgreen;
        }

        .barry {
            background-color: lightsalmon;
        }

        .wrapper {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .remove:before {
            content: "\00d7";
        }

        .remove {
            position: absolute;
            top: 0;
            right: 2px;
            cursor: pointer;
        }

        .add:before {
            content: "+";
        }

        .add {
            position: absolute;
            top: 0;
            right: 2px;
            cursor: pointer;
        }
    </style>
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script>
        $(document).ready(function () {
            $('.event').on("dragstart", function (event) {
                var dt = event.originalEvent.dataTransfer;
                dt.setData('Text', $(this).attr('id'));
            });
            $('table td').on("dragenter dragover drop", function (event) {
                event.preventDefault();
                if (event.type === 'drop') {
                    var data = event.originalEvent.dataTransfer.getData('Text', $(this).attr('id'));
                    alert(data);
                    //if ($(this).find('span').length === 0) {
                        de = $('#' + data).detach();
                        de.appendTo($(this));
                   // }

                };
            });
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%">
            <thead>
                <tr>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                    <th>Sunday</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div class="date">22 Oct</div>
                        <div class="event">
                            <div class="wrapper">
                                <div id="123" class="title">Meeting 1:00 - 2:30</div>
                                <span class="add"></span>
                            </div>
                            <div class="wrapper" draggable="true">
                                <div class="person greg">Greg</div>
                                <span class="remove"></span>
                            </div>
                        </div>

                        <div class="event">
                            <div class="wrapper">
                                <div id="124" class="title">Meeting 3:00 - 4:30</div>
                                <span class="add"></span>
                            </div>
                            <div class="wrapper">
                                <div class="person greg">Greg</div>
                                <span class="remove"></span>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="date">23 Oct</div>
                        <div class="event">
                            <div class="wrapper">
                                <div id="1231" class="title">Meeting 1:00 - 2:30</div>
                                <span class="add"></span>
                            </div>
                            <div class="wrapper">
                                <div class="person roanna">Roanna</div>
                                <span class="remove"></span>
                            </div>
                            <div class="wrapper">
                                <div class="person barry">Barry</div>
                                <span class="remove"></span>
                            </div>
                        </div>

                        <div class="event">
                            <div class="wrapper">
                                <div id="1241" class="title">Meeting 3:00 - 4:30</div>
                                <span class="add"></span>
                            </div>

                        </div>
                    </td>
                    <td>
                        <div class="date">24 Oct</div>
                    </td>
                    <td>
                        <div class="date">25 Oct</div>
                    </td>
                    <td>
                        <div class="date">26 Oct</div>
                    </td>
                    <td>
                        <div class="date">27 Oct</div>
                    </td>
                    <td>
                        <div class="date">28 Oct</div>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</body>
</html>
