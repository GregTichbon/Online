<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="DataInnovations.Accounts.Upload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Accounts Upload</title>
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

    </style>
</head>
<body>
    <form id="form1" runat="server">
   <div class="container" style="background-color: #FCF7EA">

        <h1>Upload
        </h1>
       <table>
           <thead>
               <tr>
                   <th>Bank Account</th>
                   <th>First Date</th>
                   <th>Last Date</th>
                   <th style="text-align: right">Transactions</th>
                   <th style="text-align: right">Credits</th>
                   <th style="text-align: right">Debits</th>
                   <th style="text-align: right">Net</th>
               </tr>
           </thead>
           <tbody>
               <%= html %>
           </tbody>
       </table>
       <div class="form-group">
           <div class="col-sm-4">
                Please upload the bank file
            </div>
            <div class="col-sm-8">
                <asp:FileUpload ID="fu_bankfile" runat="server" AllowMultiple="True" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-4">
                What format is it
            </div>
            <div class="col-sm-8">
                <asp:DropDownList ID="dd_format" runat="server">
                    <asp:ListItem Selected="True">ANZ - TSV</asp:ListItem>
                </asp:DropDownList>

            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>

    </div>
    </form>
</body>
</html>
