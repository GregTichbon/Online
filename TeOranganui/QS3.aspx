<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QS3.aspx.cs" Inherits="TeOranganui.QS3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var person_options = '<option value="0"></option>';
            param = "../functions/data.asmx/test?myvalue=Greg";
            $.getJSON(param, function (data) {
                alert("This should say 'Greg'.  It says : " + data.message);
            });
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
