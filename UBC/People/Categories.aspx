<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="UBC.People.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/UBC.css")%>" rel="stylesheet" />

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

    <style>
        .notcurrent {color:red;}
    </style>

    <script>
        $(document).ready(function () {

            $('input[type=text]').change(function () {
                tr = $(this).closest('tr');
                $(tr).find('td:first').attr("class", "changed");
                $(tr).attr('maint', 'changed');
            });
            $('.submit').click(function () {
                delim = String.fromCharCode(254);
                $('#tbl_main > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_start = $(this).find('td:eq(2) input').val();
                    tr_end = $(this).find('td:eq(3) input').val();
                    tr_note = $(this).find('td:eq(4) input').val();

                    value = tr_start + delim + tr_end + delim + tr_note;
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');
                    alert(tr_id + ',' + value);
                });
            });

        }) //document.ready
    </script>

</asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container" style="background-color: #FCF7EA">
            <div class="toprighticon">
            
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - People Categories
        </h1>
            <p>To do:  Options to choose categories and non-current ones to show, option to add category to a person.  Database update.</p>
            <table id="tbl_main" class="table">
                <thead>
                    <tr>
                        <th></th>
                        <th>Person/Category</th>
                        <th>Start</th>
                        <th>End</th>
                        <th>Note</th>
                        <th>Maintain</th>
                    </tr>
                    <tr style="display: none">
                        <td style="text-align: center"></td>
                        <td></td>
                        <td>
                            <input type="text" class="form-control" /></td>
                        <td>
                            <input type="text" class="form-control" /></td>
                        <td>
                            <input type="text" class="form-control" /></td>
                        <td><a href="javascript:void(0)" class="delete" data-mode="delete">Delete</a></td>
                    </tr>
                </thead>
                <tbody><%=html %></tbody>
            </table>
            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="submit btn btn-info" Text="Submit" />
                </div>
            </div>


        </div>
    </asp:Content>
