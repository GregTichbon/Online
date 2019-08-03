<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="Winners.aspx.cs" Inherits="Auction.Administration.Reports.Winners" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style> td.numeric, th.numeric {
            text-align:right;
        }
    </style>
    <script>
        $(document).ready(function () {

            $('#export').click(function () {
                var table = "<table>";
                $('#winners > thead  > tr').each(function () {
                    table += "<tr>";
                    $(this).find('th').each(function () {
                        table += "<th>";
                        table += $(this).text();
                        table += "</th>";
                    });
                    table += "</tr>";
                });
                $('#winners > tbody  > tr').each(function () {
                    table += "<tr>";
                    $(this).find('td').each(function () {
                        table += "<td>";
                        if ($(this).find('select').length > 0) {
                            table += $("option:selected", this).text();
                        } else {
                            table += $(this).text();
                        }
                        table += "</td>";
                    });
                    table += "</tr>";
                });
                table += "</table>";
                $.ajax({
                    type: "POST",
                    url: "../../posts.asmx/TabletoExcelCSV",
                    data: '{"table": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {
                        $('#div_downloadtext').html('Download: <a href="../../downloads/' + result.d.message + '">File</a>');
                        $("#div_download").dialog({
                            resizable: false,
                            width: 800,
                            modal: true
                        });

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Status: " + textStatus); alert("Error: " + errorThrown);
                    }
                });
                //alert(table);
            });
        });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table id="winners">
        <thead>
            <tr>
                <th>Title</th>
                <th class="numeric">Retail Price</th>
                <th class="numeric">Reserve</th>
                <th class="numeric">Amount</th>
                <th class="numeric">Autobid</th>
                <th class="numeric">Will Go To</th>
                <th>Reserve Status</th>
                <th>Name</th>
                <th>Email Address</th>
                <th>Mobile Number</th>
            </tr>
        </thead>
        <tbody>
            <%= html %>
        </tbody>
    </table>
            <input type="button" id="export" value="Export" />
     <div id="div_download" title="Download" style="display: none;">
            <div id="div_downloadtext"></div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
