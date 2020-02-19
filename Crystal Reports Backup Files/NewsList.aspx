<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="NewsList.aspx.cs" Inherits="UBC.People.NewsList" %>
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

             $('#newsviewer').click(function () {
                window.location.href = "<%: ResolveUrl("newsviewer.aspx")%>";
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
        <div class="toprighticon">
            <input type="button" id="newsviewer" class="btn btn-info" value="News Viewer" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>

        <h1>Union Boat Club - News Selection
        </h1>

        <h2><a href="news.aspx?id=new" target="edit">New</a></h2>
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
    </div>
</asp:Content>
