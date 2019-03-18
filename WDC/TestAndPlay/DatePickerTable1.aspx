<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatePickerTable1.aspx.cs" Inherits="Online.TestAndPlay.DatePickerTable1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script>
        $(document).ready(function () {

            $('.datetime').datetimepicker({
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


    <p class="h3" style="text-align: center">Venues / Facilities / Equipment Requirements</p>
                               <div class="col-sm-12">
                                       <table class="table table-hover table-responsive">
        <tr>
            <td>Venue</td>
            <td>Required</td>
            <td>Access From</td>
            <td>Access To</td>
            <td>Attendees Access From</td>
            <td>Attendees Access To</td>

        </tr>


        <tr>
            <td>Main Hall <a href='http://www.warmemorialcentre.co.nz/facilities/main-hall' target='WMCVenue'>See detail</a></td>
            <td>
                <input id="required_" type="checkbox" /></td>
            <td>
                <input type="text" id="accessfrom_1" class="datetime" /></td>
            <td>
                <input type="text" id="accessto_1" class="datetime" /></td>
            <td>
                <input type="text" id="attendanceaccessfrom_1" class="datetime" /></td>
            <td>

                <input type="text" id="attendanceaccessto_1" class="datetime" /></td>
        </tr>



    </table>

</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
