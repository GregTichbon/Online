<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="TeOranganui.List" %>

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

        .grid_select {
            width: 100%;
        }
    </style>
    <script type="text/javascript" src="../scripts/CascadingDropdown/jquery.cascadingdropdown.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });


            $('#ccdd_grouptype_list').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '.ccdd_grouptype',
                        source: function (request, response) {
                            $.getJSON('../functions/data.asmx/get_grouptype', function (data) {
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
                        selector: '.ccdd_list',
                        requires: ['.ccdd_grouptype'],
                        source: function (request, response) {
                            $.getJSON('../functions/data.asmx/get_list', request, function (data) {
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
                            if (!requirementsMet) return;
                            //alert('here');

                            //example2.loading(true);
                            loaditems();
                            /*
                            var ajaxData = requiredValues;
                            ajaxData[this.el.attr('name')] = value;
                            alert(value);
                            $.getJSON('../cemetery/data.asmx/xxxx', ajaxData, function (data) {
                                alert(data);
                            });
                            */
                        }
                    }
                ]
            });

            $("#a_add").click(function () {
                if ($("#dd_list").val() != "") {
                    var $tr = $('<tr data-id="0" class="rowdata">').append(
                        $('<td style="text-align:center">').html(''),
                        $('<td>').html('<input class="grid_select" type="text" value="" />'),
                        $('<td style="text-align:right">').text(0),
                    $('<td style="text-align:center">').html('Delete')
                    ).appendTo('#tbl_items');
                }
            });

            $('body').on('click', '.a_delete', function () {
                //var trid = $(this).closest('tr').data('id');
                //var trid = $(this).parents('tr').data('id');
                mode = $(this).text();
                if (mode == 'Delete') {
                    $('td:first', $(this).parents('tr')).html('<img src="images/delete.png">');
                    $(this).text('Restore');
                } else {
                    var a = $('td:first', $(this).parents('tr')).html('');
                    $(this).text('Delete');
                }
                id = -$(this).parents('tr').data('id');
                $(this).parents('tr').data('id', id);
            });


            $("#btn_Save").click(function () {
                $('table tr.rowdata').each(function (i, tr) {
                    $tr = $(tr);
                    $.getJSON("../functions/data.asmx/updatelistitem?list_item_id=" + $tr.data("id") + "&list_id=" + $("#dd_list").val() + "&label=" + $tr.find('.grid_select').val() + "&value=", function (data) {
                        if ($tr.data("id") == '') {
                            $(tr).data("id", data.created_id);
                        }
                    });
                });
                //alert("Saved");
                loaditems();
            });

 


            function loaditems() {
                $('table tr.rowdata').remove();
                /*
                var $tr = $('<tr>').append(
                    $('<th>').text('Label'),
                    $('<th>').text('Count')
                ).appendTo('#tbl_items');
                */
                $.getJSON("../functions/data.asmx/get_list_item?list_id=" + $("#dd_list").val(), function (data) {
                    $.each(data, function (i, item) {
                        if (item.count == 0 || 1 == 1) {
                            del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                        } else {
                            del = "";
                        }
                        var $tr = $('<tr data-id="' + item.List_item_ID + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<input name="label_' + item.List_item_ID + '" class="grid_select" type="text" value="' + item.label + '" />'),
                            $('<td style="text-align:right">').text(item.count),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_items');
                    });
                });
            }

            /*
                        return $.ajax({
                            type: "GET",
                            url: "../functions/data.asmx/get_list_item?list_id=" + $("#dd_list").val(),
                            data: filter,
                            dataType: "JSON"
                        })
  
                            xx = $.ajax({
                                type: "POST",
                                url: "../functions/posts.asmx/updatelistitem",
                                data: record
                            });
  */
        });

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="ccdd_grouptype_list">

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_grouptype">Group Type</label><div class="col-sm-8">
                <select id="dd_grouptype" name="dd_grouptype" class="form-control ccdd_grouptype" required>
                    <option></option>
                </select>
            </div>
        </div>


        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_list">List</label><div class="col-sm-8">
                <select id="dd_list" name="dd_list" class="form-control ccdd_list" required>
                    <option></option>
                </select>
            </div>
        </div>



    </div>

    <div class="datagrid">
        <table id="tbl_items">
            <tr>
                <td style="width: 50px; text-align: right"></td>
                <td>Label</td>
                <td style="width: 50px; text-align: right">Count</td>
                <td style="width: 100px; text-align: center">Action / <a id="a_add" href="javascript:void(0)">Add</a></td>
            </tr>
        </table>
    </div>

    <input id="btn_Save" type="button" value="Save" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
