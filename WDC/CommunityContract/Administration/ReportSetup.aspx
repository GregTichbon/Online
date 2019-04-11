<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ReportSetup.aspx.cs" Inherits="Online.CommunityContract.Administration.ReportSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .sorting-row {
            background-color: red;
        }
    </style>

    <script src="../../Scripts/RowSorter/Rowsorter.js"></script>
    <script type="text/javascript">
        var newid = 0;

        $(document).ready(function () {

            new RowSorter('#table_items'/*, options*/);


            //$('.item').click(function () {
            $('body').on('click', '.item', function() {
                thisitem = $(this);
                //$('#tb_prompt').val($(thisitem).text());
                $('#tb_prompt').val($(thisitem).closest('td').next('td').text());

                //$(thisitem).closest('td').next('td').text();
                $('#dd_type').val($(thisitem).data('type'));
                $('#dd_group').val($(thisitem).data('group'));

                if ($(thisitem).data('delete') == 'Yes') {
                    DeleteLabel = 'Restore'
                } else {
                    DeleteLabel = 'Delete'
                }

                $("#itemmaint").dialog({
                    modal: true,
                    width: 600,
                    buttons: [{
                        text: DeleteLabel,
                        click: function () {
                            if (confirm("Do you really want to " + DeleteLabel + " this item?")) {
                                if ($(thisitem).data('delete') == 'Yes') {
                                    $(thisitem).data('delete', 'No');
                                    $(thisitem).css("background-color", "");
                                } else {
                                    $(thisitem).data('delete', 'Yes');
                                    $(thisitem).css("background-color", "red");
                                }
                                $(this).dialog("close");
                            }
                        },

                    }, {
                        text: "Update",
                        click: function () {
                            //$(thisitem).text($('#tb_prompt').val());
                            if ($(thisitem).attr("id") == "item_new") {
                                newid++;
                                $('#table_items tr:last').after('<tr><td id="item_new_' + newid + '" class="item" data-type="' + $('#dd_type').val() + '" data-group="' + $('#dd_group').val() + '">Edit</td><td>' + $('#tb_prompt').val() + '</td><td>' + $('#dd_group option:selected').text() + '</td></tr>');
                            } else {
                                $(thisitem).closest('td').next('td').text($('#tb_prompt').val());
                                $(thisitem).closest('td').next('td').next('td').text($('#dd_group option:selected').text());
                                $(thisitem).data('type', $('#dd_type').val());
                                $(thisitem).data('group', $('#dd_group').val());
                            }

                            $(this).dialog("close");
                        },
                    }]
                    /*
                    buttons: {
                        "Update": function () {
                            $(thisitem).text($('#tb_prompt').val());
                            $(thisitem).data('type', $('#dd_type').val());
                            $(this).dialog("close");
                        },
                        DeleteLabel: function () {
                            if (confirm("Do you really want to ' + DeleteLabel + ' this item?")) {
                                if ($(thisitem).data('delete') == 'Yes') {
                                    $(thisitem).data('delete', 'No');
                                } else {
                                    $(thisitem).data('delete', 'Yes');
                                }
                                $(this).dialog("close");
                            }
                        }
                    }
                    */


                });

                /*
                var myButtons = {
                    "Save": function () {
                        //some junk logic removed
                    },
                    "Cancel": function () {
                        $(this).dialog("close");
                    }
                };


                [{
        text: "Ok",
        "id": "btnOk",
        click: function () {
            //okCallback();
        },

    }, {
        text: "Cancel",
        click: function () {
            //cancelCallback();
        },
    }]
                */




            });



            $("#a_view").colorbox({ href: "ReportView.aspx?reference=<%:tb_reference %>", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            $("#form1").submit(function (event) {
                $('#table_items tr').each(function (i1, tr) {
                    $(tr).find('td.item').each(function (i2, td) {
                        id = $(td).attr('id');
                        //prompt = $(td).text();
                        prompt = $(td).closest('td').next('td').text();
                        type = $(td).data('type');
                        group = $(td).data('group');
                        del = $(td).data('delete');
                        delim = String.fromCharCode(254);
                        value = type + delim + prompt + delim + group + delim + del;
                        $('<input>').attr({
                            type: 'hidden',
                            name: id,
                            value: value
                        }).appendTo('#form1');
                    });
                });
                //event.preventDefault();
            });

        }) //document.ready

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Report reference number:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_reference" name="tb_reference" value="<%:tb_reference %>" readonly="readonly" />
        </div>
    </div>
    <asp:Literal ID="lit_html" runat="server"></asp:Literal>

    <a id="a_view" href="javascript:void(0);">View</a>
    <!-- Submit -->
    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>

    <div id="itemmaint" title="Item Maintenance" style="display: none">

        <div class="form-group">
            <label class="control-label col-sm-2" for="dd_type">Group:</label>
            <div class="col-sm-10">
                <select id="dd_group" name="dd_group" class="form-control" required>
                    <option value="1">How much did you do?</option>
                    <option value="2">How well did you do it?</option>
                    <option value="3">Is anyone better off as a result of this project?</option>
                    <option value="4">Other</option>
                </select>
            </div>
        </div>


        <div class="form-group">
            <label class="control-label col-sm-2" for="tb_prompt">Prompt:</label>
            <div class="col-sm-10">
                <textarea rows="8" id="tb_prompt" name="tb_prompt" class="form-control"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-2" for="dd_type">Type:</label>
            <div class="col-sm-10">
                <select id="dd_type" name="dd_type" class="form-control" required>
                    <option>Inject</option>
                    <option>Textbox</option>
                </select>
            </div>
        </div>

    </div>





</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
