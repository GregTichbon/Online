<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="DataInnovations.Raffles.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(document).ready(function () {
            $( "#dialog" ).dialog({
                autoOpen: false
            });
        });
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="hf_raffle" name="hf_raffle" value="1" />
        <input type="hidden" id="hf_ticket" name="hf_ticket" />
        <input type="hidden" id="hf_update" name="hf_update" />
        <div>
            <table id="tbl" class="blueTable">
                <tbody>
                    <tr>
                        <td>Ticket Number</td>
                        <td>Status</td>
                    </tr>

                </tbody>
            </table>
        </div>
    </form>

    <div id="dialog" title="Please enter your details">
        <table class="blueTable" style="width: 100%">
            <tr>
                <td style="text-align: right">Ticket Number:</td>
                <td id="td_ticket"></td>
            </tr>
            <tr>
                <td style="text-align: right">Your name:</td>
                <td style="text-align: left">
                    <input type="text" id="tb_name" name="tb_name" /></td>
            </tr>
            <tr>
                <td style="text-align: right">Email Address:</td>
                <td>
                    <input type="text" id="tb_emailaddress" name="tb_emailaddress" /></td>
            </tr>
            <tr>
                <td style="text-align: right">Mobile Number:</td>
                <td>
                    <input type="text" id="tb_mobile" name="tb_mobile" /></td>
            </tr>
            <tr>
                <td style="text-align: right">How will you get the money to Greg?</td>
                <td>
                    <textarea id="tb_payment" name="tb_payment"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input id="btn_get" type="button" value="Get this ticket" /></td>
            </tr>
        </table>
    </div>

</body>
</html>
