<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DirectDebit.aspx.cs" Inherits="Online.Finance.DirectDebit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        var showmap = GetQueryStringParams("showmap");

        var eoy = new Date('30 June 2019');

        var instalmentdates = [new Date('29 August 2018'), new Date('28 November 2018'), new Date('27 February 2019'), new Date('29 May 2019')];

        var yeardates = [new Date('29 August 2018'), new Date('30 June 2019')];

        var lastfrequency = '';


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "RatesDirectDebitHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            window.onbeforeunload = function () {
                if ($("#pagehelp").css("display") == "block") {
                    return 'Check unload';
                }
            };

            $(".money").numeric({ negative: false, decimalPlaces: 2 });

            $("#form1").validate({
                //ignore: '.novalidation input'
            });

            jQuery.validator.addClassRules("autotab", {
                digits: true
            });

            //not currently allowing debtors and water - options hidden in body and line below to show appropriate search div
            $("#div_searchrates").show();

            $("#ddl_system").change(function () {
                var option = $(this).val();
                if (option == 'Rates') {
                    $("#div_searchrates").show();
                }
            });


            $("#ddl_searchby").change(function () {
                if (showmap == '1') {
                    $("#propertymap").hide();
                }
                $('#results').empty();
                $('#revaluation').empty();
                var option = $(this).val();
                if (option == 'Property Number') {
                    $("#tr_propertynumber").show();
                    $("#tr_assessmentnumber").hide();
                    $("#tr_address").hide();
                    $("#tr_search").show();
                    //$('body').height(300);
                } else if (option == 'Assessment Number') {
                    $("#tr_propertynumber").hide();
                    $("#tr_assessmentnumber").show();
                    $("#tr_address").hide();
                    $("#tr_search").show();
                    //$('body').height(300);
                } else {
                    $("#tr_propertynumber").hide();
                    $("#tr_assessmentnumber").hide();
                    $("#tr_address").show();
                    $("#tr_search").hide();
                    //$("#div_main").height(600);
                    //$('body').height(600);
                }

            });


            $("#tb_address").autocomplete({
                source: "../functions/data.asmx/PropertySelect?mode=address",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    if (address) {
                        $("#tb_address").val(address.label);
                        passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no);
                        if (showmap == '1') {
                            $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                            $("#propertymap").show();
                        }
                    } else {
                        alert('Not found');
                    }
                    //selectedproperty(ui.item ?
                    // passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no) :
                    // "Nothing selected, input was " + this.value);
                },
                open: function (event, ui) {
                    if (navigator.userAgent.match(/iPad/)) {
                        // alert(1);
                        $('.autocomplete').off('menufocus hover mouseover');
                    }
                },

            })
            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  .append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .appendTo(ul);
            };

            /*
            function selectedproperty(message) {
                $("#selectedproperty").html(message);
                $(".selectedproperty").show();
                //$("#btn_select").show();
            }
            */

            $("#btn_search").click(function () {
                if (showmap == '1') {
                    $("#propertymap").hide();
                }
                $('#results').empty();
                $('#revaluation').empty();
                var mode = $("#ddl_searchby").val();
                if (mode == "Property Number") {
                    //$('body').height(300);
                    var term = $("#tb_propertynumber").val();
                } else {
                    //$('body').height(300);
                    var term = $("#tb_assessmentnumber").val();
                }
                $.ajax({
                    url: "../functions/data.asmx/PropertySelect?mode=" + mode + "&term=" + term, success: function (result) {
                        property = $.parseJSON(result);
                        if (property.length == 0) {
                            $('#search_result').html('Not found');
                        } else {
                            address = property[0];
                            //selectedproperty(address.label + "<br>" + address.legaldescription + " " + address.area + "<br>" + "Property Number: " + address.value + "<br>Assessment Number: " + address.assessment_no);
                            passproperty(0, address.label, address.value, address.area, address.legaldescription, address.assessment_no)
                            if (showmap == '1') {
                                $("#propertymap").attr('src', 'http://maps.whanganui.govt.nz/IntraMaps/MapControls/EasiMaps/index.html?configId=00000000-0000-0000-0000-000000000000&form=2fb1ccb7-bfdd-4d20-b318-5a56d52d7fe7&mapkey=' + address.value + '&project=WhanganuiMapControls&module=WDCPublicEnquiry&layer=WDCProperty&search=false&info=false&slider=false&expand=false');
                                $("#propertymap").show();
                            }
                        }
                    }
                });
            });

            $("#dd_frequency").change(function () {
                var option = $(this).val();
                if (option == 'Weekly' || option == 'Fortnightly' || option == 'Monthly') {
                    if (lastfrequency == 'fixed') {
                        $('#tb_startdate').val('');
                        $('#tb_startdate').datepicker('setDate', null);
                    }
                    $('#tb_amount').val('');
                    $('#tb_amount').prop("disabled", false);
                    $('#tb_startdate').prop("disabled", false);
                    lastfrequency = 'period';
                    calculate_number_of_payments();
                } else {
                    lastfrequency = 'fixed';
                    $('#div_calculate').hide();
                    $('#tb_amount').val('Balance due');
                    $('#tb_amount').prop("disabled", true);
                    today = new Date();
                    if (option == 'Instalment due date') {
                        for (var i = 0, len = instalmentdates.length; i < len; i++) {
                            if (instalmentdates[i] > today) {
                                //$('#tb_startdate').val(instalmentdates[i]);
                                $('#tb_startdate').val(moment(instalmentdates[i]).format('D MMM YYYY'));
                                break;
                            }
                        }
                    } else {
                        for (var i = 0, len = yeardates.length; i < len; i++) {
                            if (yeardates[i] > today) {
                                $('#tb_startdate').val(moment(yeardates[i]).format('D MMM YYYY'));
                                break;
                            }
                        }
                    }


                    $('#tb_startdate').prop("disabled", true);
                }
            });

            $("#tb_startdate").on("dp.change", function (e) {
                calculate_number_of_payments();
            });

            $("#tb_startdate").keydown(false);  //Force entry through datetimepicker

            $('#tb_startdate').datetimepicker({
                format: 'D MMM YYYY',
                daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                minDate: moment().millisecond(0).second(0).minute(0).hour(0).add(2, 'day'),
                //maxDate: moment(eoy).add(-10, 'day'),
                maxDate: moment().millisecond(0).second(0).minute(0).hour(0).add(3, 'M'),
                useCurrent: false,
                sideBySide: true
            });


            $('.autotab').keyup(function (e) {
                //console.log('keyup: ' + e.which);
                if ($(this).attr('maxLength') == $(this).val().length && e.which != 9 && e.which != 16) { //if TAB to this field and it's already "full" will just jump on
                    //console.log('keyup: jump');
                    var inputs = $(this).closest('form').find(':input');
                    inputs.eq(inputs.index(this) + 1).focus();
                }
            });

            $('.autotab').keypress(function (e) {  //keypress happens before keyup
                //console.log('keypress: ' + e.which);
                if (e.which != 8 && e.which != 46 && e.which != 0 && isNaN(String.fromCharCode(e.which))) {
                    //console.log('keypress: preventdefault');
                    e.preventDefault(); //stop character from entering input
                }
                //if ($(this).attr('maxLength') == $(this).val().length) {
                //    //console.log('keypress: jump');
                //    var inputs = $(this).closest('form').find(':input');
                //    inputs.eq(inputs.index(this) + 1).focus();
                //}
            });

            $('.autotab').change(function () {
                //console.log('change');
                pad = $(this).attr('maxLength') - $(this).val().length;
                if (pad != 0) {
                    //console.log('change: pad: ' + pad);
                    $(this).val('0000000000000000'.substring(0, pad) + $(this).val());
                }
            });

            signatory_ctr = 1;
            $('#addsignatory').click(function () {
                var cloned = $('#tr_signatory_').clone()
                signatory_ctr++;
                cloned = cloned.repeater_changer(signatory_ctr);
                var place = $('#table_signatory tr:last');
                cloned.insertAfter(place);
                return false;
            });

            $('body').on('click', '.deletesignatory', function () {
                trid = this.id;
                trid = 'tr_signatory_' + trid.substring(22);  //the number of characters before the number eg: href_signatory_delete_3
                $('#' + trid).remove();
                update_authority();
            });

            $('body').on('change', '.signatory', function () {
                update_authority();
            });


            $('#btn_calculate').click(function () {
                calculate_amount();
            });

            $('#tb_balance').change(function () {
                //calculate_amount();
                $('#td_calculated').text('');

            });

            $('#btn_use').click(function () {
                $('#tb_amount').val($('#td_calculated').text());
            });

            $('.money').change(function () {
                amount = $(this).val();
                amount = parseFloat(amount).toFixed(2);
                $(this).val(amount);
            });

                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>


        }); //document ready

        function calculate_number_of_payments() {
            option = $("#dd_frequency").val();
            startdate = $("#tb_startdate").val();
            //alert(option + ' ' + startdate);
            if (option != '' && startdate != '') {
                $('#div_calculate').show();
                var nextdate = startdate;
                var payments = 0;
                switch (option) {
                    case 'Weekly':
                        do {
                            payments++;
                            nextdate = moment(nextdate).add(7, 'day');
                            //alert(nextdate);
                        } while (nextdate < eoy)
                        break;
                    case 'Fortnightly':
                        do {
                            payments++;
                            nextdate = moment(nextdate).add(14, 'day');
                            //alert(nextdate);
                        } while (nextdate < eoy)
                        break;
                    case 'Monthly':
                        do {
                            payments++;
                            nextdate = moment(nextdate).add(1, 'month');
                            //alert(nextdate);
                        } while (nextdate < eoy)
                        break;

                }
                //alert(payments);
                $('#td_numberofpayments').html(payments);
                //calculate_amount();
                $('#td_calculated').text('');
            } else {
                $('#div_calculate').hide();
            }
        }

        function calculate_amount() {
            balance = $('#tb_balance').val();
            payments = $('#td_numberofpayments').html();
            if (balance != '' && payments != '') {
                calculated = balance / payments;
                calculated = parseFloat(calculated).toFixed(2);
                $('#td_calculated').text(calculated);
            }
            else {
                $('#td_calculated').text('Please enter the balance above');
            }
        }




        function update_authority() {
            var names = '';
            //var delim = '';
            var cnt = 0;
            var numberofnames = $('.signatory:visible').length;
            $('.signatory:visible').each(function (index) {
                cnt++;
                names += ' ' + $(this).val();
                if (numberofnames > 2 || (numberofnames == 2 && cnt == 2)) {
                    names += ',';
                }
                if (numberofnames > 1 && cnt == numberofnames - 1) {
                    names += ' and ';
                }
                //delim = ', ';
            });
            if (cnt > 1) {
                names1 = 'We;' + names + ' ';
                names2 = 'we ';
            } else {
                names1 = 'I,' + names + ', ';
                names2 = 'I ';
            }
            $('#span_authorise1').text(names1);
            $('#hf_authorise1').val(names1);
            $('#span_authorise2').text(names2);
            $('#hf_authorise2').val(names2);
        }

        function passproperty(line, label, value, area, legaldescription, assessment_no) {
            $('#search_result').html('');

            $('#Property_number').html(value);
            $('#hf_property_number').val(value);
            $('#Assessment_number').html(assessment_no);
            $('#hf_assessment_number').val(assessment_no);
            $('#Property_address').html(label);
            $('#hf_property_address').val(label);
            $('#Legal_description').html(legaldescription);
            $('#hf_legal_description').val(legaldescription);

            $('#property_result').show();
            $('.submit').prop("disabled", false)

            //$("#tb_property").val(label);
            //$("#hf_property").val(value);
            //$.colorbox.close();

            if (showmap == '1') {
                $("#propertymap").hide();
            }
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            list-style-type: lower-alpha;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <asp:Literal ID="lit_user" runat="server"></asp:Literal>
    <h1>Direct Debit Application
    </h1>


    <div id="div_system" class="form-group">
        <label class="control-label col-sm-4" for="ddl_system">System: </label>
        <div class="col-sm-8">
            <select id="ddl_system" class="form-control">
                <!--<option value="">Please select</option>-->
                <option>Rates</option>
                <!--<option>Water</option>
                <option>Sundry Debtors</option>-->
            </select>
        </div>
    </div>



    <div id="div_searchrates" style="display: none">
        <div class="form-group">
            <label class="control-label col-sm-4" for="ddl_searchby">Search by: </label>
            <div class="col-sm-8">
                <select id="ddl_searchby" class="form-control">
                    <option>Property Address</option>
                    <option>Property Number</option>
                    <option>Assessment Number</option>
                </select>
            </div>
        </div>

        <div class="form-group" id="tr_propertynumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_propertynumber">
                Enter the property number:
                <img src="../Images/questionsmall.png" title="This is the number allocated to every property by the Whanganui District Council.  This can be found on all of the WDC correspondence relating to the property"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_propertynumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_assessmentnumber" style='display: none'>
            <label class="control-label col-sm-4" for="tb_assessmentnumber">
                Enter the property assessment:
                <img src="../Images/questionsmall.png" title="This is the reference provided by QV.  It will be in a form similar to 1327054401 or 1327054401A"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_assessmentnumber" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_address">
            <label class="control-label col-sm-4" for="tb_address">
                Please start typing the address:
                <img src="../Images/questionsmall.png" title="Please separate the address parts with spaces eg: Flat 4 77 C Whatever St.  Also use the abbreviated version of the road type eg: Ave, Rd, St"></label>
            <div class="col-sm-8">
                <input type="text" id="tb_address" class="form-control" />
            </div>
        </div>

        <div class="form-group" id="tr_search" style="display: none">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input id="btn_search" value="Search" type="button" class="btn btn-info" />
                <span id="search_result"></span>
            </div>
        </div>
    </div>

    <div id="property_result" style="display:none">


        <div class="form-group">
            <label class="control-label col-sm-4">
                Property number:
            </label>

            <div class=" col-sm-8" id="Property_number"></div>
            <input type="hidden" id="hf_property_number" name="hf_property_number" />
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4">
                Assessment number:
            </label>

            <div class="col-sm-8" id="Assessment_number"></div>
            <input type="hidden" id="hf_assessment_number" name="hf_assessment_number" />

        </div>
        <div class="form-group">
            <label class="control-label col-sm-4">
                Property address:
            </label>

            <div class="col-sm-8" id="Property_address"></div>
            <input type="hidden" id="hf_property_address" name="hf_property_address" />

        </div>
        <div class="form-group">
            <label class="control-label col-sm-4">
                Legal description:
            </label>

            <div class="col-sm-8" id="Legal_description"></div>
            <input type="hidden" id="hf_legal_description" name="hf_legal_description" />

        </div>



        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <iframe id="propertymap" style="width: 400px; height: 400px; display: none;" src=""></iframe>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
            <div class="col-sm-8">
                <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
        </div>

        <div class="panel panel-danger">
            <div class="panel-heading">Payment information</div>
            <div class="panel-body">
                <p>If you elect to pay on the Instalment due date or Annually on the the discount date, Whanganui District Council will debit your account the balance due at those dates.</p>
                <p>If you elect to pay Weekly, Fortnightly or Monthly a calculator will be displayed to assist you to calculate the required regular amount to ensure your rates are paid by the 30 June 2019.  The number of payments from the "Start date" you have entered to 30 June 2018 will be shown. You must enter the balance due to 30 June 2018, this figure is available on your rate notice or by contacting the Rates Department of the Whanganui District Council, the required regular amount will then be calculated.  You can choose to "Use" this amount or you may elect to pay more. </p>
                <p>The start date must be at least 2 days from today and within 3 months of today.</p>
            </div>
        </div>





        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_frequency">
                Frequency of payments:
            </label>
            <div class="col-sm-8">
                <select id="dd_frequency" name="dd_frequency" class="form-control" required>
                    <option value="">Please select</option>
                    <option>Weekly</option>
                    <option>Fortnightly</option>
                    <option>Monthly</option>
                    <option>Instalment due date</option>
                    <option>Annually on discount date</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_startdate">
                Start date:
            </label>
            <div class="col-sm-2">
                <input type="text" id="tb_startdate" name="tb_startdate" class="form-control" data-populate="@D5" required />
            </div>
            <div id="div_calculate" class="col-sm-6" style="display: none">
                <table class="table table-striped table-responsive">
                    <tr>
                        <td>Balance:</td>
                        <td>
                            <input type="text" id="tb_balance" name="tb_balance" class="form-control numeric money" /></td>
                    </tr>
                    <tr>
                        <td>Payments:</td>
                        <td id="td_numberofpayments"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input id="btn_calculate" value="Calculate" type="button" class="btn btn-info" /></td>
                    </tr>
                    <tr>
                        <td>Required payment:</td>
                        <td id="td_calculated"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input id="btn_use" value="Use this amount" type="button" class="btn btn-info" /> <img src="../Images/questionsmall.png" title="The calculated amount will be used for your direct debit, however, you may choose to actually pay more than this if you wish."></td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_amount">
                Amount:
            </label>
            <div class="col-sm-8">
                <input type="text" id="tb_amount" name="tb_amount" class="form-control numeric money" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_bankaccount_name">
                Bank account name:
            </label>
            <div class="col-sm-8">
                <input type="text" id="tb_bankaccount_name" name="tb_bankaccount_name" class="form-control" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4">
                Bank account number:
            </label>
            <div class="col-sm-2">
                <input type="text" id="tb_bankaccount_bank" name="tb_bankaccount_bank" class="form-control autotab" required maxlength="2" data-populate="00" />
            </div>
            <div class="col-sm-2">
                <input type="text" id="tb_bankaccount_branch" name="tb_bankaccount_branch" class="form-control autotab" required maxlength="4" data-populate="0000" />
            </div>
            <div class="col-sm-2">
                <input type="text" id="tb_bankaccount_number" name="tb_bankaccount_number" class="form-control autotab" required maxlength="7" data-populate="0000000" />
            </div>
            <div class="col-sm-2">
                <input type="text" id="tb_bankaccount_suffix" name="tb_bankaccount_suffix" class="form-control autotab" required maxlength="3" data-populate="000" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="xxxxx">
                Name of the authorised account signatory/signatories
                <img src="../Images/questionsmall.png" title="Please show all the names required to authorise a payment."><br />
                <a href="javascript:void(0);" id="addsignatory">Add</a>
            </label>
            <div class="table-responsive table-bordered">
                <table class="table" id="table_signatory">
                    <thead>
                        <tr>
                            <th colspan="2" class="col-md-8">Signatory</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input id="repeat_signatory_tb_signatory_1" name="repeat_signatory_tb_signatory_1" type="text" class="form-control signatory" required />
                            </td>
                            <td>Required</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>





        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_bank">
                Bank:  
            </label>
            <div class="col-sm-8">
                <!--
                <select id="dd_bank" name="dd_bank" class="form-control" required>
                    <option value="">Please select</option>
                    <%//=Online.WDCFunctions.WDCFunctions.populateselect(dd_bank_values, "", "None")%>
                </select>
                -->
                <input type="text" id="tb_bank" name="tb_bank" class="form-control" required />

            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_branch">
                Branch:  
            </label>
            <div class="col-sm-8">
                <input type="text" id="tb_branch" name="tb_branch" class="form-control" required />
            </div>
        </div>


        <div class="panel panel-danger">
            <div class="panel-heading">
            
                <p>Information to appear on your bank statements</p>
                </div>
                <div class="panel-body">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_particulars">
                        Particulars:  
                    </label>
                    <div class="col-sm-8">
                        <input type="text" id="tb_particulars" name="tb_particulars" class="form-control" maxlength="12" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_code">
                        Code:  
                    </label>
                    <div class="col-sm-8">
                        <input type="text" id="tb_code" name="tb_code" class="form-control" maxlength="12" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_bankreference">
                        Reference:  
                    </label>
                    <div class="col-sm-8">
                        <input type="text" id="tb_bankreference" name="tb_bankreference" class="form-control" maxlength="8" required />
                    </div>
                </div>
            </div>
        </div>



        <h4>Conditions of this authority to accept direct debits</h4>

        <ol>
            <li><strong>The Initiator:</strong><br />
                <ol class="auto-style1">
                    <li>Has agreed to give advance notice of the net amount of each direct debit and the due date of the debiting at least 10 calendar days (but not more than 2 calendar months) before the date when the direct debit will be initiated. This notice will be provided in writing (including by electronic means and SMS where the customer has provided prior written consent (including by electronic means including SMS) to communicate electronically). The advance notice will include the following message: "Unless advice to the contrary is received from you by (date*), the amount of $........... will be directly debited to your bank account on (initiating date)." *This date will be at least two (2) days prior to the initiating date to allow for amendment of direct debits.</li>
                    <li>May, upon the relationship which gave rise to this Instruction being terminated, give notice to the bank that no further direct debits are to be initiated under the Instruction. Upon receipt of such notice the bank may terminate this Instruction as to future payments by notice in writing to me/us.</li>
                </ol>
            </li>
            <li><strong>The Customer may:</strong><br />
                <ol class="auto-style1">
                    <li>At any time, terminate this Instruction as to future payments by giving written notice of termination to the bank and to the Initiator by means agreed by the customer, bank and Initiator.</li>
                    <li>Stop payment of any direct debit to be initiated under this Instruction by the Initiator by giving written notice to the bank prior to the direct debit being paid by the bank.</li>
                                    </ol>
            </li>
            <li><strong>The Customer acknowledges that:</strong><br />
                <ol class="auto-style1">
                    <li>This Instruction will remain in full force and effect in respect of all direct debits passed to my/our account in good faith notwithstanding my/our death, bankruptcy or other revocation of this Instruction until actual notice of such event is received by the bank.</li>
                    <li>In any event this Instruction is subject to any arrangement now or hereafter existing between me/us and the bank in relation to my/our account.</li>
                    <li>Any dispute as to the correctness or validity of an amount debited to my/our account shall not be the concern of the bank except in so far as the direct debit has not been paid in accordance with this Instruction. Any other dispute lies between me/us and the Initiator.</li>
                    <li>Where the bank has used reasonable care and skill in acting in accordance with this Instruction, the bank accepts no responsibility or liability in respect of:-<ul>
                        <li>&nbsp;the accuracy of information about direct debits on bank statements; and</li>
                        <li>&nbsp;any variations between notices given by the Initiator and the amounts of direct debits.</li>
                    </ul>
                    </li>
                    <li>The bank is not responsible for, or under any liability in respect of the Initiator's failure to give notice in accordance with 1(a) nor for the non-receipt or late receipt of notice by me/us for any reason whatsoever. In any such situation the dispute lies between me/us and the Initiator.</li>
                </ol>
            </li>
            <li><strong>The bank may:</strong><br />
                <ol class="auto-style1">
                    <li>In its absolute discretion conclusively determine the order of priority of payment by it of any monies pursuant to this or any other Instruction, cheque or draft properly signed by me/us and given to or drawn on the bank.</li>
                    <li>At any time terminate this Instruction as to future payments by notice in writing to me/us.</li>
                    <li>Charge its current fees for this service in force from time to time.</li>
                </ol>
            </li>
        </ol>

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_authorisation">
                <span id="span_authorise1">I/We </span>confirm that <span id="span_authorise2">I/we </span> have read and accept the above terms and conditions and are the required authority over the bank account nominated above and, therefore, authorise Whanganui District Council, using Authorisation: Code 0109806, (herein after referred to as the Initiator) until further notice in writing to debit my/our account with all amounts the Initiator may initiate by direct debit.
             <input type="hidden" id="hf_authorise1" name="hf_authorise1" />
                <input type="hidden" id="hf_authorise2" name="hf_authorise2" />
            </label>
            <div class="col-sm-8">
                <select id="dd_authorisation" name="dd_authorisation" class="form-control" required>
                    <option value="">Please select</option>
                    <option>Yes</option>
                </select>
            </div>
        </div>



        <!-- SUBMIT -->

        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" disabled="disabled" class="btn btn-info submit" Text="Submit" />
            </div>
        </div>
    </div>
    <!-- REPEATER SECTION-->

    <div style="display: <%:none%>" class="novalidation">
        <table>
            <tr id="tr_signatory_" class="repeatupdateid">
                <td>
                    <input id="repeat_signatory_tb_signatory_" type="text" class="form-control signatory" required /></td>
                <td><a href="javascript:void(0)" id="href_signatory_delete_" class="deletesignatory repeatupdateid">Delete</a></td>
            </tr>
        </table>
    </div>
    <!-- END OF REPEATER SECTION -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
