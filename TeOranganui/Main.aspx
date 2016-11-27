<%@ Page Title="" Language="C#" MasterPageFile="~/TeOranganui.Master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="TeOranganui.Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $("#tb_group").autocomplete({
                source: "../functions/data.asmx/GroupAutoComplete",
                minLength: 3,
                select: function (event, ui) {
                    $("#hf_groupid").val(ui.item.group_id);
                    alert('here');
                    $("#grid_people").jsGrid("reset");

                    //alert(ui.item.group_id);
                }
            })

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
                            url: "../functions/data.asmx/get_system?group_id=1",
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
                        alert('load');
                        var deferred = $.Deferred();
                        return $.ajax({
                            type: "GET",
                            url: "../functions/data.asmx/get_person?group_id=" + $("#hf_groupid").val(),
                            data: filter,
                            dataType: "JSON",
                            success: function (data) {
                                alert(1);
                                deferred.resolve(data.results);
                            }
                        })
                        return deferred.promise();
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
        });

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="hf_groupid" type="hidden" />
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_group">Please enter the group name</label><div class="col-sm-8">
            <input id="tb_group" name="tb_group" type="text" class="form-control" />
        </div>
    </div>

    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#div_systems">Systems</a></li>
        <li><a data-toggle="tab" href="#div_people">People</a></li>
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

        <div id="div_test" class="tab-pane fade">
            <h3>Test</h3>
            <div id="jsGrid"></div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
