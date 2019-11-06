<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendText.aspx.cs" Inherits="BadHagrid.Administration.SendText" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <style>
        .mytable {
            width: 100%;
            border: 1px solid #FFFFFF;
            border-collapse: collapse;
        }

            .mytable td, table th {
                border: 1px solid #FFFFFF;
                padding: 5px;
                text-align: left;
            }

            .mytable tbody td {
                font-size: 13px;
            }

            .mytable tr:nth-child(even) {
                background: #D0E4F5;
            }

            .mytable thead {
                background: #0B6FA4;
                border-bottom: 5px solid #FFFFFF;
            }

                .mytable thead th {
                    font-size: 17px;
                    font-weight: bold;
                    color: #FFFFFF;
                    text-align: left;
                    border-left: 2px solid #FFFFFF;
                }

                    .mytable thead th:first-child {
                        border-left: none;
                    }

        input[type=text] {
            width: 100%;
        }
    </style>

    <script>
        var Message;

        $(document).ready(function () {
            $('#btn_submit').click(function (e) {
                e.preventDefault();
                $("#tbl_results > tbody").empty();
                $('#dialog_sending').dialog({
                    modal: true,
                    width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                    height: 600, //auto
                    position: { my: "center", at: "100", of: window }
                });

                Message = $('#tb_message').val();

                newobj = $("#tbl_people > tbody > tr > td > input:checked").toArray()
                //console.log(newobj);
                sendtext(0, $(newobj).length);
            });

            $('#cb_textall').click(function (event) {
                if (this.checked) {
                    $('[id^=cb_text_]').each(function () {
                        this.checked = true;
                    });
                } else {
                    $('[id^=cb_text_]').each(function () {
                        this.checked = false;
                    });
                }
            });

        }); //document ready

        function sendtext(i, items) {
            console.log(i + ',' + items);
            thisobj = newobj[i];
            id = $(thisobj).attr("id").substring(8);
            PhoneNumber = $(thisobj).val();
            Greeting = $(thisobj).parent().next().next().text();
            Inject = $(thisobj).parent().next().next().next().find(':input').val();
            //public string send_text(string PhoneNumber, string Message, string Inject, string Greeting)
            var arForm = { PhoneNumber: PhoneNumber, Message: Message, Inject: Inject, Greeting: Greeting };

            mydata = JSON.stringify(arForm);

            $.ajax({
                type: "POST",
                url: "../posts.asmx/send_text",
                data: mydata,
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (responseFromServer) {
                    $('#tbl_results tbody').prepend("<tr><td>" + PhoneNumber + '</td><td>' + Greeting + '</td><td>' + responseFromServer.d + '</td></tr>');
                }
            });

            i++;
            if (i < items) {
                setTimeout(function () { sendtext(i, items); }, 100);
            //} else {
            //    $('#tbl_results tbody').prepend('<tr><td>Complete</td></tr>');
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <textarea id="tb_message">Hi ||greeting||</textarea>
        <table id="tbl_people" class="mytable"><%=html %></table>
        <input type="button" id="btn_submit" value="Send" />

        <div id="dialog_sending" title="Sending ..." style="display: none">
            <table id="tbl_results">
                <thead>
                    <tr>
                        <th>Number</th>
                        <th>Name</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </form>
</body>
</html>
