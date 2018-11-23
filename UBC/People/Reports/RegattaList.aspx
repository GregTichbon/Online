<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="RegattaList.aspx.cs" Inherits="UBC.People.Reports.RegattaList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <p>
        select dbo.get_name(PE.person_id,&#39;&#39;), Role, dbo.get_phone(pe.person_id,&#39;&#39;) as [Phone], PE.Note, PE.PrivateNote, PE.PersonNote, P.Dietry, P.Medical
    </p>
    <p>
        from Person_Event PE left outer join person P on P.person_id = PE.Person_ID
    </p>
    <p>
        --left outer join person_phone PC on PC.Person_id = PE.Person_ID
    </p>
    <p>
        where Event_ID = 107 and attendance = &#39;Going&#39;
    </p>
    <p>
        order by Role, dbo.get_name(PE.person_id,&#39;&#39;)</p>


</asp:Content>
