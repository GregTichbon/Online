<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Online.Animals.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="<%: ResolveUrl("~/Scripts/pwstrength-bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/Mask/JQuery.Maks.min.js")%>"></script>

    <script type="text/javascript">

        var sitearray = [];

        $(document).ready(function () {

            var sitectr = 0;
            $(".phone-group").mask('009 0000000999');

            $("#pagehelp").colorbox({ href: "RegisterHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            /*
            window.onbeforeunload = function () {
                if ($("#pagehelp").css("display") == "block") {
                    return 'Check unload';
                }
            };
            */

            $('.adddog').click(function () {
                addrepeater();
            });


            function addrepeater() {

                // validator.resetForm();

                //var lastRepeatingGroup = $('#div_site_0').last();

                //var cloned = lastRepeatingGroup.clone()
                var cloned = $('#div_site_').clone()

                sitectr = sitectr + 1;
                sitearray.push(sitectr);
                //alert(sitearray);
                $("#hf_sitearray").val(sitearray.toString());
                cloned = cloned.repeater_changer(sitectr);

                var place = $('.adddog');
                cloned.insertBefore(place);

                validator.groups['tb_daytodaymanagerphonemobile_' + sitectr] = 'daytodaymanagerphone_' + sitectr;
                validator.groups['tb_daytodaymanagerphonehome_' + sitectr] = 'daytodaymanagerphone_' + sitectr;
                validator.groups['tb_daytodaymanagerphonework_' + sitectr] = 'daytodaymanagerphone_' + sitectr;

                $("#repeat_site_tb_daytodaymanagerphonemobile_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_daytodaymanagerphone_" + sitectr],   //this should match the class on the element
                    pattern: /02[0-9] \d{5,9}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                    }
                });


                $("#repeat_site_tb_daytodaymanagerphonehome_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_daytodaymanagerphone_" + sitectr],   //this should match the class on the element
                    pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }
                });

                $("#repeat_site_tb_daytodaymanagerphonework_" + sitectr).rules("add", {
                    require_from_group: [1, ".validgroup_daytodaymanagerphone_" + sitectr],    //this should match the class on the element
                    pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/,
                    messages: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    }
                });

                return false;
            };


            addrepeater();



            // Delete a repeating section
            // $('.deletesite').on('click', function () {
            $('body').on('click', '.deletesite', function () {
                //$('.deletesite').click(function () {
                if ($('[id^=div_site_]').length == 2) {
                    alert('You can not delete this site, at least 1 site is required.')
                } else {
                    var siteid = this.id.substring(23)
                    if (window.confirm("Are you sure you want to delete this site?")) {
                        $('#div_site_' + siteid).remove();
                        sitearray.splice($.inArray(siteid, sitearray), 1);
                        $("#hf_sitearray").val(sitearray.toString());
                    }
                }
                return false;
            });



            $("#form1").validate({
                groups: {
                    phone_numbers: "tb_mobilephone tb_homephone tb_workphone"
                },
                rules: {
                    tb_emailconfirm: {
                        //equalTo: '#tb_emailaddress'
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
                    tb_dateofbirth: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
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
                    tb_dateofbirth: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }
            });


            $('#cb_residentialaddressformat').click(function () {
                if ($('#span_residentialaddressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_residentialaddressformat').text('Free format address mode (not preferred)');
                    $("#tb_residentialaddress").autocomplete("disable");
                } else {
                    $('#span_residentialaddressformat').text('Address lookup mode (preferred)');
                    $("#tb_residentialaddress").autocomplete("enable");
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

            $("#tb_residentialaddress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_residentialaddress").val(ui.item ?
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

            .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .append("<a>" + item.label + "</a>")
                  .appendTo(ul);
            };

            /*
            $('#tb_dateofbirth').datepick({
                dateFormat: 'd M yyyy',
                defaultDate: '-30y',
                showOnFocus: false,
                showTrigger: '#btn_dateofbirth',
                onSelect: function (dates) {
                    calculate_age(new Date(dates));
                }
            });
            */

            //$("#tb_dateofbirth").keydown(false);  //Force entry through datetimepicker
            $('#div_dateofbirth').datetimepicker({
                //$('#tb_dateofbirth').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'years'
                //,maxDate: moment().add(-1, 'year')




                // format: 'D MMM YYYY',
                // viewMode: 'years',
                // //defaultDate: moment().subtract(30, 'years'),
                //showClear: true,
                //viewDate: false
            });



            /*
            $("#span_dateofbirth_trigger").datepicker({
    
                dateFormat: "d M yy",
                changeMonth: true,
                changeYear: true,
                onSelect: function (dateStr) {
                    $("#tb_dateofbirth").val(dateStr);
                    $('#span_dateofbirth_trigger').hide();
                    calculate_age($(this).datepicker('getDate'));
                }
            }).toggle();
            $('#btn_dateofbirth').click(function () {
                $('#span_dateofbirth_trigger').show();
            });
            */


            $("#div_dateofbirth").on("dp.change", function (e) {
                //$("#tb_dateofbirth").on("dp.change", function (e) {
                if (moment().diff(e.date, 'seconds') < 0) {
                    e.date = moment(e.date).subtract(100, 'years');
                    $("#tb_dateofbirth").val(moment(e.date).format('D MMM YYYY'));
                }
                var years = moment().diff(e.date, 'years');
                //alert(years);
                $("#span_age").text('Age: ' + years + ' years');
                //calculate_age(e.date);    
            });

            /*
            $("#div_dateofbirth").on("dp.error", function (e) {
                alert(e.date);
                console.log(e);
            });
            */

            /*
            $("#tb_dateofbirth").change(function () {
                alert(1);
                calculate_age(new Date($('#tb_dateofbirth').val()));
            });
    
            function calculate_age(birthday) {
                var today = new Date();
                var nextbirthday = new Date(today.getFullYear(), birthday.getMonth(), birthday.getDate());
                if (isNaN(nextbirthday)) {
                    $("#span_age").text('');
                } else {
                    var age = today.getFullYear() - birthday.getFullYear();
                    if (nextbirthday > today) {
                        age = age - 1;
                    }
                    $("#span_age").text('Age: ' + age + ' years');
                }
            };
            */
            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string selected;
        string none = "none";
    %>
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>New Dog Owner Registration
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true" Style="width: 100%"></asp:TextBox>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
        <div class="col-sm-8">
            <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_firstname">
            First name
            <img src="../Images/questionsmall.png" title="Only your first name in full.  If you are known by a 'nickname' or shortened version of your first name please enter it in the 'Known as' field below." /></label>
        <div class="col-sm-8">
            <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_othernames">
            Other names
            <img src="../Images/questionsmall.png" title="ie: middle names." /></label>
        <div class="col-sm-8">
            <input id="tb_othernames" name="tb_othernames" type="text" class="form-control" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_knownas">Known as</label>
        <div class="col-sm-8">
            <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" />
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_residentialaddressformat">
            Residential address
            <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_residentialaddressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_residentialaddressformat">Change</a>
            <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="4" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_postaladdressformat">
            Postal address
            <img src="../Images/questionsmall.png" title="This is only required if different to the residential address above. If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_postaladdressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_postaladdressformat">Change</a>
            <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="4"></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" required />
        </div>
    </div>
    <div class="form-group" id="div_emailconfirm">
        <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
        <div class="col-sm-8">
            <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste required" autocomplete="off" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_mobilephone">Mobile phone</label>
        <div class="col-sm-8">
            <input id="tb_mobilephone" placeholder="eg: 027 123456..." name="tb_mobilephone" type="text" class="form-control phone-group" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_homephone">Home phone</label>
        <div class="col-sm-8">
            <input id="tb_homephone" name="tb_homephone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_workphone">Work phone</label>
        <div class="col-sm-8">
            <input id="tb_workphone" name="tb_workphone" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
        <div class="col-sm-8">
            <select id="dd_gender" name="dd_gender" class="form-control" required>
                <option></option>
                <%=Online.WDCFunctions.WDCFunctions.populateselect(genders, "", "None")%>
            </select>
        </div>
    </div>



    <div class="form-group">
        <label for="tb_dateofbirth" class="control-label col-sm-4">
            Date of birth
            <img src="../Images/questionsmall.png" title="Your date of birth will help us better locate you on our council records and will help distinguish you from others with the same name" /></label>
        <div class="col-sm-8">
            <div class="input-group date" id="div_dateofbirth">
                <input id="tb_dateofbirth" name="tb_dateofbirth" required placeholder="eg: 23 Jun 1985" type="text" class="form-control" />

                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>

                <span id="span_age" class="input-group-addon"></span>
            </div>
        </div>
    </div>



    <a href="javascript:void(0);" class="adddog">Add Dog</a>


    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
        </div>
    </div>


    <div style="display: <%:none%>">
        <!-- REPEATER SECTION -->
        <!-- Accordian header start -->
        <div id="div_site_" class="repeatupdateid">
            <div class="panel-group">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a data-toggle="collapse" href="#collapse_site_" class="repeatupdatehref">
                            <h4 class="panel-title repeatupdatehtml">Dog 1</h4>
                        </a>
                    </div>
                    <div id="collapse_site_" class="panel-collapse collapse repeatupdateid">
                        <div class="panel-body">

                            <!-- Accordian header end -->




                            <!-- Name -->

                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_tb_name_">Name</label>
                                <div class="col-sm-8">
                                    <input type="text" id="repeat_site_tb_name_" class="form-control" maxlength="100" required />
                                </div>
                            </div>

                            <!-- Breed-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_breed1_">Breed</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_breed1_" class="form-control" required>
                                        <option></option>
                                        <%= breeds %>

                                    </select>
                                </div>
                            </div>

                            <!-- Breed-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_breed2_">Breed</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_breed2_" class="form-control" required>
                                        <option></option>
                                        <%= breeds %>

                                    </select>
                                </div>
                            </div>

                            <!-- Age-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_years_">Age</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_years_" class="form-control" required>
                                        <option></option>


                                    </select>
                                </div>
                            </div>
                            <!-- Age-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_months_">Age</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_months_" class="form-control" required>
                                        <option></option>


                                    </select>
                                </div>
                            </div>

                            <!-- Colour-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_colour1_">Colour</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_colour1_" class="form-control" required>
                                        <option></option>


                                    </select>
                                </div>
                            </div>

                            <!-- Colour-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_colour2_">Colour</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_colour2_" class="form-control" required>
                                        <option></option>


                                    </select>
                                </div>
                            </div>


                            <!-- Gender-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_gender_">Gender</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_gender_" class="form-control" required>
                                        <option></option>


                                    </select>
                                </div>
                            </div>

                            <!-- Neutered-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_dd_neutered_">Neutered</label>
                                <div class="col-sm-8">
                                    <select id="repeat_site_dd_neutered_" class="form-control" required>
                                        <option></option>


                                    </select>
                                </div>
                            </div>
                            <!-- Chip-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_tb_chip_">Chip</label>
                                <div class="col-sm-8">
                                    <input type="text" id="repeat_site_tb_chip_" class="form-control" maxlength="100" required />
                                </div>
                            </div>

                            <!-- Distinguishin Marks-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="repeat_site_tb_marks_">Distinguishin Marks</label>
                                <div class="col-sm-8">
                                    <input type="text" id="repeat_site_tb_marks_" class="form-control" maxlength="100" required />
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
                <!-- Accordian footer end -->


            </div>
        </div>
        <!-- END OF REPEATER SECTION -->

    </div>





</asp:Content>
