<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="Quiz.Host.Quiz" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quiz Host</title>
    <style>
        .split {
            height: 100%;
            width: 50%;
            position: fixed;
            z-index: 1;
            top: 0;
            overflow-x: hidden;
            padding-top: 20px;
        }

        .left {
            left: 0;
        }

        .right {
            right: 0;
            background-color: lightblue;
        }
    </style>
    <script src="../Scripts/jquery-3.3.1.min.js"></script>
    <script src="../Scripts/jquery.signalR-2.2.2.min.js"></script>
    <script src="../signalr/hubs"></script>

    <script type="text/javascript">
        var chat = $.connection.chatHub;
        $(function () {
            // Declare a proxy to reference the hub.

            // Create a function that the hub can call to broadcast messages.
            chat.client.broadcastMessage = function (detail) {
                $('#preview').append(detail);
            };

            $.connection.hub.start().done(function () {
                var connectionID = $.connection.hub.id;
                alert(connectionID);
                $('#sendmessage').click(function () {
                    chat.server.send($('#displayname').val(), $('#message').val());
                    $('#message').val('').focus();
                });
            });
        });

        $(document).ready(function () {
            $('#act_action').click(function () {
                action = $('#act_action').val();
                if (action == "Send question but keep hidden") {
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        //contentType: "application/json; charset=utf-8",
                        url: '../data.aspx/?mode=get_question&quizid=1&question_number=1', // the url where we want to POST
                        dataType: 'html', // what type of data do we expect back from the server
                        success: function (result) {
                            chat.server.send("1" + "|" + "10000" + "|" + result);
                            $('#div_question').html(result);
                            $('#act_action').val("Show question and start timer");
                        },
                        error: function (xhr, status) {
                            alert('error');
                        }
                    });
                }
                else if (action == "Show question and start timer") {
                    chat.server.send("2");
                    $('#act_action').hide();
                }
            });
        }); //document.ready


    </script>
</head>
<body>

    <form id="form1" runat="server">

        <div class="split left">
            <%: title %><br />
            <%: description %>
            <br />
            <%: questions %> Questions
            <div id="div_question"></div>
            <div id="div_participants"></div>
            <input type="button" id="act_action" value="Send question but keep hidden" />
            <div id="discussion"></div>
        </div>

        <div id="preview" class="split right"></div>




    </form>
</body>
</html>
