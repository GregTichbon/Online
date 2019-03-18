<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Amended.aspx.cs" Inherits="Online.Contractor.Amended" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            font-size: x-large;
            display:table;
            margin:0 auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <span class="auto-style1">Thank you for your update, your changes have been recorded.</span>
    <br />
    <br />
    <span class="auto-style1"><a href="contractor.aspx">Return to your page.</a></span>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
