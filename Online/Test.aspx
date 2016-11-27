﻿<%@ Page Title="Whanganui District Council Online Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="Online.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1><%: webconfig %>
    </h1>
    <div class="row">
        <div class="col-sm-3">
            <h3>Community Contracts</h3>
            <ul>
                <li><a href="CommunityContract/default.aspx">Group Registration<br />
                    and Funding Application</a></li>
            </ul>

        </div>
        <div class="col-sm-3">
            <h3>Health Premises</h3>
            <ul>
                <li>
                    <a href="Entity/Entity.aspx?folder=healthpremiseregistration&amp;form=healthpremiseregistration">Registration</a></li>
            </ul>
        </div>
        <div class="col-sm-3">
            <h3>Licences</h3>
            <ul>
                <li>
                    <a href="Entity/Entity.aspx?folder=mobileshoplicence&amp;form=mobileshoplicence">Mobile Shop</a></li>

                <li>
                    <a href="fcp/foodbusinessregistration.aspx">Food Business Registration</a></li>

            </ul>

        </div>
        <div class="col-sm-3">
            <h3>War Memorial Centre</h3>
            <ul>
                <li>
                    <a href="wmc/bookingenquiry.aspx">Booking Enquiry</a></li>
                <li>
                    <a href="wmc/calendar.aspx">Calendar</a></li>


            </ul>
        </div>
        <div class="col-sm-3">
            <h3>General</h3>
            <ul>
                <li>
                    <a href="general/FireSafetyReferral.aspx">Fire Safety Referral</a></li>



            </ul>
        </div>
        <div class="col-sm-3">
            <h3>Test & Play</h3>
            <ul>
                <li>
                    <a href="TestandPlay/validation1.aspx">Validation1</a></li>
                <li>
                    <a href="Entity/entity.aspx">Entity</a></li>
                <li>
                    <a href="mobileshoplicence/mobileshoplicence.aspx">Mobile Shop Licence</a></li>
                <li>
                    <a href="invoicepayment/invoicepayment.aspx">Invoice Payment</a></li>
                <li>
                    <a href="FCP/FoodBusinessRegistration.aspx">Food Business Registration</a></li>
                                <li>
                    <a href="mapping/showfile.aspx">Show Map</a></li>
            </ul>
        </div>
        <div class="col-sm-9">
        </div>
    </div>

</asp:Content>
