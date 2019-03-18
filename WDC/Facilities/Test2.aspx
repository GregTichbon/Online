<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="Online.Facilities.Test2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        table.paleBlueRows {
            font-family: "Times New Roman", Times, serif;
            border: 1px solid #FFFFFF;
            width: 350px;
            height: 200px;
            text-align: center;
            border-collapse: collapse;
        }

            table.paleBlueRows td, table.paleBlueRows th {
                border: 1px solid #FFFFFF;
                padding: 3px 2px;
            }

            table.paleBlueRows tbody td {
                font-size: 13px;
            }

            table.paleBlueRows tr:nth-child(even) {
                background: #D0E4F5;
            }

            table.paleBlueRows thead {
                background: #0B6FA4;
                border-bottom: 5px solid #FFFFFF;
            }

                table.paleBlueRows thead th {
                    font-size: 17px;
                    font-weight: bold;
                    color: #FFFFFF;
                    text-align: center;
                    border-left: 2px solid #FFFFFF;
                }

                    table.paleBlueRows thead th:first-child {
                        border-left: none;
                    }

            table.paleBlueRows tfoot {
                font-size: 14px;
                font-weight: bold;
                color: #333333;
                background: #D0E4F5;
                border-top: 3px solid #444444;
            }

                table.paleBlueRows tfoot td {
                    font-size: 14px;
                }
    </style>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.css" />
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('table').DataTable(
                {
                    "paging": false,
                    "ordering": false,
                    "info": false,
                    "bFilter": false
                });

            $('td').click(function () {
                if ($(this).text() == '') {
                    val = 2;
                } else {
                    val = parseInt($(this).text());
                    //alert(val);
                    val = val + 1
                    if (val == 3) {
                        val = 0;
                    }
                }
                $(this).text(val);
            });

        }); //document.ready
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="paleBlueRows">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Wed<br />
                        22 Nov</th>
                    <th>Thu<br />23 Nov</th>
                    <th>Fri<br />24 Nov</th>
                    <th>25 Nov</th>
                    <th>26 Nov</th>
                    <th>27 Nov</th>
                    <th>28 Nov</th>
                    <th>29 Nov</th>
                    <th>30 Nov</th>
                    <th>1 Dec</th>
                    <th>2 Dec</th>
                    <th>3 Dec</th>
                    <th>4 Dec</th>
                    <th>5 Dec</th>
                    <th>6 Dec</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Judy & Greg</td>
                    <td>1</td>
                    <td>2</td>
                    <td>1</td>
                    <td>1</td>
                    <td>2</td>
                    <td>0</td>
                    <td>1</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>1</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Jordi & Nate</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>

        </table>



    </form>
</body>
</html>
