<%@ Page Title="Submission: Proposed Parking Management Plan and Parking Bylaw" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Online.PolicySubmissions.Parking1117._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        table, th, td {
            padding: 15px;
        }
        table.table-bordered {
            border:2px solid black; 
        }
        .tdcenter {
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "Help.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                rules: {
                    tb_emailconfirm: {
                        equalTo: '#tb_emailaddress'
                    },
                    tb_emailaddress: {
                        require_from_group: [1, ".contact-group"]
                    },
                    tb_postaladdress: {
                        require_from_group: [1, ".contact-group"]
                    }
                },
                messages: {
                    tb_emailaddress: 'You must enter EITHER an email address OR a postal address into their respective field',
                    tb_postaladdress: 'You must enter EITHER an email address OR a postal address into their respective field'
                },
                submitHandler: function (form) {
                    if (grecaptcha.getResponse()) {
                        form.submit();
                    } else {
                        $("#dialog-text").attr('title', 'Captca');
                        $("#dialog-text").html("Please confirm you are not a robot to proceed");
                        $("#dialog").dialog();
                    }
                }

            });

            $('#cb_postaladdressformat').click(function () {
                if ($('#span_postaladdressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_postaladdressformat').text('Free format address mode (not preferred)');
                    $("#tb_postaladdress").autocomplete("disable");
                } else {
                    $('#span_postaladdressformat').text('Address lookup mode (preferred)');
                    $("#tb_postaladdress").autocomplete("enable");
                }
            })

            $("#tb_postaladdress").autocomplete({
                source: "../../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_postaladdress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .append("<a>" + item.label + "</a>")
                  .appendTo(ul);
            };

            $("#dd_organisation").change(function () {
                if ($(this).val() == 'Yes') {
                    $("#div_organisation").show();
                } else {
                    $("#div_organisation").hide();
                }

            });

            $("#dd_panel").change(function () {
                if ($(this).val() == 'Yes') {
                    $("#tb_emailaddress").addClass("required");
                    $("#tb_emailaddress").rules("add", "required");
                } else {
                    $("#tb_emailaddress").removeClass("required");
                    $("#tb_emailaddress").rules("remove", "required");
                }

            });


            $("#cb_speak").change(function () {
                if ($(this).is(':checked')) {
                    $("#tb_daytimephonenumber").addClass("required");
                    $("#tb_daytimephonenumber").rules("add", "required");

                } else {
                    $("#tb_daytimephonenumber").removeClass("required");
                    $("#tb_daytimephonenumber").rules("remove", "required");

                }
            });





            $("#cb_ethnicity_6").change(function () {
                if ($(this).is(':checked')) {
                    $("#span_otherethnicity").show();
                } else {
                    $("#span_otherethnicity").hide();
                    $("#tb_otherethnicity").val("");
                }

            });

            /*
            $("#form1").submit(function (e) {
                var captcha_response = grecaptcha.getResponse();
                if (captcha_response.length == 0) {
                    alert('Captcha not correct');
                    e.preventDefault();
                }
              });
              */

            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready


    </script>

    <script src='https://www.google.com/recaptcha/api.js'></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string selected;
        string none = "none";
    %>

    <div id="dialog" title="">
        <p><span id="dialog-text"></span></p>
    </div>

    <!--<a id="pagehelp">        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" alt="Help" title="Click on me for specific help on this page." /></a>-->

    <h1>Submission: Proposed Parking Management Plan and Parking Bylaw
    </h1>

    <div class="panel panel-danger">
        <div class="panel-heading">Privacy statement</div>
        <div class="panel-body">
            <p>Please be aware when providing personal information that this submission form is part of the public consultation process.  As such, this document (including contact details) will be copied and made publicly available. Personal information will be used for the administration of this consultation process and decision-making. All information will be held by the Whanganui District Council, 101 Guyton Street, and submitters have the right to access and correct personal information.</p>
        </div>
    </div>

    <div class="panel panel-danger">
        <div class="panel-heading">Written submisions</div>
        <div class="panel-body">
            <p>Written submissions may be made by downloading the <a href="http://www.whanganui.govt.nz/our-district/have-your-say/proposed-parking-management-plan-parking-bylaw-2017/Documents/3.pdf">form</a>, completing it and posting or delivering it to:  </p>
            <p>
                <b>Proposed Parking Management Plan and Parking Bylaw </b>
                <br />
                Whanganui District Council<br />
                101 Guyton Street<br />
                Whanganui 4500
            </p>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Reference number</label>
        <div class="col-sm-8">
            <%: reference %>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_firstname">
            First name
        </label>
        <div class="col-sm-8">
            <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
        <div class="col-sm-8">
            <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" required />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control contact-group" />
        </div>
    </div>
    <div class="form-group" id="div_emailconfirm">
        <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
        <div class="col-sm-8">
            <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" />
        </div>
    </div>





    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_postaladdressformat">
            Postal address
            <img src="../../Images/questionsmall.png" alt="Help" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_postaladdressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_postaladdressformat">Change</a>
            <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control contact-group" rows="4"></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_daytimephonenumber">Best daytime phone number</label>
        <div class="col-sm-8">
            <input id="tb_daytimephonenumber" placeholder="eg: 027 123456..." name="tb_daytimephonenumber" type="text" class="form-control" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_organisation">
            Are you making this submission on behalf of an organisation?
        </label>
        <div class="col-sm-8">
            <select id="dd_organisation" name="dd_organisation" class="form-control" required>
                <option></option>
                <option>Yes</option>
                <option>No</option>
            </select>
        </div>
    </div>

    <div id="div_organisation" style="display: none">

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_organisationname">Organisation name</label>
            <div class="col-sm-8">
                <input id="tb_organisationname" name="tb_organisationname" type="text" class="form-control" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_organisationrole">Your role</label>
            <div class="col-sm-8">
                <input id="tb_organisationrole" name="tb_organisationrole" type="text" class="form-control" required />
            </div>
        </div>
    </div>


    <br />
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_overall">Parking Management Plan: Overall, do you agree with the contents of the Parking Management Plan?</label>
        <div class="col-sm-8">
            <textarea id="tb_overall" name="tb_overall" class="form-control" rows="4"></textarea>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table-bordered" style="width:100%;">
            <tr>
                <th style="width=50%">PARKING TIME LIMITS</th>
                <th class="tdcenter">P60</th>
                <th class="tdcenter">P90</th>
                <th class="tdcenter">P120</th>
            </tr>
            <tr>
                <td>What is your preferred parking time limit within Victoria Avenue from Ingestre Street to Taupo Quay (pp 3-5 of the statement of proposal (SOP) and figure 1)? </td>
                <td class="tdcenter">
                    <input id="opt_q1_1" name="opt_q1" type="radio" value="P60" />
                </td>
                <td class="tdcenter">
                    <input id="opt_q1_2" name="opt_q1" type="radio" value="P90" />
                </td>

                <td class="tdcenter">
                    <input id="opt_q1_3" name="opt_q1" type="radio" value="P120" /></td>

            </tr>

            <tr>
                <td style="width: 50%">
                    <label class="control-label" for="tb_q1reason">What are your reasons for your preference?</label></td>
                <td colspan="3" style="width: 50%">
                    <textarea id="tb_q1reason" name="tb_q1reason" class="form-control" rows="4" cols="20"></textarea></td>
            </tr>

            <tr>
                <td colspan="4">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/PolicySubmissions/Parking1117/Files/map1.png" class="img-responsive" Style="display: block; width: 100%; height: auto;" AlternateText="Map 1" />
                </td>
            </tr>


        </table>
    </div>

    <!--       <asp:Image ID="Image1x" runat="server" ImageUrl="~/PolicySubmissions/Parking1117/Files/map1.png" class="img-responsive"   AlternateText="Map 1" /> -->

    <br />


    <div class="table-responsive">
        <table class="table-bordered" style="width: 100%;">
            <tr>
                <th style="width=50%">KEY ISSUES</th>
                <th class="tdcenter">Strongly<br />
                    agree</th>
                <th class="tdcenter">Agree</th>
                <th class="tdcenter">Neither<br />
                    agree<br />
                    nor<br />
                    disagree</th>
                <th class="tdcenter">Disagree</th>
                <th class="tdcenter">Strongly<br />
                    disagree</th>
            </tr>
            <tr>
                <td><strong>Retaining parking tariffs.</strong>
                    <br />
                    This would mean parking tariffs for on street parking on Victoria Avenue, Guyton Street and Ridgway Street would be retained (pp 2-4 of SOP).</td>
                <td class="tdcenter">
                    <input id="opt_q2_1" name="opt_q2" type="radio" value="Strongly agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q2_2" name="opt_q2" type="radio" value="Agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q2_3" name="opt_q2" type="radio" value="Neither agree or disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q2_4" name="opt_q2" type="radio" value="Disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q2_5" name="opt_q2" type="radio" value="Strongly disagree" /></td>
            </tr>
            <tr>
                <td style="width: 50%">
                    <label class="control-label" for="tb_q2reason">What are your reasons for your preference?</label></td>
                <td colspan="5" style="width: 50%">
                    <textarea id="tb_q2reason" name="tb_q2reason" class="form-control" rows="4" cols="20"></textarea></td>
            </tr>
            <tr>
                <td><strong>Increasing parking time limits</strong>
                    <br />
                    This would mean parking time limits are increased from 60 minutes to 120 minutes in St Hill Street (between Guyton and Ingestre Street) (pp. 5 &amp; 6 of SOP and figure 2). </td>



                <td class="tdcenter">
                    <input id="opt_q3_1" name="opt_q3" type="radio" value="Strongly agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q3_2" name="opt_q3" type="radio" value="Agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q3_3" name="opt_q3" type="radio" value="Neither agree or disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q3_4" name="opt_q3" type="radio" value="Disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q3_5" name="opt_q3" type="radio" value="Strongly disagree" /></td>
            </tr>
            <tr>
                <td style="width: 50%">
                    <label class="control-label" for="tb_q3reason">What are your reasons for your preference?</label></td>
                <td colspan="5" style="width: 50%">
                    <textarea id="tb_q3reason" name="tb_q3reason" class="form-control" rows="4" cols="20"></textarea></td>
            </tr>

            <tr>
                <td colspan="6">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/PolicySubmissions/Parking1117/Files/map2.png" class="img-responsive" Style="display: block; width: 100%; height: auto;" AlternateText="Map 2" />
                </td>
            </tr>
        </table>
    </div>

    <!-- <asp:Image ID="Image2x" runat="server" ImageUrl="~/PolicySubmissions/Parking1117/Files/map2.png" class="img-responsive" AlternateText="Map 2" /> -->
        <br />

    <div class="table-responsive">
        <table class="table-bordered" style="width: 100%;">
            <tr>
                <th style="width=50%">KEY ISSUES</th>
                <th class="tdcenter">Strongly<br />
                    agree</th>
                <th class="tdcenter">Agree</th>
                <th class="tdcenter">Neither<br />
                    agree<br />
                    nor<br />
                    disagree</th>
                <th class="tdcenter">Disagree</th>
                <th class="tdcenter">Strongly<br />
                    disagree</th>
            </tr>
            <tr>
                <td><strong>Airport parking.</strong>
                    <br />
                    This would mean parking at the airport would be included in the parking management plan and allow Council to enforce time limits (pp 6-8 of SOP).</td>
                <td class="tdcenter">
                    <input id="opt_q4_1" name="opt_q4" type="radio" value="Strongly agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q4_2" name="opt_q4" type="radio" value="Agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q4_3" name="opt_q4" type="radio" value="Neither agree or disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q4_4" name="opt_q4" type="radio" value="Disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q4_5" name="opt_q4" type="radio" value="Strongly disagree" /></td>
            </tr>
            <tr>
                <td style="width: 50%">
                    <label class="control-label" for="tb_q4reason">What are your reasons for your preference?</label></td>
                <td colspan="5" style="width: 50%">
                    <textarea id="tb_q4reason" name="tb_q4reason" class="form-control" rows="4" cols="20"></textarea></td>
            </tr>
<tr>
                <td colspan="6">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/PolicySubmissions/Parking1117/Files/map3.png" class="img-responsive" Style="display: block; width: 100%; height: auto;" AlternateText="Map 3" />
                </td>
            </tr>
        </table>
    </div>

    <!-- <asp:Image ID="Image3x" runat="server" ImageUrl="~/PolicySubmissions/Parking1117/Files/map3.png" class="img-responsive" AlternateText="Map 3" /> -->
        <br />

    <div class="table-responsive">
        <table class="table-bordered" style="width: 100%;">
            <tr>
                <th style="width=50%">KEY ISSUES</th>
                <th class="tdcenter">Strongly<br />
                    agree</th>
                <th class="tdcenter">Agree</th>
                <th class="tdcenter">Neither<br />
                    agree<br />
                    nor<br />
                    disagree</th>
                <th class="tdcenter">Disagree</th>
                <th class="tdcenter">Strongly<br />
                    disagree</th>
            </tr>
            <tr>
                <td><strong>Disabled parking. </strong>
                    <br />
                    This would mean disabled parking spaces in Churton Street and Puriri Street would be included in the parking management plan (pp 6-8 of SOP).</td>
                <td class="tdcenter">
                    <input id="opt_q5_1" name="opt_q5" type="radio" value="Strongly agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q5_2" name="opt_q5" type="radio" value="Agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q5_3" name="opt_q5" type="radio" value="Neither agree or disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q5_4" name="opt_q5" type="radio" value="Disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q5_5" name="opt_q5" type="radio" value="Strongly disagree" /></td>
            </tr>
            <tr>
                <td style="width: 50%">
                    <label class="control-label" for="tb_q5reason">What are your reasons for your preference?</label></td>
                <td colspan="5" style="width: 50%">
                    <textarea id="tb_q5reason" name="tb_q5reason" class="form-control" rows="4" cols="20"></textarea></td>
            </tr>
            <tr>
                <td><strong>Parking exemptions:</strong>
                    <br />
                    This would mean the parking exemptions for mobility card holders, super gold card holders, trade persons and special event permits would be retained (pg 9 of SOP).</td>



                <td class="tdcenter">
                    <input id="opt_q6_1" name="opt_q6" type="radio" value="Strongly agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q6_2" name="opt_q6" type="radio" value="Agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q6_3" name="opt_q6" type="radio" value="Neither agree or disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q6_4" name="opt_q6" type="radio" value="Disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q6_5" name="opt_q6" type="radio" value="Strongly disagree" /></td>
            </tr>
            <tr>
                <td style="width: 50%">
                    <label class="control-label" for="tb_q6reason">What are your reasons for your preference?</label></td>
                <td colspan="5" style="width: 50%">
                    <textarea id="tb_q6reason" name="tb_q6reason" class="form-control" rows="4" cols="20"></textarea></td>
            </tr>
            <tr>
                <td><strong>Parking and stopping. </strong>
                    <br />
                    This would mean the existing parking and stopping rules outside of the town centre would be retained (pp 10 &amp; 11 of SOP).</td>



                <td class="tdcenter">
                    <input id="opt_q7_1" name="opt_q7" type="radio" value="Strongly agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q7_2" name="opt_q7" type="radio" value="Agree" /></td>
                <td class="tdcenter">
                    <input id="opt_q7_3" name="opt_q7" type="radio" value="Neither agree or disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q7_4" name="opt_q7" type="radio" value="Disagree" /></td>
                <td class="tdcenter">
                    <input id="opt_q7_5" name="opt_q7" type="radio" value="Strongly disagree" /></td>
            </tr>
            <tr>
                <td style="width: 50%">
                    <label class="control-label" for="tb_q7reason">What are your reasons for your preference?</label></td>
                <td colspan="5" style="width: 50%">
                    <textarea id="tb_q7reason" name="tb_q7reason" class="form-control" rows="4" cols="20"></textarea></td>
            </tr>
        </table>
    </div>


    <br />

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_furthercomments">Please feel free to add further comments</label>
        <div class="col-sm-8">
            <textarea id="tb_furthercomments" name="tb_furthercomments" class="form-control" rows="4"></textarea>
        </div>
    </div>

    <div class="form-group">

        <label class="control-label col-sm-4" for="fu_documents">
            Please upload any other documents that you would like to submit.
                        <img src="../../Images/questionsmall.png" alt="Help" title="The Whanganui District Council can accept Word, Excel, PDF, and most image files." />

        </label>
        <div class="col-sm-8">
            <asp:FileUpload ID="fu_documents" runat="server" AllowMultiple="True" />
        </div>
    </div>



    <div class="panel panel-danger">
        <div class="panel-heading">Oral submissions</div>
        <div class="panel-body">
            <p>
                If you wish to speak to Council in support of your written submission please tick the box below.
            </p>
            <p>
                <input type="checkbox" id="cb_speak" name="cb_speak" value="Yes" />
                Yes, I would like to speak in support of my submission (please ensure you have completed the details above, including contact phone number)<br />
                Note: Submissions will be heard on <b>Thursday 23 November 2017</b>. If you have indicated that you wish to speak on your submission we will contact you to arrange a time.
            </p>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_panel">
            Would you be interested in being involved in further consultation opportunities with Council?<br />
            (You will need to supply your email address.)
        </label>
        <div class="col-sm-8">
            <select id="dd_panel" name="dd_panel" class="form-control" required>
                <option></option>
                <option>Yes</option>
                <option>No</option>
            </select>
        </div>
    </div>

    <div class="panel panel-danger">
        <div class="panel-heading">About you</div>
        <div class="panel-body">
            <p>
                The following questions are optional.
            </p>

        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_previoussubmission">
            Have you submitted to the Whanganui District Council before?
        </label>
        <div class="col-sm-8">
            <select id="dd_previoussubmission" name="dd_previoussubmission" class="form-control">
                <option></option>
                <option>Yes</option>
                <option>No</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
        <div class="col-sm-8">
            <select id="dd_gender" name="dd_gender" class="form-control">
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(genders, "", "None")%>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_agegroup">Age</label>
        <div class="col-sm-8">
            <select id="dd_agegroup" name="dd_agegroup" class="form-control">
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(agegroups, "", "None")%>
            </select>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_ethnicity">Ethnicity</label>
        <div class="col-sm-8">
            <input type="checkbox" id="cb_ethnicity_1" name="cb_ethnicity" value="NZ European" />
            NZ European<br />
            <input type="checkbox" id="cb_ethnicity_2" name="cb_ethnicity" value="Maori" />
            Maori<br />
            <input type="checkbox" id="cb_ethnicity_3" name="cb_ethnicity" value="Asian" />
            Asian<br />
            <input type="checkbox" id="cb_ethnicity_4" name="cb_ethnicity" value="Pacific Peoples" />
            Pacific Peoples<br />
            <input type="checkbox" id="cb_ethnicity_5" name="cb_ethnicity" value="Middle Eastern/Latin American/African" />
            Middle Eastern/Latin American/African<br />
            <input type="checkbox" id="cb_ethnicity_6" name="cb_ethnicity" value="Other" />
            Other<span id="span_otherethnicity" style="display: none">, please state:
                <input type="text" id="tb_otherethnicity" name="tb_otherethnicity" class="form-control" /></span>


        </div>
    </div>

    <%
        if (HttpContext.Current.Request.Url.AbsolutePath.ToLower().Substring(0, 8) == "/online/")
        {
    %>

    <!--CAPTCHA-->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8 g-recaptcha" data-sitekey="6LekmjAUAAAAAKegUSV-1igHCkq4flUMTcSu_6a5">
        </div>
    </div>
    <%
        }
    %>

    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
