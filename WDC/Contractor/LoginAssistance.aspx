<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginAssistance.aspx.cs" Inherits="Online.Contractor.LoginAssistance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "loginassistancehelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

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
                        require_from_group: [1, ".username_emailaddress"]
                    },
                    tb_username: {
                        require_from_group: [1, ".username_emailaddress"]
                    }
                },
                errorPlacement: function (error, element) {
                    //Custom position
                    //alert(element.attr("name"));
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

            $("input[name = rb_option]").change(function () {
                //alert(this.id);
                if (this.id == 'rb_emailaddress') {
                    $('#div_username_emailaddress').show();
                    $('#div_password').hide();

                } else {
                    $('#div_password').show();
                    $('#div_username_emailaddress').hide();
                }
            });

            $('#cb_sendpasswordreset').change(function () {
                if ($('#cb_sendpasswordreset').prop('checked')) {
                    $('#div_getusername').show();
                } else {
                    $('#div_getusername').hide();
                }

            });
                        <%
        string url = Request.Url.Query;
        if (url == "")
        {
            url = "?create=true";
        }
        else
        {
            url = url + "&create=true";
        }
             %>

            $('#a_register').attr('href', 'contractor.aspx<%=url %>');


                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>


        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="dialog-message" title="Processing Message">
    </div>
    <h1>Login Assistance</h1>

    <div class="form-group">
        <div class="col-sm-4">
            If you haven't already registered, please do so now
        </div>
        <div class="col-sm-8">
            <a id="a_register">
                <input type="button" id="btn_register" class="btn btn-info" value="Register" /></a>
        </div>
    </div>


    <div class="form-group">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-9">
            <input id="rb_emailaddress" name="rb_option" type="radio" value="username" required />
            <label>I don't know my email address and/or username</label>
        </div>
    </div>
    <div id="div_username_emailaddress" style="display: none">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <p>Please contact the Whanganui District Council (06) 3490001.</p>
            <p>Council office hours are 8:00am to 5:00pm Monday to Friday.</p>
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
                Send a link to reset the password to your email addresses</label>
            <div id="myerror_cb_sendpasswordreset"></div>
            <div id="div_getusername" style="display: none">
                <p>&nbsp</p>
                <p>Please enter your email address</p>
                <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control username_emailaddress" />
                <br />
                <p>or username</p>

                <input id="tb_username" name="tb_username" type="text" class="form-control username_emailaddress" />
                <br />
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Submit" />

            </div>
        </div>
        <p>&nbsp</p>
    </div>

    <div class="col-sm-3">
    </div>
    <div id="myerror" class="col-sm-9"></div>



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
