<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="Online.Cemetery.DataMatching.reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .datagrid table {
            border-collapse: collapse;
            text-align: left;
            width: 100%;
        }

        .datagrid {
            font: normal 12px/150% Arial, Helvetica, sans-serif;
            background: #fff;
            overflow: hidden;
            border: 1px solid #006699;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
        }

            .datagrid table td, .datagrid table th {
                padding: 3px 10px;
            }

            .datagrid table thead th {
                background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #006699), color-stop(1, #00557F) );
                background: -moz-linear-gradient( center top, #006699 5%, #00557F 100% );
                filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#006699', endColorstr='#00557F');
                background-color: #006699;
                color: #FFFFFF;
                font-size: 15px;
                font-weight: bold;
                border-left: 1px solid #0070A8;
            }

                .datagrid table thead th:first-child {
                    border: none;
                }

            .datagrid table tbody td {
                color: #00496B;
                border-left: 1px solid #E1EEF4;
                font-size: 12px;
                font-weight: normal;
            }

            .datagrid table tbody .alt td {
                background: #E1EEF4;
                color: #00496B;
            }

            .datagrid table tbody td:first-child {
                border-left: none;
            }

            .datagrid table tbody tr:last-child td {
                border-bottom: none;
            }

            .datagrid table tfoot td div {
                border-top: 1px solid #006699;
                background: #E1EEF4;
            }

            .datagrid table tfoot td {
                padding: 0;
                font-size: 12px;
            }

                .datagrid table tfoot td div {
                    padding: 2px;
                }

                .datagrid table tfoot td ul {
                    margin: 0;
                    padding: 0;
                    list-style: none;
                    text-align: right;
                }

            .datagrid table tfoot li {
                display: inline;
            }

                .datagrid table tfoot li a {
                    text-decoration: none;
                    display: inline-block;
                    padding: 2px 8px;
                    margin: 1px;
                    color: #FFFFFF;
                    border: 1px solid #006699;
                    -webkit-border-radius: 3px;
                    -moz-border-radius: 3px;
                    border-radius: 3px;
                    background: -webkit-gradient( linear, left top, left bottom, color-stop(0.05, #006699), color-stop(1, #00557F) );
                    background: -moz-linear-gradient( center top, #006699 5%, #00557F 100% );
                    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#006699', endColorstr='#00557F');
                    background-color: #006699;
                }

            .datagrid table tfoot ul.active, .datagrid table tfoot ul a:hover {
                text-decoration: none;
                border-color: #006699;
                color: #FFFFFF;
                background: none;
                background-color: #00557F;
            }

        div.dhtmlx_window_active, div.dhx_modal_cover_dv {
            position: fixed !important;
        }
    </style>

    <script>
        $(document).ready(function () {
            $("#href_report1").click(function () {
                $('table tr.plotdata').remove();
                var $tr = $('<tr class="plotdata">').append(
                    $('<th>').text('Cemetery'),
                    $('<th>').text('Area'),
                    $('<th>').text('Count')
                ).appendTo('#tbl_plots');

                $.getJSON('../data.asmx/SextonDataMatchingReports?mode=area', function (data) {
                    $.each(data, function (i, item) {
                        var $tr = $('<tr class="plotdata">').append(
                            $('<td>').text(item.cemetery),
                            $('<td>').text(item.area),
                            $('<td>').text(item.count)
                        ).appendTo('#tbl_plots');
                    });
                });
            });
            $("#href_report2").click(function () {
                $('table tr.plotdata').remove();
                var $tr = $('<tr class="plotdata">').append(
                    $('<th>').text('Cemetery'),
                    $('<th>').text('Area'),
                    $('<th>').text('Block'),
                    $('<th>').text('Count')
                ).appendTo('#tbl_plots');

                $.getJSON('../data.asmx/SextonDataMatchingReports?mode=block', function (data) {
                    $.each(data, function (i, item) {
                        var $tr = $('<tr class="plotdata">').append(
                            $('<td>').text(item.cemetery),
                            $('<td>').text(item.area),
                            $('<td>').text(item.block),
                            $('<td>').text(item.count)
                        ).appendTo('#tbl_plots');
                    });
                });
            });
            $("#href_report3").click(function () {
                $('table tr.plotdata').remove();
                var $tr = $('<tr class="plotdata">').append(
                    $('<th>').text('Cemetery'),
                    $('<th>').text('Area'),
                    $('<th>').text('Block'),
                    $('<th>').text('Division'),
                    $('<th>').text('Count')
                ).appendTo('#tbl_plots');

                $.getJSON('../data.asmx/SextonDataMatchingReports?mode=division', function (data) {
                    $.each(data, function (i, item) {
                        var $tr = $('<tr class="plotdata">').append(
                            $('<td>').text(item.cemetery),
                            $('<td>').text(item.area),
                            $('<td>').text(item.block),
                            $('<td>').text(item.division),
                            $('<td>').text(item.count)
                        ).appendTo('#tbl_plots');
                    });
                });
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Sexton Data</h3>

    <p><a href="javascript:void(0)" id="href_report1">Areas that are not in the standardised data</a></p>

    <p><a href="javascript:void(0)" id="href_report2">Blocks that are not in the standardised data</a></p>

    <p><a href="javascript:void(0)" id="href_report3">Divisions that are not in the standardised data</a></p>

    <div class="datagrid">
        <table id="tbl_plots">
        </table>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
