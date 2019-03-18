<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Online.CommunityContract.Administration.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "login.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <h1>Community Contracts - Administration Login
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_username">User name</label>
        <div class="col-sm-8">
             <asp:TextBox ID="tb_username" name="tb_username" runat="server" class="form-control" required="required"></asp:TextBox>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_password">Password</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_password" name="tb_password" runat="server" class="form-control" required="required" TextMode="Password"></asp:TextBox>
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

