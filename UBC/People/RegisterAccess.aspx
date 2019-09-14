<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="RegisterAccess.aspx.cs" Inherits="UBC.People.RegisterAccess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>
    <!--additional-methods.min.js-->

    <style>
        :required {
            border-color: red;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $('[required]').addClass('required');

            $('#dd_exisiting').change(function () {
                if ($(this).val() == "Yes") {
                    $('#div_exising').show();
                    $('#div_submit').show();
                } else if($(this).val() == "No") {
                    $('#div_exising').hide();
                    $('#div_submit').show();
                } else {
                    $('#div_exising').hide();
                    $('#div_submit').hide();
                }
            })

            $("#form1").validate();
        });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color:#B1C9E6" >
        <p></p>
        <table style="width:100%">
            <tr>
                <td style="width:350px">
                    <img src="../dependencies/images/Logo-Page-Head.png" style="width:100%" /></td>
                <td style="text-align:center">
                    <h1>Registration</h1>
                </td>
            </tr>
        </table>
        <p></p>
        <hr />
        <p></p>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_usercode">Are you an exisiting member?</label>
            <div class="col-sm-8">
                <select id="dd_exisiting" class="form-control">
                    <option value="">Please Select</option>
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                </select>
            </div>
        </div>
        <div id="div_exising" style="display: none">
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_usercode">Please enter your user code</label>
                <div class="col-sm-8">
                    <input id="tb_usercode" name="tb_usercode" type="text" class="form-control" maxlength="50" required />
                    <asp:Literal ID="lit_error" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
        <!------------------------------------------------------------------------------------------------------>

        <div id="div_submit" class="form-group" style="display:none">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>
</asp:Content>
