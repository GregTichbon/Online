<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WMF.aspx.cs" Inherits="Online.WMF.WMF" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "WMF.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $(".numeric").numeric({ negative: false, decimalPlaces: 2 });

            $("#form1").validate({
                ignore: [],
            });

            var addressnames = ['physicaladdress', 'postaladdress'];
            for (var i = 0, len = addressnames.length; i < len; i++) {
                addressname = addressnames[i];
                $('#cb_' + addressname).click(function () {
                    addressname = $(this).attr("id").substring(3);
                    if ($('#span_' + addressname).text() == 'Address lookup mode (preferred)') {
                        $('#span_' + addressname).text('Free format address mode (not preferred)');
                        $('#tb_' + addressname).autocomplete("disable");
                    } else {
                        $('#span_' + addressname).text('Address lookup mode (preferred)');
                        $('#tb_' + addressname).autocomplete("enable");
                    }
                })
                $('#tb_' + addressname).autocomplete({
                    source: "../functions/data.asmx/NZPostAddressSearch",
                    minLength: 5,
                    select: function (event, ui) {
                        event.preventDefault();
                        address = ui.item;
                        addressname = $(this).attr("id").substring(3);
                        $('#tb_' + addressname).val(ui.item ?
                            address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                    }
                })
            }


            var repeaternames = ['expenditure', 'income', 'otherfunding', 'similarservice'];
            var repeatercounters = [1, 1, 0, 0];
            for (var i = 0, len = repeaternames.length; i < len; i++) {
                repeatername = repeaternames[i];
                $('.add' + repeatername).click(function () {
                    repeatername = $(this).attr("id").substring(3);
                    var cloned = $('#tr_' + repeatername + '_').clone(true)
                    var i = repeaternames.indexOf(repeatername);
                    repeatercounters[i]++;
                    cloned = cloned.repeater_changer(repeatercounters[i]);
                    var place = $('#table_' + repeatername + ' tr:last');
                    if ($(this).data('footer') >= 1) {
                        cloned.insertBefore(place);  
                    } else {
                        cloned.insertAfter(place);  
                    }
                    return false;
                });

                $('body').on('click', '.delete' + repeatername, function () {
                    repeatername = $(this).attr("id").substring(11);
                    trid = 'tr_' + repeatername;
                    $('#' + trid).remove();
                    var xx = repeatername.split("_");
                    switch (xx[0]) {
                        case 'expenditure':
                            calculateexpenditure();
                            break;
                        case 'income':
                            calculateincome();
                            break;
                        case 'otherfunding':
                            calculateotherfunds();
                            break;
                        //default:
                            //alert('*' + xx[0] + '*');
                    }
                });
            }

            $('body').on('change', '.expenditureamount', function () {
                formatamount = parseFloat($(this).val()).toFixed(2);
                $(this).val(formatamount);
                calculateexpenditure();
            });
            $('body').on('change', '.incomeamount', function () {
                formatamount = parseFloat($(this).val()).toFixed(2);
                $(this).val(formatamount);
                calculateincome();
            });


            /*
            $('.addexpenditure').click(function () {
                var cloned = $('#tr_expenditure_').clone()
                expenditure_ctr++;
                cloned = cloned.repeater_changer(expenditure_ctr);
                var place = $('#table_expenditure tr:last');
                cloned.insertAfter(place);
                return false;
            });

            $('body').on('click', '.deleteexpenditure', function () {
                trid = this.id;
                trid = 'tr_expenditure' + trid.substring(11);
                //alert(trid);
                $('#' + trid).remove();
            });
            */

            function calculateexpenditure() {
                totalamount = 0;
                $(".expenditureamount").each(function (index) {
                    amount = $(this).val();
                    if (amount != '') {
                        totalamount += parseFloat(amount);
                    }
                });
                $("#expendituretotal").text(totalamount.toFixed(2));
                calculateapplicationamount();
            }


            function calculateincome() {
                totalamount = 0;
                $(".incomeamount").each(function (index) {
                    amount = $(this).val();
                    if (amount != '') {
                        totalamount += parseFloat(amount);
                    }
                });
                $("#incometotal").text(totalamount.toFixed(2));
                calculateapplicationamount();
            }

            function calculateapplicationamount() {
                $('#tb_amountappliedfor').val(($("#incometotal").text() - $("#expendituretotal").text()).toFixed(2));
            }

            $('body').on('change', '.appliedamount', function () {
                formatamount = parseFloat($(this).val()).toFixed(2);
                $(this).val(formatamount);
                calculateotherfunds();
            });
            $('body').on('change', '.grantedamount', function () {
                formatamount = parseFloat($(this).val()).toFixed(2);
                $(this).val(formatamount);
                calculateotherfunds();
            });

            function calculateotherfunds() {
                totalamount = 0;
                $(".appliedamount").each(function (index) {
                    amount = $(this).val();
                    if (amount != '') {
                        totalamount += parseFloat(amount);
                    }
                });
                $("#otherfundingapplied").text(totalamount.toFixed(2));

                totalamount = 0;
                $(".grantedamount").each(function (index) {
                    amount = $(this).val();
                    if (amount != '') {
                        totalamount += parseFloat(amount);
                    }
                });
                $("#otherfundinggranted").text(totalamount.toFixed(2));
            }

        });



    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_organisationname">Name of organisation</label>
        <div class="col-sm-8">
            <input id="tb_organisationname" name="tb_organisationname" type="text" class="form-control" required />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_physicaladdress">Physical address</label>
        <div class="col-sm-8">
            <span id="span_physicaladdress">Address lookup mode (preferred)</span> <a href="javascript:void(0);" id="cb_physicaladdress" class="addressformat">Change</a><textarea id="tb_physicaladdress" name="tb_physicaladdress" class="form-control autoaddress" rows="4"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_postaladdress">Postal address (if different)</label>
        <div class="col-sm-8">
            <span id="span_postaladdress">Address lookup mode (preferred)</span> <a href="javascript:void(0);" id="cb_postaladdress" class="addressformat">Change</a><textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control autoaddress" rows="4"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactname1">First Contact Person</label>
        <div class="col-sm-8">
            <input id="tb_contactname1" name="tb_contactname1" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactposition1">Position in the organisation</label>
        <div class="col-sm-8">
            <input id="tb_contactposition1" name="tb_contactposition1" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactphonemobile1">Mobile phone</label>
        <div class="col-sm-8">
            <input id="tb_contactphonemobile1" name="tb_contactphonemobile1" type="email" class="form-control phone" placeholder="eg: 027 123456..." />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactphonehome1">Home phone</label>
        <div class="col-sm-8">
            <input id="tb_contactphonehome1" name="tb_contactphonehome1" type="email" class="form-control phone" placeholder="eg: 06 1234567 or 027 123456..." />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactphonework1">Work phone</label>
        <div class="col-sm-8">
            <input id="tb_contactphonework1" name="tb_contactphonework1" type="email" class="form-control phone" placeholder="eg: 06 1234567 or 027 123456..." />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactemailaddress1">Email address</label>
        <div class="col-sm-8">
            <input id="tb_contactemailaddress1" name="tb_contactemailaddress1" type="email" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactemailaddressconfirm1">Please confirm your email address</label>
        <div class="col-sm-8">
            <input id="tb_contactemailaddressconfirm1" name="tb_contactemailaddressconfirm1" type="email" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactname2">Second Contact Person</label>
        <div class="col-sm-8">
            <input id="tb_contactname2" name="tb_contactname2" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactposition2">Position in the organisation</label>
        <div class="col-sm-8">
            <input id="tb_contactposition2" name="tb_contactposition2" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactphonemobile2">Mobile phone</label>
        <div class="col-sm-8">
            <input id="tb_contactphonemobile2" name="tb_contactphonemobile2" type="email" class="form-control phone" placeholder="eg: 027 123456..." />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactphonehome2">Home phone</label>
        <div class="col-sm-8">
            <input id="tb_contactphonehome2" name="tb_contactphonehome2" type="email" class="form-control phone" placeholder="eg: 06 1234567 or 027 123456..." />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactphonework2">Work phone</label>
        <div class="col-sm-8">
            <input id="tb_contactphonework2" name="tb_contactphonework2" type="email" class="form-control phone" placeholder="eg: 06 1234567 or 027 123456..." />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactemailaddress2">Email address</label>
        <div class="col-sm-8">
            <input id="tb_contactemailaddress2" name="tb_contactemailaddress2" type="email" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactemailaddressconfirm2">Please confirm your email address</label>
        <div class="col-sm-8">
            <input id="tb_contactemailaddressconfirm2" name="tb_contactemailaddressconfirm2" type="email" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_purpose">What is the main purpose of your organisation</label>
        <div class="col-sm-8">
            <textarea id="tb_purpose" name="tb_purpose" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_gstnumber">If your organisation is registered for GST, please supply your GST number</label>
        <div class="col-sm-8">
            <input id="tb_gstnumber" name="tb_gstnumber" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_yearestablished">Year organisation established</label>
        <div class="col-sm-8">
            <input id="tb_yearestablished" name="tb_yearestablished" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_type">Organisation type</label>
        <div class="col-sm-8">
            <select id="dd_type" name="dd_type" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(type, "","None") %></select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_othertype">Please state</label>
        <div class="col-sm-8">
            <input id="tb_othertype" name="tb_othertype" type="text" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityreference">If your organisation is a registered charity please provide your charitable reference number</label>
        <div class="col-sm-8">
            <input id="tb_charityreference" name="tb_charityreference" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_projectdetails">Project details</label>
        <div class="col-sm-8">
            <textarea id="tb_projectdetails" name="tb_projectdetails" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_projectfiles">Upload supporting project files</label>
        <div class="col-sm-8">
            <input id="fu_projectfiles" name="fu_projectfiles" type="file" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_nofunding">What would happen to your project if you do not receive any Council funding?</label>
        <div class="col-sm-8">
            <textarea id="tb_nofunding" name="tb_nofunding" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_partfunding">What would happen to your project if you only receive some of the funding you have requested from the Council?</label>
        <div class="col-sm-8">
            <textarea id="tb_partfunding" name="tb_partfunding" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>




    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">Please provide details of similar services</label>
        <div class="col-sm-8">


            <a href="javascript:void(0);" class="addsimilarservice" id="addsimilarservice" data-footer="0">Add</a>
            <div class="table-responsive table-bordered">
                <table class="table" id="table_similarservice">
                    <thead>
                        <tr>
                            <th class="col-md-2">Service</th>
                            <th class="col-md-2">How do they differ?</th>
                            <th class="col-md-1">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_dates">If you were successful with obtaining this waste minimisation funding, when would your project start and would it have a finish date?</label>
        <div class="col-sm-8">
            <textarea id="tb_dates" name="tb_dates" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_whyfund">Tell us why Council should fund this project</label>
        <div class="col-sm-8">
            <textarea id="tb_whyfund" name="tb_whyfund" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_minimisationgoals">How will this project help meet Whanganui’s waste minimisation goals? (Refer to Council’s Waste Minimisation Fund Policy 2014 and Council’s Waste Management and Minimisation Strategy 2009).</label>
        <div class="col-sm-8">
            <textarea id="tb_minimisationgoals" name="tb_minimisationgoals" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">Expenditure</label>
        <div class="col-sm-8">


            <a href="javascript:void(0);" class="addexpenditure" id="addexpenditure" data-footer="1">Add</a>
            <div class="table-responsive table-bordered">

                <table class="table" id="table_expenditure">
                    <thead>
                        <tr>
                            <th class="col-md-2">Description</th>
                            <th class="col-md-2">Amount</th>
                            <th class="col-md-1">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input id="repeat_expediture_tb_expenditureitem_1" name="repeat_expediture_tb_expenditureitem_1" type="text" class="form-control" required />
                            </td>
                            <td><input id="repeat_expediture_tb_expenditureamount_1" name="repeat_expediture_tb_expenditureamount_1" type="text" class="form-control numeric expenditureamount" required />
