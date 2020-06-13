<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Quiz._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.2.2.min.js"></script>
    <script src="signalr/hubs"></script>

    <script type="text/javascript">
        $(function () {
            var chat = $.connection.chatHub;
            // Create a function that the hub can call to broadcast messages.
            chat.client.broadcastMessage = function (detail) {
                $('#discussion').append(detail);
            };

            $.connection.hub.start().done(function () {
                $('#sendmessage').click(function () {
                    chat.server.send($('#message').val());
                    // Clear text box and reset focus for next comment.
                    $('#message').val('').focus();
                });
            });
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div id="discussion"></div>
    </form>
</body>
</html>
