<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="Online.WMC.Booking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            $("#pagehelp").colorbox({ href: "bookingHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


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

            $("#viewtermsandconditions").colorbox({ iframe: true, width: "80%", height: "80%" });


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
                    }
                }
            })
/*
            $('#tb_charityregistration').change(function () { 
                charityregistration = $('#tb_charityregistration').val();
                alert(charityregistration);
                if (charityregistration == "") {
                    alert("null");
                } else {
                    //CharityInformation CC49050
                    $.ajax({
                        url: "../functions/data.asmx/CharityInformation?param1=" + charityregistration, success: function (result) {
                            charityname = $.parseJSON(result);
                            console.log(charityname);
                        }
                    });
                }
            })
*/
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
                    case 'cb_pioneer':
                        if (thischecked) {
                            $('#div_pioneer').show();
                        } else {
                            $('#div_pioneer').hide();
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
                    format: 'D MMM YYYY LT',
                    showClear: true,
                    viewDate: false,
                    stepping: 30,
                    minDate: moment().add(1, 'day'),
                    maxDate: moment().add(10, 'year'),
                    useCurrent: false,
                    sideBySide: true
                });
            });
    

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


        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>War Memorial Centre Booking
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
                    <img src="../Images/questionsmall.png" title="Charitable organisations maybe eligible for discounted fees." /></label>
        <div class="col-sm-8">
            <input type="text" id="tb_charityregistration" name="tb_charityregistration" class="form-control" maxlength="100" value="<%: tb_charityregistration %>" />
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
             <div class="col-sm-2"> To </div>
        <div class="col-sm-3">
            <input type="text" id="tb_dateto" name="tb_dateto" class="form-control dateonly" value="" required />
        </div>
    </div>

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
            <img src="../Images/questionsmall.png" title="Please describe as fully as you can the event." /></label>
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
        <label class="control-label col-sm-4" for="dd_feecharged">Will an admission or registration fee be charged?</label>
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
            <label class="control-label col-sm-4" for="dd_liquorsales">Will liquor be sold?</label>
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
            <label class="control-label col-sm-4" for="dd_liquorlicence">Have you applied for a liquor licence?</label>
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
                <div id="main" class="panel-collapse collapse in">
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
                        <label class="control-label col-sm-4" for="tb_main_curtains">Curtains</label><div class="col-sm-8">
                            <input id="tb_main_curtains" name="tb_main_curtains" type="text" class="form-control" />
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
                <div id="pioneer" class="panel-collapse collapse in">
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
                <div id="concert" class="panel-collapse collapse in">
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
                <div id="kitchen" class="panel-collapse collapse in">
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

    <!--General-->

    <div id="div_general">

        <!-- Accordian header start -->

        <div class="panel-group">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a data-toggle="collapse" href="#general">
                        <h4 class="panel-title">General equipment</h4>
                    </a>
                </div>
                <div id="general" class="panel-collapse collapse in">
                    <div class="panel-body" style="position: relative">
                        <!-- added relative for datetimepicker -->
                        <!-- Accordian header end -->
                            
                        <h3>Equipment</h3>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_teacoffee">Tea and Coffee</label><div class="col-sm-8">
                                <input id="tb_general_teacoffee" name="tb_general_teacoffee" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_glasses">Glasses</label><div class="col-sm-8">
                                <input id="tb_general_glasses" name="tb_general_glasses" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_cupssaucers">Cups and Saucers</label><div class="col-sm-8">
                                <input id="tb_general_cupssaucers" name="tb_general_cupssaucers" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_milkjugs">Milk Jugs</label><div class="col-sm-8">
                                <input id="tb_general_milkjugs" name="tb_general_milkjugs" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_hotwaterurns">Hot water urns</label><div class="col-sm-8">
                                <input id="tb_general_hotwaterurns" name="tb_general_hotwaterurns" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_chaircovers">Chair covers</label><div class="col-sm-8">
                                <input id="tb_general_chaircovers" name="tb_general_chaircovers" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_chairsaches">Chair sashes</label><div class="col-sm-8">
                                <input id="tb_general_chairsaches" name="tb_general_chairsaches" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_tablecloths">Table cloths</label><div class="col-sm-8">
                                <input id="tb_general_tablecloths" name="tb_general_tablecloths" type="text" class="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_whiteboard">Whiteboards</label><div class="col-sm-8">
                                <input id="tb_general_whiteboard" name="tb_general_whiteboard" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_lectern">Lectern</label><div class="col-sm-8">
                                <input id="tb_general_lectern" name="tb_general_lectern" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_smokebeamisolation">
                                Smoke beam isolation
                            <img src="../Images/questionsmall.png" title="This is required if you are having decorations that may interfere with the smoke beams or large candles." /></label><div class="col-sm-8">
                                <input id="tb_general_smokebeamisolation" name="tb_general_smokebeamisolation" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_projectorscreenlaptop">Projector, screen and laptop</label><div class="col-sm-8">
                                <input id="tb_general_projectorscreenlaptop" name="tb_general_projectorscreenlaptop" type="text" class="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_soundsystem">
                                Sound system
                                <img src="../Images/questionsmall.png" title="Includes 2 hand held and 2 lapel mics." /></label><div class="col-sm-8">
                                    <input id="tb_general_soundsystem" name="tb_general_soundsystem" type="text" class="form-control" />
                                </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_partitions">Partitions</label><div class="col-sm-8">
                                <input id="tb_general_partitions" name="tb_general_partitions" type="text" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-4" for="tb_general_snorkellift">Snorkel lift</label><div class="col-sm-8">
                                <input id="tb_general_snorkellift" name="tb_general_snorkellift" type="text" class="form-control" />
                            </div>
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

            <select id="dd_emptyskipbin" name="dd_emptyskipbin" class="form-control">
                <option></option>
                <option>Yes</option>
                <option>No</option>
            </select>
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
        <label class="control-label col-sm-4" for="dd_termsandconditions">
            Have you read and agree to the terms and conditions?
            <img src="../Images/questionsmall.png" title="You must agree to the terms and conditions to submit this booking." /></label>
            
        <div class="col-sm-8">
 <select id="dd_termsandconditions" name="dd_termsandconditions" class="form-control" required>
                        <option></option>
                        <%
                            foreach (string dd_value in yesno_values)
                            {
                                if (dd_value == dd_termsandconditions)
                                {
                                    selected = " selected";
                                }
                                else
                                {
                                    selected = "";
                                }
                                Response.Write("<option" + selected + ">" + dd_value + "</option>");
                            }
                        %>
                    </select>
            <a id="viewtermsandconditions" href="termsandconditions.html">View terms and conditions</a>
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
