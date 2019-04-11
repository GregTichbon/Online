<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="Online.Contractor.ResetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="<%: ResolveUrl("~/Scripts/pwstrength-bootstrap.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "default.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $("#form1").validate({
                rules: {
                    tb_password: {
                        pattern: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$/
                    },
                    tb_passwordconfirm: {
                        equalTo: '#tb_password'
                    }
                },
                messages: {
                    tb_password: 'Must be between 6 and 8 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit'
                }
            });


            "use strict";
            var options = {};
            options.ui = {
                container: "#pwd-container",
                showVerdictsInsideProgressBar: true,
                viewports: {
                    progress: ".pwstrength_viewport_progress"
                },
                progressBarExtraCssClasses: "progress-bar-striped active"
            };
            options.common = {
                debug: true,
                onLoad: function () {
                }
            };
            $('#tb_password').pwstrength(options);



                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>



        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Reset Password    </h1>


    <input id="hf_contractor_ctr" name="hf_contractor_ctr" type="hidden" value="<%:contractor_ctr %>" />

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_name">Name</label><div class="col-sm-8">
            <input id="tb_name" name="tb_name" type="text" class="form-control" readonly="readonly" value="<%:name%>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_password">User reference number</label><div class="col-sm-8">
            <input id="tb_reference" name="tb_reference" type="text" class="form-control" readonly="readonly" value="<%:actionreference%>" />
        </div>
    </div>

    <div class="form-group" id="pwd-container">
        <label class="control-label col-sm-4" for="tb_password">New password</label>
        <div class="col-sm-8">
            <div class="col-sm-3">
                <input id="tb_password" name="tb_password" type="password" class="form-control" required />
            </div>
            <div class="col-sm-3" style="padding-top: 10px;">
                <div class="pwstrength_viewport_progress"></div>
            </div>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_password">Please confirm the new password</label>
        <div class="col-sm-8">
            <div class="col-sm-3">
                <input id="tb_passwordconfirm" name="tb_passwordconfirm" type="password" class="form-control" required />
            </div>
        </div>
    </div>



  

    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Reset your password" />
        </div>
    </div>


    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <a href="login.aspx">Login</a>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>