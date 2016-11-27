<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="ListORIG.aspx.cs" Inherits="TeOranganui.ListORIG" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                            $("#grid_items").jsGrid("loadData");
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
         
            var orig;
            $("#grid_items").jsGrid({
                width: "100%",
                height: "400px",

                inserting: true,
                editing: true,
                sorting: true,
                paging: true,
                autoload: false,

                controller: {
                    loadData: function (filter) {
                        return $.ajax({
                            type: "GET",
                            url: "../functions/data.asmx/get_list_item?list_id=" + $("#dd_list").val(),
                            data: filter,
                            dataType: "JSON"
                        })
                    },
                    updateItem: function (item) {
                        record = $.extend(true, {}, item);
                        //console.log(item);
                        if(!(isEquivalent(record,orig))) {
                            console.log(orig);
                            console.log(record);
                            record.list_id = '';
                            //alert('saving changes');
                            xx = $.ajax({
                                type: "POST",
                                url: "../functions/posts.asmx/updatelistitem",
                                data: record
                            });
                            console.log(xx);
                        }
                    },
                    insertItem: function (item) {
                        item.list_id = $('#dd_list').val();
                        return $.ajax({
                            type: "POST",
                            url: "../functions/posts.asmx/updatelistitem",
                            data: item
                        });
                    }
                },
                onItemEditing: function(args) {
                    //console.log(args.item);
                    orig = $.extend(true, {}, args.item);
                    //orig.list_id = '';
                    //orig = args.item;
                },

                fields: [
                { name: "label", title: "Label", type: "text", width: 150, validate: "required" },
               // { name: "value", title: "Value", type: "text", width: 150 },
                { type: "control", deleteButton: false }
                ]/*,
                onDataLoaded: function (grid, data) {
                    console.log("onDataLoaded", grid);
                }*/
            });
            /*
            $("#btn_Save").click(function () {
                var items = $("#grid_items").jsGrid("option", "data");
                console.log(items);
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

    <div id="grid_items"></div>

   <!-- <input id="btn_Save" type="button" value="Save" />-->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
