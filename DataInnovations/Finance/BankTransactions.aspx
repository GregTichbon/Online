﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankTransactions.aspx.cs" Inherits="DataInnovations.Finance.BankTransactions" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <link href="Dependencies/UBC.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script>
        $(document).ready(function () {
            $(".select").click(function () {
                id = $(this).attr("id");
                 window.open("banktransaction.aspx?id=" + id, "banktransaction");
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="background-color: #FCF7EA">

            <h1>Data Innovations - Bank Transaction
            </h1>

            <table class="table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Details</th>
                        <th>Particulars</th>
                        <th>Code</th>
                        <th>Reference</th>
                        <th style="text-align: right">Amount</th>
                        <th style="text-align: right">Allocated</th>
                        <th>Transactions<br />Items</th>
                    </tr>
                </thead>
                <tbody>
                    <%= html %>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>

