<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InArray1.aspx.cs" Inherits="TOHW.Pickups.InArray1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script type="text/javascript">
        var missingicons = 'Jordi,Nate,Watties,Charlie Boy,Keegan,Mahanga,Aimee,Whakapakari,Driver 1,Driver 2,Driver 3'.split(',');
        var icons = 'Greg,Jordi'.split(',');

        $.each(icons, function (index, icon) {
            alert(icon + " = " + $.inArray(icon, missingicons));
            alert(typeof (icon));
 
        });




    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
