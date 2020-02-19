<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="ComingEventsList.aspx.cs" Inherits="UBC.People.Reports.ComingEventsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

    <script>

        $(document).ready(function () {
            $('#export').click(function () {
                var table = "<table>";
                $('table > tbody  > tr:visible').each(function () {
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
                table = table.replace(/"/g, "'");
                //console.log(table);
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

            $('#dd_categories_filter').select2();

            function processrows() {
                category = $('#dd_categories_filter').val();
                if (category == null) {
                    $('.tr_event').show();
                } else {
                    $('.tr_event').each(function () {
                        found = false;
                        for (f1 = 0; f1 < category.length; f1++) {
                            usecategory = '|' + category[f1] + '|';
                            event_category = '|' + $(this).attr('data-categories') + '|';
                            //console.log(event_category + '-' + usecategory + '=' + event_category.indexOf(usecategory));
                            if (event_category.indexOf(usecategory) != -1) {
                                found = true;
                                //console.log('found');
                                break;
                            }
                        }
                        if (found) {
                            $(this).show();
                            //console.log('show ' + thename);
                        } else {
                            $(this).hide();
                            //console.log('hide ' + thename);
                        }
                    });
                }
            }

            $('#btn_refresh').click(function () {
                //Now will have all data but just hidden alert('Get data from server for categories: ' + $('#dd_categories_filter').val());
                processrows();
            })

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA; width: 100%">
        <div class="toprighticon">
            <input type="button" id="export" class="btn btn-info" value="Export" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Coming Events List
        </h1>
                <select class="form-control" id="dd_categories_filter" name="dd_categories_filter" multiple="multiple">
            <%= categories_values %>
        </select>
        <button type="button" id="btn_refresh">Refresh</button><br />
        <table class="table">
            <%= html %>
        </table>
        <div id="div_download" title="Download" style="display: none;">
            <div id="div_downloadtext"></div>
        </div>
    </div>
</asp:Content>
