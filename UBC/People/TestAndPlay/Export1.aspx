<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Export1.aspx.cs" Inherits="UBC.People.TestAndPlay.Export1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <script>

        $(document).ready(function () {
            $('#export').click(function () {
                var table = "<table>";
                $('table > tbody  > tr').each(function () {
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
                alert(table);
                table = "<table><tr><td>Sat 02 Feb 19 07:30 - 10:00</td><td>Senior Training</td><td>row</td><td>Training</td></tr></table>";
                $.ajax({
                    type: "POST",
                    url: "../posts.asmx/TabletoExcelCSV",
                    data: '{"table": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {

                        //alert(result);
                        details = $.parseJSON(result.d);
                        console.log(details);


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
    <table class="table">
        <thead>
            <tr>
                <th>When</th>
                <th>Title</th>
                <th>Detail</th>
                <th>Type</th>
            </tr>
        </thead>
        <tbody>
            <tr class="tr_event" data-categories="16|5">
                <td>Sat 02 Feb 19 07:30 - 10:00</td>
                <td>Senior Training</td>
                <td>Row: 16km 
4km warmup
4 x 1000m with 10 min rest, first from the start and get on to race pace, middle two rolling middle of the race, last rolling end of the race. Key is to focus on your boat and keep length and technique
Good warm down after"</td>
                <td>Training</td>
            </tr>
            <tr class="tr_event" data-categories="5|1">
                <td>Sat 02 Feb 19 08:00 - 10:00</td>
                <td>Novice Training</td>
                <td></td>
                <td>Training</td>
            </tr>
        </tbody>
    </table>




    <input type="button" id="export" class="btn btn-info" value="Export" />
    <div id="div_download" title="Download" style="display: none;">
        <div id="div_downloadtext"></div>
    </div>
</asp:Content>
