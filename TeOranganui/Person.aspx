<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="Person.aspx.cs" Inherits="TeOranganui.Person" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/datagrid.css" rel="stylesheet" />


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            //Drop Down Lists
            var gender_options = '<option value="0"></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=gender&param1=", function (data) {
                $.each(data, function (i, item) {
                    gender_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
                $('#dd_gender').append(gender_options);
            });

            var addresstype_options = '<option value="0"></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=addresstype&param1=", function (data) {
                $.each(data, function (i, item) {
                    addresstype_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var yesno_options = '<option value="0"></option>';
            yesno_options += '<option>Yes</option>';
            yesno_options += '<option>No</option>';

            //Get Record
            $("#dd_selectperson").change(function () {
                $("#tb_lastname").val('');
                $("#tb_firstname").val('');
                $("#dd_gender")[0].selectedIndex = 0;
                $("#tb_notes").val('');
                $(".rowdata").remove();

                person_id = $(this).val();
                if (person_id != '') {
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

                    $.getJSON("../functions/data.asmx/get_person_addresses?person_id=" + person_id, function (data) {
                        $.each(data, function (i, item) {
                            id = item.person_address_id + "_" + person_id;
                            populate_address(id);
                            $("#addresstype_" + id).val(item.addresstype_id);
                            $("#addressdetail_" + id).val(item.detail);
                            $("#addressnote_" + id).val(item.note);
                            $("#addresscurrent_" + id).val(item.current);
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
            });

            function populate_address(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr data-id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<select name="addresstype_' + id + '" id="addresstype_' + id + '" class="grid_select addresstype" type="text">' + addresstype_options + '</select>'),
                            $('<td>').html('<textarea name="addressdetail' + id + '" id="addressdetail_' + id + '" class="grid_select addressdetail"></textarea>'),
                            $('<td>').html('<textarea name="addressnote' + id + '" id="addressnote_' + id + '" class="grid_select addressnote"></textarea>'),
                            $('<td>').html('<select name="addresscurrent_' + id + '" id="addresscurrent_' + id + '" class="grid_select addresscurrent" type="text">' + yesno_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_addresses');
            }

            $(".a_add").click(function () {
                tbl = $(this).closest('table').attr('id');
                switch (tbl) {
                    case 'tbl_addresses':
                        populate_address('New_' + 0);
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
                } else {
                    var a = $('td:first', $(this).parents('tr')).html('');
                    $(this).text('Delete');
                }
                id = -$(this).parents('tr').data('id');
                $(this).parents('tr').data('id', id);
            });

            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var mytab = $(event.target).text();         // active tab
                //alert(mytab);
                $("#grid_" + mytab.toLowerCase()).jsGrid("refresh");
                //var y = $(event.relatedTarget).text();  // previous tab
            });

            $("#btn_Save").click(function () {
                savefields();
            });

            function savefields() {
                var arForm = $("#form1")
                    .find("input,textarea,select,hidden")
                    .not("[id^='__']")
                    //.not("[id^='cb_deletefile_additional_']")
                    .serializeArray();


                var formData = JSON.stringify({ formVars: arForm });
                //var formData = JSON.stringify(arForm);

                //var formData = arForm;
                //alert(formData);
                console.log(formData);

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: 'functions/posts.asmx/update_person', // the url where we want to POST
                    data: formData,
                    //data: "<test></test>",
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        //alert(result);
                        //$('.form_result').html('Saved');
                        //details = $.parseJSON(result.d);
                        //alert(details.status);
                        alert('Saved');
                        //loaditems();
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                })
            }

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="hf_groupid" name="hf_person_id" type="hidden" value="<%: hf_person_id %>" />

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_selectperson">Select</label><div class="col-sm-8">
            <select id="dd_selectperson" name="dd_selectperson" class="form-control" required>
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_selectperson_values, "", "None")%>
            </select>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_lastname">Last name</label><div class="col-sm-8">
            <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%: tb_lastname %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_firstname">First name</label><div class="col-sm-8">
            <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%: tb_firstname %>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_gender">Gender</label><div class="col-sm-8">
            <select id="dd_gender" name="dd_gender" class="form-control" required>
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
                        <td>Detail</td>
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

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