</td>
                            <td>Required</td>
                        </tr>
                                                <tr><td colspan="2" id="expendituretotal" style="text-align:right"></td><td></td></tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">Income</label>
        <div class="col-sm-8">
            <a href="javascript:void(0);" class="addincome" id="addincome" data-footer="1">Add</a>
            <div class="table-responsive table-bordered">

                <table class="table" id="table_income">
                    <thead>
                        <tr>
                            <th class="col-md-2">Description</th>
                            <th class="col-md-2">Amount</th>
                            <th class="col-md-1">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <input id="repeat_income_tb_incomeitem_1" name="repeat_income_tb_incomeitem_1" type="text" class="form-control" required />
                            </td>
                            <td><input id="repeat_income_tb_incomeamount_1" name="repeat_income_tb_incomeamount_1" type="text" class="form-control numeric incomeamount" required />
</td>
                            <td>Required</td>
                        </tr>
                        <tr><td colspan="2" id="incometotal" style="text-align:right"></td><td></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_amountappliedfor">Amount applied for</label>
        <div class="col-sm-8">
            <input id="tb_amountappliedfor" name="tb_amountappliedfor" type="text" class="form-control" readonly="readonly" required />
        </div>
    </div>








    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_accounts">Please attach a copy of your most recent approved accounts</label>
        <div class="col-sm-8">
            <input id="fu_accounts" name="fu_accounts" type="file" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_audited">Are your accounts audited</label>
        <div class="col-sm-8">
            <select id="dd_audited" name="dd_audited" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(yesno, "","None") %></select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">Please provide details for any other funds applied to any other organisation</label>
        <div class="col-sm-8">


            <a href="javascript:void(0);" class="addotherfunding" id="addotherfunding" data-footer="1">Add</a>
            <div class="table-responsive table-bordered">
                <table class="table" id="table_otherfunding">
                    <thead>
                        <tr>
                            <th class="col-md-2">Organisation</th>
                            <th class="col-md-2">Outcome</th>
                            <th class="col-md-1">Applied</th>
                            <th class="col-md-1">Received</th>
                            <th class="col-md-1">Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                        <tr><td colspan="3" id="otherfundingapplied" style="text-align:right"></td><td id="otherfundinggranted" style="text-align:right"></td><td></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="repeat_otherfunding_fu_otherfundingevidence_">Evidence</label>
        <div class="col-sm-8">
            <input id="repeat_otherfunding_fu_otherfundingevidence_" name="repeat_otherfunding_fu_otherfundingevidence_" type="file" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_acknowledgment">If funding is approved, how will your organisation acknowledge the Whanganui District Council's assistance?</label>
        <div class="col-sm-8">
            <textarea id="tb_acknowledgment" name="tb_acknowledgment" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_performancemeasures">To receive waste minimisation funding from the Council, your organisation must negotiate performance measurements for this project. Please list the performance measurements you propose.</label>
        <div class="col-sm-8">
            <textarea id="tb_performancemeasures" name="tb_performancemeasures" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_performancereporting">Please advise how your organisation will report on the achievement of the performance measurements.</label>
        <div class="col-sm-8">
            <textarea id="tb_performancereporting" name="tb_performancereporting" class="form-control autoaddress" rows="3" required></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_plan">Please attach a copy of a Development Plan or Business Plan for the Project.</label>
        <div class="col-sm-8">
            <input id="fu_plan" name="fu_plan" type="file" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_declaration">Declaration/Consent Under Privacy Act 1993 I hereby declare that, to the best of my knowledge and belief, the information supplied here on behalf of my organisation is correct, and also consent to Whanganui District Council collecting the personal details provided, and retaining and using these details. I undertake that I have obtained the consent of the other persons to provide these details. I acknowledge my right to have access to this information. This consent is given in accordance with the Privacy Act 1993</label>
        <div class="col-sm-8">
            <select id="dd_declaration" name="dd_declaration" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect(yesno, "","None") %></select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_declarationname">Your name</label>
        <div class="col-sm-8">
            <input id="tb_declarationname" name="tb_declarationname" type="text" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>

    <!-- REPEATER SECTION-->

    <div style="display: <%:none%>">

        <table>
            <tr id="tr_expenditure_">
                            <td>
            <input id="repeat_expediture_tb_expenditureitem_" name="repeat_expediture_tb_expenditureitem_" type="text" class="form-control" required /></td>

                  <td>
            <input id="repeat_expediture_tb_expenditureamount_" name="repeat_expediture_tb_expenditureamount_" type="text" class="form-control numeric expenditureamount" required /></td>

            <td><a href="javascript:void(0)" id="href_deleteexpenditure_" class="deleteexpenditure repeatupdateid">Delete</a></td>
            </tr>
        </table>

                <table>
            <tr id="tr_income_">
                            <td>
            <input id="repeat_income_tb_incomeitem_" name="repeat_income_tb_incomeitem_" type="text" class="form-control" required /></td>

                  <td>
            <input id="repeat_income_tb_incomeamount_" name="repeat_income_tb_incomeamount_" type="text" class="form-control numeric incomeamount" required /></td>

            <td><a href="javascript:void(0)" id="href_deleteincome_" class="deleteincome repeatupdateid">Delete</a></td>
            </tr>
        </table>

        <table>
            <tr id="tr_otherfunding_">
                            <td>

            <input id="repeat_otherfunding_tb_otherfundingroup_" name="repeat_otherfunding_tb_otherfundingroup_" type="text" class="form-control" required />

  </td><td>
  

            <input id="repeat_otherfunding_tb_otherfundingoutcome_" name="repeat_otherfunding_tb_otherfundingoutcome_" type="text" class="form-control" required />

</td><td>

            <input id="repeat_otherfunding_tb_otherfundingamountapplied_" name="repeat_otherfunding_tb_otherfundingamountapplied_" type="text" class="form-control numeric appliedamount" required />

</td><td>
   
            <input id="repeat_otherfunding_tb_otherfundingamountgranted_" name="repeat_otherfunding_tb_otherfundingamountgranted_" type="text" class="form-control numeric grantedamount" required />
 
 </td>
            <td><a href="javascript:void(0)" id="href_deleteotherfunding_" class="deleteotherfunding repeatupdateid">Delete</a></td></tr>
        </table>

        <table>
            <tr id="tr_similarservice_">
                            <td>            <input id="repeat_similarservice_tb_service_" name="repeat_similarservice_tb_service_" type="text" class="form-control" required />
        </td>
<td>            <textarea id="repeat_similarservice_tb_differences_" name="repeat_similarservice_tb_differences_" class="form-control autoaddress" rows="3" required></textarea>
            <td><a href="javascript:void(0)" id="href_deletesimilarservice_" class="deletesimilarservice repeatupdateid">Delete</a></td></tr>
</table>





    <!-- END OF REPEATER SECTION -->

    </div>



</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
