<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Data.aspx.cs" Inherits="Online.Administration.PolicySubmissions.Data" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        table {
            font-family: "Times New Roman", Times, serif;
            border: 1px solid #FFFFFF;
            width: 350px;
            height: 200px;
            text-align: center;
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

            table tfoot td {
                font-size: 14px;
            }

        br {
            mso-data-placement: same-cell;
        }
    </style>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script src="../../Scripts/table2excel.min.js"></script>
    <script type="text/javascript">


        $(document).ready(function () {
            if ($('#tbl_data tr').length > 0) {
                $("#btn_export").show();
            }

            $('#dd_table').change(function () {
                //alert($(this).val());
                if ($(this).val() == 'PS_Submitter') {
                    $('#div_showsubmitter').hide();
                } else {
                    //alert(1);
                    $('#div_showsubmitter').show();
                }

            });

            $("#btn_export").click(function () {
                // $("#tbl_data td").text()
                $("#tbl_data").table2excel({
                    name: "Pickups",
                    // exclude CSS class
                    exclude: ".noExport",
                    name: "Sheet1",
                    filename: "PolicySubmissions" + new Date().toISOString().replace(/[\-\:\.]/g, "") //do not include extension

                });
            });
        });
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <select id="dd_table" name="dd_table">
            <option></option>
            <%= tables%>
        </select>


        <span id="div_showsubmitter" style="display: none">
            <asp:CheckBox ID="cb_showsubmitter" runat="server" /> Show submitter details
        </span>
        <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />

        <br />
        <input id="btn_export" type="button" value="Export" style="display: none" />


        <%= table %>
    </form>
</body>
</html>
