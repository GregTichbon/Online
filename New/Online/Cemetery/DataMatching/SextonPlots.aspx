<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SextonPlots.aspx.cs" Inherits="Online.Cemetery.DataMatching.SextonPlots" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="<%: ResolveUrl("~/scripts/CascadingDropdown/jquery.cascadingdropdown.min.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#standardised').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#std_cemetery',
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Cemeteries', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    }
                                }));
                            })
                        }
                    },
                    {
                        selector: '#std_area',
                        requires: ['#std_cemetery'],
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Areas', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#std_block',
                        requires: ['#std_cemetery', '#std_area'],
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Blocks', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#std_division',
                        requires: ['#std_cemetery', '#std_area', '#std_block'],
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Divisions', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            if (!requirementsMet) {
                                $("#btn_update").prop('disabled', true);
                                return;
                            }
                            //standardised.loading(true);
                            $("#btn_update").prop('disabled', false);
                        }
                    }
                ]
            });



            $('#sexton').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#sexton_cemetery',
                        source: function (request, response) {
                            $.getJSON('../data.asmx/Cemeteries', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    }
                                }));
                            })
                        }
                    },
                    {
                        selector: '#sexton_area',
                        requires: ['#sexton_cemetery'],
                        source: function (request, response) {
                            $.getJSON('../data.asmx/SextonAreas', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#sexton_block',
                        requires: ['#sexton_cemetery', '#sexton_area'],
                        source: function (request, response) {
                            $.getJSON('../data.asmx/SextonBlocks', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#sexton_division',
                        requires: ['#sexton_cemetery', '#sexton_area', '#sexton_block'],
                        source: function (request, response) {
                            $.getJSON('../data.asmx/SextonDivisions', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            //alert(requirementsMet);
                            if (!requirementsMet) {
                                $("#btn_update").prop('disabled', true);
                                $('table tr.plotdata').remove();
                                return;
                            }
                            //alert('here');

                            //standardised.loading(true);

                            var ajaxData = requiredValues;
                            ajaxData[this.el.attr('name')] = value;
                            $('table tr.plotdata').remove();
                            $.getJSON('../data.asmx/SextonPlots', ajaxData, function (data) {
                                //alert(data);
                                $.each(data, function (i, item) {
                                    var $tr = $('<tr class="plotdata">').append(
                                        $('<td>').html('<input type="checkbox" class="sel_plot" value="' + item.plotid + '" />'),
                                        $('<td>').text(item.plotid),
                                        $('<td>').text(item.cemetery),
                                        $('<td>').text(item.area),
                                        $('<td>').text(item.block),
                                        $('<td>').text(item.division),
                                        $('<td>').text(item.plot),
                                        $('<td>').text(item.remarks),
                                        $('<td>').text(item.transactiontype)
                                    ).appendTo('#tbl_plots');
                                });
                            });
                        }
                    }
                ]
            });

            $("#btn_search").click(function () {
                $('table tr.plotdata').remove();
                $.getJSON('../data.asmx/SextonPlots?cemetery=' + $("#sexton_cemetery option:selected").val() + "&area=" + $("#sexton_area option:selected").val() + "&block=" + $("#sexton_block option:selected").val() + "&division=" + $("#sexton_division option:selected").val(), function (data) {
                    $.each(data, function (i, item) {
                        var $tr = $('<tr class="plotdata">').append(
                            $('<td>').html('<input type="checkbox" class="sel_plot" value="' + item.plotid + '" />'),
                            $('<td>').text(item.plotid),
                            $('<td>').text(item.cemetery),
                            $('<td>').text(item.area),
                            $('<td>').text(item.block),
                            $('<td>').text(item.division),
                            $('<td>').text(item.plot),
                            $('<td>').text(item.remarks),
                            $('<td>').text(item.transactiontype)
                        ).appendTo('#tbl_plots');
                    });
                });
            });

            $("#btn_update").click(function () {
                var existingplot = $("#sexton_cemetery option:selected").text() + ' Area: ' + $("#sexton_area option:selected").text() + ' Block: ' + $("#sexton_block option:selected").text() + ' Division: ' + $("#sexton_division option:selected").text();
                var newplot = $("#std_cemetery option:selected").text() + ' Area: ' + $("#std_area option:selected").text() + ' Block: ' + $("#std_block option:selected").text() + ' Division: ' + $("#std_division option:selected").text();

                $("#dialog-text").html("Please confirm that you want to update the " + $(".sel_plot:checked").length + " selected plots from:<br />" + existingplot + "<br />to<br />" + newplot);

                $("#dialog-confirm").dialog("open");
            });

            $("#dialog-confirm").dialog({
                autoOpen: false,
                resizable: false,
                height: "auto",
                width: 800,
                modal: true,
                buttons: {
                    "Update all items": function () {
                        $("#btn_update").prop('disabled', true);
                        alert("I need to put code in here")
                        $(this).dialog("close");
                        alert('Your updates have been processed');
                    },
                    Cancel: function () {
                        $(this).dialog("close");
                        alert('Nothing has been updated');
                    }
                }
            });

            $("#selectall").change(function () {
                allcheck = $(this).is(":checked");
                //alert(allcheck);
                $(".sel_plot").prop('checked', allcheck);
            });

        });
    </script>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="dialog-confirm" title="Update Confirmation">
        <p><span id="dialog-text"></span></p>
    </div>

    <h3>Sexton Data</h3>

    <div id="sexton">
        <div class="form-group">
            <label class="control-label col-sm-4" for="sexton_cemetery">Cemetery</label><div class="col-sm-8">
                <select id="sexton_cemetery" name="cemetery">
                    <option></option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="sexton_area">Area</label><div class="col-sm-8">
                <select id="sexton_area" name="area">
                         <option></option>
               </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="sexton_block">Block</label><div class="col-sm-8">
                <select id="sexton_block" name="block">
                        <option></option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="sexton_division">Division</label><div class="col-sm-8">
                <select id="sexton_division" name="division">
                         <option></option>
               </select>
            </div>
        </div>

    </div>

            <div class="form-group">
            <label class="control-label col-sm-4" for="sexton_division"></label><div class="col-sm-8">
  <input type="button" id="btn_search" value="Search" />
            </div>
        </div>
  

    <div class="datagrid">
        <table id="tbl_plots">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectall" /> Select</th>
                    <th>ID</th>
                    <th>Cemetery</th>
                    <th>Area</th>
                    <th>Block</th>
                    <th>Division</th>
                    <th>Plot No.</th>
                    <th>Remarks</th>
                    <th>Type</th>
                </tr>
            </thead>

        </table>
    </div>

    <p></p>
    <h3>Standardised Data</h3>

    <div id="standardised">
        <table>
            <tr>
                <th>Cemetery</th>
                <th>Area</th>
                <th>Block</th>
                <th>Division</th>
                <th>Update</th>
            </tr>
            <tr>
                <td style="width: 20%">
                    <select id="std_cemetery" name="cemetery">
                        <option></option>
                    </select></td>
                <td style="width: 20%">
                    <select id="std_area" name="area">
                        <option></option>
                    </select></td>
                <td style="width: 20%">
                    <select id="std_block" name="block">
                        <option></option>
                    </select></td>
                <td style="width: 20%">
                    <select id="std_division" name="division">
                        <option></option>
                    </select></td>
                <td style="width: 20%">
                    <input type="button" id="btn_update" value="Update" disabled /></td>
            </tr>
        </table>
    </div>
    <p></p>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
