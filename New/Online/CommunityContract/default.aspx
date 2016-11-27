<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Online.CommunityContract._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "defaultHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">Community Contracts</a><span class="navbar-brand"> <%:Session["communitycontractsgroup_legalname"]%></span>
            </div>
            <!--
    <ul class="nav navbar-nav">
      <li class="active"><a href="#">Home</a></li>
      <li><a href="#">Page 1</a></li>

    </ul>
                  -->
            <ul class="nav navbar-nav navbar-right">
                <% if (Session["communitycontracts_users_ctr"] != null)
                   { %>


                <li><a href="logout.aspx"><span class="glyphicon glyphicon-user"></span> Log out</a></li>
                <li><a href="resetpassword.aspx"><span class="glyphicon glyphicon-user"></span> Reset Password</a></li>
                <%}%>
                <li><a href="login.aspx"><span class="glyphicon glyphicon-user"></span> Login</a></li>
                <li><a href="register.aspx"><span class="glyphicon glyphicon-user"></span> Register a new group</a></li>


                <li><a id="pagehelp">
                    <img id="helpiconz" src="http://wdc.whanganui.govt.nz/online/images/questionNavBar.png" title="Click on me for specific help on this page." /></a></li>
            </ul>
        </div>
    </nav>
    <h1>Community Contracts
    </h1>
    <p>Welcome to the Community Contracts site.</p>
    <p></p>

    <% if (Session["communitycontracts_users_ctr"] == null)
       { %>
    <p>You are not logged in</p>
    <%}
       else
       {%>
    <p>You are logged on as: <%: Session["communitycontractsgroup_legalname"] %></p>
    <%} %>

    <p><a href="register.aspx">Register a new group</a> </p>

    <% if (Session["communitycontracts_users_ctr"] == null)
       { %>
    <p><a href="login.aspx">Log in</a> </p>
    <p><a href="LoginAssistance.aspx">Login assistance</a> </p>
    <%}
       else
       {%>
    <p><a href="groupdetails.aspx">Maintain the details for your group</a> </p>
    <p><a href="ApplicationList.aspx">View a completed application from a previous funding round</a> </p>
    <% if (1 == 1)
       { %>
    <p><a href="application.aspx">Create/Maintain an application for the current funding round</a> </p>
    <%} %>
    <p><a href="logout.aspx">Log out</a> </p>
    <%} %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
