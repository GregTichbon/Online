<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="TOHW.Pickups.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .centered {
            position: fixed;
            top: 50%;
            left: 50%;
            /* bring your own prefixes */
            transform: translate(-50%, -50%);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr><td>Name: </td><td><asp:TextBox ID="tb_name" runat="server" style="width:200px"></asp:TextBox></td></tr>
        <tr><td>Password: </td><td><asp:TextBox ID="tb_password" runat="server" TextMode="Password" style="width:200px"></asp:TextBox></td></tr>
        <tr><td colspan="2"><asp:Button ID="Button1" runat="server" Text="Submit" OnClick="btn_submit_Click" style="width:200px" /></td></tr>
    </table>

</asp:Content>
