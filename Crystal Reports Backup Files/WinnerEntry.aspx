<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WinnerEntry.aspx.cs" Inherits="DataInnovations.Raffles.WinnerEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script type="text/javascript">


        $(document).ready(function () {
            $('#act_save').click(function () {
                var arForm = [{ "name": "rafflegroup_ID", "value": 1},
                    { "name": "date", "value": $('#fld_date').val() },
                    { "name": "identifier", "value": $('#fld_identifier').val() },
                    { "name": "ticket", "value": $('#fld_ticket').val() },
                    { "name": "note", "value": $('#fld_note').val() },
                    { "name": "voucher", "value": $('#fld_voucher').val() },
                    { "name": "draw", "value": $('#fld_draw').val() }];
                var formData = JSON.stringify({ formVars: arForm });
                //console.log(formData);
                
                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    contentType: "application/json; charset=utf-8",
                    url: 'posts.asmx/update_ticket_winner2', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        //console.log(result);
                        details = $.parseJSON(result.response);
                        alert(details);
                        //$(tr).attr('id', 'tr_' + details.id);
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                });
                
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        Date:
        <input type="text" id="fld_date" name="fld_date" />
        <br />
        Identifier:
        <select id="fld_identifier" name="fld_identifier">
            <option></option>
            <option>Black</option>
            <option>Blue</option>
            <option>Green</option>
            <option>Grey</option>
            <option>Navy</option>
            <option>Pink</option>
            <option>Purple</option>
            <option>Red</option>
            <option>Teal</option>
            <option>Yellow</option>
        </select>
        <br />
        Ticket Number:
        <input type="text" id="fld_ticket" name="fld_ticket" />
        <br />
        Draw:
        <input type="text" id="fld_draw" name="fld_draw" />
        <br />
        Note: <input type="text" id="fld_note" name="fld_note" />
        <br />
        Voucher: <input type="text" id="fld_voucher" name="fld_voucher" />
        <br />
        <br />
        <input type="button" id="act_save" value="Save" />
    </form>
</body>
</html>
