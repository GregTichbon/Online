<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Closed.aspx.cs" Inherits="Online.PolicySubmissions.Closed" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align:center">
    <h1><asp:Literal ID="lit_title" runat="server"></asp:Literal></h1>
    Closed at<br />
<asp:Literal ID="lit_datetime" runat="server"></asp:Literal>
    <br />
    <p><a href="http://www.whanganui.govt.nz/our-district/have-your-say/Pages/default.aspx">Return to "Have your say"</a></p>
        <br />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
