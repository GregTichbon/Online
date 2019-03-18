<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookingEnquiry.aspx.cs" Inherits="Online.WMC.BookingEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "bookingenquiryHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

           
            $.validator.addMethod("dateseq", function (value, element, params) {
                $('#date_error').text("");
                $('#tb_datefrom').removeClass('error')
                $('#tb_dateto').removeClass('error')
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
                    tb_datefrom: {
                        dateseq: ["#tb_datefrom", "#tb_dateto"]
                    },
                    tb_dateto: {
                        dateseq: ["#tb_datefrom", "#tb_dateto"]
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
                    tb_postaladdress: {
                        required: 'This field is required.'
                    },
                    tb_description: {
                        required: 'This field is required.'
                    }
                },
                errorPlacement: function (error, element) {
                    if (element.attr("name") == "tb_datefrom" || element.attr("name") == "tb_dateto") {
                        error.appendTo($('#date_error'));
                    }
                    else {
                        error.insertAfter(element);
                    }
                }
            })
 
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
 
            /*
            $('#cb_fullcomplex').click(function () {        
                if ($('#cb_fullcomplex').prop('checked')) {



                    $('.partoffullcomplex').hide();
                    $('#fullcomplex').show();
                    $('#div_main').show();
                    $('#div_pioneer').show();
                    $('#div_concert').show();
                } else {
                    $('.partoffullcomplex').show();
                    $('#fullcomplex').hide();
                    $('#div_main').hide();
                    $('#div_pioneer').hide();
                    $('#div_concert').hide();
                }

            })
            */


            $(".venue").click(function () {
                if ($("#cb_kitchen").is(":checked") && $(".venue:checked").length == 1) {
                    $('#cb_kitchen').prop('checked', false)
                }
                thischeckbox = this.id;
                thischecked = this.checked;

                if (thischeckbox == 'cb_fullcomplex' && $('.partoffullcomplex').prop('checked', false)) {
                    if (thischecked) {
                        $('.partoffullcomplex').hide();
                    } else {
                        $('.partoffullcomplex').show();
                    }
                }


            })


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
            /*
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
            */

            //$('[required]').css('border', '1px solid red');

                        <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>War Memorial Centre Booking Enquiry
    </h1>
            <div class="form-group">
            <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
            <div class="col-sm-8">
                <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
        </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_applicant">Applicant name</label>
        <div class="col-sm-8">
            <input type="text" id="tb_applicant" name="tb_applicant" class="form-control" maxlength="100" value="<%: tb_applicant %>" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_organisation">Organisation name
            <img src="../Images/questionsmall.png" title="Organisation name only required where applicable." /></label>
        <div class="col-sm-8">
            <input type="text" id="tb_organisation" name="tb_organisation" class="form-control" maxlength="100" value="<%: tb_organisation %>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityregistration">Charity registration number
                    <img src="../Images/questionsmall.png" title="Charitable organisations may be eligible for discounted fees." /></label>
        <div class="col-sm-2">
            <input type="text" id="tb_charityregistration" name="tb_charityregistration" class="form-control" maxlength="100" value="<%: tb_charityregistration %>" />
        </div>
               <div class="col-sm-6" id="div_charityname"></div>
    </div>

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
        <label class="control-label col-sm-4" for="xxxxxx">Date</label>
        <div class="col-sm-3">
            <input type="text" id="tb_datefrom" name="tb_datefrom" class="form-control dateonly" value="" required />
        </div>
             <div class="col-sm-2" style="align-content:center"> To </div>
        <div class="col-sm-3">
            <input type="text" id="tb_dateto" name="tb_dateto" class="form-control dateonly" value="" required />
        </div>

    </div>
    <div class="col-sm-4"></div>
    <div class="col-sm-8" id="date_error"></div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_eventtype">Type of event:</label>
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
            Event description:
            <img src="../Images/questionsmall.png" title="Please describe the event as fully as you can." /></label>
        <div class="col-sm-8">
            <textarea id="tb_description" name="tb_description" class="form-control" rows="4" maxlength="500"><%:tb_description%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_overallnumbers">Overall, how many people do you anticipate will be attending?</label>
        <div class="col-sm-8">
            <input type="text" id="tb_overallnumbers" name="tb_overallnumbers" class="form-control" maxlength="100" value="<%: tb_overallnumbers %>" required />
        </div>
    </div>
 

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxx">Which facilties will you use?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">

                <input id="cb_fullcomplex" name="cb_fullcomplex" value="Yes" type="checkbox" class="venue" />
                Full complex
                <br />
                <input id="cb_main" name="cb_main" value="Yes" type="checkbox" class="venue partoffullcomplex" />
                Main hall
                <br />
                <input id="cb_pioneer" name="cb_pioneer" value="Yes" type="checkbox" class="venue partoffullcomplex" />
                Pioneer room
                <br />
                <input id="cb_concert" name="cb_concert" value="Yes" type="checkbox" class="venue partoffullcomplex" />
                Concert chamber
                <br />
                <input id="cb_kitchen" name="cb_kitchen" value="Yes" type="checkbox" class="venue partoffullcomplex" />
                Kitchen (this can not be hired alone)
                <div id="fullcomplex" style="display: <%:none%>">
                    <br />
                    Also includes
                    <br />
                    - Downstairs foyer
                    <br />
                    - Upstairs foyer
                    <br />
                    - Forecourt
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
