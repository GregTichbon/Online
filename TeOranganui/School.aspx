<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="School.aspx.cs" Inherits="TeOranganui.School" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/datagrid.css" rel="stylesheet" />


    <script type="text/javascript">

        var newkey = 0;

        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            //Drop Down Lists
            var yesno_options = '<option value="0"></option>';
            yesno_options += '<option value="Yes">Yes</option>';
            yesno_options += '<option value="No">No</option>';

            var person_options = '<option value="0"></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=person&param1=", function (data) {
                $.each(data, function (i, item) {
                    person_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var user_options = '<option value="0"></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=userinitials&param1=", function (data) {
                $.each(data, function (i, item) {
                    user_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var role_options = '<option value="0"></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=role&param1=1", function (data) {
                $.each(data, function (i, item) {
                    role_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var system_options = '<option value="0"></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=system&param1=1", function (data) {
                $.each(data, function (i, item) {
                    system_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var communicationtype_options = '<option value="0"></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=communicationtype&param1=1", function (data) {
                $.each(data, function (i, item) {
                    communicationtype_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            //Get Record
            $("#dd_groupname").change(function () {
                $("#dd_gendertype")[0].selectedIndex = 0;
                $("#dd_authority")[0].selectedIndex = 0;
                $("#dd_decile")[0].selectedIndex = 0;
                $("#tb_moenumber").val('');
                $("#dd_type")[0].selectedIndex = 0;
                $("#dd_startyear")[0].selectedIndex = 0;
                $("#dd_endyear")[0].selectedIndex = 0;
                $(".rowdata").remove();

                group_id = $(this).val();
                if (group_id != '') {
                    $("#hf_group_id").val(group_id);

                    $.ajax({
                        async: false,
                        url: "../functions/data.asmx/get_school?group_id=" + group_id, success: function (result) {
                            item = $.parseJSON(result);
                            $("#dd_gendertype").val(item[0]['gendertype']);
                            $("#dd_authority").val(item[0]['authority']);
                            $("#dd_decile").val(item[0]['decile']);
                            $("#tb_moenumber").val(item[0]['moenumber']);
                            $("#dd_type").val(item[0]['type']);
                            $("#dd_startyear").val(item[0]['startyear']);
                            $("#dd_endyear").val(item[0]['endyear']);
                        }
                    });

                    $.getJSON("../functions/data.asmx/get_system?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = item.system_id + "_" + group_id;
                            populate_system(id);
                            $("#systemname_" + id).val(item.system_id);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_group_persons?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = item.group_person_id + "_" + group_id;
                            populate_people(id);
                            $("#personname_" + id).val(item.person_id);
                            $("#roledescription_" + id).val(item.role_id);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_group_communications?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-GroupCommunication-" + item.groupcommunication_id;
                            populate_communications(id);
                            $("#" + id + "-communicationtype_id").val(item.communicationtype_id);
                            $("#" + id + "-detail").val(item.detail);
                            $("#" + id + "-note").val(item.note);
                            $("#" + id + "-current").val(item.current);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_narrative?type=group&id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = item.narrative_id + "_" + group_id;
                            populate_narrative(id);
                            $("#narrativedate_" + id).val(item.date);
                            $("#narrative_" + id).val(item.narrative);
                            $("#narrativewho_" + id).val(item.user_id);
                            $("#narrativeaction_" + id).val(item.action);
                            $("#narrativeactiondate_" + id).val(item.action_date);
                            $("#narrativeactionwho_" + id).val(item.action_user_id);
                        });
                    });
                }
            });

            function nextnewkey() {
                newkey ++;
            }

            function populate_system(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr data-id="' + id + '" class="rowdata">').append(
                    $('<td style="text-align:center">').html(''),
                    $('<td>').html('<select name="systemname_' + id + '" id="systemname_' + id + '" class="grid_select systemname">' + system_options + '</select>'),
                    $('<td style="text-align:center">').html(del)
                ).appendTo('#tbl_systems');
            }

            function populate_people(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr data-id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<select name="personname_' + id + '" id="personname_' + id + '" class="grid_select person">' + person_options + '</select>'),
                            $('<td>').html('<select name="roledescription_' + id + '" id="roledescription_' + id + '" class="grid_select role">' + role_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_people');
            }

            function populate_narrative(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr data-id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<input name="narrativedate_' + id + '" id="narrativedate_' + id + '" type="text" />'),
                            $('<td>').html('<textarea name="narrative_' + id + '" id="narrative_' + id + '"></textarea>'),
                            $('<td>').html('<select name="narrativewho_' + id + '" id="narrativewho_' + id + '" class="grid_select narrativewho">' + user_options + '</select>'),
                            $('<td>').html('<textarea name="narrativeaction_' + id + '" id="narrativeaction_' + id + '"></textarea>'),
                            $('<td>').html('<input name="narrativeactiondate_' + id + '" id="narrativeactiondate_' + id + '" type="text" />'),
                            $('<td>').html('<select name="narrativeactionwho_' + id + '" id="narrativeactionwho_' + id + '" class="grid_select narrativewho">' + user_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_narrative');
            }
            function populate_communications(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<select name="' + id + '-communicationtype_id" id="' + id + '-communicationtype_id" class="grid_select">' + communicationtype_options + '</select>'),
                            $('<td>').html('<input name="' + id + '-detail" id="' + id + '-detail" type="text" />'),
                            $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note"></textarea>'),
                            $('<td>').html('<select name="' + id + '-current" id="' + id + '-current" class="grid_select">' + yesno_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_communications');
            }


            $(".a_add").click(function () {
                tbl = $(this).closest('table').attr('id');
                nextnewkey();
                switch (tbl) {
                    case 'tbl_people':
                        populate_people('New_' + 0);
                        break;
                    case 'tbl_systems':
                        populate_system('New_' + 0);
                        break;
                    case 'tbl_narrative':
                        populate_narrative('New_' + 0);
                        break;
                    case 'tbl_communications':
                        populate_communications("sub-GroupCommunication-N" + newkey);
                        break;
                }
            });

            $('body').on('click', '.a_delete', function () {
                mode = $(this).text();
                if (mode == 'Delete') {
                    $('td:first', $(this).parents('tr')).html('<img src="images/delete.png">');
                    $(this).text('Restore');
                    prefix = 'D';
                } else {
                    $('td:first', $(this).parents('tr')).html('');
                    $(this).text('Delete');
                    prefix = '';
                }
                tr = $(this).parents('tr');
                tr.toggleClass( "deleterow" )
                dataid = tr.attr("id");
                $('[name^=' + dataid + ']').each(function (i, obj) {
                    inputid = $(this).attr('id');
                    nameparts = inputid.split('-');
                    newname = nameparts[0] + "-" + nameparts[1] + "-" + prefix + nameparts[2] + "-" + nameparts[3];
                    $(this).attr('name',newname);
                });
                dataidparts = dataid.split('-');
                if (dataidparts[2].substring(0,1) == 'D') {
                    dataidparts[2] = dataidparts[2].substring(1);
                }
                newdataid = dataidparts[0] + "-" + dataidparts[1] + "-" + prefix + dataidparts[2];
                tr.attr('id', newdataid);
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
                        $('.deleterow').remove();



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
    <input id="hf_group_id" name="hf_group_id" type="hidden" />
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_groupname">Group name</label><div class="col-sm-8">
            <select id="dd_groupname" name="dd_groupname" class="form-control" required>
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_groupname_values, "", "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_gendertype">Gender</label><div class="col-sm-8">
            <select id="dd_gendertype" name="dd_gendertype" class="form-control" required>
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_gendertype_values, "", "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_authority">Authority</label><div class="col-sm-8">
            <select id="dd_authority" name="dd_authority" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_authority_values, "", "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_decile">Decile</label><div class="col-sm-8">
            <select id="dd_decile" name="dd_decile" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_decile_values, "", "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_moenumber">MOE Number</label><div class="col-sm-8">
            <input id="tb_moenumber" name="tb_moenumber" type="text" class="form-control" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_type">Type</label><div class="col-sm-8">
            <select id="dd_type" name="dd_type" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_type_values, "", "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_startyear">Start Year</label><div class="col-sm-8">
            <select id="dd_startyear" name="dd_startyear" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_startyear_values, "", "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_endyear">End Year</label><div class="col-sm-8">
            <select id="dd_endyear" name="dd_endyear" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_endyear_values, "", "None")%>
            </select>
        </div>
    </div>





    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#div_communications">Communications</a></li>
        <li><a data-toggle="tab" href="#div_people">People</a></li>
        <li><a data-toggle="tab" href="#div_programs">Programs</a></li>
        <li><a data-toggle="tab" href="#div_policies">Policies</a></li>
        <li><a data-toggle="tab" href="#div_accreditation">Accreditation</a></li>
        <li><a data-toggle="tab" href="#div_narrative">Narrative</a></li>
        <li><a data-toggle="tab" href="#div_systems">Systems</a></li>

    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">


        <div id="div_communications" class="tab-pane fade in active">
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

        <div id="div_narrative" class="tab-pane fade">
            <h3>Narrative</h3>
            <div class="datagrid">
                <table id="tbl_narrative">
                    <tr>
                        <td style="width: 50px; text-align: right"></td>
                        <td>Date</td>
                        <td>Narrative</td>
                        <td>Who</td>
                        <td>Action</td>
                        <td>Date</td>
                        <td>Who</td>
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

        <div id="div_systems" class="tab-pane fade">
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

    </div>
    <input id="btn_Save" type="button" value="Save" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
