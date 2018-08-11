<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="TOHW.Database.Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/Grid/css/grid.min.css")%>" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Scripts/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

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
    <script src="<%: ResolveUrl("~/Scripts/Grid/js/grid.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/generic.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
                $(".act span").text(x);
                $(".prev span").text(y);
            });



            function edit ($container, currentValue) {
                //$container.append("<input type=\"text\" value=\"" + currentValue + "\"/>");
                $container.append("<textarea style=\"width:99%\">" + currentValue + "</textarea>")
            };

            $('#tblencounters').grid({
                dataSource: '../functions/data.asmx/get_encounters?id=69',
                dataKey: "encounterid",
                columns: [
                    { field: 'encounterid', title: 'ID', width: 30 },
                    { field: 'startdatetime', title: 'Start', width: 120  },
                    { field: 'enddatetime', title: 'End', width: 120 },
                    { field: 'narrative', title: 'Narrative', width: 400, editor: edit },
                    { field: 'worker_name', title: 'Worker' }
                ],
                uiLibrary: 'bootstrap',
                pager: { limit: 2, sizes: [2, 5, 10, 20] }
            });

            $('#tbladdress').grid({
                dataSource: '../functions/data.asmx/get_addresses?id=69',
                dataKey: "addressid",
                columns: [
                    { field: 'addressid', title: 'ID', width: 30 },
                    { field: 'address', title: 'Address', width: 200 },
                    { field: 'note', title: 'Note', width: 400 },
                ],
                uiLibrary: 'bootstrap',
                pager: { limit: 2, sizes: [2, 5, 10, 20] }
            });

            $("#refreshencounter").click(function () {
                $.ajax({
                    url: "../functions/data.asmx/get_encounters?id=" + $("#hf_id").val(), success: function (result) {
                        encounters = $.parseJSON(result);
                        alert(result);
                        //http://gijgo.com/Grid
                        /*
                        for (var i = 0, len = burialrecord.length; i < len; ++i) {
                            var table = $(document.createElement('table'))
                            $('#results').append('<table id="table' + i + '" class="table table-hover table-responsive"></table>');
                            table = $("#table" + i);
                            for (var key in burialrecord[i]) {
                                //alert(key + ', ' + burialrecord[i][key]);
                                buildburialrecords(table, key, burialrecord[i][key]);
                            }
                            table.append('<tr><td class="col-md-4 text-right">Request the inclusion of additional information</td><td><input id="additional' + i + '" type="text" /></td></tr>');
                            table.append('<tr><td class="col-md-4 text-right">Upload files</td><td><input id="file' + i + '" type="file" /></td></tr>');
                        }
                        */
                    }
                });

            })

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
        <li class="active"><a href="#div_encounter">Encounters</a></li>
        <li><a href="#div_address">Address</a></li>
    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">
        <div id="div_encounter" class="tab-pane fade in active">
            <h3>Encounters</h3>
            <table id="tblencounters" data-ui-library="bootstrap"></table>

            <a id="refreshencounter">Refresh</a>
        </div>


        <div id="div_address" class="tab-pane fade in">
            <h3>
                Address</h3>
        </div>
    </div>

    <!--
    <table id="grid"></table>
 <script>
     var data, grid;
     data = [
         { 'ID': 1, 'Name': 'Hristo Stoichkov', 'PlaceOfBirth': 'Plovdiv, Bulgaria' },
         { 'ID': 2, 'Name': 'Ronaldo Luis Nazario de Lima', 'PlaceOfBirth': 'Rio de Janeiro, Brazil' },
         { 'ID': 3, 'Name': 'David Platt', 'PlaceOfBirth': 'Chadderton, Lancashire, England' }
     ];
     grid = $('#grid').grid({
         dataSource: data,
         columns: [{ field: 'ID' }, { field: 'Name' }, { field: 'PlaceOfBirth' }],
         pager: { limit: 2 }
     });
 </script>
    -->

</asp:Content>
