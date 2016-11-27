<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ApplicationList.aspx.cs" Inherits="Online.CommunityContract.ApplicationList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        
        <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="default.aspx">Community Contracts</a><span class="navbar-brand"> <%:Session["communitycontractsgroup_legalname"]%></span>
            </div>
            <!--
    <ul class="nav navbar-nav">dir
      <li class="active"><a href="#">Home</a></li>
      <li><a href="#">Page 1</a></li>

    </ul>
                  -->
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.aspx"><span class="glyphicon glyphicon-user"></span> Log out</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-user"></span> Reset Password</a></li>
                <li><a id="pagehelp">
                    <img id="helpiconz" src="http://wdc.whanganui.govt.nz/online/images/questionNavBar.png" title="Click on me for specific help on this page." /></a></li>
            </ul>
        </div>
    </nav>


      <h1>Community Contracts - Completed applications
    </h1> <asp:Literal ID="Literal1" runat="server"></asp:Literal>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

</asp:Content>
