<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Reportmenu.aspx.cs" Inherits="Auction.Administration.Reportmenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <p><a href="reports/winners.aspx">Winners (export to Excel)</a></p>
        <p><a href="winners.aspx">Winners (with history)</a></p>
    <p>
    </p>
    <p><a href="default.aspx">Return to Administration menu</a></p>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
