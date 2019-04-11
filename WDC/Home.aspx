<%@ Page Title="Whanganui District Council Online Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Online.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1><%: webconfig %>
    </h1>
    <div class="row">
        <div class="col-sm-4">
            <h3>Community Contracts</h3>
            <ul>
                <li><a href="CommunityContract/default.aspx">Group Registration<br />
                    and Funding Application</a></li>
            </ul>

        </div>
        <div class="col-sm-4">
            <h3>Health Premises</h3>
            <ul>
                <li>
                    <a href="Entity/Entity.aspx?folder=healthpremiseregistration&amp;form=healthpremiseregistration">Registration</a></li>
            </ul>
        </div>
        <div class="col-sm-4">
            <h3>Licences</h3>
            <ul>
                <li>
                    <a href="Entity/Entity.aspx?folder=mobileshoplicence&amp;form=mobileshoplicence">Mobile Shop</a></li>
            </ul>
        </div>

    </div>

</asp:Content>
