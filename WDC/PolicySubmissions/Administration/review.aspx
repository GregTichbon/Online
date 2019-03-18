<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="review.aspx.cs" Inherits="Online.PolicySubmissions.Administration.review" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <asp:DropDownList ID="dd_submission_name" runat="server">
      <asp:ListItem>Gambling1017</asp:ListItem>
      <asp:ListItem>Parking1117</asp:ListItem>
      <asp:ListItem>EasterSunday1017</asp:ListItem>
    </asp:DropDownList>

    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />

        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

</asp:Content>