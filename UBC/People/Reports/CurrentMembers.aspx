﻿<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="CurrentMembers.aspx.cs" Inherits="UBC.People.Reports.CurrentMembers" %>

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
            $('#export').click(function () {
                var table = "<table>";
                $('table > thead  > tr').each(function () {
                    table += "<tr>";
                    $(this).find('th').each(function () {
                        if (!$(this).hasClass("noexport")) {
                            table += "<td>";
                            table += $(this).text();
                            table += "</td>";
                        }
                    });
                    table += "</tr>";
                });
                $('table > tbody  > tr').each(function () {
                    table += "<tr>";
                    $(this).find('td').each(function () {
                        if (!$(this).hasClass("noexport")) {
                            table += "<td>";
                            if ($(this).find('select').length > 0) {
                                table += $("option:selected", this).text();
                            } else {
                                table += $(this).text();
                            }
                            table += "</td>";
                        }
                    });
                    table += "</tr>";
                });
                table += "</table>";
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
    <div class="container" style="background-color: #FCF7EA; width: 100%">
          <div class="toprighticon">
            <input type="button" id="export" class="btn btn-info" value="Export" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Registered members <%=html_year %>
        </h1>
        <!--
        <select id="dd_year" name="dd_year"><option value="">Please select the season</option>
            <option value="2019/20">2019/20</option>
            <option value="2018/19">2018/19</option>
            <option value="2017/18">2017/18</option>
        </select> <input type="submit" id="btn_go" value="Go" />
        -->
        <table class="table">
            <%= html %>
        </table>

        <div id="div_download" title="Download" style="display: none;">
            <div id="div_downloadtext"></div>
        </div>
    </div>
</asp:Content>
