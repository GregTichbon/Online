<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="Person.aspx.cs" Inherits="TeOranganui.Person" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/datagrid.css" rel="stylesheet" />

    <script type="text/javascript">

        var newkey = 0;
        var inputfields_disabled = true;

        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $("#form1").validate();

            $("#inputfields :input").prop("disabled", inputfields_disabled)

            //Drop Down Lists
            var yesno_options = '<option value=""></option>';
            yesno_options += '<option value="Yes">Yes</option>';
            yesno_options += '<option value="No">No</option>';

            var gender_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=gender&param1=", function (data) {
                $.each(data, function (i, item) {
                    gender_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
                $('#dd_gender').append(gender_options);
            });

            var addresstype_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=addresstype&param1=", function (data) {
                $.each(data, function (i, item) {
                    addresstype_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var communicationtype_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=communicationtype&param1=1", function (data) {
                $.each(data, function (i, item) {
                    communicationtype_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            //Get Record
            $("#dd_search").change(function () {
                inputfields_disabled = false;
                $("#inputfields :input").prop("disabled", inputfields_disabled)
                $("#tb_lastname").val('');
                $("#tb_firstname").val('');
                $("#dd_gender")[0].selectedIndex = 0;
                $("#tb_notes").val('');
                $(".rowdata").remove();

                person_id = $(this).val();
                if (person_id == 'Create') {
                    $("#hf_person_id").val(0);
                } else if (person_id != '') {
                    $("#hf_person_id").val(person_id);

                    $.ajax({
                        async: false,
                        url: "../functions/data.asmx/get_person?person_id=" + person_id, success: function (result) {
                            item = $.parseJSON(result);
                            $("#tb_lastname").val(item[0]['lastname']);
                            $("#tb_firstname").val(item[0]['firstname']);
                            $("#dd_gender").val(item[0]['gender']);
                            $("#tb_notes").val(item[0]['notes']);
                        }
                    });

                    $.getJSON("../functions/data.asmx/get_personaddress?person_id=" + person_id, function (data) {

                        $.each(data, function (i, item) {
                            id = "sub-personaddress-" + item.personaddress_id;
                            populate_address(id);
                            $("#" + id + "-addresstype_id").val(item.addresstype_id);
                            $("#" + id + "-detail").val(item.detail);
                            $("#" + id + "-note").val(item.note);
                            $("#" + id + "-current").val(item.current);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_personcommunication?person_id=" + person_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-PersonCommunication-" + item.communication_id;
                            populate_communications(id);
                            $("#" + id + "-communicationtype_id").val(item.communicationtype_id);
                            $("#" + id + "-detail").val(item.detail);
                            $("#" + id + "-note").val(item.note);
                            $("#" + id + "-current").val(item.current);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_group_person_links?person_id=" + person_id, function (data) {
                        $.each(data, function (i, item) {
                            var $tr = $('<tr class="rowdata">').append(
                            $('<td>').html(item.Group),
                            $('<td>').html(item.Role)
                        ).appendTo('#tbl_links');
                        });
                    });
                }
                $(this).prop('selectedIndex', 0);
            });

            function nextnewkey() {
                newkey++;
            }

            function populate_address(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<select name="' + id + '-addresstype_id" id="' + id + '-addresstype_id" class="grid_select form-control" required>' + addresstype_options + '</select>'),
                            $('<td>').html('<input name="' + id + '-detail" id="' + id + '-detail" type="text" class="form-control" required />'),
                            $('<td>').html('<input name="' + id + '-note" id="' + id + '-note" type="text" class="form-control" />'),
                            $('<td>').html('<select name="' + id + '-current" id="' + id + '-current" class="grid_select form-control" required>' + yesno_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_addresses');
            }

            function populate_communications(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<select name="' + id + '-communicationtype_id" id="' + id + '-communicationtype_id" class="grid_select form-control" required>' + communicationtype_options + '</select>'),
                            $('<td>').html('<input name="' + id + '-detail" id="' + id + '-detail" type="text" class="form-control" required />'),
                            $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                            $('<td>').html('<select name="' + id + '-current" id="' + id + '-current" class="grid_select form-control" required>' + yesno_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_communications');
            }

            $(".a_add").click(function () {
                tbl = $(this).closest('table').attr('id');
                nextnewkey();
                switch (tbl) {
                    case 'tbl_addresses':
                        populate_address('sub-personaddress-N' + newkey);
                        break;
                    case 'tbl_communications':
                        populate_communications("sub-PersonCommunication-N" + newkey);
                        break;
                }
            });

            $('body').on('click', '.a_delete', function () {
                //var trid = $(this).closest('tr').data('id');
                //var trid = $(this).parents('tr').data('id');
                mode = $(this).text();
                if (mode == 'Delete') {
                    $('td:first', $(this).parents('tr')).html('<img src="images/delete.png">');
                    $(this).text('Restore');
                    prefix = 'D';
                } else {
                    var a = $('td:first', $(this).parents('tr')).html('');
                    $(this).text('Delete');
                    prefix = '';
                }
                tr = $(this).parents('tr');
                tr.toggleClass("deleterow")
                dataid = tr.attr("id");
                $('[name^=' + dataid + ']').each(function (i, obj) {
                    inputid = $(this).attr('id');
                    nameparts = inputid.split('-');
                    newname = nameparts[0] + "-" + nameparts[1] + "-" + prefix + nameparts[2] + "-" + nameparts[3];
                    $(this).attr('name', newname);
                });
                dataidparts = dataid.split('-');
                if (dataidparts[2].substring(0, 1) == 'D') {
                    dataidparts[2] = dataidparts[2].substring(1);
                }
                newdataid = dataidparts[0] + "-" + dataidparts[1] + "-" + prefix + dataidparts[2];
                tr.attr('id', newdataid);
            });

            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var mytab = $(event.target).text();         // active tab
                //alert(mytab);
                $("#grid_" + mytab.toLowerCase()).jsGrid("refresh");
                //var y = $(event.relatedTarget).text();  // previous tab
            });

            $("#btn_Save").click(function () {
                if ($("#form1").valid()) {
                    var arForm = $("#form1")
                    .find("input,textarea,select,hidden")
                    .not("[id^='__']")
                    //.not("[id^='cb_deletefile_additional_']")
                    .serializeArray();


                    var formData = JSON.stringify({ formVars: arForm });

                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        async: false,
                        contentType: "application/json; charset=utf-8",
                        url: 'functions/posts.asmx/update_person', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {
                            $('.deleterow').remove();
                            item = $.parseJSON(result.d);
                            subtable_ids = $.parseJSON(item.subtable_ids);
                            $.each(subtable_ids, function (key, value) {
                                $('[id^=sub-' + value.table + '-' + value.original_id + ']').each(function (index) {
                                    $(this).attr('id', $(this).attr('id').replace(value.original_id, value.created_id));
                                });
                                $('[name^=sub-' + value.table + '-' + value.original_id + ']').each(function (index) {
                                    $(this).attr('name', $(this).attr('name').replace(value.original_id, value.created_id));
                                });
                            });
                            alert('Saved');
                        },
                        error: function (xhr, status) {
                            alert("An error occurred: " + status);
                        }
                    })
                }
            })
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="hf_person_id" name="hf_person_id" type="hidden" />

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_search">Select</label><div class="col-sm-8">
            <select id="dd_search" name="dd_search" class="form-control">
                <option></option>
                <option value="Create">Create</option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_person_values, "", "None")%>
            </select>
        </div>
    </div>
    <div id="inputfields">

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_lastname">Last name</label><div class="col-sm-8">
                <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" required value="<%: tb_lastname %>" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_firstname">First name</label><div class="col-sm-8">
                <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" required value="<%: tb_firstname %>" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_gender">Gender</label><div class="col-sm-8">
                <select id="dd_gender" name="dd_gender" class="form-control">
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_notes">Notes</label><div class="col-sm-8">
                <textarea id="tb_notes" name="tb_notes" rows="3" class="form-control"><%: tb_notes %></textarea>
            </div>
        </div>

        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#div_addresses">Addresses</a></li>
            <li><a data-toggle="tab" href="#div_communications">Communications</a></li>
            <li><a data-toggle="tab" href="#div_links">Links</a></li>
        </ul>
        <!------------------------------------------------------------------------------------------------------>
        <div class="tab-content">
            <div id="div_addresses" class="tab-pane fade in active">
                <h3>Addresses</h3>
                <div class="datagrid">
                    <table id="tbl_addresses">
                        <tr>
                            <td style="width: 50px; text-align: right"></td>
                            <td>Type</td>
                            <td>Address</td>
                            <td>Note</td>
                            <td>Current</td>
                            <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="div_communications" class="tab-pane fade">
                <h3>Communications</h3>
                <div class="datagrid">
                    <table id="tbl_communications">
                        <tr>
                            <td style="width: 50px; text-align: right"></td>
                            <td>Type</td>
                            <td>Detail</td>
                            <td>Note</td>
                            <td>Current</td>
                            <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="div_links" class="tab-pane fade">
                <h3>Links</h3>
                <div class="datagrid">
                    <table id="tbl_links">
                        <tr>
                            <td>Group</td>
                            <td>Role</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <input id="btn_Save" type="button" value="Save" />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
