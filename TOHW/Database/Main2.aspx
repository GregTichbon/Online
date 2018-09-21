<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="Main2.aspx.cs" Inherits="TOHW.Database.Main2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />
    <!--http://js-grid.com-->
    <link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.1/jsgrid.min.css" />
    <link type="text/css" rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.1/jsgrid-theme.min.css" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jsgrid/1.5.1/jsgrid.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Scripts/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/init.js")%>" type="text/javascript"></script>
    <script src="<%: ResolveUrl("~/Scripts/colorbox/jquery.colorbox-min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/additional-methods.js")%>"></script>
    <!--additional-methods.min.js-->

    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
    <script src="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/generic.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            width = screen.width;

            $(".nav-tabs a").click(function () {
                href = $(this).attr('href');
                //$(href).show();
                hreftab = href.substring(4);
                //$('#grid' + hreftab).jsGrid('refresh');
                $(this).tab('show');
                setTimeout(
                    function () {
                        href = $(this).attr('href');
                        //$(href).show();
                        hreftab = href.substring(4);
                        //$('#grid' + hreftab).jsGrid('refresh');
                        $('#grid' + hreftab).jsGrid('refresh');
                    }, 500);
            });

            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
                $(".act span").text(x);
                $(".prev span").text(y);
            });

            var workers = [
                { worker_name: "", worker_entityid: 0 },
                { worker_name: "Judy Kumeroa", worker_entityid: 14 },
                { worker_name: "Keith Ramage", worker_entityid: 16 },
                { worker_name: "Jay Rerekura", worker_entityid: 19 },
                { worker_name: "Greg Tichbon", worker_entityid: 27 },
                { worker_name: "Karen Phillips", worker_entityid: 70 },
                { worker_name: "Zeana Thomas", worker_entityid: 92 },
                { worker_name: "Jordin Butters", worker_entityid: 96 },
                { worker_name: "Watson Matthews", worker_entityid: 97 },
                { worker_name: "Terry Tubman", worker_entityid: 119 },
                { worker_name: "Keegan Easton", worker_entityid: 140 },
                { worker_name: "Charlie boy Williams", worker_entityid: 4276 },
                { worker_name: "Korrallie Bailey-Taurua", worker_entityid: 4277 },
                { worker_name: "Mary Tafilipepe", worker_entityid: 4344 }
            ];

            var programs = [
                { program_name: "", ProgramID: 0, active: 0 },
                { program_name: "Senior Club", ProgramID: 1, active: 1 },
                { program_name: "Te Pihi Ora Hou - Tane", ProgramID: 2, active: 1 },
                { program_name: "Nga Toa", ProgramID: 8, active: 1 },
                { program_name: "Breakaway", ProgramID: 9, active: 1 },
                { program_name: "Te Pihi Ora Hou - Wahine", ProgramID: 10, active: 1 },
                { program_name: "Whakapakari", ProgramID: 11, active: 1 },
                { program_name: "Holiday Program October 2014", ProgramID: 12, active: 0 },
                { program_name: "Social Work", ProgramID: 14, active: 1 },
                { program_name: "Whanau Ora", ProgramID: 15, active: 1 },
                { program_name: "Te Pihi Ora Hou Tuahine", ProgramID: 16, active: 1 }
            ];

            $("#grid_enrolements").jsGrid({
                width: "100%",
                height: 400,
                inserting: false,
                editing: false,
                sorting: true,
                paging: true,
                autoload: true,
                controller: {
                    loadData: function (filter) {
                        return $.ajax({
                            url: '../functions/data.asmx/get_enrolements?id=69',
                            dataType: "json"
                        });
                    }
                },
                fields: [
                    { name: 'enrolementid', type: 'number', visible: false },
                    { name: 'programid', title: 'Program', type: "select", items: programs, valueField: "ProgramID", textField: "program_name", selectedIndex: -1, width: 100 },
                    { name: 'onfile', title: 'On file', type: "checkbox", width: 50 },
                    { name: 'onfileasat', title: 'Of file at', type: "text", width: 50 },
                    { name: 'worker', title: 'Worker', type: "checkbox", width: 50 },
                    { name: 'enrolementstatus', title: 'Status', type: "text", width: 50 },
                    { name: 'alwayspickup', title: 'Always Pickup', type: "checkbox", width: 50 },
                    { type: "control" }
                ]
            });


            $("#grid_addresses").jsGrid({
                width: "100%",
                height: 400,
                inserting: false,
                editing: true,
                sorting: true,
                paging: true,
                autoload: true,
                controller: {
                    loadData: function (filter) {
                        return $.ajax({
                            url: '../functions/data.asmx/get_addresses?id=69',
                            dataType: "json"
                        });
                    }
                },
                fields: [
                    { name: 'addressid', type: 'number', visible: false },
                    { name: 'address', title: 'address', type: "textarea", width: 200 },
                    { name: 'description', title: 'description', type: "textarea", width: 300 },
                    { name: 'longitude', title: 'longitude', type: "text", width: 100, editing: false },
                    { name: 'latitude', title: 'latitude', type: "text", width: 100, editing: false },
                    { name: 'current', title: 'current', type: "checkbox", width: 50 },
                    { name: 'notes', title: 'Notes', type: "textarea", width: 200 },
                    { type: "control" }
                ]
            });

            $("#grid_encounters").jsGrid({
                width: "100%",
                height: 400,
                inserting: false,
                editing: false,
                sorting: true,
                paging: true,
                autoload: true,
                controller: {
                    loadData: function (filter) {
                        return $.ajax({
                            url: '../functions/data.asmx/get_encounters?id=69',
                            dataType: "json"
                        });
                    }
                },
                fields: [
                    { name: 'encounterid', type: 'number', visible: false },
                    { name: 'startdatetime', title: 'Start', type: "text", width: 120 },
                    { name: 'enddatetime', title: 'End', type: "text", width: 120 },
                    { name: 'narrative', title: 'Narrative', type: "textarea", width: 400 },
                    { name: 'worker_entityid', title: 'Worker', type: "select", items: workers, valueField: "worker_entityid", textField: "worker_name", selectedIndex: -1, width: 50 },
                    { type: "control" }
                ]
            });




            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="hf_id" name="hf_id" value="<%: id %>" />
    Surname:
    <asp:TextBox ID="tb_surname" runat="server"></asp:TextBox><br />
    First name:
    <asp:TextBox ID="tb_firstname" runat="server"></asp:TextBox><br />
    Know as:
    <asp:TextBox ID="tb_knownas" runat="server"></asp:TextBox><br />
    Other names:
    <asp:TextBox ID="tb_othernames" runat="server"></asp:TextBox><br />
    Gender:
    <asp:DropDownList ID="dd_gender" runat="server"></asp:DropDownList><br />
    Date of birth:
    <asp:TextBox ID="tb_dateofbirth" runat="server"></asp:TextBox><br />

    <ul class="nav nav-tabs">
        <li class="active"><a href="#div_enrolements">Enrolements</a></li>
        <li><a href="#div_addresses">Address</a></li>
        <li><a href="#div_encounters">Encounters</a></li>
    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">

        <div id="div_enrolements" class="tab-pane fade in active">
            <h3>Enrolement</h3>
            <div id="grid_enrolements"></div>
        </div>

        <div id="div_addresses" class="tab-pane fade in">
            <h3>Address</h3>
            <div id="grid_addresses"></div>
        </div>

        <div id="div_encounters" class="tab-pane fade in">
            <h3>Encounters</h3>
            <div id="grid_encounters"></div>
        </div>
    </div>
    <!------------------------------------------------------------------------------------------------------>




</asp:Content>
