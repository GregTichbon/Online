<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginAssistance.aspx.cs" Inherits="Online.CommunityContract.LoginAssistance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "default.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('#cb_username').change(function () {
                if ($('#cb_username').prop('checked')) {
                    $('#div_username').show();
                } else {
                    $('#div_username').hide();
                }

            });

            $('#cb_password').change(function () {
                if ($('#cb_password').prop('checked')) {
                    $('#div_password').show();
                } else {
                    $('#div_password').hide();
                }

            });


            $('#cb_sendusername').change(function () {
                if ($('#cb_sendusername').prop('checked')) {
                    $('#div_getemailaddress').show();
                } else {
                    $('#div_getemailaddress').hide();
                }

            });


            $('#cb_sendpasswordreset').change(function () {
                if ($('#cb_sendpasswordreset').prop('checked')) {
                    $('#div_getusername').show();
                } else {
                    $('#div_getusername').hide();
                }

            });


        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Community Contracts - Login Assistance
    </h1>



    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <div class="checkbox">
                <label>
                    <input id="cb_username" type="checkbox" value="username">I can't remember my user name</label>
            </div>
        </div>
    </div>
    <div id="div_username" style="display: none">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <p>Your username is a minimum of 6 characters long.  It may use a mixture of letters, symbols, and numbers but is not case sensitive.  It is most likely "meaningful" to the group.</p>
            <div class="checkbox">
                <label>
                    <input id="cb_sendusername" type="checkbox" value="sendusername">Send the username to the email addresses recorded against the group</label>
            </div>
            <div id="div_getemailaddress" style="display: none">
                <p>&nbsp</p>
                <p>Please enter an email address that is recorded for the group</p>
                <input id="tb_emailaddress" name="tb_emailaddress" type="text" class="form-control" />
            </div>
        </div>
        <p>&nbsp</p>
    </div>



    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <div class="checkbox">
                <label>
                    <input id="cb_password" type="checkbox" value="password">I can't remember my password</label>
            </div>
        </div>
    </div>
    <div id="div_password" style="display: none">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <p>Your password is between 6 and 8 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit.</p>
            <div class="checkbox">
                <label>
                    <input id="cb_sendpasswordreset" type="checkbox" value="sendpasswordreset">Send a link to reset the password to the email addresses recorded against the group</label>
            </div>
            <div id="div_getusername" style="display: none">
                <p>&nbsp</p>
                 <p>Please enter the username for the group</p>
                               <input id="tb_username" name="tb_username" type="text" class="form-control" required /></div>
        </div>
        <p>&nbsp</p>
    </div>



    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Submit" />
        </div>
    </div>


    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <a href="default.aspx">Menu</a> | <a href="login.aspx">Login</a>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
