<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="EventList.aspx.cs" Inherits="UBC.People.EventList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="../Dependencies/moment.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>

    <script>
        $(document).ready(function () {

            $('#fromdate').val(moment().subtract(7,'day').format('D MMM YYYY'));
            $('#todate').val(moment().add(1,'year').format('D MMM YYYY'));

            filterbydate();

            $('#btn_refresh').click(function () {
                filterbydate();
            });




            $('.createrecurring').click(function () {
                event_id = $(this).attr('data-id');
                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }
                $("#dialog-createrecurring").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Create": function () {
                            var arForm = { event_id: event_id, period: 'D', frequency: 7, upto: $('#tb_createrecurring_upto').val() };
                            mydata = JSON.stringify(arForm);

                            $.ajax({
                                type: "POST",
                                url: "posts.asmx/create_recurring_events",
                                data: mydata,
                                contentType: "application/json",
                                datatype: "json",
                                success: function (response) {
                                    console.log(response);
                                    //alert(responseFromServer.d.);
                                }
                            });
                            /*
                            $.post("posts.asmx/create_recurring_events", { event_id: event_id, period: 'D', frequency: 7, upto: $('#tb_createrecurring_upto').val() }, function (data) {
                            //alert(data);
                            });
                            */
                            $(this).dialog("close");
                        }
                    }
                });
            })

            $('.date').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: true
            });
            /*
            $('#menu').click(function () {
                window.location.href = '../default.aspx';
            })
            */
            $('.title').tooltip({
                content: function () {
                    var element = $(this);
                    return element.attr("title");
                }
            });

        });

        function filterbydate() {
            fromdate = moment($('#fromdate').val());
            todate = moment($('#todate').val());

            $("[data-date]").each(function () {
                thedate = $(this).attr('data-date');
                var day = moment(thedate);
              
                if (day >= fromdate && day <= todate) {
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

     
        <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" /> 


        <h1>Union Boat Club - Event Selection
        </h1>

        <h2><a href="event.aspx?id=new" target="edit">New</a></h2>
        <div class="form-inline">
        Show events between: 
            <div class="input-group date">
                <input type="text" id="fromdate" class="date form-control"/>

                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        and
        <div class="input-group date">
                <input type="text" id="todate" class="date form-control"/>

                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>


        <input id="btn_refresh" type="button" class="submit btn btn-info" value="Refresh" />
            </div>
        <table class="table">
            <%=html %>
        </table>

        <div id="dialog-createrecurring" title="Create Recurring Events" style="display: none" class="form-horizontal">

                <div class="form-group">
                    <label for="tb_notes_datetime" class="control-label col-sm-4">
                        Type
                    </label>
                    <div class="col-sm-8">
                        Days
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="span_notes_madeby">Period</label>
                    <div class="col-sm-8">
                        7
                    </div>
                </div>
  
                <div class="form-group">
                    <label for="tb_createrecurring_upto" class="control-label col-sm-4">
                        Date upto
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_createrecurring_upto" name="tb_createrecurring_upto" placeholder="eg: 23 Jun 1985" type="text" class="form-control date"  />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>

                
            </div>

    </div>
</asp:Content>
