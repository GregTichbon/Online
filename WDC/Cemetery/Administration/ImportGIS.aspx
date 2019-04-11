<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImportGIS.aspx.cs" Inherits="Online.Cemetery.Administration.ImportGIS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Import GIS
    </h1>
    <p>Import a CSV file into Cemetery GIS Import</p>

    <asp:TextBox ID="tb_filename" runat="server" Width="1354px">F:\InternetData\Cemetery\AramohoCemeteryPlots .......csv</asp:TextBox>
            <asp:Button ID="btn_go" runat="server" OnClick="btn_go_Click" Text="Go" />

    <br />
    <asp:Literal ID="lit_response" runat="server"></asp:Literal>
    <br />

 </asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
