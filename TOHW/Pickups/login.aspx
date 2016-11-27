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
    <div class="centered">
        <span style="text-align:center">Please enter password</span><br />
        <asp:TextBox ID="tb_password" runat="server" TextMode="Password" style="width:200px"></asp:TextBox>
        <br />
        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" style="width:200px" />
    </div>
</asp:Content>
