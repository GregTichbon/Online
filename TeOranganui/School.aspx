<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="School.aspx.cs" Inherits="TeOranganui.School" %>

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

            var validator = $("#form1").validate({
                ignore: []
            });

            $("#inputfields :input").prop("disabled", inputfields_disabled)

            //Drop Down Lists
            var yesno_options = '<option value=""></option>';
            yesno_options += '<option value="Yes">Yes</option>';
            yesno_options += '<option value="No">No</option>';

            var person_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=person&param1=", function (data) {
                $.each(data, function (i, item) {
                    person_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var user_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=userinitials&param1=", function (data) {
                $.each(data, function (i, item) {
                    user_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var role_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=role&param1=1", function (data) {
                $.each(data, function (i, item) {
                    role_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var programme_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=list_item&param1=5", function (data) {
                $.each(data, function (i, item) {
                    programme_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var policy_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=list_item&param1=7", function (data) {
                $.each(data, function (i, item) {
                    policy_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var accreditation_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=list_item&param1=6", function (data) {
                $.each(data, function (i, item) {
                    accreditation_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var system_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=system&param1=", function (data) {
                $.each(data, function (i, item) {
                    system_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var communicationtype_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=communicationtype&param1=", function (data) {
                $.each(data, function (i, item) {
                    communicationtype_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var addresstype_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=addresstype&param1=", function (data) {
                $.each(data, function (i, item) {
                    addresstype_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var engagementlevel_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=list_Item&param1=12", function (data) {
                $.each(data, function (i, item) {
                    engagementlevel_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var rolltype_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=list_item&param1=13", function (data) {
                $.each(data, function (i, item) {
                    rolltype_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            var rollclassification_options = '<option value=""></option>';
            $.getJSON("../functions/data.asmx/get_dropdown?type=list_item&param1=8", function (data) {
                $.each(data, function (i, item) {
                    rollclassification_options += '<option value="' + item.value + '">' + item.label + '</option>';
                });
            });

            //Get Record
            $("#dd_search").change(function () {
                inputfields_disabled = false;
                $("#inputfields :input").prop("disabled", inputfields_disabled)
                $("#tb_groupname").val('');
                $("#dd_gendertype")[0].selectedIndex = 0;
                $("#dd_authority")[0].selectedIndex = 0;
                $("#dd_decile")[0].selectedIndex = 0;
                $("#tb_moenumber").val('');
                $("#dd_type")[0].selectedIndex = 0;
                $("#dd_startyear")[0].selectedIndex = 0;
                $("#dd_endyear")[0].selectedIndex = 0;
                $(".rowdata").remove();

                group_id = $(this).val();
                if (group_id == 'Create') {
                    $("#hf_group_id").val(0);
                } else if (group_id != '') {
                    $("#hf_group_id").val(group_id);

                    $.ajax({
                        async: false,
                        url: "../functions/data.asmx/get_school?group_id=" + group_id, success: function (result) {
                            item = $.parseJSON(result);
                            $("#tb_groupname").val(item[0]['groupname']);
                            $("#dd_gendertype").val(item[0]['gendertype']);
                            $("#dd_authority").val(item[0]['authority']);
                            $("#dd_decile").val(item[0]['decile']);
                            $("#tb_moenumber").val(item[0]['moenumber']);
                            $("#dd_type").val(item[0]['type']);
                            $("#dd_startyear").val(item[0]['startyear']);
                            $("#dd_endyear").val(item[0]['endyear']);
                        }
                    });

                    $.getJSON("../functions/data.asmx/get_group_persons?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-group_person-" + item.group_person_id;
                            populate_people(id);
                            $("#" + id + "-person_id").val(item.person_id);
                            $("#" + id + "-role_id").val(item.role_id);
                            $("#" + id + "-note").val(item.note);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_groupcommunication?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-GroupCommunication-" + item.communication_id;
                            populate_communications(id);
                            $("#" + id + "-communicationtype_id").val(item.communicationtype_id);
                            $("#" + id + "-detail").val(item.detail);
                            $("#" + id + "-note").val(item.note);
                            $("#" + id + "-current").val(item.current);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_groupaddress?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-groupaddress-" + item.groupaddress_id;
                            populate_address(id);
                            $("#" + id + "-addresstype_id").val(item.addresstype_id);
                            $("#" + id + "-detail").val(item.detail);
                            $("#" + id + "-note").val(item.note);
                            $("#" + id + "-current").val(item.current);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_grouproll?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-grouproll-" + item.grouproll_id;
                            populate_roll(id);
                            $("#" + id + "-date").val(item.date);
                            $("#" + id + "-type_id").val(item.type_id);
                            $("#" + id + "-classification_id").val(item.classification_id);
                            $("#" + id + "-roll").val(item.roll);
                            $("#" + id + "-note").val(item.note);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_groupengagement?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-groupengagement-" + item.engagement_id;
                            populate_engagement(id);
                            $("#" + id + "-level_id").val(item.level_id);
                            $("#" + id + "-date").val(item.date);
                            $("#" + id + "-note").val(item.note);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_school_programme?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-School_Programme-" + item.school_programme_id;
                            populate_programme(id);
                            $("#" + id + "-list_item_id").val(item.list_item_id);
                            $("#" + id + "-startdate").val(item.startdate);
                            $("#" + id + "-enddate").val(item.enddate);
                            $("#" + id + "-note").val(item.note);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_school_policy?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-School_Policy-" + item.school_policy_id;
                            populate_policy(id);
                            $("#" + id + "-list_item_id").val(item.list_item_id);
                            $("#" + id + "-dateimplemented").val(item.dateimplemented);
                            $("#" + id + "-datereview").val(item.datereview);
                            $("#" + id + "-reviewdone").val(item.reviewdone);
                            $("#" + id + "-note").val(item.note);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_school_accreditation?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-School_Accreditation-" + item.school_accreditation_id;
                            populate_accreditation(id);
                            $("#" + id + "-list_item_id").val(item.list_item_id);
                            $("#" + id + "-dateaccredited").val(item.dateaccredited);
                            $("#" + id + "-datereview").val(item.datereview);
                            $("#" + id + "-reviewdone").val(item.reviewdone);
                            $("#" + id + "-note").val(item.note);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_group_system?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-group_system-" + item.group_system_id;
                            populate_system(id);
                            $("#" + id + "-system_id").val(item.system_id);
                        });
                    });

                    $.getJSON("../functions/data.asmx/get_groupnarrative?group_id=" + group_id, function (data) {
                        $.each(data, function (i, item) {
                            id = "sub-groupnarrative-" + item.groupnarrative_id;
                            populate_narrative(id);
                            $("#" + id + "-date").val(item.date);
                            $("#" + id + "-narrative").val(item.narrative);
                            $("#" + id + "-user_id").val(item.user_id);
                            $("#" + id + "-action").val(item.action);
                            $("#" + id + "-action_date").val(item.action_date);
                            $("#" + id + "-action_user_id").val(item.action_user_id);
                        });
                    });
                }
                $(this).prop('selectedIndex', 0);
            });

            function nextnewkey() {
                newkey++;
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

            function populate_address(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<select name="' + id + '-addresstype_id" id="' + id + '-addresstype_id" class="grid_select form-control" required>' + addresstype_options + '</select>'),
                            $('<td>').html('<textarea name="' + id + '-detail" id="' + id + '-detail" class="form-control" required></textarea>'),
                            $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                            $('<td>').html('<select name="' + id + '-current" id="' + id + '-current" class="grid_select form-control" required>' + yesno_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_address');
            }

            function populate_roll(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<input name="' + id + '-date" id="' + id + '-date" type="date" class="form-control" required/>'),
                            $('<td>').html('<select name="' + id + '-type_id" id="' + id + '-type_id" class="grid_select form-control" required>' + rolltype_options + '</select>'),
                            $('<td>').html('<select name="' + id + '-classification_id" id="' + id + '-classification_id" class="grid_select form-control" required>' + rollclassification_options + '</select>'),
                            $('<td>').html('<input name="' + id + '-roll" id="' + id + '-roll" type="text" class="form-control" required/>'),
                            $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_roll');
            }

            function populate_engagement(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<input name="' + id + '-date" id="' + id + '-date" type="date" class="form-control" required />'),
                            $('<td>').html('<select name="' + id + '-level_id" id="' + id + '-level_id" class="grid_select form-control" required>' + engagementlevel_options + '</select>'),
                            $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_engagement');
            }

            function populate_people(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata person">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<select name="' + id + '-person_id" id="' + id + '-person_id" class="grid_select form-control" required>' + person_options + '</select>'),
                            $('<td>').html('<select name="' + id + '-role_id" id="' + id + '-role_id" class="grid_select form-control">' + role_options + '</select>'),
                            $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_people');
            }

            function populate_programme(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                    $('<td style="text-align:center">').html(''),
                    $('<td>').html('<select name="' + id + '-list_item_id" id="' + id + '-list_item_id" class="grid_select form-control" required>' + programme_options + '</select>'),
                    $('<td>').html('<input name="' + id + '-startdate" id="' + id + '-startdate" type="date" class="form-control" />'),
                    $('<td>').html('<input name="' + id + '-enddate" id="' + id + '-enddate" type="date" class="form-control" />'),
                    $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                    $('<td style="text-align:center">').html(del)
                ).appendTo('#tbl_programme');
            }

            function populate_policy(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                    $('<td style="text-align:center">').html(''),
                    $('<td>').html('<select name="' + id + '-list_item_id" id="' + id + '-list_item_id" class="grid_select form-control" required>' + policy_options + '</select>'),
                    $('<td>').html('<input name="' + id + '-dateimplemented" id="' + id + '-dateimplemented" type="date" class="form-control" />'),
                    $('<td>').html('<input name="' + id + '-datereview" id="' + id + '-datereview" type="date" class="form-control" />'),
                    $('<td>').html('<select name="' + id + '-reviewdone" id="' + id + '-reviewdone" class="grid_select form-control">' + yesno_options + '</select>'),
                    $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                    $('<td style="text-align:center">').html(del)
                ).appendTo('#tbl_policy');
            }

            function populate_accreditation(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                    $('<td style="text-align:center">').html(''),
                    $('<td>').html('<select name="' + id + '-list_item_id" id="' + id + '-list_item_id" class="grid_select form-control" required>' + accreditation_options + '</select>'),
                    $('<td>').html('<input name="' + id + '-dateaccredited" id="' + id + '-dateaccredited" type="date" class="form-control" />'),
                    $('<td>').html('<input name="' + id + '-datereview" id="' + id + '-datereview" type="date" class="form-control" />'),
                    $('<td>').html('<select name="' + id + '-reviewdone" id="' + id + '-reviewdone" class="grid_select form-control">' + yesno_options + '</select>'),
                    $('<td>').html('<textarea name="' + id + '-note" id="' + id + '-note" class="form-control"></textarea>'),
                    $('<td style="text-align:center">').html(del)
                ).appendTo('#tbl_accreditation');
            }

            function populate_system(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                    $('<td style="text-align:center">').html(''),
                    $('<td>').html('<select name="' + id + '-system_id" id="' + id + '-system_id" class="grid_select form-control" required>' + system_options + '</select>'),
                    $('<td style="text-align:center">').html(del)
                ).appendTo('#tbl_systems');
            }

            function populate_narrative(id) {
                del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                var $tr = $('<tr id="' + id + '" class="rowdata">').append(
                            $('<td style="text-align:center">').html(''),
                            $('<td>').html('<input name="' + id + '-date" id="' + id + '-date" type="text" class="form-control" required />'),
                            $('<td>').html('<textarea name="' + id + '-narrative" id="' + id + '-narrative" class="form-control" required></textarea>'),
                            $('<td>').html('<select name="' + id + '-user_id" id="' + id + '-user_id" Adclass="grid_select form-control" required>' + user_options + '</select>'),
                            $('<td>').html('<textarea name="' + id + '-action" id="' + id + '-action" class="form-control"></textarea>'),
                            $('<td>').html('<input name="' + id + '-action_date-" id="' + id + '-action_date" type="text" class="form-control" />'),
                            $('<td>').html('<select name="' + id + '-action_user_id-" id="' + id + '-action_user_id" class="grid_select form-control">' + user_options + '</select>'),
                            $('<td style="text-align:center">').html(del)
                        ).appendTo('#tbl_narrative');
            }

            $(".a_add").click(function () {
                if (!inputfields_disabled) {
                    tbl = $(this).closest('table').attr('id');
                    nextnewkey();
                    switch (tbl) {
                        case 'tbl_communications':
                            populate_communications("sub-GroupCommunication-N" + newkey);
                            break;
                        case 'tbl_address':
                            populate_address("sub-GroupAddress-N" + newkey);
                            break;
                        case 'tbl_roll':
                            populate_roll("sub-GroupRoll-N" + newkey);
                            break;
                        case 'tbl_engagement':
                            populate_engagement("sub-GroupEngagement-N" + newkey);
                            break;
                        case 'tbl_people':
                            populate_people('sub-group_person-N' + newkey);
                            break;
                        case 'tbl_programme':
                            populate_programme('sub-school_programme-N' + newkey);
                            break;
                        case 'tbl_policy':
                            populate_policy('sub-school_policy-N' + newkey);
                            break;
                        case 'tbl_accreditation':
                            populate_accreditation('sub-school_accreditation-N' + newkey);
                            break;
                        case 'tbl_narrative':
                            populate_narrative('sub-groupnarrative-N' + newkey);
                            break;
                        case 'tbl_systems':
                            populate_system('sub-group_system-N' + newkey);
                            break;
                    }
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

            $('body').on('dblclick', '.person', function () {
                idparts = $(this).attr('id').split('-');
                tbl = idparts[1];
                id = idparts[2];
                switch (tbl) {
                    case 'group_person':
                        alert('Person: ' + id);
                        break;
                }

            });

            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var mytab = $(event.target).text();         // active tab
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
                        url: 'functions/posts.asmx/update_school', // the url where we want to POST
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
                } else {
                    //alert('There is a validation error');
                    //console.log(validator.errorList);
                    msg = "";
                    for (var i = 0; i < validator.errorList.length; i++) {
                        msg += validator.errorList[i].element.name + "\n";
                    }
                    alert(msg);
                }
            })
        });

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="hf_group_id" name="hf_group_id" type="hidden" />
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_search">Search</label><div class="col-sm-8">
            <select id="dd_search" class="form-control">
                <option></option>
                <option value="Create">Create</option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_groupname_values, "", "None")%>
            </select>
        </div>
    </div>
    <div id="inputfields">

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_groupname">Group name</label><div class="col-sm-8">
                <input id="tb_groupname" name="tb_groupname" type="text" class="form-control" required />
            </div>
        </div>

        <!-- Accordian header start -->
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#header">
                        <h4 class="panel-title">Show/Hide</h4>
                    </a>
                </div>
                <div id="header" class="panel-collapse collapse in">
                    <div class="panel-body" style="position: relative">
                        <!-- added relative for datetimepicker -->
                        <!-- Accordian header end -->

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="dd_gendertype">Gender</label><div class="col-sm-8">
                                <select id="dd_gendertype" name="dd_gendertype" class="form-control">
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

                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
        </div>
        <!-- Accordian footer end -->



        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#div_communications">Communications</a></li>
            <li><a data-toggle="tab" href="#div_address">Addresses</a></li>
            <li><a data-toggle="tab" href="#div_engagement">Engagement</a></li>
            <li><a data-toggle="tab" href="#div_roll">Roll</a></li>
            <li><a data-toggle="tab" href="#div_people">People</a></li>
            <li><a data-toggle="tab" href="#div_programmes">Programmes</a></li>
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

            <div id="div_address" class="tab-pane fade">
                <h3>Address</h3>
                <div class="datagrid">
                    <table id="tbl_address">
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

            
            <div id="div_engagement" class="tab-pane fade">
                <h3>Engagement</h3>
                <div class="datagrid">
                    <table id="tbl_engagement">
                        <tr>
                            <td style="width: 50px; text-align: right"></td>
                            <td>Date</td>
                            <td>Level</td>
                            <td>Note</td>
                            <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="div_roll" class="tab-pane fade">
                <h3>Roll</h3>
                <div class="datagrid">
                    <table id="tbl_roll">
                        <tr>
                            <td style="width: 50px; text-align: right"></td>
                            <td>Date</td>
                            <td>Type</td>
                            <td>Classification</td>
                            <td>Roll</td>
                            <td>Note</td>
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
                            <td>Note</td>
                            <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="div_programmes" class="tab-pane fade">
                <h3>Programmes</h3>
                <div class="datagrid">
                    <table id="tbl_programme">
                        <tr>
                            <td style="width: 50px; text-align: right"></td>
                            <td>Programme</td>
                            <td>Start</td>
                            <td>End</td>
                            <td>Note</td>
                            <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="div_policies" class="tab-pane fade">
                <h3>Policies</h3>
                <div class="datagrid">
                    <table id="tbl_policy">
                        <tr>
                            <td style="width: 50px; text-align: right"></td>
                            <td>Policy</td>
                            <td>Implemented</td>
                            <td>Review</td>
                            <td>Review done</td>
                            <td>Note</td>
                            <td style="width: 100px; text-align: center">Action / <a class="a_add" href="javascript:void(0)">Add</a></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="div_accreditation" class="tab-pane fade">
                <h3>Accreditation</h3>
                <div class="datagrid">
                    <table id="tbl_accreditation">
                        <tr>
                            <td style="width: 50px; text-align: right"></td>
                            <td>Accreditation</td>
                            <td>Accredited</td>
                            <td>Review</td>
                            <td>Review done</td>
                            <td>Note</td>
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
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
