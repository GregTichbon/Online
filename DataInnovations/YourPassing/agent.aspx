<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="agent.aspx.cs" Inherits="DataInnovations.YourPassing.agent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <h2>Sign in</h2>
    Email Address: <asp:TextBox ID="tb_emailaddress" runat="server"></asp:TextBox> <br />
    Password: <asp:TextBox ID="tb_password" runat="server" TextMode="Password"></asp:TextBox> <br />
    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
        <br />
        <br />
        <a href="agentregister.aspx">Not yet registered</a>
</asp:Content>
