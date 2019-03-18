<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="navtab1.aspx.cs" Inherits="Online.TestAndPlay.navtab1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a data-target="#tab1" role="tab" data-toggle="tab">First Tab</a></li>
        <li role="presentation"><a data-target="#tab2" role="tab" data-toggle="tab">Second Tab</a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="tab1">Content 1</div>
        <div role="tabpanel" class="tab-pane" id="tab2">Content 2</div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
