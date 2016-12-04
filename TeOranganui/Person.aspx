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

            $.getJSON("../functions/data.asmx/get_personaddress?person_id=" + $("#hf_personid").val(), function (data) {
                $.each(data, function (i, item) {
                    del = '<a class="a_delete" href="javascript:void(0)">Delete</a>';
                    var $tr = $('<tr data-id="' + item.List_item_ID + '" class="rowdata">').append(
                        $('<td style="text-align:center">').html(''),
                        $('<td>').html('<input name="systemname_' + item.group_system_id + '|' + item.system_id + '" class="grid_select" type="text" value="' + item.systemname + '" />'),
                        $('<td style="text-align:center">').html(del)
                    ).appendTo('#tbl_systems');
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
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_gender_values, dd_gender, "None")%>
            </select>
        </div>
    </div>

        <div class="form-group">
        <label class="control-label col-sm-4" for="tb_notes">Notes</label><div class="col-sm-8">
            <textarea id="tb_notes" name="tb_notes" rows="3" class="form-control"><%: tb_notes %></textarea>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
