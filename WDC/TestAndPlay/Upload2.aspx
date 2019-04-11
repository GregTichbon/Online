<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Upload2.aspx.cs" Inherits="Online.TestAndPlay.Upload2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <input id="fu_additionalfiles" name="fu_additionalfiles" type="file" multiple="multiple" />
    <asp:FileUpload ID="FileUpload1" runat="server" />
    <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
