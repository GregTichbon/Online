<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="UBC.People.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/UBC.css")%>" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <style>
        .notcurrent {color:red;}
        .div_input {position: relative}
    </style>

    <script>
        $(document).ready(function () {
            $('.date').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false
                //,maxDate: moment().add(-1, 'year')

            });

            $('#dd_categories_filter').select2();

            $('#btn_refresh').click(function () {
                //Now will have all data but just hidden alert('Get data from server for categories: ' + $('#dd_categories_filter').val());
                processrows();
            })

            //$("#form1").validate();

            /*
            $(".date").rules("add", { 
              date:true
            });
            */
            $(".date").on("dp.change", function (e) {
                id = $(this).attr('id');
                if (id.substring(0, 5) == 'start') {
                    field = 'startdate';
                    id = id.substring(5);
                } else {
                    field = 'enddate';
                    id = id.substring(3);
                }
                startdate = $('#start' + id).val(); 
                enddate = $('#end' + id).val(); 
                update = true;
                if (startdate != '' && enddate != '') {
                    if (moment(startdate).isAfter(enddate)) {
                        $(this).val('');
                        alert('The end date can not be before the start date')
                        update = false;
                    }
                }
                if (update) {
                    recordid = $(this).closest('tr').attr('id').substring(3);
                    var arForm = { table: 'person_category', field: field, id: recordid, value: $(this).val(), keyfield: 'person_category_id' };
                    mydata = JSON.stringify(arForm);

                    $.ajax({
                        type: "POST",
                        url: "posts.asmx/updatefield",
                        data: mydata,
                        contentType: "application/json",
                        datatype: "json",
                        success: function (response) {
                            console.log(response);
                            //alert(responseFromServer.d.);
                        }
                    });
                }
            });
            //$('input[type=text]').change(function () {
            $('.note').change(function () {
                //$(this).valid();
                //tr = $(this).closest('tr');
                //$(tr).find('td:first').attr("class", "changed");
                //$(tr).attr('maint', 'changed');
                recordid = $(this).closest('tr').attr('id').substring(3);
                var arForm = { table: 'person_category', field: 'note', id: recordid, value: $(this).val(), keyfield: 'person_category_id' };
                mydata = JSON.stringify(arForm);

                $.ajax({
                    type: "POST",
                    url: "posts.asmx/updatefield",
                    data: mydata,
                    contentType: "application/json",
                    datatype: "json",
                    success: function (response) {
                        console.log(response);
                        //alert(responseFromServer.d.);
                    }
                });

            });
            /*
            $('.submit').click(function () {
                delim = String.fromCharCode(254);
                $('#tbl_main > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_start = $(this).find('td:eq(2) input').val();
                    tr_end = $(this).find('td:eq(3) input').val();
                    tr_note = $(this).find('td:eq(4) input').val();

                    value = tr_start + delim + tr_end + delim + tr_note;
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');
                    alert(tr_id + ',' + value);
                });
            });
            */

        }) //document.ready

        function processrows() {
            category = ',' + $('#dd_categories_filter').val() + ',';
            $('.tr_category').each(function () {
                thiscategory = ',' + $(this).attr('data-category') + ',';
                if (category.includes(thiscategory)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        };
    </script>

</asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container" style="background-color: #FCF7EA">
            <div class="toprighticon">
            
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - People Categories
        </h1>
            <p>To do:  Options to choose categories and non-current ones to show, option to add category to a person.  Database update.</p>
       <input type="checkbox" checked="checked" /> Show only current
               <select class="form-control" id="dd_categories_filter" name="dd_categories_filter" multiple="multiple">
            <%= categories_values %>
        </select>  
        <button type="button" id="btn_refresh">Refresh</button><br />
            <table id="tbl_main" class="table">
                <thead>
                    <tr>
                        <th></th>
                        <th>Person/Category</th>
                        <th>Start</th>
                        <th>End</th>
                        <th>Note</th>
                        <th>Maintain</th>
                    </tr>
                    <tr style="display: none">
                        <td style="text-align: center"></td>
                        <td></td>
                        <td>
                            <input type="text" class="form-control" /></td>
                        <td>
                            <input type="text" class="form-control" /></td>
                        <td>
                            <input type="text" class="form-control" /></td>
                        <td><a href="javascript:void(0)" class="delete" data-mode="delete">Delete</a></td>
                    </tr>
                </thead>
                <tbody><%=html %></tbody>
            </table>
             <!--
            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="submit btn btn-info" Text="Submit" />
                </div>
            </div>
             -->


        </div>   
    </asp:Content>
 <asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     <form id="form2" class="form-horizontal" role="form">
       
         </form>
     </asp:Content>