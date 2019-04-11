<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Online.User.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <script type="text/javascript">
          $(document).ready(function () {

              $("#pagehelp").colorbox({ href: "default.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
          });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="default.aspx">Whanganui District Council</a>
            </div>

            <ul class="nav navbar-nav navbar-right">
                                <li><a href="register.aspx"><span class="glyphicon glyphicon-user"></span> Register</a></li>
                <li><a href="loginassistance.aspx"><span class="glyphicon glyphicon-user"></span> Login Assistance</a></li>
                <li><a id="pagehelp">
                    <img id="helpiconz" src="http://wdc.whanganui.govt.nz/online/images/questionNavBar.png" title="Click on me for specific help on this page." /></a></li>
            </ul>
        </div>
    </nav>

    <h1>Log in
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email Address</label>
        <div class="col-sm-8">
            <input id="tb_emailaddress" name="tb_emailaddress" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_password">Password</label>
        <div class="col-sm-8">
            <input id="tb_password" name="tb_password" type="password" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <a href="register.aspx">Register | <a href="loginassistance.aspx">Log in assistance</a>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
