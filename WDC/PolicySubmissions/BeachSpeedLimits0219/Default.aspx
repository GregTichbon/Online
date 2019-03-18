<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Online.PolicySubmissions.BeachSpeedLimits0219.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        table, th, td {
            padding: 15px;
        }

            table.table-bordered {
                border: 2px solid black;
            }

        .tdcenter {
            text-align: center;
        }

        i {
            font-style: italic;
            font-weight: 700;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "Help.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });
            $("#xxx").colorbox({ href: "Help.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            <% if (administration == "True")
        {   %>
            $('#form1').validate().currentForm = '';
            <% }
        else
        { %>
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
                    if (grecaptcha.getResponse() != '') {
                        form.submit();
                    } else {
                        $("#dialog-text").attr('title', 'Captcha');
                        $("#dialog-text").html("Please confirm you are not a robot to proceed");
                        $("#dialog").dialog();
                    }
                }


            });
                                    <% }%>
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

            $("#dd_changeofpurpose").change(function () {
                if ($(this).val() == 'No') {
                    $("#div_changeofpurpose").show();
                } else {
                    $("#tb_changeofpurpose").val("");
                    $("#div_changeofpurpose").hide();
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
            <% if (administration == "")
        {
            Response.Write(Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false));
        }%>

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
    <h1><%:title %>

    </h1>

    <div class="panel panel-danger">
        <div class="panel-heading">Privacy statement</div>
        <div class="panel-body">
            <p>Please be aware when providing personal information that this submission form is part of the public consultation process.  As such, this document (including contact details) will be copied and made publicly available. Personal information will be used for the administration of this consultation process and decision-making. All information will be held by the Whanganui District Council, 101 Guyton Street, and submitters have the right to access and correct personal information.</p>
        </div>
    </div>

    <div class="panel panel-danger" style="display: none">
        <div class="panel-heading">Written submisions</div>
        <div class="panel-body">
            <%: form%>
            <p>
                <b><%: shorttitle %></b>
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

    <asp:literal id="lit_questions1" runat="server"></asp:literal>
    <br />
    <br />




    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_furthercomments">Please use this space to add any further comments.</label>
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
            <asp:fileupload id="fu_documents" runat="server" allowmultiple="True" />
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
                <!--Note: Submissions will be heard on <b><%: submissionshearing %></b>. If you have indicated that you wish to speak on your submission we will contact you to arrange a time.-->
                <b>Note</b>: A hearing may be held to hear submissions on a date to be advised. If you have indicated that you wish to speak on your submission we will contact you to arrange a time.

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
        if (HttpContext.Current.Request.Url.AbsolutePath.ToLower().Substring(0, 8) == "/online/" && administration == "")
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
            <asp:button id="btn_submit" runat="server" onclick="btn_submit_Click" class="btn btn-info" text="Submit" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
