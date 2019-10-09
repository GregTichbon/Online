<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Attendees.aspx.cs" Inherits="Makaranui.HuiOct2019.Attendees" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        th {
            text-align: left;
        }

            th.right, td.right {
                text-align: right;
            }

        .numeric {
            direction: rtl;
            text-align: right;
            width: 50px;
        }

        #regtable {
            width: 100%;
        }

        table {
            border: 1px solid black;
            border-collapse: collapse;
        }

            table td, table th {
                border: 1px solid black;
                padding: 5px;
                text-align: left;
            }

            table tbody td {
                font-size: 13px;
            }

            table tr.blue {
                background: #D0E4F5;
            }

            table tr.altcolour:nth-child(even) {
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <thead><tr>

       <th>PrimaryContact</th><th>Firstname</th><th>Lastname</th><th>Age</th><th>Dietary</th><th>Medical</th><th>Medication</th><th>Emergency Contacts</th><th>First Aid Certificate</th><th>Mobile</th><th>Email Address</th>



               </tr></thead><tbody><%=html %></tbody>
    </table>
</asp:Content>
