<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonEntry.aspx.cs" Inherits="Online.Cemetery.Sexton.PersonEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var datamode = 'GIS';
        var mydialog;

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
                var years = moment().diff(e.date, 'years');
                //alert(years);
                $("#tb_age").val(years);
                $("#dd_agetype").val('Years');


                //calculate_age(e.date);    
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


            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("href") // activated tab
                //alert(target);
                if (target == '#div_map') {
                    $('#div_map').show();
                } else {
                    $('#div_map').hide();
                }
            });

            $("#form1").validate();

            $("#btn_findplot").click(function () {
                //mydialog = $("#dialog").load("plotselection.aspx").dialog({
                mydialog = $('#dialog').dialog({
                    width: 900,
                    height: 600
                });

            });



            //There is a small issue, where a dropdown is changed by the user, the dependant dropdowns still use the parent values when they should really be set to -1
            //The problem is trying to identify that it was a human that changed it rather than the parent values



        }); //document ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a href="http://wdc.whanganui.govt.nz/cemeteries/business/home.aspx">http://wdc.whanganui.govt.nz/cemeteries/business/home.aspx</a>


    <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" data-target="#div_information">Information</a></li>
        <li><a data-toggle="tab" data-target="#div_internment">Internment</a></li>
        <li><a data-toggle="tab" data-target="#div_map">Map</a></li>
        <li><a data-toggle="tab" data-target="#div_images">Images</a></li>
        <li><a data-toggle="tab" data-target="#div_inscription">Inscription</a></li>
    </ul>
    <br />
    <div class="tab-content">
        <div id="div_information" class="tab-pane fade in active">

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_warrant">Warrant number</label>
                <div class="col-sm-8">
                    <input id="tb_warrant" name="tb_warrant" type="text" class="form-control" maxlength="50" value="<%: warrant_no%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_register">Register number</label>
                <div class="col-sm-8">
                    <input id="tb_register" name="tb_register" type="text" class="form-control" maxlength="50" value="<%: register_no%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_surname">Surname</label>
                <div class="col-sm-8">
                    <input id="tb_surname" name="tb_surname" type="text" class="form-control" maxlength="50" value="<%: surname%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_givenname1">Given name 1</label>
                <div class="col-sm-8">
                    <input id="tb_givenname1" name="tb_givenname1" type="text" class="form-control" maxlength="50" value="<%: givenname1%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_givenname2">Given name 2</label>
                <div class="col-sm-8">
                    <input id="tb_givenname2" name="tb_givenname2" type="text" class="form-control" maxlength="50" value="<%: givenname2%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_givenname3">Given name 3</label>
                <div class="col-sm-8">
                    <input id="tb_givenname3" name="tb_givenname3" type="text" class="form-control" maxlength="50" value="<%: givenname3%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_lastresidence">Last Residence</label><div class="col-sm-8">
                    <textarea id="tb_lastresidence" name="tb_lastresidence" class="form-control" rows="4" maxlength="500" required><%: lastpermanentaddress%></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_city">City</label>
                <div class="col-sm-8">
                    <input id="tb_city" name="tb_city" type="text" class="form-control" maxlength="50" value="<%: city%>" />
                </div>
            </div>

            <div class="form-group">
                <label for="tb_dateofdeath" class="control-label col-sm-4">Date of death</label>
                <div class="col-sm-8">
                    <div class="input-group date dateselector" id="div_dateofdeath">
                        <input id="tb_dateofdeath" name="tb_dateofdeath" required placeholder="eg: 23 Jun 1985" class="form-control" value="<%: dateofdeath%>" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="tb_dateofbirth" class="control-label col-sm-4">Date of birth</label>
                <div class="col-sm-8">
                    <div class="input-group date" id="div_dateofbirth">
                        <input id="tb_dateofbirth" name="tb_dateofbirth" required placeholder="eg: 23 Jun 1985" class="form-control" value="<%: dateofbirth%>" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_stillborn">Still born</label><div class="col-sm-8">

                    <select id="dd_stillborn" name="dd_stillborn" class="form-control" required>
                        <option></option>
                        <%
                            string[] yesno_values = new string[2] { "Yes", "No" };
                            Response.Write(Online.WDCFunctions.WDCFunctions.populateselect(yesno_values, stillborn, "None"));
                        %>
                    </select>

                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_age">Age</label>
                <div class="col-sm-4">
                    <input id="tb_age" name="tb_age" type="text" class="form-control" maxlength="50" value="<%: age%>" />
                </div>
                <div class="col-sm-4">
                    <select id="dd_agetype" name="dd_agetype" class="form-control" required>
                        <option></option>
                        <%
                            string[] age_period_values = new string[4] { "Days", "Weeks", "Months", "Years" };
                            Response.Write(Online.WDCFunctions.WDCFunctions.populateselect(age_period_values, age_period, "None"));
                        %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_gender">Gender</label><div class="col-sm-8">

                    <select id="dd_gender" name="dd_gender" class="form-control" required>
                        <option></option>
                        <%
                            string[] gender_values = new string[3] { "Female", "Male", "Gender Diverse" };
                            Response.Write(Online.WDCFunctions.WDCFunctions.populateselect(gender_values, gender, "None"));
                        %>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_rankoccupation">Rank / Occupation</label>
                <div class="col-sm-8">
                    <input id="tb_rankoccupation" name="tb_rankoccupation" type="text" class="form-control" maxlength="50" value="<%: rankoroccupation%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_marital">Marital status</label><div class="col-sm-8">

                    <select id="dd_maritalstatus" name="dd_maritalstatus" class="form-control" required>
                        <option></option>
                        <%
                            string[] maritalstatus_values = new string[4] { "Widow", "Widowed", "Married", "Infant" };
                            Response.Write(Online.WDCFunctions.WDCFunctions.populateselect(maritalstatus_values, maritalstatus, "None"));
                        %>
                    </select>
                </div>
            </div>

            

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_placeofdeath">Place of death</label>
                <div class="col-sm-8">
                    <input id="tb_placeofdeath" name="tb_placeofdeath" type="text" class="form-control" maxlength="50" value="<%: placeofdeath%>" />
                </div>
            </div>

            <div class="form-group">
                <label for="tb_dateofcertificate" class="control-label col-sm-4">Date Of medical certificate</label>
                <div class="col-sm-8">
                    <div class="input-group date dateselector" id="div_dateofcertificate">
                        <input id="tb_dateofcertificate" name="tb_dateofcertificate" required placeholder="eg: 23 Jun 1985" class="form-control" value="<%: dateofmedcert%>" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_celebrant">Celebrant / Minister</label>
                <div class="col-sm-8">
                    <input id="tb_celebrant" name="tb_celebrant" type="text" class="form-control" maxlength="50" value="<%: minister%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_religousaffiliation">Religous affiliation</label>
                <div class="col-sm-8">
                    <input id="tb_religousaffiliation" name="tb_religousaffiliation" type="text" class="form-control" maxlength="50" value="<%: denomination%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_funeralcoordinator">Funeral co-ordinator</label>
                <div class="col-sm-8">
                    <input id="tb_funeralcoordinator" name="tb_funeralcoordinator" type="text" class="form-control" maxlength="50" value="<%: funeralcoordinator%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_remarks">Remarks</label><div class="col-sm-8">
                    <textarea id="tb_remarks" name="tb_remarks" class="form-control" rows="4" maxlength="500" required><%: remarks%></textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <input id="btn_submit" type="button" value="Save" class="btn btn-info submit" />
                </div>
            </div>
        </div>

        <div id="div_internment" class="tab-pane fade">

            <div style="text-align: center">

                <div class="form-group">
                    <label class="control-label col-sm-5" style="text-align: left" for="tb_internment_plot">Plot</label>
                    <label class="control-label col-sm-2" style="text-align: left" for="dd_internment_modifier">Modifier</label>
                    <label class="control-label col-sm-1" style="text-align: left" for="tb_internment_date">Date</label>
                    <label class="control-label col-sm-1" style="text-align: left" for="dd_internment_type">Type</label>
                    <label class="control-label col-sm-1" style="text-align: left" for="dd_internment_status">Status</label>
                    <label class="control-label col-sm-2" style="text-align: left" for="tb_internment_remarks">Remarks</label>
                </div>
                <div class="form-group">
                    <div class="col-sm-5">
                        <input id="tb_internment_plot" name="tb_internment_plot" type="text" class="form-control" readonly="readonly" />
                        <button id="btn_findplot" type="button">Find</button>
                    </div>

                    <div class="col-sm-2">
                        <select id="dd_internment_modifier" name="dd_internment_modifier" class="form-control">
                            <option></option>
                            <option>In space to the left</option>
                            <option>In space to the right</option>
                            <option>Scattered near</option>
                        </select>
                    </div>


                    <div class="col-sm-1">
                        <input id="tb_internment_date" name="tb_internment_date" type="text" class="form-control dateselector" />
                    </div>

                    <div class="col-sm-1">
                        <select id="dd_internment_type" name="dd_internment_type" class="form-control">
                            <option></option>
                            <option value="Burialash">Burial of ashes</option>
                            <option value="Memorial">Memorial (only)</option>
                            <option value="Taken">Ashes taken</option>
                            <option value="Cremation">Cremation</option>
                            <option value="Scattered">Ashes scattered</option>
                            <option value="Disinter">Disinternment</option>
                            <option value="Burial">Burial</option>
                        </select>
                    </div>

                    <div class="col-sm-1">
                        <select id="dd_internment_status" name="dd_internment_status" class="form-control">
                            <option></option>
                            <option>Current</option>
                            <option>Past</option>
                        </select>
                    </div>

                    <div class="col-sm-2">
                        <input id="tb_internment_remarks" name="tb_internment_remarks" type="text" class="form-control" />
                    </div>
                </div>
            </div>
        </div>

        <div id="div_map" class="tab-pane fade">
            <div style="text-align: center">
                <asp:Literal ID="lit_map" runat="server"></asp:Literal>
            </div>
        </div>

        <div id="div_images" class="tab-pane fade">
            <asp:Literal ID="lit_images" runat="server"></asp:Literal>
        </div>
    </div>

    <div id="dialog" style="display: none">
        <iframe src="PlotSelection.aspx" frameborder="0" allowfullscreen style="width: 100%; height: 100%;"></iframe>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
