<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Upload1.aspx.cs" Inherits="Online.TestAndPlay.Upload1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <asp:FileUpload ID="fu_othercouncil" runat="server" />
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Submit" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
