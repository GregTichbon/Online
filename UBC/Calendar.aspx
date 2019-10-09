<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Calendar.aspx.cs" Inherits="UBC.Calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <style>

        tr.Aqua {
            background-color: aqua;
        }
         tr.Blue {
            background-color: Blue;
            color:white;
        }

        tr.gray {
            background-color: gray;
        }

        tr.Orange {
            background-color: Orange;
        }

        tr.Pink {
            background-color: Pink;
        }

        tr.Yellow {
            background-color: Yellow;
        }

        tr.Aqua {
            background-color: aqua;
        }
    </style>

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <script>
        $(document).ready(function () {

            $('#login').click(function () {
                window.location.href = "people/security/login.aspx";
            })
            $('#menu').click(function () {
                window.location.href = "default.aspx";
            })

        }); //document.ready

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        <%=html_button %>
        <h1>Union Boat Club - Calendar
        </h1>
        <table class="table">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Detail</th>
                </tr>
            </thead>
            <tbody><%=html %></tbody>
        </table>
    </div>

</asp:Content>
