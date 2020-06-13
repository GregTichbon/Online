<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="ErgRegister.aspx.cs" Inherits="UBC.People.ErgRegister" %>
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

 
            $("[field='status']").append(new Option('Please select', ''));

            $("[field='status']").append(new Option('Club', 'Club'));
            $("[field='status']").append(new Option('Own', 'Own'));
            $("[field='status']").append(new Option('None', 'None'));

            $("[field='status']").each(function () {
                $(this).val($(this).attr('myvalue'));
            });

            $('input').addClass('form-control');
            $("[field='status']").addClass('form-control');

            $("input, [field='status']").change(function () {

                myid = $(this).closest('tr').attr("id");
                myvalue = $(this).val();
                myfield = $(this).attr("field");

                
                var arForm = { table: 'ergregister', field: myfield, id: myid, value: myvalue, keyfield: 'guid' };
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

        }); //document ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <!--<input type="button" id="export" style="display: none" class="btn btn-info" value="Export" />-->
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Erg register
        </h1>

        <table class="table">
            <thead>
                <tr>
                    <th>Person</th>
                    <th>Erg Number</th>
                    <th>Status</th>
                    <th>Note</th>
                </tr>
            </thead>
            <tbody><%=html %></tbody>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
