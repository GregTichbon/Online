<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="UBC.People.Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="font-size: xx-large">
        <a href="Search.aspx">People Search</a>
        <br />
        <a href="List.aspx">People List</a>
        <br />
        <a href="EventList.aspx">Event List</a>
        <br />
        <a href="reports/CheckList.aspx">Check List</a>
        <br />
        <a href="AttendanceMatrix.aspx">Attendance Matrix</a>
    </div>

</asp:Content>
