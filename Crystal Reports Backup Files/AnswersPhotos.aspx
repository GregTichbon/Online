<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnswersPhotos.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.AnswersPhotos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <style>
        img {
            width: 100%;
        }
    </style>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.rotate').click(function () {
                photo = $(this).data('photo');
                groupcode = $(this).data('groupcode');
                direction = $(this).data('direction');
                filename = $(this).data('filename');

                alert(groupcode + ' ' + photo + ' ' + direction + ' ' + filename)

                $.ajax({
                    url: "data.asmx/rotateimage?filename=" + filename + "&direction=" + direction, success: function (result) {
                        location.reload();
                    }
                });
            });
        }); //document.ready

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
    </form>
</body>
</html>
