<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Complete.aspx.cs" Inherits="UBC.People.Signup.Complete" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    
    <style type="text/css">
               
        .style1 {
            text-align: center;
            font-size: xx-large;
        }
               
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        

    <div class="container" style="background-color:#B1C9E6" >
        <p></p>
        <table style="width:100%">
            <tr>
                <td style="width:350px">
                    <img src="http://private.unionboatclub.co.nz/dependencies/images/Logo-Page-Head.png" style="width:100%" /></td>
                <td style="text-align:center">
                    <h1>Schools Learn to Row<br />Friday 23 - Sunday 25 August 2019
                    </h1>
                </td>
            </tr>
        </table>
        <p></p>
        <hr />
        <p></p>

        <div class="panel panel-danger">
            <!--<div class="panel-heading">Rower</div>-->
            <div class="style1">
                <br />
                Thanks for your registration<--, we look forward to seeing you.<br />
                <br />
                Get more information from the <a href="http://ubc.org.nz/people/SchoolLearntoRowAug2019.pdf" target="_blank">brochure</a>
                <br />-->
                <br />
                You can contact us on 0800 002 541 if you have any questions<br />
                <br />
            </div>
        </div>

       

    </div>


</asp:Content>
