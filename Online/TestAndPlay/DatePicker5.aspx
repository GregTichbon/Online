<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatePicker5.aspx.cs" Inherits="Online.TestAndPlay.DatePicker5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>

        $(document).ready(function () {

            $("#cb_allday").change(function () {
                var ad = $(this).is(":checked");
                if (ad == true) {
                    $("#td_startdate").html("Date")
                    //$('#div_startdate').datetimepicker('setDate', new Date);
                    //startdate.datetimepicker('option', 'format', 'D MMM YYYY');
                    //startdate.datetimepicker('option', 'sideBySide', true);
                    //$element = $("#div_startdate");
                    //$element = $("#td_startdate");
                    //$element.datepicker('remove');
                    //$element.datepicker({ language: 'fr' });
                    //$element.datepicker('option', 'language', 'fr');
                    //$element.datepicker("change", { language: 'fr' });

                    //$element.data("DateTimePicker").language('fr');

                    $('#div_startdate').datepicker('destroy');
                    alert('destroyed');
                    /*
                    $('#div_startdate').datetimepicker({
                        format: 'D MMM YYYY',
                        showClear: true,
                        viewDate: false,
                        stepping: 30,
                        minDate: moment().add(1, 'day'),
                        maxDate: moment().add(10, 'year'),
                        useCurrent: false

                    });
                    */

                } else {
                    $("#td_startdate").html("Start (Date and Time");
                    //$('#div_startdate').datetimepicker('option', 'format', 'D MMM YYYY LT');
                    //startdate.datetimepicker('option', 'sideBySide', false);
                    //$element = $("#div_startdate");
                    //$element = $("#td_startdate");
                    //$element.datepicker('remove');
                    //$element.datepicker({ language: 'ar' });
                    //$element.datepicker('option', 'language', 'ar');
                    //$element.datepicker("change", { language: 'ar' });
                    //$element.data("DateTimePicker").language('ar');
                    $('#div_startdate').datepicker('destroy');
                    alert('destroyed');
                    /*
                    $('#div_startdate').datetimepicker({
                        format: 'D MMM YYYY LT',
                        showClear: true,
                        viewDate: false,
                        stepping: 30,
                        minDate: moment().add(1, 'day'),
                        maxDate: moment().add(10, 'year'),
                        useCurrent: false,
                        sideBySide: true

                    });
                    */

                }
            });



            $('#div_startdate').datetimepicker({
                format: 'D MMM YYYY LT',
                showClear: true,
                viewDate: false,
                stepping: 30,
                minDate: moment().add(1, 'day'),
                maxDate: moment().add(10, 'year'),
                useCurrent: false,
                sideBySide: true

            });



        });



    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="eventMaint">
        <table id="mainttable">


            <tr>
                <td style="text-align: right">All day</td>
                <td>
                    <input id="cb_allday" name="cb_allday" type="checkbox" /></td>
            </tr>

            <tr>
                <td style="text-align: right" id="td_startdate">Start (Date and Time)</td>
                <td>
                    <div class="input-group date" id="div_startdate">
                        <input id="tb_startdate" name="tb_startdate" type="date" value="" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </td>
            </tr>



        </table>


    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
