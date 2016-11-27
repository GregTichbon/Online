<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="TOHW.Pickups.Admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:TextBox ID="tb_date" runat="server"></asp:TextBox><asp:Button ID="btn_setdate" runat="server" Text="Set Date" OnClick="btn_setdate_Click" />
    <br />
    <br />


    <asp:Button ID="btn_clear" runat="server" Text="Clear All" OnClick="btn_clear_Click" />

</asp:Content>
