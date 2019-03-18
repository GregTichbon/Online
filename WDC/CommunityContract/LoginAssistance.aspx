<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginAssistance.aspx.cs" Inherits="Online.CommunityContract.LoginAssistance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "loginassistancehelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            <% if (Session["communitycontracts_loginassistance_message"] != null)
               {%>
            $("#dialog-message").html('<%:Session["communitycontracts_loginassistance_message"]%>');
            $("#dialog-message").dialog({
                resizable: false,
                height: 140,
                modal: true,
            });

        <%                       Session.Remove("communitycontracts_loginassistance_message");
               }%>

            $("#form1").validate({
                rules: {
                    tb_emailaddress: {
                        remote: "../functions/data.asmx/communitycontracts_emailaddress?submissionperiod=2016"
                    }
                },
                messages: {
                    rb_option: "Please select an option",
                    cb_sendusername: "You will need to check this and enter the email address to be sent your user name",
                    cb_sendpasswordreset: "You will need to check this and enter the user name to be sent an email to reset your password"
                },
                errorPlacement: function (error, element) {
                    //Custom position
                    if (element.attr("name") == "rb_option") {
                        error.appendTo('#myerror');
                    }
                    else if (element.hasClass('cb_error')) {
                        error.appendTo('#myerror_' + element.attr("id"));
                        // Default position
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

            /*
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
            */

            $("input[name = rb_option]").change(function () {
                //alert(this.id);
                if (this.id == 'rb_username') {
                    $('#div_username').show();
                    $('#div_password').hide();

                } else {
                    $('#div_password').show();
                    $('#div_username').hide();
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
            /*
            <input id="cb_username" type="checkbox" value="username">
            <input id="cb_password" type="checkbox" value="password">
            */

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="dialog-message" title="Processing Message">
    </div>


            <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="default.aspx">Community Contracts</a>
            </div>

            <ul class="nav navbar-nav navbar-right">
                                <li><a href="register.aspx"><span class="glyphicon glyphicon-user"></span> Register a new group</a></li>
                                <li><a href="login.aspx"><span class="glyphicon glyphicon-user"></span> Log in</a></li>
                <li><a id="pagehelp">
                    <img id="helpiconz" src="http://wdc.whanganui.govt.nz/online/images/questionNavBar.png" title="Click on me for specific help on this page." /></a></li>
            </ul>
        </div>
    </nav>





    <h1>Community Contracts - Login Assistance
    </h1>



    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <input id="rb_username" name="rb_option" type="radio" value="username" required />
            <label>I don't have a record of the user name</label>
        </div>
    </div>
    <div id="div_username" style="display: none">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <p>The username is a minimum of 6 characters long.  It may use a mixture of letters, symbols, and numbers but is not case sensitive.  It is most likely "meaningful" to the group.</p>
            <input id="cb_sendusername" name="cb_sendusername" type="checkbox" value="sendusername" required class="cb_error" />
            Send the username to the email addresses recorded against the group
            <div id="myerror_cb_sendusername"></div>
            <div id="div_getemailaddress" style="display: none">
                <p>&nbsp</p>
                <p>Please enter the email address that is recorded for the group</p>
                <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" required />
            </div>
        </div>
        <p>&nbsp</p>
    </div>



    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <input id="rb_password" name="rb_option" type="radio" value="password" />
            <label>I don't have a record of the password</label>
        </div>
    </div>
    <div id="div_password" style="display: none">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <p>The password is between 6 and 8 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit.</p>
            <label>
                <input id="cb_sendpasswordreset" name="cb_sendpasswordreset" type="checkbox" value="sendpasswordreset" required class="cb_error" />
                Send a link to reset the password to the email addresses recorded against the group</label>
            <div id="myerror_cb_sendpasswordreset"></div>
            <div id="div_getusername" style="display: none">
                <p>&nbsp</p>
                <p>Please enter the username for the group</p>
                <input id="tb_username" name="tb_username" type="text" class="form-control" required />
            </div>
        </div>
        <p>&nbsp</p>
    </div>

    <div class="col-sm-3">
    </div>
    <div id="myerror" class="col-sm-9"></div>

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
