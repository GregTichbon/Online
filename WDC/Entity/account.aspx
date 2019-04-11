<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="account.aspx.cs" Inherits="Online.Entity.account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">


        $(document).ready(function () {
            $('.view').click(function () {
                id = $(this).attr("id");
                $(".view").colorbox({ href: "displayactivity.aspx?id=" + id, iframe: true, height: "800", width: "700", overlayClose: true });
            });

                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document ready



    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>My Account</h1>
    <p><a href="entity.aspx">View/Edit my profile</a></p>
    <p><a href="Login.aspx">Log out</a></p>
    <p><a href="http://www.whanganui.govt.nz">Return to the Whanganui District Council web site</a></p>
        <h3>Actions</h3>
    <p><a href="../finance/directdebit.aspx">Make rates direct debit application</a></p>
    <h3>Activity</h3>
    <asp:Literal ID="Lit_activity" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
