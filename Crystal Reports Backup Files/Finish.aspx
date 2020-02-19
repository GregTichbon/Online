<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Finish.aspx.cs" Inherits="DataInnovations.Row.Timing.Finish" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous" />
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <style>
        body {
            font-size: x-large;
        }

        input[type=button] {
            width: 200px;
            height: 200px;
            font-size: x-large;
        }

        select {
            font-size: x-large;
        }

        table {
            width: 100%;
            border: none;
        }

        td {
            border: none;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js" integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU=" crossorigin="anonymous"></script>
    <script src="../../Dependencies/moment.min.js"></script>

    <script type="text/javascript">
        var RaceTimer_CTR;
        var place = 0;

        $(document).ready(function () {
            $('#dd_race').change(function () {
                RaceTimer_CTR = this.value;
                $('.finish').css('color', 'black');
                $('#div_scheduledstart').html($(this).find(':selected').data('scheduledstart'));
                $('#div_starttime').html($(this).find(':selected').data('starttime'));
                $('.temp').remove();
            })
            $('.finish').click(function () {
                var timer = moment().format('HH:mm:ss.SSS'); // new Date();
                place++;
                /*
                var doit;
                if ($('#div_starttime').html() != '') {
                    doit = false;
                    if (confirm("This race has already started.\nDo you want to use this new time?")) {
                        doit = true;
                    }
                } else {
                    doit = true;
                }
                if (doit) {
                */
                lane = $(this).attr('id').substring(4);
                $(this).css('color', 'red');
                $(this).parent().prepend('<div class="temp">' + place + '<br /></div>');
                $(this).parent().append('<div class="temp">' + timer + '</div>');
                var arForm = [{ "name": "RaceTimer_CTR", "value": RaceTimer_CTR }, { "name": "mode", "value": "finish" }, { "name": "time", "value": timer }, { "name": "lane", "value": lane }];

                var formData = JSON.stringify({ formVars: arForm });

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    contentType: "application/json; charset=utf-8",
                    url: '../posts.asmx/recordtime', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    //success: function (result) {
                    //    window.location.href = 'default.aspx';
                    //},
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                });
                //}
            })
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td style="width: 34%">Race</td>
                <td style="width: 33%; text-align: center">Scheduled Start</td>
                <td style="width: 33%; text-align: right">Started</td>
            </tr>
            <tr>
                <td>
                    <select id="dd_race">
                        <option></option>
                        <%=race_values %>
                    </select>
                </td>
                <td style="text-align: center">
                    <div id="div_scheduledstart"></div>
                </td>
                <td style="text-align: right">
                    <div id="div_starttime"></div>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <table>

            <tr>
                <td style="text-align: center">
                    <input class="finish" id="btn_1" type="button" value="1" />
                </td>
                <td style="text-align: center">
                    <input class="finish" id="btn_2" type="button" value="2" />
                </td>
                <td style="text-align: center">
                    <input class="finish" id="btn_3" type="button" value="3" />
                </td>
                <td style="text-align: center">
                    <input class="finish" id="btn_4" type="button" value="4" />
                </td>
                <td style="text-align: center">
                    <input class="finish" id="btn_5" type="button" value="5" />
                </td>
                <td style="text-align: center">
                    <input class="finish" id="btn_6" type="button" value="6" />
                </td>
                <td style="text-align: center">
                    <input class="finish" id="btn_7" type="button" value="7" />
                </td>
                <td style="text-align: center">
                    <input class="finish" id="btn_8" type="button" value="8" />
                </td>

            </tr>
        </table>

    </form>
</body>
</html>
