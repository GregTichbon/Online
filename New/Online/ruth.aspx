<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ruth.aspx.cs" Inherits="Online.ruth" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1><%: webconfig %>
    </h1>


    <h3>Licences</h3>
    <ul>
        <li>
            <a href="HealthPremiseRegistration/HealthPremiseRegistration.aspx">Health Premises Registration</a></li>
        <li>
            <a href="mobileshoplicence/mobileshoplicence.aspx">Mobile Shop Licence</a></li>

        <li>
            <a href="fcp/foodbusinessregistration.aspx">Food Business Registration</a></li>
        <li>
            <a href="MarketFoodStallLicence/MarketFoodStallLicence.aspx">Market Food Stall Licence</a></li>
    </ul>
     <h3>Stuff to check</h3>
    <ul><li>All the correct fields</li>
        <li>Validation</li>
        <li>Dependant fields</li>
        <li>Top level help</li>
        <li>Field help</li>
        <li>Screen on submit</li>
        <li>Email on submit; to applicant and WDC</li>
        <li>Attachments</li>
        <li>Links to attachments</li>
        <li>P&amp;R - Data, Links, Attachments</li>
        <li>Hubble - Data, Links, Attachments</li></ul>
    <h3>Status</h3>
    <ul>
        <li><strong>Health Premises Registration</strong><br />Ruth to do Help at top level and on fields.</li>
        <li><strong>Mobile Shop Licence</strong><br />This should be complete, waiting for Ruth to sign off.</li>

        <li><strong>Food Business Registration</strong><br />P&amp;R and Hubble not yet done, Want to ensure correct fields, help, validation, dependant fields, screen on submit, email on submit.</li>
        <li><strong>Market Food Stall Licence</strong><br />Ruth to do Help at top level and on fields.</li>
    </ul>
        <h3><a href="http://hubbletest.wanganui.govt.nz/site/ehlthapps/2016" target="_blank">Hubble Test</a></h3>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
