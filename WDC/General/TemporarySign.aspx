<%@ Page Title="Temporary Sign Application" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TemporarySign.aspx.cs" Inherits="Online.General.TemporarySign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "TemporarySignHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

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
                    }
                    <% if (1 == 2)
        { %>
,
                    tb_postaladdress: {
                        required: 'This field is required.'
                    }
                    <%}%>

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

            
            //"Election", "Event", "Community information" 
            $('#dd_purpose').change(function () {
                purpose = $(this).val();
                switch (purpose) {
                    case 'Election':
                        $('#div_election').show();
                        $('#div_event').hide();
                        $('#div_communityinformation').hide();
                        $('#div_eventdate').hide();
                        $('#lbl_dateto').text('To 12:00 midnight on');
                        $('#tb_datefrom').val('25 Sep 2019')
                        $('#tb_dateto').val('20 Oct 2019')
                        startdate = xx;
                        enddate = xx;
                        break;
                    case 'Event':
                        $('#div_election').hide();
                        $('#div_event').show();
                        $('#div_communityinformation').hide();
                        $('#div_eventdate').show();
                        $('#lbl_dateto').text('Date to');
                        break;
                    case 'Community information':
                        $('#div_election').hide();
                        $('#div_event').hide();
                        $('#div_communityinformation').show();
                        $('#div_eventdate').hide();
                        $('#lbl_dateto').text('Date to');
                        startdate = xx;
                        enddate = xx;
                        break;
                }

                $("#tb_eventdate").on("dp.change", function (e) {
                    //alert('To do: set the date from and date to events defaults');
                    //console.log(e);
                    thedate = $("#tb_eventdate").val();
                    $('#tb_datefrom').val(moment(thedate).subtract(2, 'months').format('D MMM YYYY'));
                    $('#tb_dateto').val(moment(thedate).format('D MMM YYYY'));
                });

            });
           
            

            //$('[required]').css('border', '1px solid red');

            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>


            <% if (1 == 2)
        { %>          

            $('#dd_fundraiser').change(function () {
                fundraiser = $(this).val();
                org = $('#dd_registered').val();
                if (fundraiser == 'Charitable organisation' || fundraiser == 'Community group' || org == 'Whanganui District Council' || org == 'Another territorial authority' || org == 'MPI') {
                    $('#div_notregistered').hide();
                } else {
                    $('#div_notregistered').show();
                }

                if (fundraiser == 'Charitable organisation' || fundraiser == 'Community group') {
                    $('#div_fundraiser').show();
                } else {
                    $('#div_fundraiser').hide();
                }

                if ($(this).val() == 'Charitable organisation') {
                    $("#tb_charityreference").rules("add", "required")
                    $("#tb_charityreference").toggleClass('required');
                    $('#div_charityreference').show();
                } else {
                    $("#tb_charityreference").rules("remove", "required")
                    $("#tb_charityreference").toggleClass('required');
                    $('#div_charityreference').hide();
                }
            });
            <% }%>

        }) //document.ready

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FileUpload ID="fu_dummy" runat="server" Style="display: none" />
    <!--Forces form to be rendered with enctype="multipart/form-data" -->
    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <asp:Literal ID="lit_user" runat="server"></asp:Literal>
    <h1>Application for a temporary sign on designated Council reserve land</h1>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_name">Name</label>
        <div class="col-sm-8">
            <input type="text" id="tb_name" name="tb_name" class="form-control" maxlength="100" value="<%: tb_applicant %>" required />
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
        <label class="control-label col-sm-4" for="dd_purpose">Purpose of sign(s)?</label>
        <div class="col-sm-8">
            <select id="dd_purpose" name="dd_purpose" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(dd_purpose_values, dd_purpose, "None")%>
            </select>
        </div>
    </div>





    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxx">Sign location(s)</label>
        <div class="col-sm-8">
            <div class="col-sm-8">
                <input id="cb_location1" name="cb_location" value="Cornmarket Reserve" type="checkbox" />
                Cornmarket Reserve
                <br />
                <input id="cb_location2" name="cb_location" value="London Street roundabout" type="checkbox" />
                London Street roundabout
                <br />
                <input id="cb_location3" name="cb_location" value="Anzac Parade (opposite Hakeke Street)" type="checkbox" />
                Anzac Parade (opposite Hakeke Street)
                <br />
                <input id="cb_location4" name="cb_location" value="Anzac Parade (opposite Georgetti Street)" type="checkbox" />
                Anzac Parade (opposite Georgetti Street)
                <br />
                <input id="cb_location5" name="cb_location" value="Corner of Liffiton Street and Carlton Avenue" type="checkbox" />
                Corner of Liffiton Street and Carlton Avenue
                <br />
                <input id="cb_location6" name="cb_location" value="Corner of Bamber Street and Cornfoot Street" type="checkbox" />
                Corner of Bamber Street and Cornfoot Street
            </div>
        </div>
    </div>


        <div class="panel panel-danger" id="div_election" style="display: none">
        <div class="panel-heading">Election</div>
        <div class="panel-body">
            <p>
               The earliest a sign may be erected is 25 September 2019 and they must be removed by 12:00 midnight on 20 October 2019  </p>
        </div>
    </div>

        <div class="panel panel-danger" id="div_event" style="display: none">
        <div class="panel-heading">Event</div>
        <div class="panel-body">
            <p>
              A sign must only be erected for a period of 2 months prior to the date of the last event displayed on the sign</p>

        </div>
    </div>

            <div class="panel panel-danger" id="div_communityinformation" style="display: none">
        <div class="panel-heading">Community information</div>
        <div class="panel-body">
            <p>
               A sign may only be erected for the period of 2 months </p>
        </div>
    </div>

    <div id="div_eventdate" class="form-group" style="display: none">
        <label class="control-label col-sm-4" for="tb_eventdate">Event date</label>
        <div class="col-sm-8">
            <input type="text" id="tb_eventdate" name="tb_eventdate" class="form-control dateonly" value="" required />
        </div>
    </div>





    

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_datefrom">Date from</label>
        <div class="col-sm-8">
            <input type="text" id="tb_datefrom" name="tb_datefrom" class="form-control dateonly" value="" required />
        </div>
    </div>


    <div class="form-group">
        <label id="lbl_dateto" class="control-label col-sm-4" for="tb_datefrom">Date to</label>
        <div class="col-sm-8">
            <input type="text" id="tb_dateto" name="tb_dateto" class="form-control dateonly" value="" required />
        </div>
    </div>





    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_requirements">Please confirm that the sign(s) meet the dimentions and requirements as set out on <a href="xxx">CSG-006</a></label>
        <div class="col-sm-8">
            <select id="dd_requirements" name="dd_requirements" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(yes_values, dd_requirements, "None")%>
            </select>
        </div>
    </div>

        <div class="form-group">
        <label class="control-label col-sm-4" for="dd_dates">Please confirm that the sign(s) will be not be erected prior to the "Date from" and will be removed by the "Date to" stipulated above</label>
        <div class="col-sm-8">
            <select id="dd_dates" name="dd_dates" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(yes_values, dd_requirements, "None")%>
            </select>
        </div>
    </div>

        <div class="form-group">
        <label class="control-label col-sm-4" for="design">Please upload a copy of the sign design</label><div class="col-sm-8">
            <!--<asp:FileUpload ID="fu_design" runat="server" />-->
            <input id="fu_design" name="fu_design" type="file" />
            <asp:Label ID="lbl_design" runat="server" Text=""></asp:Label>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_generalinformation">
            General information
            <img src="../Images/questionsmall.png" title="Please let us know any other information that the Council should consider in this application." /></label><div class="col-sm-8">
                <textarea id="tb_generalinformation" name="tb_generalinformation" class="form-control" rows="4" maxlength="500" required></textarea>
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
