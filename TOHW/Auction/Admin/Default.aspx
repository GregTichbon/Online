<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TOHW.Auction.Admin.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p><a href="itemlist.aspx">Items</a></p>
    <p><a href="item.aspx?all=true">All Items</a></p>
    <p><a href="donorlist.aspx">Donors</a></p>
    <p><a href="donor.aspx?all=true">All Donors</a></p>
    <p><a href="sql.aspx">Reports</a></p>
    <p><a href="winners.aspx">Winners</a></p>
    <p><a href="logoff.aspx">Sign Off</a></p>
</asp:Content>
