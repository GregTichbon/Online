<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendText.aspx.cs" Inherits="DataInnovations.Raffles.SendText" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        table.blueTable {
            border: 1px solid #1C6EA4;
            background-color: #EEEEEE;
            width: auto;
            text-align: left;
            border-collapse: collapse;
        }

            table.blueTable td, table.blueTable th {
                border: 1px solid #AAAAAA;
                padding: 3px 2px;
            }

            table.blueTable tbody td {
                font-size: 13px;
            }

            table.blueTable tr:nth-child(even) {
                background: #D0E4F5;
            }

            table.blueTable thead {
                background: #1C6EA4;
                background: -moz-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: -webkit-linear-gradient(top, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                background: linear-gradient(to bottom, #5592bb 0%, #327cad 66%, #1C6EA4 100%);
                border-bottom: 2px solid #444444;
            }

                table.blueTable thead th {
                    font-size: 15px;
                    font-weight: bold;
                    color: #FFFFFF;
                    border-left: 2px solid #D0E4F5;
                }

                    table.blueTable thead th:first-child {
                        border-left: none;
                    }

            table.blueTable tfoot td {
                font-size: 14px;
            }

            table.blueTable tfoot .links {
                text-align: right;
            }

                table.blueTable tfoot .links a {
                    display: inline-block;
                    background: #1C6EA4;
                    color: #FFFFFF;
                    padding: 2px 8px;
                    border-radius: 5px;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="tb_message" runat="server" Height="115px" Width="498px"></asp:TextBox>

            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" Text="Button" />

            <table id="tbl" class="blueTable">
                <tbody>

                    <tr>
                        <td>Mobile</td>
                        <td>Person</td>
                        <td>Response</td>
                    </tr>

                    <asp:Literal ID="LitRows" runat="server"></asp:Literal>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
