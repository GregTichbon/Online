<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="agentregister.aspx.cs" Inherits="DataInnovations.YourPassing.agentregister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Agent Registration</h2>
    Email Address: <asp:TextBox ID="tb_emailaddress" runat="server"></asp:TextBox> <br />
    Password: <asp:TextBox ID="tb_password" runat="server" TextMode="Password"></asp:TextBox> <br />
    First name<br />
    Last name<br />
    Known as<br />
    Mobile Phone number<br />
    Gender<br />
    Address<br />
    Terms and Conditions<br />



    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
        <br />
        <br />
        <a href="agent.aspx">Already registered</a>
</asp:Content>
