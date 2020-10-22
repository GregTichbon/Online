<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="UniformRegister.aspx.cs" Inherits="UBC.People.UniformRegister" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

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
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>

    <script>

        $(document).ready(function () {

            $("textarea, select").change(function () {
                var parts = $(this).attr("id").split("_");
                var arForm = { table: 'person', field: parts[0], id: parts[1], value: $(this).val(), keyfield: 'guid' };
                    mydata = JSON.stringify(arForm);

                    $.ajax({
                        type: "POST",
                        url: "posts.asmx/updatefield",
                        data: mydata,
                        contentType: "application/json",
                        datatype: "json",
                        success: function (response) {
                            //console.log(response);
                            //alert(responseFromServer.d.);
                        }
                    });

            });

             $('#assistance').click(function () {
                $("#dialog_assistance").dialog({
                    resizable: false,
                    height: 600,
                    width: 800,
                    modal: true
                });
            })

        }); //document ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div id="dialog_assistance" title="<%: Title + " Assistance"%>" style="display: none">
        <p><b>Details:</b> Please keep all relevant records of uniforms loans.  eg: What was the item, when was it given, distinguishing marks or design, who it might have been passed on to, when it was returned etc.</p>
        <p><b>On loan:</b> If it has not been returned or has not been verified as having been passed on to someone else then it should be recorded as being still on loan.  If has been lost, written off, or paid for then it can be recorded as not being on loan.</p>
    </div>


    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <!--<input type="button" id="export" style="display: none" class="btn btn-info" value="Export" />-->
            <input type="button" id="assistance" class="btn btn-info" value="Assistance" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>

        <h1>Union Boat Club - Uniform register
        </h1>

        <table class="table">
            <thead>
                <tr>
                    <th>Person</th>
                    <th>Detail</th>
                    <th>On loan</th>
                </tr>
            </thead>
            <tbody><%=html %></tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
