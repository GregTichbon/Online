<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EventSelector.aspx.cs" Inherits="UBC.People.EventSelector" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #container {
            width: 400px;
            margin: 0px auto;
            padding: 10px 0;
        }

        #scrollbox {
            width: 400px;
            height: 400px;
            overflow: auto;
            overflow-x: hidden;
        }

        #container > p {
            background: #eee;
            color: #666;
            font-family: Arial, sans-serif;
            font-size: 0.75em;
            padding: 5px;
            margin: 0;
            text-align: right;
        }
    </style>

    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>

    <script>
        var firstdate;
        var lastdate;

        $(document).ready(function () {
            firstdate = moment().format('DD-MMM-YYYY');
            lastdate = firstdate;
            getdata(7);

            $('#next').click(function () {
                getdata(7);
            })

            $('#previous').click(function () {
                getdata(-7);
            })

            //$('body').on('click', 'tr', function () {
            $('body').on('click', '.select', function () {
                $('#tb_event_id', parent.document).val($(this).parent().attr('id'));
                window.parent.closeeventselector();
                window.parent.reloadpage();
            });

        });

        function getdata(days) {
            $('#status').text('Loading items...');
            if (days < 0) {
                usedate = firstdate;
            } else {
                usedate = lastdate;
            }
            $.get('data.aspx?mode=eventselector&date=' + usedate + '&days=' + days, '', function (newitems) {
                if (days < 0) {
                    $('#eventstable tbody').prepend(newitems);
                } else {
                    $('#eventstable tbody').append(newitems);
                }

                //var totalItems = $('#eventstable tbody tr').length;
                //$('#status').text('Loaded ' + totalItems + ' Items');
                if (days < 0) {
                    firstdate = moment(firstdate).add(days, 'days').format('DD-MMM-YYYY');
                } else {
                    lastdate = moment(lastdate).add(days, 'days').format('DD-MMM-YYYY');
                }
                //console.log(firstdate + ', ' + lastdate);

            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="container">
            <p><span id="previous">Previous</span></p>
            <div id="scrollbox">
                <table id="eventstable">
                    <thead>
                        <tr>
                            <th>Date/Time</th>
                            <th>Title</th>
                            <th>Select</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
            <p><span id="next">Next</span></p>
        </div>
    </form>
</body>
</html>
