<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="UBC.People.Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/dirty.js")%>"></script>
    <style>
 
    </style>

    <script>

        $(document).ready(function () {

            $("#myForm").dirty();

            $('#bookinglist').click(function () {
                window.location.href = "<%: ResolveUrl("bookinglist.aspx")%>";
            })

            $("#form1").validate({
                rules: {
                    tb_startdatetime: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    },
                    tb_enddatetime: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    }
                },
                messages: {
                    tb_startdatetime: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    },
                    tb_enddatetime: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }
            });

            $('#div_startdatetime').datetimepicker({
                format: 'D MMM YYYY HH:mm',
                extraFormats: ['D MMM YY HH:mm', 'D MMM YYYY HH:mm', 'DD/MM/YY HH:mm', 'DD/MM/YYYY HH:mm', 'DD.MM.YY HH:mm', 'DD.MM.YYYY HH:mm', 'DD MM YY HH:mm', 'DD MM YYYY HH:mm'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'days',
                stepping: 15
                //,maxDate: moment().add(-1, 'year')
            });

            $('#div_enddatetime').datetimepicker({
                format: 'D MMM YYYY HH:mm',
                extraFormats: ['D MMM YY HH:mm', 'D MMM YYYY HH:mm', 'DD/MM/YY HH:mm', 'DD/MM/YYYY HH:mm', 'DD.MM.YY HH:mm', 'DD.MM.YYYY HH:mm', 'DD MM YY HH:mm', 'DD MM YYYY HH:mm'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'days',
                stepping: 15
                //,maxDate: moment().add(-1, 'year')
            });

            $('#cb_allday').change(function () {
                if ($(this).is(":checked")) {
                    $('.usetime').text('');
                    myformat = 'D MMM YYYY';
                    myextraFormats = ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'];
                    $('#div_startdatetime').data("DateTimePicker").format(myformat);
                    $('#div_startdatetime').data("DateTimePicker").extraFormats(myextraFormats);
                    $('#div_enddatetime').data("DateTimePicker").format(myformat);
                    $('#div_enddatetime').data("DateTimePicker").extraFormats(myextraFormats);
                } else {
                    $('.usetime').text('/time');
                    myformat = 'D MMM YYYY HH:mm';
                    myextraFormats = ['D MMM YY HH:mm', 'D MMM YYYY HH:mm', 'DD/MM/YY HH:mm', 'DD/MM/YYYY HH:mm', 'DD.MM.YY HH:mm', 'DD.MM.YYYY HH:mm', 'DD MM YY HH:mm', 'DD MM YYYY HH:mm'];
                    $('#div_startdatetime').data("DateTimePicker").format(myformat);
                    $('#div_startdatetime').data("DateTimePicker").extraFormats(myextraFormats);
                    $('#div_enddatetime').data("DateTimePicker").format(myformat);
                    $('#div_enddatetime').data("DateTimePicker").extraFormats(myextraFormats);
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="hf_booking_id" name="hf_booking_id" value="<%: booking_id %>" />
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <input type="button" id="bookinglist" class="btn btn-info" value="Booking List" />
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Booking
        </h1>


        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_who">Who</label>
            <div class="col-sm-8">
                <input id="tb_who" name="tb_who" type="text" class="form-control" value="<%: who %>" maxlength="200" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="cb_allday">All day</label>
            <div class="col-sm-8">
                <input id="cb_allday" name="cb_allday" type="checkbox" style="width: auto" value="Yes" <%:allday_checked %>class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_startdatetime">Start date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <div class="input-group date" id="div_startdatetime">
                    <input id="tb_startdatetime" name="tb_startdatetime" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: startdatetime %>" maxlength="20" required />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_enddatetime">End date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <div class="input-group date" id="div_enddatetime">
                    <input id="tb_enddatetime" name="tb_enddatetime" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: enddatetime %>" maxlength="20" required />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_description">Description</label>
            <div class="col-sm-8">
                <textarea id="tb_description" name="tb_description" class="form-control"><%: description %></textarea>
            </div>
        </div>

                <div class="form-group">
            <label class="control-label col-sm-4" for="tb_contact_details">Contact Details</label>
            <div class="col-sm-8">
                <textarea id="tb_contact_details" name="tb_contact_details" class="form-control" required><%: contact_details %></textarea>
            </div>
        </div>
     
        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>
    </div>




</asp:Content>
