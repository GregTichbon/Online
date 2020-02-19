<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="LoginAssistance.aspx.cs" Inherits="UBC.People.Security.LoginAssistance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
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

    <script type="text/javascript">
        $(document).ready(function () {

            //$("#pagehelp").colorbox({ href: "loginassistancehelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            <% if (Session["loginassistance_message"] != null)
        {%>
            $("#dialog-message").html('<%:Session["loginassistance_message"]%>');
            $("#dialog-message").dialog({
                resizable: false,
                height: 140,
                modal: true,
            });

        <%                       Session.Remove("loginassistance_message");
        }%>

            $("#form1").validate({
                rules: {
                    tb_emailaddress: {
                        require_from_group: [1, ".username_mobile"]
                    },
                    tb_mobile: {
                        require_from_group: [1, ".username_mobile"],
                        pattern: /02[0-9]\d{5,9}/
                    }
                }/*,
                errorPlacement: function (error, element) {
                    //Custom position
                
                    alert(element.attr("name"));
                    if (element.attr("name") == "tb_emailaddress") {
                        error.appendTo('#myerror');
                    }
                    else if (element.hasClass('cb_error')) {
                        error.appendTo('#myerror_' + element.attr("id"));
                        // Default position
                    } else {
                        error.insertAfter(element);
                    }
                 
                    error.appendTo('#myerror_' + element.attr("id"));
                }*/
            });

            $("input[name='rb_option']").change(function () {
                //alert(this.id);
                if (this.id == 'rb_username') {
                    $('#div_username').show();
                    $('#div_password').hide();

                } else {
                    $('#div_password').show();
                    $('#div_username').hide();
                }
            });

            $('#cb_sendpasswordreset').change(function () {
                if ($('#cb_sendpasswordreset').prop('checked')) {
                    $('#div_resetpassword').show();
                } else {
                    $('#div_resetpassword').hide();
                }
            });

            $('#cb_sendpusername').change(function () {
                if ($('#cb_sendpusername').prop('checked')) {
                    $('#div_sendusername').show();
                } else {
                    $('#div_sendusername').hide();
                }
            });

        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="dialog-message" title="Processing Message">
    </div>
    <h1>Login Assistance</h1>
    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <input id="rb_username" name="rb_option" type="radio" value="username" required />
            <label>I don't know / remember my username</label>
        </div>
    </div>

    <div id="div_username" style="display: none">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <label>
                <input id="cb_sendpusername" name="cb_sendpusername" type="checkbox" value="sendpusername" required class="cb_error" />
                Send your username to your email address and mobile phone</label>

            <div id="div_sendusername" style="display: none">
                <p>Please enter your email address</p>
                <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control username_mobile" />
                <br />
                <p>and/or mobile number</p>
                <input id="tb_mobile" name="tb_mobile" type="text" class="form-control username_mobile" />
                <div id="myerror_tb_emailaddress"></div>
                <br />
                <asp:Button ID="btn_sendusername" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Submit" />
            </div>

        </div>
        <p>&nbsp</p>
    </div>

    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <input id="rb_password" name="rb_option" type="radio" value="password" />
            <label>I don't don't know / remember my password</label>
        </div>
    </div>

    <div id="div_password" style="display: none">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <p>The password is between 6 and 8 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit.</p>
            <label>
                <input id="cb_sendpasswordreset" name="cb_sendpasswordreset" type="checkbox" value="sendpasswordreset" required class="cb_error" />
                Send a link to reset the password to your email addresses or mobile number</label>
            <div id="div_resetpassword" style="display: none">
                <p>Please enter your username</p>
                <input id="tb_username" name="tb_username" class="form-control" required />
                <div id="myerror_tb_username"></div>
                <br />

                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Submit" />
            </div>
        </div>
        <p>&nbsp</p>
    </div>


    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <a href="login.aspx">Login</a>
        </div>
    </div>
</asp:Content>
