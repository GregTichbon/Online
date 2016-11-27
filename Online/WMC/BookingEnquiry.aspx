<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookingEnquiry.aspx.cs" Inherits="Online.WMC.BookingEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "bookingenquiryHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            mainaccess_ctr = 1;
            pioneeraccess_ctr = 1;
            concertaccess_ctr = 1;

            $('.addaccess').click(function () {
                addaccess(this.id.substring(9));
            });

            function addaccess(facility) {
                //alert(facilty);
                var cloned = $('#tr_access_').clone()
                switch (facility) {
                    case 'main':
                        mainaccess_ctr++;
                        access_ctr = mainaccess_ctr;
                        break;
                    case 'pioneer':
                        pioneeraccess_ctr++;
                        access_ctr = pioneeraccess_ctr;
                        break;
                    case 'concert':
                        concertaccess_ctr++;
                        access_ctr = concertaccess_ctr;
                        break;
                }
                cloned = cloned.repeater_changer(facility + '_' + access_ctr);
                var place = $('#table_' + facility + ' tr:last');
                cloned.insertAfter(place);
                return false;
            };

            $('body').on('click', '.deleteaccess', function () {
                trid = this.id;
                trid = 'tr_access_' + trid.substring(12);
                $('#' + trid).remove();
            });


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
                    },
                    tb_overallfrom: {
                        required: 'This field is required.'
                    },
                    tb_overallto: {
                        required: 'This field is required.'
                    }, tb_overallattendeesfrom: {
                        required: 'This field is required.'
                    },
                    tb_overallattendeesto: {
                        required: 'This field is required.'
                    }
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

            $("input[name='cb_facilities']").click(function () {
                thischeckbox = this.id;
                thischecked = this.checked;
                switch (thischeckbox) {
                    case 'cb_fullcomplex':
                        $('.partoffullcomplex').prop('checked', false);
                        if (thischecked) {
                            //$('.partoffullcomplex').prop('checked', true);
                            $('.partoffullcomplex').hide();
                            $('#fullcomplex').show();
                            $('#div_main').show();
                            $('#div_pioneer').show();
                            $('#div_concert').show();
                            $('#div_kitchen').show();
                        } else {
                            $('.partoffullcomplex').show();
                            $('#fullcomplex').hide();
                            $('#div_main').hide();
                            $('#div_pioneer').hide();
                            $('#div_concert').hide();
                            $('#div_kitchen').hide();
                        }
                        break;
                    case 'cb_main':
                        if (thischecked) {
                            $('#div_main').show();
                        } else {
                            $('#div_main').hide();
                        }
                        break;
                    case 'cb_concert':
                        if (thischecked) {
                            $('#div_concert').show();
                        } else {
                            $('#div_concert').hide();
                        }
                        break;
                    case 'cb_pioneer':
                        if (thischecked) {
                            $('#div_pioneer').show();
                        } else {
                            $('#div_pioneer').hide();
                        }
                        break;
                    case 'cb_main':
                        if (thischecked) {
                            $('#div_main').show();
                        } else {
                            $('#div_main').hide();
                        }
                        break;
                    case 'cb_concert':
                        if (thischecked) {
                            $('#div_concert').show();
                        } else {
                            $('#div_concert').hide();
                        }
                        break;
                    case 'cb_kitchen':
                        if (thischecked) {
                            $('#div_kitchen').show();
                        } else {
                            $('#div_kitchen').hide();
                        }
                        break;

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

            $('#dd_liquor').change(function () { //will liquor be consumed?
                //alert($(this).val());
                willliquorbeconsumed = $('#dd_liquor :selected').text();
                switch (willliquorbeconsumed) {
                    case 'Yes':
                        $('#div_liquorsold').show();
                        $('#div_liquorlicence').show();
                        break;
                    case 'No':
                        $('#div_liquorsold').hide();
                        $('#div_liquorlicence').hide();
                        break;
                }
            });

            $('.liquorlicence').change(function () {
                //alert($(this).val());
                willtherebeliquor = $('#dd_liquor :selected').text();
                feecharged = $('#dd_feecharged :selected').text();
                liquorsales = $('#dd_liquorsales :selected').text();

                if (willtherebeliquor == 'Yes' && feecharged != 'No' && liquorsales != 'No') {
                    $('#div_liquorsold').show();
                    $('#div_liquorlicence').show();
                } else {
                    $('#div_liquorsold').hide();
                    $('#div_liquorlicence').hide();
                }
            });

            $('#dd_publicinformation').change(function () {
                selectedvalue = $('#dd_publicinformation :selected').text();
                switch (selectedvalue) {
                    case 'Yes':
                        $('#div_publictext').show();
                        break;
                    case 'No':
                        $('#div_publictext').hide();
                        break;
                }
            });

            $('#dd_concert_piano').change(function () {
                selectedvalue = $('#dd_concert_piano').val();
                switch (selectedvalue) {
                    case 'Yes':
                        $('#div_pianotuning').show();
                        break;
                    case 'No':
                        $('#div_pianotuning').hide();
                        break;
                }
            });

            $('body').on('focus', ".datetime", function () {
                $(this).datetimepicker({
                    format: 'D/MM/YYYY LT',
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


        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>War Memorial Centre Booking Enquiry
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Applicant Name</label>
        <div class="col-sm-8">
            <input type="text" id="tb_applicant" name="tb_applicant" class="form-control" maxlength="100" value="<%: tb_applicant %>" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_businessname">Organisation Name</label>
        <div class="col-sm-8">
            <input type="text" id="tb_organisation" name="tb_organisation" class="form-control" maxlength="100" value="<%: tb_organisation %>" title="Organisation name only required where applicable." />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charityregistration">Charity Registration Number</label>
        <div class="col-sm-8">
            <input type="text" id="tb_charityregistration" name="tb_charityregistration" class="form-control" maxlength="100" value="<%: tb_charityregistration %>" title="Charitable organisations maybe eligible for discounted fees." />
        </div>
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
            Invoice Address (if different to the postal address)
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
        <label class="control-label col-sm-4" for="tb_description">Type of Event:</label>
        <div class="col-sm-8">
            <select id="rbl_eventtype" name="rbl_eventtype" class="form-control" required>
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
            Event Description:
            <img src="../Images/questionsmall.png" title="Please describe as fully as you can the event." /></label>
        <div class="col-sm-8">
            <textarea id="tb_description" name="tb_description" class="form-control" rows="4" required maxlength="500"><%:tb_description%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_overallnumbers">Overall, how many people do you anticipate will be attending?</label>
        <div class="col-sm-8">
            <input type="text" id="tb_overallnumbers" name="tb_overallnumbers" class="form-control" maxlength="100" value="<%: tb_overallnumbers %>" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_feecharged">Will there be an admission of registration fee be charged?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <select id="dd_feecharged" name="dd_feecharged" class="form-control liquorlicence" required>
                    <option></option>
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_liquor">Will liquor be consumed?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <select id="dd_liquor" name="dd_liquor" class="form-control liquorlicence" required>
                    <option></option>
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </div>
        </div>
    </div>

    <div id="div_liquorsold" style="display: <%: none %>">
        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_liquor">Will liquor be sold?</label>
            <div class="col-sm-8">
                <div class="col-sm-8">
                    <select id="dd_liquorsales" name="dd_liquorsales" class="form-control" required>
                        <option></option>
                        <option>Yes</option>
                        <option>No</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <div id="div_liquorlicence" style="display: <%: none %>">
        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_liquor">Have you applied for a liquor licence?</label>
            <div class="col-sm-8">
                <div class="col-sm-8">
                    <select id="dd_liquorlicence" name="dd_liquorlicence" class="form-control" required>
                        <option></option>
                        <option>Yes</option>
                        <option>No</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_music">Is there music being provided?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <select id="dd_music" name="dd_music" class="form-control" required>
                    <option></option>
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_publicinformation">May we provide information to the public?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <select id="dd_publicinformation" name="dd_publicinformation" class="form-control" required>
                    <option></option>
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </div>
        </div>
    </div>

    <div id="div_publictext" style="display: <%: none %>">
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_publictext">Public information</label>
            <div class="col-sm-8">
                <textarea id="tb_publictext" name="tb_publictext" class="form-control" rows="4"><%:tb_publictext%></textarea>

            </div>
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_photos">May we use photos for marketting purposes?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <select id="dd_photos" name="dd_photos" class="form-control" required>
                    <option></option>
                    <option>Yes</option>
                    <option>No</option>
                </select>
            </div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxx">Which facilties will you use?</label>
        <div class="col-sm-8">
            <div class="col-sm-8">

                <input id="cb_fullcomplex" name="cb_facilities" value="Full complex" type="checkbox" />
                Full complex
                <br />
                <input id="cb_main" name="cb_facilities" value="Main hall" type="checkbox" class="partoffullcomplex" />
                Main hall
                <br />
                <input id="cb_pioneer" name="cb_facilities" value="Pioneer room" type="checkbox" class="partoffullcomplex" />
                Pioneer room
                <br />
                <input id="cb_concert" name="cb_facilities" value="Concert chamber" type="checkbox" class="partoffullcomplex" />
                Concert chamber
                <br />
                <input id="cb_kitchen" name="cb_facilities" value="Kitchen" type="checkbox" class="partoffullcomplex" />
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









    <!--Main Hall-->

    <div id="div_main" style="display: <%:none%>">

        <!-- Accordian header start -->

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#main">
                        <h4 class="panel-title">Main hall equipment and access times</h4>
                    </a>
                </div>
                <div id="main" class="panel-collapse collapse">
                    <div class="panel-body" style="position: relative">
                        <!-- added relative for datetimepicker -->
                        <!-- Accordian header end -->
                        <h3>Access times</h3>
                        <a href="javascript:void(0);" class="addaccess" id="addaccessmain">Add times</a>
                        <div class="table-responsive table-bordered">

                            <table class="table" id="table_main">
                                <thead>
                                    <tr>
                                        <th class="col-md-2">Date/Time in</th>
                                        <th class="col-md-2">Date/Time out </th>
                                        <th>Comments</th>
                                        <th class="col-md-1">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input id="tb_datetimein_main_1" name="tb_datetimein_main_1" type="text" class="form-control datetime" required />

                                        </td>

                                        <td>

                                            <input id="tb_datetimeout_main_1" name="tb_datetimeout_main_1" type="text" class="form-control datetime" required />

                                        </td>

                                        <td>
                                            <input id="tb_datetimecomments_main_1" name="tb_datetimecomments_main_1" type="text" class="form-control" /></td>
                                        <td>Required</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <h3>Equipment</h3>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_teacoffee">Tea and Coffee</label><div class="col-sm-8">
                            <input id="tb_main_teacoffee" name="tb_main_teacoffee" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_glasses">Glasses</label><div class="col-sm-8">
                            <input id="tb_main_glasses" name="tb_main_glasses" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_cupssaucers">Cups and Saucers</label><div class="col-sm-8">
                            <input id="tb_main_cupssaucers" name="tb_main_cupssaucers" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_milkjugs">Milk Jugs</label><div class="col-sm-8">
                            <input id="tb_main_milkjugs" name="tb_main_milkjugs" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_hotwaterurns">Hot water urns</label><div class="col-sm-8">
                            <input id="tb_main_hotwaterurns" name="tb_main_hotwaterurns" type="text" class="form-control" />
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_whitechaircovers">White chair covers</label><div class="col-sm-8">
                            <input id="tb_whitechaircovers" name="tb_whitechaircovers" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_colouredchairsaches">Various coloured chair sashes</label><div class="col-sm-8">
                            <input id="tb_colouredchairsaches" name="tb_colouredchairsaches" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_roundwhitetablecloths">Round white table cloths</label><div class="col-sm-8">
                            <input id="tb_roundwhitetablecloths" name="tb_roundwhitetablecloths" type="text" class="form-control" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_whiteboard">Whiteboards</label><div class="col-sm-8">
                            <input id="tb_whiteboard" name="tb_whiteboard" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_lectern">Lectern</label><div class="col-sm-8">
                            <input id="tb_lectern" name="tb_lectern" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_smokebeamisolation">
                            Smoke beam isolation
                            <img src="../Images/questionsmall.png" title="This is required if you are having decorations that may interfere with the smoke beams or large candles." /></label><div class="col-sm-8">
                                <input id="tb_smokebeamisolation" name="tb_smokebeamisolation" type="text" class="form-control" />
                            </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_projectorscreenlaptop">Projector, screen and laptop</label><div class="col-sm-8">
                            <input id="tb_main_projectorscreenlaptop" name="tb_main_projectorscreenlaptop" type="text" class="form-control" />
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_soundsystem">
                            Sound system
                            <img src="../Images/questionsmall.png" title="Includes 2 hand held and 2 lapel mics." /></label><div class="col-sm-8">
                                <input id="tb_main_soundsystem" name="tb_main_soundsystem" type="text" class="form-control" />
                            </div>
                    </div>



                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_partitions">Partitions</label><div class="col-sm-8">
                            <input id="tb_main_partitions" name="tb_main_partitions" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_curtains">Curtains</label><div class="col-sm-8">
                            <input id="tb_main_curtains" name="tb_main_curtains" type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_main_snorkellift">Snorkel lift</label><div class="col-sm-8">
                            <input id="tb_main_snorkellift" name="tb_main_snorkellift" type="text" class="form-control" />
                        </div>
                    </div>

                    <!-- Accordian footer start -->
                </div>
            </div>
        </div>
    </div>
    <!-- Accordian footer end -->



    <!--Pioneer Room-->

    <div id="div_pioneer" style="display: <%:none%>">

        <!-- Accordian header start -->

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#pioneer">
                        <h4 class="panel-title">Pioneer room equipment and access times</h4>
                    </a>
                </div>
                <div id="pioneer" class="panel-collapse collapse">
                    <div class="panel-body" style="position: relative">
                        <!-- added relative for datetimepicker -->
                        <!-- Accordian header end -->
                        <h3>Access times</h3>
                        <a href="javascript:void(0);" class="addaccess" id="addaccesspioneer">Add times</a>
                        <div class="table-responsive table-bordered">

                            <table class="table" id="table_pioneer">
                                <thead>
                                    <tr>
                                        <th class="col-md-2">Date/Time in</th>
                                        <th class="col-md-2">Date/Time out </th>
                                        <th>Comments</th>
                                        <th class="col-md-1">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input id="tb_datetimein_pioneer_1" name="tb_datetimein_pioneer_1" type="text" class="form-control datetime" required /></td>
                                        <td>
                                            <input id="tb_datetimeout_pioneer_1" name="tb_datetimeout_pioneer_1" type="text" class="form-control datetime" required /></td>
                                        <td>
                                            <input id="tb_datetimecomments_pioneer_1" name="tb_datetimecomments_pioneer_1" type="text" class="form-control" /></td>
                                        <td>Required</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h3>Equipment</h3>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_pioneer_teacoffee">Tea and Coffee</label><div class="col-sm-8">
                                <input id="tb_pioneer_teacoffee" name="tb_pioneer_teacoffee" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_pioneer_glasses">Glasses</label><div class="col-sm-8">
                                <input id="tb_pioneer_glasses" name="tb_pioneer_glasses" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_pioneer_cupssaucers">Cups and Saucers</label><div class="col-sm-8">
                                <input id="tb_pioneer_cupssaucers" name="tb_pioneer_cupssaucers" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_pioneer_milkjugs">Milk Jugs</label><div class="col-sm-8">
                                <input id="tb_pioneer_milkjugs" name="tb_pioneer_milkjugs" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_pioneer_hotwaterurns">Hot water urns</label><div class="col-sm-8">
                                <input id="tb_pioneer_hotwaterurns" name="tb_pioneer_hotwaterurns" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_pioneer_projectorscreenlaptop">Projector, screen and laptop</label><div class="col-sm-8">
                                <input id="tb_pioneer_projectorscreenlaptop" name="tb_pioneer_projectorscreenlaptop" type="text" class="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_pioneer_soundsystem">
                                Sound system
                                <img src="../Images/questionsmall.png" title="Includes 2 hand held and 2 lapel mics." /></label><div class="col-sm-8">
                                    <input id="tb_pioneer_soundsystem" name="tb_pioneer_soundsystem" type="text" class="form-control" />
                                </div>
                        </div>
                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
        </div>
        <!-- Accordian footer end -->

    </div>

    <!--Concert Chamber-->

    <div id="div_concert" style="display: <%:none%>">

        <!-- Accordian header start -->

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#concert">
                        <h4 class="panel-title">Concert chamber equipment and access times</h4>
                    </a>
                </div>
                <div id="concert" class="panel-collapse collapse">
                    <div class="panel-body" style="position: relative">
                        <!-- added relative for datetimepicker -->
                        <!-- Accordian header end -->
                        <h3>Access times</h3>
                        <a href="javascript:void(0);" class="addaccess" id="addaccessconcert">Add times</a>
                        <div class="table-responsive table-bordered">

                            <table class="table" id="table_concert">
                                <thead>
                                    <tr>
                                        <th class="col-md-2">Date/Time in</th>
                                        <th class="col-md-2">Date/Time out </th>
                                        <th>Comments</th>
                                        <th class="col-md-1">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input id="tb_datetimein_concert_1" name="tb_datetimein_concert_1" type="text" class="form-control datetime" required /></td>
                                        <td>
                                            <input id="tb_datetimeout_concert_1" name="tb_datetimeout_concert_1" type="text" class="form-control datetime" required /></td>
                                        <td>
                                            <input id="tb_datetimecomments_concert_1" name="tb_datetimecomments_concert_1" type="text" class="form-control" /></td>
                                        <td>Required</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <h3>Equipment</h3>


                        <div class="form-group">

                            <label class="control-label col-sm-4" for="tb_concert_projectorscreenlaptop">Projector, screen and laptop</label><div class="col-sm-8">
                                <input id="tb_concert_projectorscreenlaptop" name="tb_concert_projectorscreenlaptop" type="text" class="form-control" />
                            </div>


                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_concert_soundsystem">
                                Sound system
                                <img src="../Images/questionsmall.png" title="Includes 2 hand held and 2 lapel mics." /></label><div class="col-sm-8">
                                    <input id="tb_concert_soundsystem" name="tb_concert_soundsystem" type="text" class="form-control" />
                                </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_concert_lights">Lights</label><div class="col-sm-8">
                                <input id="tb_concert_lights" name="tb_concert_lights" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="dd_concert_piano">Piano</label><div class="col-sm-8">
                                <select id="dd_concert_piano" name="dd_concert_piano" class="form-control" required>
                                    <option></option>
                                    <option>Yes</option>
                                    <option>No</option>
                                </select>
                            </div>
                        </div>
                        <div id="div_pianotuning" style="display: <%: none %>">
                            <div class="form-group">
                                <label class="control-label col-sm-4" for="dd_concert_pianotuning">Piano tuning</label><div class="col-sm-8">

                                    <select id="dd_concert_pianotuning" name="dd_concert_pianotuning" class="form-control" required>
                                        <option></option>
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>


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


    <!--Kitchen-->

    <div id="div_kitchen" style="display: <%:none%>">

        <!-- Accordian header start -->

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#kitchen">
                        <h4 class="panel-title">Kitchen access times</h4>
                    </a>
                </div>
                <div id="kitchen" class="panel-collapse collapse">
                    <div class="panel-body" style="position: relative">
                        <!-- added relative for datetimepicker -->
                        <!-- Accordian header end -->
                        <h3>Access times</h3>
                        <a href="javascript:void(0);" class="addaccess" id="addaccesskitchen">Add times</a>
                        <div class="table-responsive table-bordered">

                            <table class="table" id="table_kitchen">
                                <thead>
                                    <tr>
                                        <th class="col-md-2">Date/Time in</th>
                                        <th class="col-md-2">Date/Time out </th>
                                        <th>Comments</th>
                                        <th class="col-md-1">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input id="tb_datetimein_kitchen_1" name="tb_datetimein_kitchen_1" type="text" class="form-control datetime" required />

                                        </td>

                                        <td>

                                            <input id="tb_datetimeout_kitchen_1" name="tb_datetimeout_kitchen_1" type="text" class="form-control datetime" required />

                                        </td>

                                        <td>
                                            <input id="tb_datetimecomments_kitchen_1" name="tb_datetimecomments_kitchen_1" type="text" class="form-control" /></td>
                                        <td>Required</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>


                        <!-- Accordian footer start -->
                    </div>
                </div>
            </div>
        </div>
        <!-- Accordian footer end -->

    </div>


    <!--
    <p class="h3" style="text-align: center">Venues and Facilities</p>
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


            <asp:Literal ID="lit_venues" runat="server"></asp:Literal>


        </table>
    </div>
    -->
    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_emptyskipbin">Empty skip bin</label><div class="col-sm-8">

            <select id="dd_emptyskipbin" name="dd_emptyskipbin" class="form-control" required>
                <option></option>
                <option>Yes</option>
                <option>No</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_otherinformation">
            Other Information
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

    <!-- REPEATER SECTION-->

    <div style="display: <%:none%>">
        <table>

            <tr id="tr_access_">
                <td>
                    <input id="tb_datetimein_" name="tb_datetimein_" type="text" class="form-control datetime" required /></td>
                <td>
                    <input id="tb_datetimeout_" name="tb_datetimeout_" type="text" class="form-control datetime" required /></td>
                <td>
                    <input id="tb_datetimecomments_" name="tb_datetimecomments_" type="text" class="form-control" /></td>
                <td><a href="javascript:void(0)" id="href_delete_" class="deleteaccess repeatupdateid">Delete</a></td>

            </tr>
        </table>
        <!-- END OF REPEATER SECTION -->
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
