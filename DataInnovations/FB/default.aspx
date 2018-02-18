<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DataInnovations.FB._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Facebook link extract</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btn_extract').click(function () {
                link = $('#tb_link').val();
                link = link.substring(31); //https://l.facebook.com/l.php?u=
                link = decodeURIComponent(link);
                words = link.split('utm_source')
//alert(words[0]);
//alert(words[1]);
                link = words[0];
                link = link.replace("slides=1","");
                $('#a_link').prop('href',link);
                $('#a_link').show();
            });
        }); //document.ready
    </script>
</head>
<body>

    <textarea id="tb_link" style="width:100%"></textarea><br />
    <button id="btn_extract">Extract</button><br />
    <a id="a_link" href="xxxxx" style="display:none">Go to extracted link</a>

</body>
</html>
