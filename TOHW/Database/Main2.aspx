<%@ Page Title="" Language="C#" MasterPageFile="~/TOHW.Master" AutoEventWireup="true" CodeBehind="Main2.aspx.cs" Inherits="TOHW.Database.Main2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/colorbox/colorbox.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Scripts/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />
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

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });

            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
                $(".act span").text(x);
                $(".prev span").text(y);
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

            var workers = [
                { Name: "", Id: 0 },
                { Name: "Keegan", Id: 1 },
                { Name: "Greg", Id: 2 },
                { Name: "Jordi", Id: 3 }
            ];
 
            $("#grid_encounters").jsGrid({
                width: "100%",
                height: "400px",
 
                inserting: true,
                editing: true,
                sorting: true,
                paging: true,
                autoload: true,
 
                controller: {
                    loadData: function () {
                        var d = $.Deferred();

                        $.ajax({
                            url: '../functions/data.asmx/get_encounters?id=69',
                            dataType: "json"
                        }).done(function (response) {
                            alert(d.response);
                            d.resolve(response.value);
                        });
                        alert(d.promise);
                        return d.promise();

                    }
                },
                fields: [
                    { name: 'encounterid', title: 'ID', type: 'number', width: 30 },
                    { name: 'startdatetime', title: 'Start', type: "text", width: 120  },
                    { name: 'enddatetime', title: 'End', type: "text", width: 120 },
                    { name: 'narrative', title: 'Narrative', type: "textarea", width: 400 },
                    { name: 'worker_name', title: 'Worker', type: "select", items: workers, valueField: "Id", textField: "Name" },
                    //{ name: "Name", type: "text", width: 150, validate: "required" },
                    //{ name: "Age", type: "number", width: 50 },
                    //{ name: "Address", type: "textarea", width: 200 },
                    //{ name: "Country", type: "select", items: countries, valueField: "Id", textField: "Name" },
                   // { name: "Married", type: "checkbox", title: "Is Married", sorting: false },
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
        <li class="active"><a href="#div_encounter">Encounters</a></li>
        <li><a href="#div_address">Address</a></li>
    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">
        <div id="div_encounter" class="tab-pane fade in active">
            <h3>Encounters</h3>
             <div id="grid_encounters"></div>

        </div>


        <div id="div_address" class="tab-pane fade in active">
            <h3>
                Address</h3>
        </div>
    </div>
    <!------------------------------------------------------------------------------------------------------>



    
</asp:Content>
