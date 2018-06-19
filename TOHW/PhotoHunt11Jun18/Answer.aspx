<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Answer.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.Answer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#form1").submit(function (event) {
            alert("Handler for .submit() called.");
            parent.jQuery.colorbox.close();
            //event.preventDefault();
        });
    }); //document.ready


</script>
<body>
    <form id="form1" runat="server">
        <asp:FileUpload ID="fu_answer" runat="server" />
        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
    </form>

</body>
</html>
