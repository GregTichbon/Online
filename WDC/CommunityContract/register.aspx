<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Online.CommunityContract.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="<%: ResolveUrl("~/Scripts/pwstrength-bootstrap.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "default.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $("#form1").validate({
                rules: {
                    tb_username: {
                        minlength: 6,
                        remote: "../functions/data.asmx/communitycontracts_username"
                    },
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






        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

            <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="default.aspx">Community Contracts</a>
            </div>

            <ul class="nav navbar-nav navbar-right">
                                 <li><a href="login.aspx"><span class="glyphicon glyphicon-user"></span> Log in</a></li>
                <li><a href="loginassistance.aspx"><span class="glyphicon glyphicon-user"></span> Login Assistance</a></li>
               <li><a id="pagehelp">
                    <img id="helpiconz" src="http://wdc.whanganui.govt.nz/online/images/questionNavBar.png" title="Click on me for specific help on this page." /></a></li>
            </ul>
        </div>
    </nav>


    <h1>Community Contracts Group Registration
    </h1>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_username">User name</label>
        <div class="col-sm-8">
            <input id="tb_username" name="tb_username" type="text" class="form-control" required />
        </div>
    </div>


    <div class="form-group" id="pwd-container">
        <label class="control-label col-sm-4" for="tb_password">Password</label>
        <div class="col-sm-3">
            <input id="tb_password" name="tb_password" type="password" class="form-control" required />
        </div>
        <div class="col-sm-3" style="padding-top: 10px;">
            <div class="pwstrength_viewport_progress"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_passwordconfirm">Please retype your password</label>
        <div class="col-sm-3">
            <input id="tb_passwordconfirm" name="tb_passwordconfirm" type="password" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
