<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="SMSLog.aspx.cs" Inherits="UBC.People.Reports.SMSLog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

            $(".select").click(function () {
                transaction_tr = this;
                smslog_id = $(this).find('td').eq(0).text();
                id = $(this).find('td').eq(1).text();
                phone = $(this).find('td').eq(4).find('.phone').text();
                message = $(this).find('td').eq(5).text();
                description = $(this).find('td').eq(6).text();

                result = '<table>' +
                    '<tr><td>Phone number</td><td><input id="phone" value="' + phone + '" /></td></tr>' +
                    '<tr><td>ID</td><td><input id="id" value="' + id + '" /></td></tr>' +
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
                                url: '../posts.asmx/send_sms', // the url where we want to POST
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
        }); //document.ready



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>days=[int]  type=[R/S] </p>

        <table>
            <thead>
                <tr>
                    <td>SMS ID</td>
                    <td>ID</td>
                    <td>When</td>
                    <td>Direction</td>
                    <td>Phone</td>
                    <td>Message</td>
                    <td>Description</td>
                    <td>Response</td>
                    <td>Resend ID</td>
                    <td>Resend Of ID</td>
                </tr>
            </thead>
            <tbody>
                <%=html %>
            </tbody>
        </table>

        <div id="dialog_messages" title="Message" style="display: none" class="form-horizontal">
            <div id="div_messages"></div>
        </div>
</asp:Content>
