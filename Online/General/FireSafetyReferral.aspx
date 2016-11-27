<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FireSafetyReferral.aspx.cs" Inherits="Online.General.FireSafetyReferral" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {


            /*
            var fieldsdiv = $("<div>", { id: "fields" });
            $("body").append(fieldsdiv);

            var x = '';
            $('input, textarea, select').each(function (index) {
                x = x + '<br>' + '@pre' + this.id + '@post';

            })
            $('#fields').html(x);
            */


            //if ($.url().param('populate') == 'True') {
            /*
                $('input, textarea').each(function () {
                    if (this.id.substring(0, 2) != '__') {
                        thetype = this.type;
                        switch (thetype) {
                            case 'email':
                                break;
                            case 'checkbox':
                                break;
                            case 'submit':
                                break;
                            default:
                                this.value = this.id;
                        }
                    }
                })
                */
            //}

            $("#pagehelp").colorbox({ href: "FireSafetyReferral.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $(".submit").click(function () {
                $(".collapse").collapse("show");  //to force validation of hidden fields
            })

            $("#form1").validate({
                groups: {
                    contact1phone: "tb_contact1mobilephone tb_contact1homephone tb_contact1workphone",
                    contact2phone: "tb_contact2mobilephone tb_contact2homephone tb_contact2workphone",
                    agencycontact1phone: "tb_agencycontact1mobilephone tb_agencycontact1officephone",
                    agencycontact2phone: "tb_agencycontact2mobilephone tb_agencycontact2officephone",
                    referrerphone: "tb_referrermobilephone tb_referrerhomephone tb_referrerworkphone"
                },
                rules: {
                    tb_contact1emailaddressconfirm: {
                        equalTo: '#tb_contact1emailaddress',
                        required: {
                            depends: function () { return $("#tb_contact1emailaddress").val() != "" }
                        }
                    },
                    tb_contact1mobilephone: {
                        require_from_group: [1, ".contact1phone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_contact1homephone: {
                        require_from_group: [1, ".contact1phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_contact1workphone: {
                        require_from_group: [1, ".contact1phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },

                    tb_contact2emailaddressconfirm: {
                        equalTo: '#tb_contact2emailaddress',
                        required: {
                            depends: function () { return $("#tb_contact2emailaddress").val() != "" }
                        }
                    },
                    tb_contact2mobilephone: {
                        require_from_group: [1, ".contact2phone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_contact2homephone: {
                        require_from_group: [1, ".contact2phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_contact2workphone: {
                        require_from_group: [1, ".contact2phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },


                    tb_agencyemailaddressconfirm: {
                        equalTo: '#tb_agencyemailaddress',
                        required: {
                            depends: function () { return $("#tb_agencyemailaddress").val() != "" }
                        }
                    },

                    tb_agencyphone: {
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },

                    tb_agencycontact1emailaddressconfirm: {
                        equalTo: '#tb_agencycontact1emailaddress'
                    },


                    tb_agencycontact1mobilephone: {
                        require_from_group: [1, ".agencycontact1phone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_agencycontact1officephone: {
                        require_from_group: [1, ".agencycontact1phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },


                    tb_agencycontact2mobilephone: {
                        require_from_group: [1, ".agencycontact2phone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_agencycontact2officephone: {
                        require_from_group: [1, ".agencycontact2phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },

                    tb_agencycontact2emailaddressconfirm: {
                        equalTo: '#tb_agencycontact2emailaddress',
                        required: {
                            depends: function () { return $("#tb_agencycontact2emailaddress").val() != "" }
                        }
                    },

                    tb_referreremailaddressconfirm: {
                        equalTo: '#tb_referreremailaddress'
                    },
                    tb_referrermobilephone: {
                        require_from_group: [1, ".referrerphone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_referrerhomephone: {
                        require_from_group: [1, ".referrerphone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_referrerworkphone: {
                        require_from_group: [1, ".referrerphone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    }





                },
                messages: {
                    tb_contact1emailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_contact1mobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_contact1homephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_contact1workphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_contact2emailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_contact2mobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_contact2homephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_contact2workphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },

                    tb_agencyemailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_agencyphone: {
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },



                    tb_agencycontact1emailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },

                    tb_agencycontact1mobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_agencycontact1officephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },




                    tb_agencycontact2emailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },

                    tb_agencycontact2mobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_agencycontact2officephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },

                    tb_referreremailaddressconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_referrermobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_referrerhomephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_referrerworkphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }

                }
            });

            $('#cb_addressformat').click(function () {
                if ($('#span_addressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_addressformat').text('Free format address mode (not preferred)');
                    $("#tb_address").autocomplete("disable");
                } else {
                    $('#span_addressformat').text('Address lookup mode (preferred)');
                    $("#tb_address").autocomplete("enable");
                }
            })



            $("#tb_address").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_address").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })


            $('#cb_agencyaddressformat').click(function () {
                if ($('#span_agencyaddressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_agencyaddressformat').text('Free format address mode (not preferred)');
                    $("#tb_agencyaddress").autocomplete("disable");
                } else {
                    $('#span_agencyaddressformat').text('Address lookup mode (preferred)');
                    $("#tb_agencyaddress").autocomplete("enable");
                }
            })



            $("#tb_agencyaddress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_agencyaddress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .append("<a>" + item.label + "</a>")
                  .appendTo(ul);
            };

            $('#dd_referraltype').change(function () {

                selectedvalue = $('#dd_referraltype :selected').text();
                //$('#hf_type').val(selectedvalue);
                switch (selectedvalue) {
                    case 'Agency':
                        $('#div_agency').show();
                        $('#div_individual').hide();
                        $('#span_fireconsent').text("Has your agency gained consent from the household representatives to allow a Whanganui Fire Service representative to visit?")
                        $('#span_civildefenceconsent').text("Has your agency gained consent from the household representatives to allow contacts to be entered into the Civil Defence emergency database to be used to send emergency messages in times of civil defence emergencies?")
                        $('#div_consent').show();
                        $('#span_consent').hide();
                        break;
                    case 'Self':
                        $('#div_agency').hide();
                        $('#div_individual').hide();
                        $('#span_fireconsent').text("Do you give consent to allow a Whanganui Fire Service representative to visit? and for the household information and contacts to be entered into the Civil Defence emergency database to be used to send emergency messages in times of civil defence emergencies?")
                        $('#span_civildefenceconsent').text("Do you give consent to allow a Whanganui Fire Service representative to visit? and for the household information and contacts to be entered into the Civil Defence emergency database to be used to send emergency messages in times of civil defence emergencies?")
                        $('#div_consent').show();
                        $('#span_consent').hide();
                        break;
                    case 'Other Individual':
                        $('#div_individual').show();
                        $('#div_agency').hide();
                        $('#span_fireconsent').text("Have you gained consent from the household representatives to allow a Whanganui Fire Service representative to visit?")
                        $('#span_civildefenceconsent').text("Have you gained consent from the household representatives to allow contacts to be entered into the Civil Defence emergency database to be used to send emergency messages in times of civil defence emergencies?")
                        $('#div_consent').show();
                        $('#span_consent').hide();
                        break;
                    case '':
                        $('#div_individual').hide();
                        $('#div_agency').hide();
                        $('#div_consent').hide();
                        $('#span_consent').show();

                        break;
                }
            });

            $('#tb_contact1emailaddress').keyup(function () {
                if (this.value == '') {
                    $('#tb_contact1emailaddressconfirm').removeClass('dependantrequired')
                } else {
                    $('#tb_contact1emailaddressconfirm').addClass('dependantrequired')
                }
            });

            $('#cb_secondcontact').change(function () {
                if (this.checked) {
                    $('#div_secondcontact').show();
                    //                    $('#div_secondcontact .optionalgrouprequired').addClass('dependantrequired');
                } else {
                    $('#div_secondcontact').hide();
                    //                    $('#div_secondcontact .optionalgrouprequired').removeClass('dependantrequired');
                }
            });

            $('#tb_contact2emailaddress').keyup(function () {
                if (this.value == '') {
                    $('#tb_contact2emailaddressconfirm').removeClass('dependantrequired')
                } else {
                    $('#tb_contact2emailaddressconfirm').addClass('dependantrequired')
                }

            });

            $('#tb_agencyemailaddress').keyup(function () {
                if (this.value == '') {
                    $('#tb_agencyemailaddressconfirm').removeClass('dependantrequired')
                } else {
                    $('#tb_agencyemailaddressconfirm').addClass('dependantrequired')
                }

            });

            $('#tb_agencycontact1emailaddress').keyup(function () {
                if (this.value == '') {
                    $('#tb_agencycontact1emailaddressconfirm').removeClass('dependantrequired')
                } else {
                    $('#tb_agencycontact1emailaddressconfirm').addClass('dependantrequired')
                }
            });

            $('#cb_secondagencycontact').change(function () {
                if (this.checked) {
                    $('#div_secondagencycontact').show();
                    //                    $('#div_secondagencycontact .optionalgrouprequired').addClass('dependantrequired');

                } else {
                    $('#div_secondagencycontact').hide();
                    //                    $('#div_secondagencycontact .optionalgrouprequired').removeClass('dependantrequired');
                }
            });

            $('#tb_agencycontact2emailaddress').keyup(function () {
                if (this.value == '') {
                    $('#tb_agencycontact2emailaddressconfirm').removeClass('dependantrequired')
                } else {
                    $('#tb_agencycontact2emailaddressconfirm').addClass('dependantrequired')
                }
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Fire Safety Referral
    </h1>



    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_addressformat">
            Household address
        <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." />
        </label>
        <div class="col-sm-8">
            <span id="span_addressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_addressformat">Change</a>
            <textarea id="tb_address" name="tb_address" class="form-control" rows="4" required></textarea>
        </div>
    </div>

    <!-- Contact Person 1 -->

    <!-- Accordian header start -->

    <div class="panel-group">
        <div class="panel panel-default">
            <div class="panel-heading">
                <a data-toggle="collapse" href="#collapse_contactperson1">
                    <h4 class="panel-title">Contact Person 1 (from the household)</h4>
                </a>
            </div>
            <div id="collapse_contactperson1" class="panel-collapse collapse">
                <div class="panel-body">

                    <!-- Accordian header end -->

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1surname">Surname</label>
                        <div class="col-sm-8">
                            <input id="tb_contact1surname" name="tb_contact1surname" type="text" class="form-control" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1firstname">First name</label>
                        <div class="col-sm-8">
                            <input id="tb_contact1firstname" name="tb_contact1firstname" type="text" class="form-control" required />
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1emailaddress">Email address</label>
                        <div class="col-sm-8">
                            <input id="tb_contact1emailaddress" name="tb_contact1emailaddress" type="email" class="form-control inhibitcutcopypaste" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1emailaddressconfirm">Please re-type the email address</label>
                        <div class="col-sm-8">
                            <input id="tb_contact1emailaddressconfirm" name="tb_contact1emailaddressconfirm" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" />
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1mobilephone">
                            Mobile phone
            <img src="../Images/questionsmall.png" title="Please provide at least one phone number.  Use the correct format.  Leave the field blank where there is not an applicable phone number." /></label>
                        <div class="col-sm-8">
                            <input id="tb_contact1mobilephone" placeholder="eg: 027 123456..." name="tb_contact1mobilephone" type="text" class="form-control contact1phone-group" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1homephone">Home phone</label>
                        <div class="col-sm-8">
                            <input id="tb_contact1homephone" name="tb_contact1homephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control contact1phone-group" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1workphone">Work phone</label>
                        <div class="col-sm-8">
                            <input id="tb_contact1workphone" name="tb_contact1workphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control contact1phone-group" />
                        </div>
                    </div>
                    <!--
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_contact1gender">Gender</label>
                        <div class="col-sm-8">
                            <select id="dd_contact1gender" name="dd_contact1gender" class="form-control" required>
                                <option></option>
                                <%
                                    foreach (string gender in genders)
                                    {
                                        Response.Write("<option>" + gender + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1age">
                            Age
            <img src="../Images/questionsmall.png" title="Providing an age may allow the fire service to provide additional services" /></label>
                        <div class="col-sm-8">
                            <input id="tb_contact1age" name="tb_contact1age" type="text" class="form-control" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1ethnicity">Ethnicity</label>
                        <div class="col-sm-8">
                            <input id="tb_contact1ethnicity" name="tb_contact1ethnicity" type="text" class="form-control" />
                        </div>
                    </div>
                    -->
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_contact1role">
                            Role within household
            <img src="../Images/questionsmall.png" title="Parent, Grandparent, Support worker" /></label>
                        <div class="col-sm-8">
                            <input id="tb_contact1role" name="tb_contact1role" type="text" class="form-control" required />
                        </div>
                    </div>

                    <!-- Accordian footer start -->
                </div>
            </div>
        </div>
    </div>
    <!-- Accordian footer end -->

    <!-- Contact Person 2 -->

    <!-- Accordian header start -->

    <div class="panel-group">
        <div class="panel panel-default">
            <div class="panel-heading">

                <a data-toggle="collapse" href="#collapse_contactperson2">
                    <h4 class="panel-title">Contact Person 2 (from the household) - Optional</h4>
                </a>

            </div>
            <div id="collapse_contactperson2" class="panel-collapse collapse">
                <div class="panel-body">

                    <!-- Accordian header end -->

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="cb_secondcontact">There is a second contact</label>
                        <div class="col-sm-8">
                            <input id="cb_secondcontact" name="cb_secondcontact" type="checkbox" value="True" />
                        </div>
                    </div>

                    <div id="div_secondcontact" style="display: <%: none%>">

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2surname">Surname</label>
                            <div class="col-sm-8">
                                <input id="tb_contact2surname" name="tb_contact2surname" type="text" class="form-control" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2firstname">First name</label>
                            <div class="col-sm-8">
                                <input id="tb_contact2firstname" name="tb_contact2firstname" type="text" class="form-control" required />
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2emailaddress">Email address</label>
                            <div class="col-sm-8">
                                <input id="tb_contact2emailaddress" name="tb_contact2emailaddress" type="email" class="form-control inhibitcutcopypaste" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2emailaddressconfirm">Please re-type the email address</label>
                            <div class="col-sm-8">
                                <input id="tb_contact2emailaddressconfirm" name="tb_contact2emailaddressconfirm" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" />
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2mobilephone">
                                Mobile phone
            <img src="../Images/questionsmall.png" title="Please provide at least one phone number.  Use the correct format.  Leave the field blank where there is not an applicable phone number." /></label>
                            <div class="col-sm-8">
                                <input id="tb_contact2mobilephone" placeholder="eg: 027 123456..." name="tb_contact2mobilephone" type="text" class="form-control contact2phone-group" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2homephone">Home phone</label>
                            <div class="col-sm-8">
                                <input id="tb_contact2homephone" name="tb_contact2homephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control contact2phone-group" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2workphone">Work phone</label>
                            <div class="col-sm-8">
                                <input id="tb_contact2workphone" name="tb_contact2workphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control contact2phone-group" />
                            </div>
                        </div>
                                                <!--
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="dd_contact2gender">Gender</label>
                            <div class="col-sm-8">
                                <select id="dd_contact2gender" name="dd_contact2gender" class="form-control" required>
                                    <option></option>
                                    <%
                                        foreach (string gender in genders)
                                        {
                                            Response.Write("<option>" + gender + "</option>");
                                        }
                                    %>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2age">
                                Age
            <img src="../Images/questionsmall.png" title="Providing an age may allow the fire service to provide additional services" /></label>
                            <div class="col-sm-8">
                                <input id="tb_contact2age" name="tb_contact2age" type="text" class="form-control" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2ethnicity">Ethnicity</label>
                            <div class="col-sm-8">
                                <input id="tb_contact2ethnicity" name="tb_contact2ethnicity" type="text" class="form-control" />
                            </div>
                        </div>
                        -->
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_contact2role">
                                Role within household
            <img src="../Images/questionsmall.png" title="Parent, Grandparent, Support worker" /></label>
                            <div class="col-sm-8">
                                <input id="tb_contact2role" name="tb_contact2role" type="text" class="form-control" required />
                            </div>
                        </div>
                    </div>
                    <!-- Accordian footer start -->

                </div>
            </div>
        </div>
    </div>






    <!-- Accordian footer end -->

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_referraltype">
            Type of referral
            <img src="../Images/questionsmall.png" title="Agencies, other individuals, or residents themselves (Self) may make referrals." /></label>
        <div class="col-sm-8">
            <select id="dd_referraltype" name="dd_referraltype" class="form-control" required>
                <option></option>
                <option>Agency</option>
                <option>Self</option>
                <option>Other Individual</option>

            </select>
        </div>
    </div>


    <!--  Agency -->

    <div id="div_agency" style="display: <%: none %>">

        <!-- Accordian header start -->

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#collapse_agency">
                        <h4 class="panel-title">Agency Details</h4>
                    </a>
                </div>
                <div id="collapse_agency" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencyname">Agency name</label>
                            <div class="col-sm-8">
                                <input id="tb_agencyname" name="tb_agencyname" type="text" class="form-control" required />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="cb_agencyaddressformat">
                                Physical address
        <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." />
                            </label>
                            <div class="col-sm-8">
                                <span id="span_agencyaddressformat">Address lookup mode (preferred)</span>
                                <a href="javascript:void(0);" id="cb_agencyaddressformat">Change</a>
                                <textarea id="tb_agencyaddress" name="tb_agencyaddress" class="form-control" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencyphone">Office phone</label>
                            <div class="col-sm-8">
                                <input id="tb_agencyphone" name="tb_agencyphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control" required />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencyemailaddress">Email address</label>
                            <div class="col-sm-8">
                                <input id="tb_agencyemailaddress" name="tb_agencyemailaddress" type="email" class="form-control inhibitcutcopypaste" value="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencyemailaddressconfirm">Please re-type the email address</label>
                            <div class="col-sm-8">
                                <input id="tb_agencyemailaddressconfirm" name="tb_agencyemailaddressconfirm" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" />
                            </div>
                        </div>
                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Accordian footer end -->
        <!--Agency Contact 1 -->

        <!-- Accordian header start -->

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#collapse_agencycontact1">
                        <h4 class="panel-title">Agency Contact 1</h4>
                    </a>
                </div>
                <div id="collapse_agencycontact1" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->


                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencycontact1surname">Surname</label>
                            <div class="col-sm-8">
                                <input id="tb_agencycontact1surname" name="tb_agencycontact1surname" type="text" class="form-control" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_firstname1">First name</label>
                            <div class="col-sm-8">
                                <input id="tb_agencycontact1firstname" name="tb_agencycontact1firstname" type="text" class="form-control" required />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencycontact1emailaddress">Email address</label>
                            <div class="col-sm-8">
                                <input id="tb_agencycontact1emailaddress" name="tb_agencycontact1emailaddress" type="email" class="form-control inhibitcutcopypaste" required />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencycontact1emailaddressconfirm">Please re-type the email address</label>
                            <div class="col-sm-8">
                                <input id="tb_agencycontact1emailaddressconfirm" name="tb_agencycontact1emailaddressconfirm" type="email" class="form-control inhibitcutcopypaste" required autocomplete="off" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencycontact1mobilephone">
                                Mobile phone
                <img src="../Images/questionsmall.png" title="Please provide at least one phone number.  Use the correct format.  Leave the field blank where there is not an applicable phone number." /></label>
                            <div class="col-sm-8">
                                <input id="tb_agencycontact1mobilephone" placeholder="eg: 027 123456..." name="tb_agencycontact1mobilephone" type="text" class="form-control agencycontact1phone-group" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencycontact1officephone">Office phone</label>
                            <div class="col-sm-8">
                                <input id="tb_agencycontact1officephone" name="tb_agencycontact1officephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control agencycontact1phone-group" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_agencycontact1role">Role / Relationship</label>
                            <div class="col-sm-8">
                                <input id="tb_agencycontact1role" name="tb_agencycontact1role" type="text" class="form-control" required />
                            </div>
                        </div>
                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Accordian footer end -->


        <!--Agency Contact 2 -->

        <!-- Accordian header start -->



        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#collapse_agencycontact2">
                        <h4 class="panel-title">Agency Contact 2 - Optional</h4>
                    </a>
                </div>
                <div id="collapse_agencycontact2" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="cb_secondagencycontact">There is a second agency contact</label>
                            <div class="col-sm-8">
                                <input id="cb_secondagencycontact" name="cb_secondagencycontact" type="checkbox" value="True" />
                            </div>
                        </div>

                        <div id="div_secondagencycontact" style="display: <%: none%>">

                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_agencycontact2surname">Surname</label>
                                <div class="col-sm-8">
                                    <input id="tb_agencycontact2surname" name="tb_agencycontact2surname" type="text" class="form-control" required />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_firstname1">First name</label>
                                <div class="col-sm-8">
                                    <input id="tb_agencycontact2firstname" name="tb_agencycontact2firstname" type="text" class="form-control" required />
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_agencycontact2emailaddress">Email address</label>
                                <div class="col-sm-8">
                                    <input id="tb_agencycontact2emailaddress" name="tb_agencycontact2emailaddress" type="email" class="form-control inhibitcutcopypaste" required />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_agencycontact2emailaddressconfirm">Please re-type the email address</label>
                                <div class="col-sm-8">
                                    <input id="tb_agencycontact2emailaddressconfirm" name="tb_agencycontact2emailaddressconfirm" type="email" class="form-control inhibitcutcopypaste" required autocomplete="off" />
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_agencycontact2mobilephone">
                                    Mobile phone
                <img src="../Images/questionsmall.png" title="Please provide at least one phone number.  Use the correct format.  Leave the field blank where there is not an applicable phone number." /></label>
                                <div class="col-sm-8">
                                    <input id="tb_agencycontact2mobilephone" placeholder="eg: 027 123456..." name="tb_agencycontact2mobilephone" type="text" class="form-control agencycontact2phone-group" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_agencycontact2officephone">Office phone</label>
                                <div class="col-sm-8">
                                    <input id="tb_agencycontact2officephone" name="tb_agencycontact2officephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control agencycontact2phone-group" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_agencycontact2role">Role / Relationship</label>
                                <div class="col-sm-8">
                                    <input id="tb_agencycontact2role" name="tb_agencycontact2role" type="text" class="form-control" required />
                                </div>
                            </div>
                        </div>
                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Accordian footer end -->


    </div>

    <!-- Individual referrer -->

    <div id="div_individual" style="display: <%: none %>">
        <!-- Accordian header start -->
        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">


                    <a data-toggle="collapse" href="#collapse_referrer">
                        <h4 class="panel-title">Individual Referrer</h4>
                    </a>
                </div>
                <div id="collapse_referrer" class="panel-collapse collapse">
                    <div class="panel-body">

                        <!-- Accordian header end -->

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referrersurname">Surname</label>
                            <div class="col-sm-8">
                                <input id="tb_referrersurname" name="tb_referrersurname" type="text" class="form-control" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referrerfirstname">First name</label>
                            <div class="col-sm-8">
                                <input id="tb_referrerfirstname" name="tb_referrerfirstname" type="text" class="form-control" required />
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referreremailaddress">Email address</label>
                            <div class="col-sm-8">
                                <input id="tb_referreremailaddress" name="tb_referreremailaddress" type="email" class="form-control inhibitcutcopypaste" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referreremailaddressconfirm">Please re-type the email address</label>
                            <div class="col-sm-8">
                                <input id="tb_referreremailaddressconfirm" name="tb_referreremailaddressconfirm" type="email" class="form-control inhibitcutcopypaste" required autocomplete="off" />
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referrermobilephone">
                                Mobile phone
            <img src="../Images/questionsmall.png" title="Please provide at least one phone number.  Use the correct format.  Leave the field blank where there is not an applicable phone number." /></label>
                            <div class="col-sm-8">
                                <input id="tb_referrermobilephone" placeholder="eg: 027 123456..." name="tb_referrermobilephone" type="text" class="form-control referrerphone-group" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referrerhomephone">Home phone</label>
                            <div class="col-sm-8">
                                <input id="tb_referrerhomephone" name="tb_referrerhomephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control referrerphone-group" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referrerworkphone">Work phone</label>
                            <div class="col-sm-8">
                                <input id="tb_referrerworkphone" name="tb_referrerworkphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control referrerphone-group" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_referrerrole">
                                Relationship / Role
            <img src="../Images/questionsmall.png" title="Relation, friend, neighbour etc" /></label>
                            <div class="col-sm-8">
                                <input id="tb_referrerrole" name="tb_referrerrole" type="text" class="form-control" required />
                            </div>
                        </div>

                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Household Information -->

    <!-- Accordian header start -->

    <div class="panel-group">
        <div class="panel panel-default">
            <div class="panel-heading">
                <a data-toggle="collapse" href="#collapse_householdinformation">
                    <h4 class="panel-title">Household Information</h4>
                </a>

            </div>
            <div id="collapse_householdinformation" class="panel-collapse collapse">
                <div class="panel-body">

                    <!-- Accordian header end -->

                                        <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_smokealarms">What assistance would you like?
                                                    <img src="../Images/questionsmall.png" title="For example, would you like a home fire safety check, some batteries changed, smoke alarms installed, etc" />
        </label>
                        <div class="col-sm-8">
                            <input id="tb_assistance" name="tb_assistance" type="text" class="form-control" required />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_smokealarms">How many smoke alarms are there in the house</label>
                        
                        <div class="col-sm-8">
                            <input id="tb_smokealarms" name="tb_smokealarms" type="text" class="form-control" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_smokealarmschecked">If there are alarms, how often are they checked?</label>
                        <div class="col-sm-8">
                            <input id="tb_smokealarmschecked" name="tb_smokealarmschecked" type="text" class="form-control" required />
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_ownedrented">Is this household owned or rented</label>
                        <div class="col-sm-8">
                            <select id="dd_ownedrented" name="dd_ownedrented" class="form-control" required>
                                <option></option>
                                <option>Owned</option>
                                <option>Rented - Private</option>
                                <option>Rented - Housing NZ</option>

                            </select>
                        </div>

                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_bedrooms">How many bedrooms are there?</label>
                        <div class="col-sm-8">
                            <input id="tb_bedrooms" name="tb_bedrooms" class="form-control" required />
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_people">
                            How many people, in total, live in this place?
                        </label>
                        <div class="col-sm-8">
                            <input id="tb_people" name="tb_people" type="text" class="form-control" required />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_under5">
                            How many under the age of 5?
                        </label>
                        <div class="col-sm-8">
                            <input id="tb_under5" name="tb_under5" type="text" class="form-control" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_over65">
                            How many over the age of 65?
                        </label>
                        <div class="col-sm-8">
                            <input id="tb_over65" name="tb_over65" type="text" class="form-control" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_disabilities">
                            How many people with disablities?
                        </label>
                        <div class="col-sm-8">
                            <input id="tb_disabilities" name="tb_disabilities" type="text" class="form-control" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_ethnicity">
                            What ethnicities are represented in this place?
                        </label>
                        <div class="col-sm-8">
                            <input id="tb_ethnicity" name="tb_ethnicity" type="text" class="form-control" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_communityservicescard">
                            Is there a Community Services Card holder within the household?
                        </label>
                        <div class="col-sm-8">
                            <select id="dd_communityservicescard" name="dd_communityservicescard" class="form-control" required>
                                <option></option>
                                <option>Yes</option>
                                <option>No</option>
                            </select>
                        </div>
                    </div>
                    <!-- Accordian footer start -->
                </div>
            </div>
        </div>
    </div>


    <!--Consent -->

    <!-- Accordian header start -->

    <div class="panel-group">
        <div class="panel panel-default">
            <div class="panel-heading">
                <a data-toggle="collapse" href="#collapse_consent">
                    <h4 class="panel-title">Consent</h4>
                </a>
            </div>
            <div id="collapse_consent" class="panel-collapse collapse">
                <div class="panel-body">

                    <!-- Accordian header end -->

               
                        <span id="span_consent">You must select the referral type first.</span>

     <div id="div_consent" style="display:none">
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_consent">
                             <span id="span_fireconsent">xxxx</span>
                            
                            <img src="../Images/questionsmall.png" title="Consent must be obtained or given" /></label>
                        <div class="col-sm-8">
                            <select id="dd_consent" name="dd_consent" class="form-control" required >
                                <option></option>
                                <option>Yes - Consent has been given</option>
                                <option>No Consent has not yet been given</option>
                            </select>
                        </div>
                    </div>


                                        <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_civildefenceconsent">
                            <span id="span_civildefenceconsent">xxxx</span>
                            <img src="../Images/questionsmall.png" title="Consent must be obtained or given" /></label>
                        <div class="col-sm-8" id="div_civildefenceconsent">
                            <select id="dd_civildefenceconsent" name="dd_civildefenceconsent" class="form-control" required>
                                <option></option>
                                <option>Yes - Consent has been given</option>
                                <option>No Consent has not yet been given</option>
                            </select>
                        </div>
                    </div>

                    </div>

                    <!-- Accordian footer start -->
                </div>
            </div>
        </div>
    </div>




    <!-- SUBMIT -->

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info submit" Text="Submit" />
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
