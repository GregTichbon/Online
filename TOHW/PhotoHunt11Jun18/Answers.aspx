<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Answers.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.Answers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="<%: ResolveUrl("~/Dependencies/colorbox/colorbox.css")%>" rel="stylesheet" />

    <style>
        table.blueTable {
            border: 1px solid #1C6EA4;
            background-color: #EEEEEE;
            width: 100%;
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

            table.blueTable tfoot {
                font-size: 14px;
                font-weight: bold;
                color: #FFFFFF;
                background: #D0E4F5;
                background: -moz-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                background: -webkit-linear-gradient(top, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                background: linear-gradient(to bottom, #dcebf7 0%, #d4e6f6 66%, #D0E4F5 100%);
                border-top: 2px solid #444444;
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

    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="<%: ResolveUrl("~/Dependencies/colorbox/jquery.colorbox-min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.showphotos').click(function () {
                photo = $(this).data('photo');
                groupcode = $(this).data('groupcode');
                $.colorbox({
                    href: 'answersphotos.aspx?groupcode=' + groupcode + '&photo=' + photo,
                    iframe: true,
                    overlayClose: false,
                    width: '90%',
                    height: '90%'
                });
            });
        }); //document.ready

    </script>



</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="blueTable">
                <tr><th>Group</th><th>Photo</th><th>Place</th><th>Photo Version</th><th>Answered</th><th>Photos</th></tr>
                <asp:Literal ID="Lit_Answers" runat="server"></asp:Literal>
            </table>
        </div>
    </form>
</body>
</html>
