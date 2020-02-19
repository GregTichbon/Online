<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="RegattaList.aspx.cs" Inherits="UBC.People.Reports.RegattaList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script>
        $(document).ready(function () {

            var col1 = {};
            var col2 = {};
            var key;
            $('#attendance > tbody  > tr').each(function () {
                key = $(this).find("td:eq(1)").text();
                if (key != "") {
                    if (!col1[key]) {
                        col1[key] = 0;
                    }
                    col1[key] += 1;
                }
                key = $(this).find("td:eq(2)").text();
                if (key != "") {

                    if (!col2[key]) {
                        col2[key] = 0;
                    }
                    col2[key] += 1;
                }

            });

            mydiv = "<h3>";
            mydelim = "";
            $.each(col1, function (key, val) {
                mydiv += mydelim + [key, val];
                mydelim = " | ";
            });

            mydelim = "";
            mydiv += "<br />";
            $.each(col2, function (key, val) {
                mydiv += mydelim + [key, val];
                mydelim = " | ";
            });
            mydiv += "</h3>";

            $('#div_count').html(mydiv);



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
                //alert(table);
                $.ajax({
                    type: "POST",
                    url: "../posts.asmx/TabletoExcelCSV",
                    data: '{"table": "' + table + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (result) {

                        //alert(result);
                        details = $.parseJSON(result.d);
                        //console.log(details);
                        $('#div_downloadtext').html('Download: <a href="../downloads/' + details.message + '">File</a>');
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
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <input type="button" id="export" class="btn btn-info" value="Export" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Regatta List
        </h1>
        <%= html %>
         <div id="div_download" title="Download" style="display: none;">
            <div id="div_downloadtext"></div>
        </div>
    </div>
</asp:Content>
