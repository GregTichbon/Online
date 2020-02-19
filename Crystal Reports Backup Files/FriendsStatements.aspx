<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="FriendsStatements.aspx.cs" Inherits="UBC.People.Reports.FriendsStatements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        table {
    width: 100%;
    border: 1px solid #FFFFFF;
    border-collapse: collapse;
}

    table td, table th {
        border: 1px solid #FFFFFF;
        padding: 5px;
        text-align: left;
    }

    table tbody td {
        font-size: 13px;
    }

    table tr:nth-child(even) {
        background: #D0E4F5;
    }

    table thead {
        background: #0B6FA4;
        border-bottom: 5px solid #FFFFFF;
    }

        table thead th {
            font-size: 17px;
            font-weight: bold;
            color: #FFFFFF;
            text-align: left;
            border-left: 2px solid #FFFFFF;
        }

            table thead th:first-child {
                border-left: none;
            }
.number {
    text-align:right;
}
    </style>
        <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <script>
        $(document).ready(function () {
            $('#btn_preview').click(function () {
                window.open("FriendsStatementsPreview.aspx", "_blank");
            });
        }); //$(document).ready

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html %>
    <button id="btn_preview" type="button">Preview</button> <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
</asp:Content>
