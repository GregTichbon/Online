<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="School.aspx.cs" Inherits="TeOranganui.School" %>

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

            $.getJSON("../functions/data.asmx/get_system?group_id=" + $("#hf_groupid").val(), function (data) {
                $.each(data, function (i, item) {
                    del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                    var $tr = $('<tr data-id="' + item.List_item_ID + '" class="rowdata">').append(
                        $('<td style="text-align:center">').html(''),
                        $('<td>').html('<input name="systemname_' + item.group_system_id + '|' + item.system_id + '" class="grid_select" type="text" value="' + item.systemname + '" />'),
                        $('<td style="text-align:center">').html(del)
                    ).appendTo('#tbl_systems');
                });
            });

            $.getJSON("../functions/data.asmx/get_school_persons?group_id=" + $("#hf_groupid").val(), function (data) {
                $.each(data, function (i, item) {
                    del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                    var $tr = $('<tr data-id="' + item.List_item_ID + '" class="rowdata">').append(
                        $('<td style="text-align:center">').html(''),
                        $('<td>').html('<input name="personname_' + item.group_person_id + '|' + item.group_person_id_id + '" class="grid_select person" type="text" value="' + item.personname + '" />'),
                        $('<td>').html('<input name="roledescription_' + item.List_item_ID + '" class="grid_select" type="text" value="' + item.roledescription + '" />'),
                        $('<td style="text-align:center">').html(del)
                    ).appendTo('#tbl_people');
                });
            });


            $(".a_add").click(function () {
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

            $('body').on('dblclick', '.person', function () {
                alert('here');
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
                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: 'functions/posts.asmx/update_school', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        alert('Saved');
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
    <input id="hf_groupid" name="hf_groupid" type="hidden" value="<%: hf_groupid %>" />
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_groupname">Group name</label><div class="col-sm-8">
            <input id="tb_groupname" name="tb_groupname" type="text" class="form-control" value="<%: tb_groupname %>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_gendertype">Gender</label><div class="col-sm-8">
            <select id="dd_gendertype" name="dd_gendertype" class="form-control" required>
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_gendertype_values, dd_gendertype, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_authority">Authority</label><div class="col-sm-8">
            <select id="dd_authority" name="dd_authority" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_authority_values, dd_authority, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_decile">Decile</label><div class="col-sm-8">
            <select id="dd_decile" name="dd_decile" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_decile_values, dd_decile, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_moenumber">MOE Number</label><div class="col-sm-8">
            <input id="tb_moenumber" name="tb_moenumber" type="text" class="form-control" value="<%: tb_moenumber %>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_type">Type</label><div class="col-sm-8">
            <select id="dd_type" name="dd_type" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_type_values, dd_type, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_startyear">Start Year</label><div class="col-sm-8">
            <select id="dd_startyear" name="dd_startyear" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_startyear_values, dd_startyear, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_endyear">End Year</label><div class="col-sm-8">
            <select id="dd_endyear" name="dd_endyear" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_endyear_values, dd_endyear, "None")%>
            </select>
        </div>
    </div>





    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#div_systems">Systems</a></li>
        <li><a data-toggle="tab" href="#div_people">People</a></li>
        <li><a data-toggle="tab" href="#div_programs">Programs</a></li>
        <li><a data-toggle="tab" href="#div_policies">Policies</a></li>
        <li><a data-toggle="tab" href="#div_accreditation">Accreditation</a></li>
    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">
        <div id="div_systems" class="tab-pane fade in active">
            <h3>Systems</h3>

            <div class="datagrid">
                <table id="tbl_systems">
                    <tr>
                        <td style="width: 50px; text-align: right"></td>
                        <td>System</td>
                        <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                    </tr>
                </table>
            </div>



        </div>

        <div id="div_people" class="tab-pane fade">
            <h3>People</h3>
            <div class="datagrid">
                <table id="tbl_people">
                    <tr>
                        <td style="width: 50px; text-align: right"></td>
                        <td>Name</td>
                        <td>Role</td>
                        <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="div_programs" class="tab-pane fade">
            <h3>Programs</h3>
            <div id="grid_programs"></div>
        </div>

        <div id="div_policies" class="tab-pane fade">
            <h3>Policies</h3>
            <div id="grid_policies"></div>
        </div>

        <div id="div_accreditation" class="tab-pane fade">
            <h3>Accreditation</h3>
            <div id="grid_accreditation"></div>
        </div>
        <div id="div_test" class="tab-pane fade">
            <h3>Test</h3>
            <div id="jsGrid"></div>
        </div>
    </div>
    <input id="btn_Save" type="button" value="Save" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
