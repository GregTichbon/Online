<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PublishedComparison.aspx.cs" Inherits="Online.Development.PublishedComparison" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:DropDownList ID="dd_options" runat="server">
        <asp:ListItem Selected="True">Online</asp:ListItem>
        <asp:ListItem>OnlineTest</asp:ListItem>
        <asp:ListItem>LocalHost - Testing</asp:ListItem>
    </asp:DropDownList><asp:Button ID="btn_compare" runat="server" Text="Compare" OnClick="btn_compare_Click" />

    &nbsp;&nbsp; For this to work &quot;Everyone&quot; needs full control on &quot;<a href="file:///F:/InetPub/whanganui">F:\InetPub\whanganui</a>&quot; on the webserver!<br />
    <br />

    Show: <asp:CheckBoxList ID="cbl_options" runat="server">
        <asp:ListItem Selected="True">Not Found</asp:ListItem>
        <asp:ListItem Selected="True">Different</asp:ListItem>
        <asp:ListItem>Found</asp:ListItem>
    </asp:CheckBoxList>

    <asp:ListBox ID="lb_output" runat="server" Height="456px">
        <asp:ListItem>xx</asp:ListItem>
    </asp:ListBox>

    <br />
    <asp:TextBox ID="tb_output_left" name="tb_output_left" runat="server" Rows="50" Width="40%" Height="63px" TextMode="MultiLine"></asp:TextBox>
    <asp:TextBox ID="tb_output_right" name="tb_output_right" runat="server" Rows="50" Width="40%" Height="63px" TextMode="MultiLine"></asp:TextBox>

    <asp:TextBox ID="tb_output" name="tb_output" runat="server" Rows="50" Width="80%" Height="63px" TextMode="MultiLine"></asp:TextBox>
    </asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
