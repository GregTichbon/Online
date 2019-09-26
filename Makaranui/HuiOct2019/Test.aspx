<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="Makaranui.HuiOct2019.Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        table {
            border: 1px solid black;
            border-collapse: collapse;
        }

            table td, table th {
                border: 1px solid black;
                padding: 5px;
                text-align: left;
            }

        #div1 {
            text-align: center;
            margin-right: auto;
            margin-left: auto;
        }
        #div2 {
            border: solid;
            text-align: center;
        }

        #table1 {
            display: inline-block;
        }

        #table2 {
            display: inline-block;
        }

        #table3 {
            float: right;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="div1">
   
                <table id="table1">
                    <tr>
                        <td>A</td>
                        <td>B</td>
                    </tr>
                    <tr>
                        <td>A</td>
                        <td>B</td>
                    </tr>
                    <tr>
                        <td>A</td>
                        <td>B</td>
                    </tr>
                    <tr>
                        <td>A</td>
                        <td>B</td>
                    </tr>
                </table>

                <table id="table2">
                    <tr>
                        <td>A</td>
                        <td>B</td>
                    </tr>
                    <tr>
                        <td>A</td>
                        <td>B</td>
                    </tr>
                    

                </table>
                

      
 

    </div>
</asp:Content>
