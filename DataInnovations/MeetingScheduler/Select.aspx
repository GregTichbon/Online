<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Select.aspx.cs" Inherits="DataInnovations.MeetingScheduler.Select" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

    <style>
        table.blueTable {
            border: 1px solid #1C6EA4;
            text-align: left;
            border-collapse: collapse;
        }

            table.blueTable td, table.blueTable th {
                border: 1px solid #AAAAAA;
                padding: 6px 12px;
                text-align: center;
            }

            table.blueTable tbody td {
                font-size: 13px;
                text-align: center;
            }

            table.blueTable thead {
                background: #1C6EA4;
                background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                border-bottom: 2px solid #444444;
            }

                table.blueTable thead th {
                    font-size: 15px;
                    font-weight: bold;
                    color: #FFFFFF;
                    border-left: 2px solid #D0E4F5;
                    text-align: center;
                }

                    table.blueTable thead th:first-child {
                        border-left: none;
                    }



        .c1 {
            background-color: green;
        }

        .c-1 {
            background-color: lightblue;
        }

        .c0 {
            background-color: red;
        }

        .mylabel {
            color: red;
        }

        .mine {
            /*background-image: url("data:image/svg+xml;base64,PHN2ZyB4bWxucz0naHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmcnIHdpZHRoPScxMCcgaGVpZ2h0PScxMCc+CiAgPHJlY3Qgd2lkdGg9JzEwJyBoZWlnaHQ9JzEwJyBmaWxsPSd3aGl0ZScvPgogIDxwYXRoIGQ9J00tMSwxIGwyLC0yCiAgICAgICAgICAgTTAsMTAgbDEwLC0xMAogICAgICAgICAgIE05LDExIGwyLC0yJyBzdHJva2U9J2JsYWNrJyBzdHJva2Utd2lkdGg9JzEnLz4KPC9zdmc+Cg==");
            background-repeat: repeat;
                */
        }
    </style>

    <script type="text/javascript">


        $(document).ready(function () {
            $('.mine').click(function () {
                if ($(this).hasClass('c-1')) {
                    $(this).toggleClass("c-1 c1");
                    $(this).text('Yes');
                    val = 1;
                } else if ($(this).hasClass('c0')) {
                    $(this).toggleClass("c0 c1");
                    $(this).text('Yes');
                    val = 1;

                } else {
                    $(this).toggleClass("c1 c0");
                    $(this).text('No');
                    val = 0;

                };


                var formData = createFormVars({ meetingoption_ctr: $(this).data('option'), entity_ctr: $(this).data('entity'), rank: val });
                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    url: 'posts.asmx/update_meetingoption_entity', // the url where we want to POST
                    contentType: "application/json; charset=utf-8",
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    async: false,
                    success: function (result) {
                        id = result.d;
                    },
                    error: function (xhr, status) {
                        alert('error');
                    }
                });

                /*
                $.post("posts.asmx/update_meetingoption_entity", createFormVars({ entity_ctr: $(this).data('entity'), option_ctr: $(this).data('option'), rank: val })
                    , function (data) {
                        alert(data);
                    });
*/


/*
                arForm.push({ option: 'roster_worker_ctr', value: $(this).data('option') }, { name: 'roster_ctr', value: roster_ctr });
                var formData = JSON.stringify({ formVars: arForm });

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    url: 'posts.asmx/update_meetingoption_entity', // the url where we want to POST
                    contentType: "application/json; charset=utf-8",
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    async: false,
                    success: function (result) {
                    },
                    error: function (xhr, status) {
                        alert('error');
                    }
                });
*/


            });

        }); //document.ready

        function createFormVars(obj) {
            var arr = [];
            for (const [key, value] of Object.entries(obj)) {
                arr.push({ 'name': key, 'value': value });
            }
            var formVars = JSON.stringify({ formVars: arr });
            return formVars;
        }

    </script>


</head>
<body>
    <form id="form1" runat="server">
        <h1><%: meeting_name %></h1>
        <h3><%: meeting_description %></h3>

        <p>Your name is identified in red in the left hand column.  You can click on any of the slots on that row to toggle whether that date/time would work for you or not.</p>
        <p>Please click on each of the slots.</p>
        <p>You may return at anytime to update your availability.</p>
        <p>Once everybody has completed the form we will advise when the meeting will be.</p>
        <table class="blueTable"><%= table %></table>
    </form>
</body>
</html>
