<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Entry.aspx.cs" Inherits="Online.Cemetery.Administration.Archive.Entry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript" src="<%: ResolveUrl("~/scripts/CascadingDropdown/jquery.cascadingdropdown.min.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
             $('#div_dateofbirth').datetimepicker({
                //$('#tb_dateofbirth').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'years'
            });

            $("#div_dateofbirth").on("dp.change", function (e) {
                //$("#tb_dateofbirth").on("dp.change", function (e) {
                if (moment().diff(e.date, 'seconds') < 0) {
                    e.date = moment(e.date).subtract(100, 'years');
                    $("#tb_dateofbirth").val(moment(e.date).format('D MMM YYYY'));
                }
            });



            $('.dateselector').datetimepicker({
                //$('#tb_dateofbirth').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
            });


            $('#standardised').cascadingDropdown({
                selectBoxes: [
                    {
                        selector: '#std_cemetery',
                        source: function (request, response) {
                            $.getJSON('../../data.asmx/Cemeteries', function (data) {
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#std_area',
                        requires: ['#std_cemetery'],
                        source: function (request, response) {
                            //console.log(request);
                            //console.log(response);
                            $.getJSON('../../data.asmx/Areas?datamode=GIS', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#std_division',
                        requires: ['#std_cemetery', '#std_area'],
                        requireAll: true,
                        source: function (request, response) {
                            //alert('division');
                            //console.log(request);
                            //console.log(response);
                            $.getJSON('../../data.asmx/Divisions?datamode=GIS', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        }
                    },
                    {
                        selector: '#std_plot',
                        requires: ['#std_cemetery', '#std_area', '#std_division'],
                        requireAll: true,
                        source: function (request, response) {
                            $.getJSON('../../data.asmx/Plots', request, function (data) {
                                //var selectOnlyOption = data.length <= 1;
                                response($.map(data, function (item, index) {
                                    return {
                                        label: item.label,
                                        value: item.value//,
                                        //selected: index == 0 //selectOnlyOption
                                    };
                                }));
                            });
                        },
                        onChange: function (event, value, requiredValues, requirementsMet) {
                            if (!requirementsMet) {
                                $("#btn_update").prop('disabled', true);
                                return;
                            }
                            //standardised.loading(true);
                            $("#btn_update").prop('disabled', false);
                        }
                    }
                ]
            });
        });
    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_warrant">Warrant</label>
        <div class="col-sm-8">
            <input id="tb_warrant" name="tb_warrant" type="text" class="form-control" maxlength="50" value="<%: warrant %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_burydate">Internment Date</label>
        <div class="col-sm-8">
            <input id="tb_burydate" name="tb_burydate" type="text" class="form-control" maxlength="50" value="<%: burydate %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_burialdate">Internment Date</label>
        <div class="col-sm-8">
            <div class="input-group date dateselector" id="div_burialdate">
                <input id="tb_burialdate" name="tb_burialdate" type="text" class="form-control" maxlength="50" value="<%: burialdate %>" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dob">Date of Birth</label>
        <div class="col-sm-8">
            <div class="input-group date" id="div_dateofbirth">
                <input id="tb_dob" name="tb_dob" type="text" class="form-control" maxlength="50" value="<%: dob %>" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dod">Date of Death</label>
        <div class="col-sm-8">
            <input id="tb_dod" name="tb_dod" type="text" class="form-control" maxlength="50" value="<%: dod %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_fullname">Full Name</label>
        <div class="col-sm-8">
            <input id="tb_fullname" name="tb_fullname" type="text" class="form-control" maxlength="250" value="<%: fullname %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_surname">Surname</label>
        <div class="col-sm-8">
            <input id="tb_surname" name="tb_surname" type="text" class="form-control" maxlength="150" value="<%: surname %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_forenames">Forenames</label>
        <div class="col-sm-8">
            <input id="tb_forenames" name="tb_forenames" type="text" class="form-control" maxlength="150" value="<%: forenames %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_age">Age</label>
        <div class="col-sm-8">
            <input id="tb_age" name="tb_age" type="text" class="form-control" maxlength="50" value="<%: age %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_residence">Residential Address</label>
        <div class="col-sm-8">
            <textarea id="tb_residence" name="tb_residence" class="form-control" rows="3" maxlength="150"><%: residence %></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_occupation">Occupation</label>
        <div class="col-sm-8">
            <input id="tb_occupation" name="tb_occupation" type="text" class="form-control" maxlength="150" value="<%: occupation %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_minister">Minister</label>
        <div class="col-sm-8">
            <input id="tb_minister" name="tb_minister" type="text" class="form-control" maxlength="150" value="<%: minister %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_director">Director</label>
        <div class="col-sm-8">
            <input id="tb_director" name="tb_director" type="text" class="form-control" maxlength="150" value="<%: director %>" />
        </div>
    </div>
    <div class="table-responsive">
        <table class="table-bordered" style="width: 98%; background-color: bisque">
            <tr>
                <td>
                    <h2>Location Details</h2>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_cemetery">Cemetery</label>
                        <div class="col-sm-8">
                            <input id="tb_cemetery" name="tb_cemetery" type="text" class="form-control" maxlength="50" value="<%: cemetery %>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_thearea">Area</label>
                        <div class="col-sm-8">
                            <input id="tb_thearea" name="tb_thearea" type="text" class="form-control" maxlength="150" value="<%: thearea %>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_theblock">Block</label>
                        <div class="col-sm-8">
                            <input id="tb_theblock" name="tb_theblock" type="text" class="form-control" maxlength="150" value="<%: theblock %>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_thediv">Division</label>
                        <div class="col-sm-8">
                            <input id="tb_thediv" name="tb_thediv" type="text" class="form-control" maxlength="150" value="<%: thediv %>" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_theplot">Plot</label>
                        <div class="col-sm-8">
                            <input id="tb_theplot" name="tb_theplot" type="text" class="form-control" maxlength="150" value="<%: theplot %>" />
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <br />

    <div id="standardised" class="table-responsive">
        <table class="table-bordered" style="width: 98%; background-color: bisque">
            <tr>
                <td>
                    <h2>Standardised Location Details</h2>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="std_cemetery">Cemetery</label>
                        <div class="col-sm-8">
                            <select id="std_cemetery" name="cemetery" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="std_area">Area</label>
                        <div class="col-sm-8">
                            <select id="std_area" name="area" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="std_division">Division</label>
                        <div class="col-sm-8">
                            <select id="std_division" name="division" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="std_plot">Plot</label>
                        <div class="col-sm-8">
                            <select id="std_plot" name="plot" class="form-control">
                                <option></option>
                            </select>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <br />

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_remarks">Remarks</label>
        <div class="col-sm-8">
            <textarea id="tb_remarks" name="tb_remarks" class="form-control" rows="3" maxlength="1000"><%: remarks %></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_book">Book</label>
        <div class="col-sm-8">
            <input id="tb_book" name="tb_book" type="text" class="form-control" maxlength="20" value="<%: book %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_pageref">Page</label>
        <div class="col-sm-8">
            <input id="tb_pageref" name="tb_pageref" type="text" class="form-control" maxlength="20" value="<%: pageref %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dateentered">Date Entered</label>
        <div class="col-sm-8">
            <input id="tb_dateentered" name="tb_dateentered" type="text" class="form-control" readonly="readonly" value="<%: dateentered %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dateupdated">Date Last Updated</label>
        <div class="col-sm-8">
            <input id="tb_dateupdated" name="tb_dateupdated" type="text" class="form-control" readonly="readonly" value="<%: dateupdated %>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_datechecked">Date Checked</label>
        <div class="col-sm-8">
             <div class="input-group date dateselector" id="div_datechecked">
            <input id="tb_datechecked" name="tb_datechecked" type="text" class="form-control" value="<%: datechecked %>" />
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            </div>
        </div>
    </div>





    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_ischecked">Checked</label>
        <div class="col-sm-8">
            <select id="dd_ischecked" name="dd_ischecked" class="form-control">
                <option></option>
                <%
                    string[] yesno_values = new string[2] { "Yes", "No" };
                    Response.Write(Online.WDCFunctions.WDCFunctions.populateselect(yesno_values, ischecked, "None"));
                %>
            </select>
        </div>
    </div>
    <%if (1 == 2)
        { %>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_actiontype">Action Type</label>
        <div class="col-sm-8">
            <input id="tb_actiontype" name="tb_actiontype" type="text" class="form-control" maxlength="50" value="<%: actiontype %>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_sextonreference">Sexton's Reference</label>
        <div class="col-sm-8">
            <input id="tb_sextonreference" name="tb_sextonreference" type="text" class="form-control" maxlength="20" value="<%: sextonreference %>" />
        </div>
    </div>
        <%} %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
