<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="tracker.aspx.cs" Inherits="iti.ninja.tracker" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

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

        .allocated {
            display: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <%= html %>
    </form>
</body>
</html>
