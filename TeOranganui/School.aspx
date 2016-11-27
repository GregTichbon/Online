<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="School.aspx.cs" Inherits="TeOranganui.School" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            var clients = [
                { "Name": "Otto Clay", "Age": 25, "Country": 1, "Address": "Ap #897-1459 Quam Avenue", "Married": false },
                { "Name": "Connor Johnston", "Age": 45, "Country": 2, "Address": "Ap #370-4647 Dis Av.", "Married": true },
                { "Name": "Lacey Hess", "Age": 29, "Country": 3, "Address": "Ap #365-8835 Integer St.", "Married": false },
                { "Name": "Timothy Henson", "Age": 56, "Country": 1, "Address": "911-5143 Luctus Ave", "Married": true },
                { "Name": "Ramona Benton", "Age": 32, "Country": 3, "Address": "Ap #614-689 Vehicula Street", "Married": false }
            ];

            var countries = [
                { Name: "", Id: 0 },
                { Name: "United States", Id: 1 },
                { Name: "Canada", Id: 2 },
                { Name: "United Kingdom", Id: 3 }
            ];



            $("#grid_systems").jsGrid({
                width: "100%",
                height: "400px",

                inserting: true,
                editing: true,
                sorting: true,
                paging: true,
                autoload: true,

                controller: {
                    loadData: function (filter) {
                        return $.ajax({
                            type: "GET",
                            url: "../functions/data.asmx/get_system?group_id=" + $("#hf_groupid").val(),
                            data: filter,
                            dataType: "JSON"
                        })
                    }
                },
                fields: [
                { name: "systemname", title: "System", type: "text", width: 150, validate: "required" },
                { type: "control" }
                ]
            });

            $("#grid_people").jsGrid({
                width: "100%",
                height: "400px",

                inserting: true,
                editing: true,
                sorting: true,
                paging: true,
                autoload: true,

                controller: {
                    loadData: function (filter) {
                        return $.ajax({
                            type: "GET",
                            url: "../functions/data.asmx/get_person?group_id=" + $("#hf_groupid").val(),
                            data: filter,
                            dataType: "JSON",
                        })
                    }
                },
                fields: [
                { name: "personname", title: "Name", type: "text", width: 150, validate: "required" },
                { name: "roledescription", title: "Role", type: "text", width: 150, validate: "required" },
                { type: "control" }
                ]
            });


            $("#jsGrid").jsGrid({
                width: "100%",
                height: "400px",

                inserting: true,
                editing: true,
                sorting: true,
                paging: true,

                data: clients,

                fields: [
                    { name: "Name", type: "text", width: 150, validate: "required" },
                    { name: "Age", type: "number", width: 50 },
                    { name: "Address", type: "text", width: 200 },
                    { name: "Country", type: "select", items: countries, valueField: "Id", textField: "Name" },
                    { name: "Married", type: "checkbox", title: "Is Married", sorting: false },
                    { type: "control" }
                ]
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
                    url: 'functions/posts.asmx/update_school', // the url where we want to POST
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
    <input id="hf_groupid" type="hidden" value="<%: hf_groupid %>" />
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">Group name</label><div class="col-sm-8">
            <input id="tb_group" name="tb_group" type="text" class="form-control" value="<%: tb_groupname %>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">Gender</label><div class="col-sm-8">
            <select id="dd_gender" name="dd_gender" class="form-control" required>
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_gender_values, dd_gender, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">Authority</label><div class="col-sm-8">
            <select id="dd_authority" name="dd_authority" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_authority_values, dd_authority, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">Decile</label><div class="col-sm-8">
            <select id="dd_decile" name="dd_decile" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_decile_values, dd_decile, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">MOE Number</label><div class="col-sm-8">
            <input id="tb_moenumber" name="tb_moenumber" type="text" class="form-control" value="<%: tb_moenumber %>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">Type</label><div class="col-sm-8">
            <select id="dd_type" name="dd_type" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_type_values, dd_type, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">Start Year</label><div class="col-sm-8">
            <select id="dd_startyear" name="dd_startyear" class="form-control">
                <option></option>
                <%=TeOranganui.Functions.Functions.populateselect(dd_startyear_values, dd_startyear, "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">End Year</label><div class="col-sm-8">
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
        <li><a data-toggle="tab" href="#div_test">Test</a></li>
    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">
        <div id="div_systems" class="tab-pane fade in active">
            <h3>Systems</h3>
            <div id="grid_systems"></div>
        </div>

        <div id="div_people" class="tab-pane fade">
            <h3>People</h3>
            <div id="grid_people"></div>
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
