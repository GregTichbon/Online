<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="UserItemsBidOn.aspx.cs" Inherits="Auction.Administration.UserItemsBidOn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Auction Register</title>

    <link href="_Includes/css/main.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
                $('.itembids').click(function () {
                    item_ctr = $(this).attr("id").substring(5);
                    $('#dialog_itemsbids').dialog({
                        modal: true,
                        open: function () {
                            $(this).load('itembids.aspx?item=' + item_ctr);
                        },
                        width: $(window).width() * .75,
                        height: 500,
                        close: function () {
                            $(this).html('');
                        },
                        closeText: false
                    });
                })
            });
    </script>
</head>
<body>
    <form id="formRegister" runat="server">
     <div id="dialog_itemsbids" title="Bids on an item"></div>
        <table class="table">
            <tr>
                <th>Item</th>
                <th>Last bid</th>
                <th>View bids</th>
            </tr>
            <%=html%>
        </table>
    </form>


</body>
</html>
