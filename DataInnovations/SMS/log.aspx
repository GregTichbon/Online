<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="log.aspx.cs" Inherits="DataInnovations.SMS.log" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <style>
        table {
            width: 100%;
            border: 1px solid #FFFFFF;
            border-collapse: collapse;
        }

            table td, table th {
                border: 1px solid #FFFFFF;
                padding: 5px;
                text-align: left;
            }

            table tbody td {
                font-size: 13px;
            }

            table tr:nth-child(even) {
                background: #D0E4F5;
            }

            table thead {
                background: #0B6FA4;
                border-bottom: 5px solid #FFFFFF;
            }

                table thead th {
                    font-size: 17px;
                    font-weight: bold;
                    color: #FFFFFF;
                    text-align: left;
                    border-left: 2px solid #FFFFFF;
                }

                    table thead th:first-child {
                        border-left: none;
                    }

        .allocated {
            display: none;
        }
    </style>
    <script type="text/javascript">

        var mywidth;

        $(document).ready(function () {

            mywidth = $(window).width() * .95;
            if (mywidth > 800) {
                mywidth = 800;
            }

            $(".send").click(function () {
                transaction_tr = $(this).closest("tr");
                smslog_id = $(transaction_tr).find('td').eq(0).text();
                id = $(transaction_tr).find('td').eq(1).text();
                phone = $(transaction_tr).find('td').eq(4).find('.phone').text();
                message = $(transaction_tr).find('td').eq(5).text();
                description = $(transaction_tr).find('td').eq(6).text();

                /*
                result = '<table>' +
                    '<tr><td>Phone number</td><td><input id="phone" value="' + phone + '" /></td></tr>' +
                    '<tr><td>ID</td><td><input id="id" value="' + id + '" /></td></tr>' +
                    '<tr><td>Message</td><td><textarea id="message" style="width:100%; height:200px">' + message + '</textarea></td>' +
                    '<tr><td>Description</td><td><textarea id="description" style="width:100%; height:50px">' + description + '</textarea></td>' +
                    '</tr></table>';
                    */
                result = '<table>' +
                    '<tr><td>Phone number</td><td><input id="phone" value="' + phone + '" /></td></tr>' +
                    '<tr><td>ID</td><td>' + id + '</td></tr>' +
                    '<tr><td>Message</td><td><textarea id="message" style="width:100%; height:200px">' + message + '</textarea></td>' +
                    '<tr><td>Description</td><td><textarea id="description" style="width:100%; height:50px">' + description + '</textarea></td>' +
                    '</tr></table>';

                $("#div_messages").html(result);

                $("#dialog_messages").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth,
                    modal: true,
                    position: { my: "centre", at: "centre", of: window },
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Send": function () {
                            $(this).dialog("close");

                            id = $('#id').val();
                            phone = $('#phone').val();
                            message = $('#message').val();
                            description = $('#description').val();

                            var arForm = [{ "name": "SMSLog_ID", "value": smslog_id }, { "name": "ID", "value": id }, { "name": "PhoneNumber", "value": phone }, { "name": "Message", "value": message }, { "name": "Description", "value": description }];
                            var formData = JSON.stringify({ formVars: arForm });

                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/send_sms', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                success: function (result) {
                                    details = $.parseJSON(result.d);
                                    alert(details.message);
                                },
                                error: function (xhr, status) {
                                    alert("An error occurred: " + status);
                                }
                            });
                        }
                    }
                });
            });

            $(".edit").click(function () {
                transaction_tr = $(this).closest("tr");
                smslog_id = $(transaction_tr).find('td').eq(0).text();
                id = $(transaction_tr).find('td').eq(1).text();
                phone = $(transaction_tr).find('td').eq(4).find('.phone').text();
                message = $(transaction_tr).find('td').eq(5).text();
                description = $(transaction_tr).find('td').eq(6).text();

                result = '<table>' +
                    '<tr><td>Phone number</td><td>' + phone + '</td></tr>' +
                    '<tr><td>ID</td><td>' + id + '</td></tr>' +
                    '<tr><td>Message</td><td>' + message + '</td>' +
                    '<tr><td>Description</td><td><textarea id="description" style="width:100%; height:50px">' + description + '</textarea></td>' +
                    '</tr></table>';
                $("#div_messages2").html(result);

                $("#dialog_edit").dialog({
                    resizable: false,
                    //height: 700,
                    width: mywidth,
                    modal: true,
                    position: { my: "centre", at: "centre", of: window },
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Save": function () {
                            $(this).dialog("close");
                             
                            id = $('#id').val();
                            description = $('#description').val();

                            var arForm = [{ "name": "SMSLog_ID", "value": smslog_id }, { "name": "Description", "value": description }];
                            var formData = JSON.stringify({ formVars: arForm });

                            $.ajax({
                                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                                contentType: "application/json; charset=utf-8",
                                url: 'posts.asmx/update_sms_description', // the url where we want to POST
                                data: formData,
                                dataType: 'json', // what type of data do we expect back from the server
                                success: function (result) {
                                    $(transaction_tr).find('td').eq(6).text(description);
                                    //alert(result.d.message);
                                },
                                error: function (xhr, status) {
                                    alert("An error occurred: " + status);
                                }
                            });
                        
                        }
                    }
                });
            });

        }); //document.ready



    </script>
</head>
<body>
    <form id="form1" runat="server">

        <p>days=[int]  type=[R/S] description=?</p>

        <table>
            <thead>
                <tr>
                    <th>SMS ID</th>
                    <th>ID</th>
                    <th>When</th>
                    <th>Direction</th>
                    <th>Phone</th>
                    <th>Message</th>
                    <th>Description</th>
                    <th>Response</th>
                    <th>Resend ID</th>
                    <th>Resend Of ID</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%=html %>
            </tbody>
        </table>

        <div id="dialog_messages" title="Message" style="display: none" class="form-horizontal">
            <div id="div_messages"></div>
        </div>
                <div id="dialog_edit" title="Edit" style="display: none" class="form-horizontal">
            <div id="div_messages2"></div>
        </div>

    </form>
</body>
</html>
