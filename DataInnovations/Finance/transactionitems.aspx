<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="transactionitems.aspx.cs" Inherits="DataInnovations.Finance.transactionitems" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <link href="Dependencies/UBC.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script>
        $(document).ready(function () {
            $(".select").click(function () {
                id = $(this).attr("id");
                 window.open("transactionitems.aspx?id=" + id, "transactionitem");
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
        <div class="container" style="background-color: #FCF7EA">

            <h1>Data Innovations - Items
            </h1>

            <div class="form-group">
                <label class="control-label col-sm-4" for="fld_reference">Reference</label>
                <div class="col-sm-8">
                    <input id="fld_reference" name="fld_reference" type="text" class="form-control" value="<%: reference %>" maxlength="200" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="fld_type">Type</label>
                <div class="col-sm-8">
                    <select id="fld_type" name="fld_type" required="required"><option></option></select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="fld_name">Name</label>
                <div class="col-sm-8">
                    <select id="fld_name" name="fld_name" required="required"><option></option></select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="fld_additionalname">Additional Name</label>
                <div class="col-sm-8">
                    <input id="fld_additionalname" name="fld_additionalname" type="text" class="form-control" value="<%: reference %>" maxlength="200" />
                </div>
            </div>
            <hr />


            <%=html %>
        </div>

    </form>
</body>
</html>

