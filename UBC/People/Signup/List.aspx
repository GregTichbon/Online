<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="UBC.People.Signup.List" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        table {
            font-family: "Times New Roman", Times, serif;
            border: 1px solid #FFFFFF;
            border-collapse: collapse;
        }

            table td, table th {
                border: 1px solid #FFFFFF;
                padding: 3px 2px;
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
                    text-align: center;
                    border-left: 2px solid #FFFFFF;
                }

                    table thead th:first-child {
                        border-left: none;
                    }

            table tfoot {
                font-size: 14px;
                font-weight: bold;
                color: #333333;
                background: #D0E4F5;
                border-top: 3px solid #444444;
            }

                table tfoot td {
                    font-size: 14px;
                }

                img {
                    width:150px;
                }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <a href="http://ubc.org.nz/people/signup">Add new person</a><br />
        <br />
        <table>
            <%= html %>
        </table>


        
    </form>
</body>
</html>
