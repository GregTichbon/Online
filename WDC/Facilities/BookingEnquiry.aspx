<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookingEnquiry.aspx.cs" Inherits="Online.Facilities.BookingEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "bookingenquiryHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $.validator.addMethod("dateseq", function (value, element, params) {
                $('#date_error').text("");
                $('#tb_eventfrom').removeClass('error')
                $('#tb_eventto').removeClass('error')
                fromdate = $(params[0]).val();
                todate = $(params[1]).val();
                if (fromdate != "" && todate != "") {
                    return new Date(fromdate) <= new Date(todate);
                } else {
                    return true;
                }
                /*
                                if (!/Invalid Date|NaN/.test(new Date(fromdate) && !/Invalid Date|NaN/.test(new Date(todate))) {
                                    //$(params).valid();
                                    return new Date(fromdate) <= new Date(todate);
                                } else {
                                    alert(2);
                                    return true;
                                }
                                */
                //return false;
            }, 'The "To date" must be the same as, or after, the "From date".');


            $("#form1").validate({
                groups: {
                    phone_numbers: "tb_mobilephone tb_homephone tb_workphone"
                },
                rules: {
                    tb_emailconfirm: {
                        equalTo: '#tb_emailaddress'
                    },
                    tb_mobilephone: {
                        require_from_group: [1, ".phone-group"],
                        pattern: /02[0-9] \d{5,9}/
                    },
                    tb_homephone: {
                        require_from_group: [1, ".phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_workphone: {
                        require_from_group: [1, ".phone-group"],
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_eventfrom: {
                        dateseq: ["#tb_eventfrom", "#tb_eventto"]
                    },
                    tb_eventto: {
                        dateseq: ["#tb_eventfrom", "#tb_eventto"]
                    }
                },
                messages: {
                    tb_emailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_mobilephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    },
                    tb_homephone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_workphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                              <% if (1 == 2)
        { %>

                    tb_postaladdress: {
                        required: 'This field is required.'
                    },
                   <%}%>
                    tb_description: {
                        required: 'This field is required.'
                    }
                },
                errorPlacement: function (error, element) {
                    if (element.attr("name") == "tb_eventfrom" || element.attr("name") == "tb_eventto") {
                        error.appendTo($('#date_error'));
                    }
                    else {
                        error.insertAfter(element);
                    }
                }
            })

            <% if (1 == 2)
        { %>
            $('#tb_charityregistration').change(function () {
                charityregistration = $('#tb_charityregistration').val();
                //alert(charityregistration);
                if (charityregistration == "") {
                    alert("null");
                } else {
                    //CharityInformation CC49050
                    //alert(1);
                    $.ajax({
                        url: "../functions/data.asmx/CharityInformation?param1=" + charityregistration, success: function (result) {
                            $("#div_charityname").text(result);
                        }
                    });
                    /*
                    // feed | entry | content | m:properties | d:name
                    $.ajax({
                        url: "../functions/data.asmx/RestFulClient?type=XML&URL=http://www.odata.charities.govt.nz/Organisations?$filter=CharityRegistrationNumber eq '" + charityregistration + "'", success: function (result) {
                            console.log(result);
                            charitydata = $.parseJSON(result);
                            console.log("charitydata");
                            console.log(charitydata);

                            feed = charitydata['feed']['entry']['content'];
                            console.log("Feed");
                            console.log(feed);

                            //feedentry = feed['entry'];
                            //console.log(feedentry);

                        }
                    });
                    */
                }
            })
            <%}%>


            $('#cb_wmc').click(function () {
                ischecked = $(this).prop('checked');
                if (!ischecked) {
                    $('#div_wmc').hide();
                    $("input[id^='cb_wmc_']").each(function () {
                        $(this).prop('checked', false);
                    });
                } else {
                    $('#div_wmc').show();
                }
            })
            $('#cb_cg').click(function () {
                ischecked = $(this).prop('checked');
                if (!ischecked) {
                    $('#div_cg').hide();
                    $("input[id^='cb_cg_']").each(function () {
                        $(this).prop('checked', false);
                    });
                } else {
                    $('#div_cg').show();
                }
            })
            $('#cb_oh').click(function () {
                ischecked = $(this).prop('checked');
                if (!ischecked) {
                    $('#div_oh').hide();
                    $("input[id^='cb_oh_']").each(function () {
                        $(this).prop('checked', false);
                    });
                } else {
                    $('#div_oh').show();
                }
            })





            $(".venue").click(function () {
                //alert($("#cb_wmc_kitchen").is(":checked"));
                //alert($(".wmc_venue:checked").length);
                if ($("#cb_wmc_kitchen").is(":checked") && $(".wmc_venue:checked").length == 0) {
                    $('#cb_wmc_kitchen').prop('checked', false)
                }
                if ($("#cb_cg_kitchen").is(":checked") && $(".cg_venue:checked").length == 0) {
                    $('#cb_cg_kitchen').prop('checked', false)
                }
                thischeckbox = this.id;
                thischecked = this.checked;

                if (thischeckbox == 'cb_wmc_fullcomplex' && $('.partof_wmc_fullcomplex').prop('checked', false)) {
                    if (thischecked) {
                        $('.partof_wmc_fullcomplex_hidden').prop('checked', true);
                        $('.partof_wmc_fullcomplex').prop('checked', true);
                        $('.partof_wmc_fullcomplex').hide();
                        $('#wmc_fullcomplex').show();
                    } else {
                        $('.partof_wmc_fullcomplex').show();
                        $('#wmc_fullcomplex').hide();
                    }
                } else if (thischeckbox == 'cb_cg_fullcomplex' && $('.partof_cg_fullcomplex').prop('checked', false)) {
                    if (thischecked) {
                        //$('.partof_cg_fullcomplex_hidden').prop('checked', true);
                        $('.partof_cg_fullcomplex').prop('checked', true);
                        $('.partof_cg_fullcomplex').hide();
                        //$('#cg_fullcomplex').show();
                    } else {
                        $('.partof_cg_fullcomplex').show();
                        //$('#cg_fullcomplex').hide();
                    }
                }
                else if (thischeckbox == 'cb_oh_fulltheatre' && $('.partof_oh_fulltheatre').prop('checked', false)) {
                    if (thischecked) {
                        $('.partof_oh_fulltheatre').prop('checked', true);
                        $('.partof_oh_fulltheatre').hide();
                        $('#oh_fulltheatre').show();
                    } else {
                        $('.partof_oh_fulltheatre').show();
                        $('#oh_fulltheatre').hide();
                    }
                }
            })

            <% if (1 == 2)
        { %>

            $('#cb_invoiceaddressformat').click(function () {
                if ($('#span_invoiceaddressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_invoiceaddressformat').text('Free format address mode (not preferred)');
                    $("#tb_invoiceaddress").autocomplete("disable");
                } else {
                    $('#span_invoiceaddressformat').text('Address lookup mode (preferred)');
                    $("#tb_invoiceaddress").autocomplete("enable");
                }
            })


            $('#cb_postaladdressformat').click(function () {
                if ($('#span_postaladdressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_postaladdressformat').text('Free format address mode (not preferred)');
                    $("#tb_postaladdress").autocomplete("disable");
                } else {
                    $('#span_postaladdressformat').text('Address lookup mode (preferred)');
                    $("#tb_postaladdress").autocomplete("enable");
                }
            })

            $("#tb_invoiceaddress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_invoiceaddress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })

            $("#tb_postaladdress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_postaladdress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            })
                        <% } %>


            /*
            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .append("<a>" + item.label + "</a>")
                  .appendTo(ul);
            };
            */


            $('body').on('focus', ".dateonly", function () {
                $(this).datetimepicker({
                    format: 'D MMM YYYY',
                    extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                    showClear: true,
                    viewDate: false,
                    stepping: 30,
                    minDate: moment().add(1, 'day'),
                    maxDate: moment().add(10, 'year'),
                    useCurrent: false,
                    sideBySide: true
                });
            });

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


            //$('[required]').css('border', '1px solid red');

            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Whanganui Venues Booking Enquiry
    </h1>

    <div class="panel panel-danger">
        <div class="panel-heading">Venues</div>
        <div class="panel-body">
            <p>
                We have a number of venues and spaces available to meet your requirements, from small to large, public or intimate and even whole complex hire.
            </p>
            <p>
                Our venues can easily accommodate multiple events at a time over a number of rooms without disruption.
            </p>
            <p>
                Please outline your requirements below and one of our dedicated Event Coordinators will get back to you and assist you in your planning, preparations and running of your event.

            </p>

        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_applicant">Name</label>
        <div class="col-sm-8">
            <input type="text" id="tb_applicant" name="tb_applicant" class="form-control" maxlength="100" value="<%: tb_applicant %>" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_organisation">
            Organisation
            <img src="../Images/questionsmall.png" title="Please provide the name of the Company, Club or Group making this booking. Leave blank if not applicable." /></label>
        <div class="col-sm-8">
            <input type="text" id="tb_organisation" name="tb_organisation" class="form-control" maxlength="100" value="<%: tb_organisation %>" />
        </div>
    </div>
    <% if (1 == 2)
        { %>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityregistration">
            Charity registration number
                    <img src="../Images/questionsmall.png" title="Charitable organisations may be eligible for discounted fees." /></label>
        <div class="col-sm-2">
            <input type="text" id="tb_charityregistration" name="tb_charityregistration" class="form-control" maxlength="100" value="<%: tb_charityregistration %>" />
        </div>
        <div class="col-sm-6" id="div_charityname"></div>
    </div>
    <%} %>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control inhibitcutcopypaste" value="<%:tb_emailaddress%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
        <div class="col-sm-8">
            <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste" required autocomplete="off" />
        </div>
    </div>

    <% if (1 == 2)
        { %>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_postaladdressformat">
            Postal address
            <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_postaladdressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_postaladdressformat">Change</a>
            <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="4" required><%:tb_postaladdress%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_invoiceaddressformat">
            Invoice address (if different to the postal address)
            <img src="../Images/questionsmall.png" title="This is only required if different to the postal address above. If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_invoiceaddressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_invoiceaddressformat">Change</a>
            <textarea id="tb_invoiceaddress" name="tb_invoiceaddress" class="form-control" rows="4"><%:tb_invoiceaddress%></textarea>
        </div>
    </div>
    <%} %>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_mobilephone">
            Mobile phone
            <img src="../Images/questionsmall.png" title="Please provide at least one phone number." /></label>
        <div class="col-sm-8">
            <input id="tb_mobilephone" placeholder="eg: 027 123456..." name="tb_mobilephone" type="text" class="form-control phone-group" value="<%:tb_mobilephone%>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_homephone">Home phone</label>
        <div class="col-sm-8">
            <input id="tb_homephone" name="tb_homephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" value="<%:tb_homephone%>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_workphone">Work phone</label>
        <div class="col-sm-8">
            <input id="tb_workphone" name="tb_workphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" value="<%:tb_workphone%>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_eventtype">Type of event</label>
        <div class="col-sm-8">
            <select id="dd_eventtype" name="dd_eventtype" class="form-control" required>
                <option></option>
                <option>Wedding</option>
                <option>Conference</option>
                <option>Seminar</option>
                <option>Training Session(s)</option>
                <option>Expo</option>
                <option>Public Meeting</option>
                <option>Cocktail Party</option>
                <option>Dinner Dance</option>
                <option>Ball</option>
                <option>Other (please describe below)</option>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_description">
            Event description
            <img src="../Images/questionsmall.png" title="Please provide us with some information about your event. This will ensure we have the ideal space for your requirements." /></label>
        <div class="col-sm-8">
            <textarea id="tb_description" name="tb_description" class="form-control" rows="4" maxlength="500"><%:tb_description%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxxx">Preferred date of event</label>
        <div class="col-sm-3">
            <input type="text" id="tb_eventfrom" name="tb_eventfrom" class="form-control datetime" value="" required />
        </div>
        <div class="col-sm-2" style="align-content: center">To </div>
        <div class="col-sm-3">
            <input type="text" id="tb_eventto" name="tb_eventto" class="form-control datetime" value="" required />
        </div>

    </div>
    <div class="col-sm-4"></div>
    <div class="col-sm-8" id="date_error"></div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_overallnumbers">Overall, how many people do you anticipate will be attending?</label>
        <div class="col-sm-8">
            <input type="text" id="tb_overallnumbers" name="tb_overallnumbers" class="form-control" maxlength="100" value="<%: tb_overallnumbers %>" required />
        </div>
    </div>

    <!--
    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxx">Which would be your preferred venue(s)?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <input id="cb_wmc" name="cb_wmc" value="Yes" type="checkbox" />
                War Memorial Centre
                <br />
                <div id="div_wmc" style="margin-left: 50px; display: <%:none%>">
                    <input id="cb_wmc_fullcomplex" name="cb_wmc_fullcomplex" value="Yes" type="checkbox" class="venue" />
                    Full complex
                    <br />
                    <input id="cb_wmc_main" name="cb_wmc_main" value="Yes" type="checkbox" class="venue partof_wmc_fullcomplex" />
                    Main hall
                    <br />
                    <input id="cb_wmc_pioneer" name="cb_wmc_pioneer" value="Yes" type="checkbox" class="venue partof_wmc_fullcomplex" />
                    Pioneer room
                    <br />
                    <input id="cb_wmc_concert" name="cb_wmc_concert" value="Yes" type="checkbox" class="venue partof_wmc_fullcomplex" />
                    Concert chamber
                    <br />
                    <input id="cb_wmc_kitchen" name="cb_wmc_kitchen" value="Yes" type="checkbox" class="venue partof_wmc_fullcomplex" />
                    Kitchen (this can not be hired alone)
                    <div id="wmc_fullcomplex" style="display: <%:none%>">
                        Also includes
                        <br />
                        - Downstairs foyer
                        <br />
                        - Upstairs foyer
                        <br />
                        - Forecourt
                    </div>
                </div>

                <input id="cb_cg" name="cb_cg" value="Yes" type="checkbox" />
                Cooks Gardens
                <br />
                <div id="div_cg" style="margin-left: 50px; display: <%:none%>">
                    <input id="cb_cg_fullcomplex" name="cb_cg_fullcomplex" value="Yes" type="checkbox" class="venue" />
                    Full complex
                    <br />
                    <input id="cb_cg_corporatebox" name="cb_cg_corporatebox" value="Yes" type="checkbox" class="venue partof_cg_fullcomplex" />
                    Corporate Box(es)
                    <br />
                    <input id="cb_cg_functioncentre" name="cb_cg_functioncentre" value="Yes" type="checkbox" class="venue partof_cg_fullcomplex" />
                    Function Centre
                    <br />
                    <input id="cb_cg_mainfield" name="cb_cg_mainfield" value="Yes" type="checkbox" class="venue partof_cg_fullcomplex" />
                    Main Field
                    <span id="cg_fullcomplex" style="display: <%:none%>">
                        Also includes
                        <br />
                        Use of venue kitchen
                        <br />
                        Whiskas Grandstand & Changing Rooms
                    </span>
                    <br />
                    <input id="cb_cg_velodrome" name="cb_cg_velodrome" value="Yes" type="checkbox" class="venue" />
                    Velodrome
                </div>

                <input id="cb_oh" name="cb_oh" value="Yes" type="checkbox" />
                Royal Whanganui Opera House
                <br />
                <div id="div_oh" style="margin-left: 50px; display: <%:none%>">
                    <input id="cb_oh_fulltheatre" name="cb_oh_fulltheatre" value="Yes" type="checkbox" class="venue" />
                    Full complex
                                       <br />
                    <input id="cb_oh_auditorium" name="cb_oh_auditorium" value="Yes" type="checkbox" class="venue" />
                    Auditorium
                     <br />
                    <input id="cb_oh_annex" name="cb_oh_annex" value="Yes" type="checkbox" class="venue" />
                    Annex
                    <br />
                    <input id="cb_oh_loungebar" name="cb_oh_loungebar" value="Yes" type="checkbox" class="venue" />
                    Lounge/Bar
                </div>
            </div>
        </div>
    </div>
-->

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxx">Which would be your preferred venue(s)?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <input id="cb_wmc" name="cb_venue" value="WMC" type="checkbox" />
                War Memorial Centre
                <br />
                <div id="div_wmc" style="margin-left: 50px; display: <%:none%>">
                    <input id="cb_wmc_fullcomplex" name="cb_venue" value="WMC-Full" type="checkbox" class="venue" />
                    Full complex
                    <br />
                    <input id="cb_wmc_main" name="cb_venue" value="WMC-MH" type="checkbox" class="venue wmc_venue partof_wmc_fullcomplex" />
                    Main hall
                    <br />
                    <input id="cb_wmc_pioneer" name="cb_venue" value="WMC-PR" type="checkbox" class="venue wmc_venue partof_wmc_fullcomplex" />
                    Pioneer room
                    <br />
                    <input id="cb_wmc_concert" name="cb_venue" value="WMC-CC" type="checkbox" class="venue wmc_venue partof_wmc_fullcomplex" />
                    Concert chamber
                    <br />
                    <input id="cb_wmc_kitchen" name="cb_venue" value="WMC-K" type="checkbox" class="venue partof_wmc_fullcomplex" />
                    Kitchen (this can not be hired alone)
                    <div id="wmc_fullcomplex" style="display: <%:none%>">
                        Also includes
                        <br />
                        <input id="cb_wmc_downstairsfoyer" name="cb_venue" value="WMC-DF" type="checkbox" class="partof_wmc_fullcomplex_hidden" style="display: none" />
                        - Downstairs foyer
                        <br />
                        <input id="cb_wmc_upstairsfoyer" name="cb_venue" value="WMC-UF" type="checkbox" class="partof_wmc_fullcomplex_hidden" style="display: none" />
                        - Upstairs foyer
                        <br />
                        <input id="cb_wmc_forecourt" name="cb_venue" value="WMC-FC" type="checkbox" class="partof_wmc_fullcomplex_hidden" style="display: none" />
                        - Forecourt
                    </div>
                </div>

                <input id="cb_cg" name="cb_venue" value="CG" type="checkbox" />
                Cooks Gardens
                <br />
                <div id="div_cg" style="margin-left: 50px; display: <%:none%>">
                    <input id="cb_cg_fullcomplex" name="cb_venue" value="CG-Full" type="checkbox" class="venue" />
                    Full complex
                    <br />
                    <input id="cb_cg_functioncentre" name="cb_venue" value="CG-FC" type="checkbox" class="venue cg_venue partof_cg_fullcomplex" />
                    Function Centre
                
                    <br />
                    <input id="cb_cg_corporatebox" name="cb_venue" value="CG-CB" type="checkbox" class="venue cg_venue partof_cg_fullcomplex" />
                    Corporate Box(es)
                                                           <br />


                    <input id="cb_cg_kitchen" name="cb_venue" value="CG-K" type="checkbox" class="venue partof_cg_fullcomplex" />
                    Kitchen (this can not be hired alone)
                    <br />
                                        <input id="cb_cg_mainfield" name="cb_venue" value="CG-MF" type="checkbox" class="venue xxxxxpartof_cg_fullcomplex" />
                    Main Field   
 <br />
                    <input id="cb_cg_velodrome" name="cb_venue" value="CG-V" type="checkbox" class="venue" />
                    Velodrome

                                        


                </div>

                <input id="cb_oh" name="cb_venue" value="OH" type="checkbox" />
                Royal Whanganui Opera House
                <br />
                <div id="div_oh" style="margin-left: 50px; display: <%:none%>">
                    <input id="cb_oh_fulltheatre" name="cb_venue" value="OH-Full" type="checkbox" class="venue" />
                    Full theatre
                                       <br />
                    <input id="cb_oh_auditorium" name="cb_venue" value="OH-AU" type="checkbox" class="venue partof_oh_fulltheatre" />
                    Auditorium
                     <br />
                    <input id="cb_oh_annex" name="cb_venue" value="OH-AN" type="checkbox" class="venue partof_oh_fulltheatre" />
                    Annex
                    <br />
                    <input id="cb_oh_loungebar" name="cb_venue" value="OH-LB" type="checkbox" class="venue partof_oh_fulltheatre" />
                    Lounge/Bar
                </div>
            </div>
        </div>
    </div>




    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_otherinformation">
            Other information
    <img src="../Images/questionsmall.png" title="Please provide any other information that might be relevant or any questions you might have." /></label>
        <div class="col-sm-8">
            <textarea id="tb_otherinformation" name="tb_otherinformation" class="form-control" rows="4"><%:tb_otherinformation%></textarea>
        </div>
    </div>

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
