<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Newslist.aspx.cs" Inherits="BadHagrid.Administration.Newslist" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="../Dependencies/moment.min.js"></script>

    <script>
        $(document).ready(function () {

            $('.title').tooltip({
                content: function () {
                    var element = $(this);
                    return element.attr("title");
                }
            });

        });


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="background-color: #FCF7EA">
            <h1>Bad Hagrid - News Selection
            </h1>

            <h2><a href="newsmaint.aspx?id=new" target="edit">New</a></h2>

            <table class="table">
                <%=html %>
            </table>
        </div>
    </form>
</body>
</html>
