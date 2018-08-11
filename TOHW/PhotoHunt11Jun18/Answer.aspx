<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Answer.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.Answer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body, input {
            font-size: 20px;
            font-size: 4vw;
        }
    </style>
</head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#form1").submit(function (event) {
            //parent.jQuery.colorbox.close();
        });

        $('#btn_close').click(function () {
            parent.jQuery.colorbox.close();
        })
        $('#btn_upload').click(function () {
            $('#span_upload').show();
            $('#span_message').text('Your image has been recorded.  You may click "Close".');
            $('#btn_upload').hide();
        })


    }); //document.ready

</script>
<body>
    <form id="form1" runat="server">
        <div id="span_upload"<%= showupload %>>
            Click on "Browse" to select an image and then submit to upload it.<hr />
            <asp:FileUpload ID="fu_answer" runat="server" /><br />
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>

        <asp:Literal ID="Lit_Response" runat="server"></asp:Literal>



    </form>

</body>
</html>
