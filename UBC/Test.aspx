<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="UBC.Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>


    <script>
        $(document).ready(function () {

            $('#dd_categories').select2({
                width: '20%' // need to override the changed default
            });



        });
    </script>
    <style>
        table {
            border:solid;
        }
        td {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <select id="dd_categories" name="dd_categories" multiple="multiple">
        <option value="5">Coach</option>
        <option value="7">Committee Member</option>
        <option value="4">Emergency Contact</option>
        <option value="6">Helper</option>
        <option value="12">Learn to Row 2018</option>
        <option value="3">Parent / Caregiver</option>
        <option value="9">Rower - Competitive</option>
        <option value="1">Rower - Novice</option>
        <option value="10">Rower - Social</option>
        <option value="11">Rower - Student</option>
        <option value="8">School Contact</option>
        <option value="2">Student</option>
    </select>

    <table>
        <tr>
            <th>Name</th>
            <th>Atendance</th>
            <th>Role</th>
            <th>Public Note</th>
            <th>Private Note</th>
        </tr>
        <tr>
            <td rowspan="3">Name</td>
            <td rowspan="3">Attendance</td>
            <td rowspan="3">Role</td>
        </tr>
        <tr>
            <td>Public</td>
            <td>Private</td>
        </tr>
        <tr>
            <td colspan="2">Personal</td>
        </tr>

        <tr>
            <td rowspan="2">Peer Nielsen</td>
            <td rowspan="2">5555555555</td>
            <td rowspan="2">6666666</td>
        </tr>
        <tr>
            <td>77777777777777</td>
            <td>88888888888888</td>
        </tr>
    </table>


    <table>
        <tr>
            <td>Mon</td>
            <td>Tues</td>
            <td>Wed</td>
        </tr>
        <tr>
            <td>4</td>
            <td>5</td>
            <td>6</td>
        </tr>
        <tr>
            <td rowspan="2">77</td>
            <td colspan="2">8&nbsp;&nbsp;&nbsp; 9</td>
        </tr>
        <tr>
            <td>8</td>
            <td>9</td>
        </tr>
        <tr>
            <td>7</td>
            <td>8</td>
            <td>9</td>
        </tr>
    </table>


</asp:Content>
