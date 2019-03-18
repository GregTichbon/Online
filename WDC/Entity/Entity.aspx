<%@ Page Title="Entity Information" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Entity.aspx.cs" Inherits="Online.Entity.Entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="<%: ResolveUrl("~/Scripts/pwstrength-bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Scripts/Mask/JQuery.Maks.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            /*
            var fieldsdiv = $("<div>", { id: "fields" });
            $("body").append(fieldsdiv);

            var x = '';
            $('input, textarea, select').each(function (index) {
                // x = x + '<br>' + '@pre' + this.id + '@post';
                if (this.id.substring(0, 2) != '__') {
                    var $myLabel = $('label[for="' + this.id + '"]');
                    x = x + '<br>' + $myLabel.html() + "=" + this.id;
                }

            })
            $('#fields').html(x);
            */

            <% if (hf_entity_ctr != "") {%>
            $('#div_emailconfirm').hide();
            $('#tb_emailaddress').change(function () {
                if ($('#tb_emailaddress').val() != '<%:tb_emailaddress%>') {
                    $('#tb_emailconfirm').addClass('required');
                    $('#div_emailconfirm').show();
                } else {
                    $('#tb_emailconfirm').removeClass('required');
                    $('#div_emailconfirm').hide();
                }
            });
            var years = moment().diff($('#tb_dateofbirth').val(), 'years');
            $("#span_age").text('Age: ' + years + ' years');

            $('#div_password').hide();
            $('#href_changepassword').click(function () {
                if ($('#href_changepassword').text() == "Don't change password") {
                    $('#href_changepassword').text("Change password");
                    $('#tb_password').val('');
                    $('#tb_passwordconfirm').val('');
                    $('#div_password').hide();
                } else {
                    $('#href_changepassword').text("Don't change password");
                    $('#div_password').show();
                }
            })

            <%}%>

            $(".phone-group").mask('009 0000000999');

            $("#pagehelp").colorbox({ href: "EntityHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            window.onbeforeunload = function () {
                if ($("#pagehelp").css("display") == "block") {
                    return 'Check unload';
                }
            };

            // $('#tb_emailaddress').change(function () {
            //      alert($('#tb_emailaddress').val());
            //  });

            $.validator.addMethod("notEqualTo", function (value, element, param) {
                var target = $(param);
                if (value) return value != target.val();
                else return this.optional(element);
            }, "Your email address and username must not be the same.");


            $("#form1").validate({
                groups: {
                    phone_numbers: "tb_mobilephone tb_homephone tb_workphone"
                },
                rules: {
                    tb_emailaddress: {
                        notEqualTo: '#tb_username',
                        remote: {
                            url: "../functions/data.asmx/entity_usernameemailaddress",
                            data: {
                                usernameemailaddress: function () {
                                    return $('#tb_emailaddress').val();
                                },
                                entity_ctr: function () {
                                    return $('#hf_entity_ctr').val();
                                }
                            },
                            async: false
                        }
                    },
                    tb_emailconfirm: {
                        required: function (element) {
                               return ($("#hf_entity_ctr").val() == '' || $("#tb_emailaddress").val() != '<%:tb_emailaddress%>');
                        },
                        equalTo: '#tb_emailaddress'
                    },
                    tb_username: {
                        notEqualTo: '#tb_emailaddress',
                        remote: {
                            url: "../functions/data.asmx/entity_usernameemailaddress",
                            data: {
                                usernameemailaddress: function () {
                                    return $('#tb_username').val();
                                },
                                entity_ctr: function () {
                                    return $('#hf_entity_ctr').val();
                                }
                            },
                            async: false
                        }
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
                    },
                    tb_password: {
                        required: function (element) {
                            return $("#hf_entity_ctr").val() == '';
                        },
                        pattern: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,15}$/
                    },
                    tb_passwordconfirm: {
                        required: function (element) {
                            return ($("#hf_entity_ctr").val() == '' || $("#tb_password").val() != '');
                        },
                        equalTo: '#tb_password'
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
                    },
                    tb_password: 'Must be between 6 and 15 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit'
                }
            });

            "use strict";
            var options = {};
            options.ui = {
                container: "#pwd-container",
                showVerdictsInsideProgressBar: true,
                viewports: {
                    progress: ".pwstrength_viewport_progress"
                },
                progressBarExtraCssClasses: "progress-bar-striped active"
            };
            options.common = {
                debug: false,
                onLoad: function () {
                }
            };
            $('#tb_password').pwstrength(options);


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

            /*
            $("#tb_postaladdress").autocomplete({
                source: "../functions/data.asmx/PropertySelect?mode=address",
                minLength: 3,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_postaladdress").val(ui.item ?
                        //address.label + ", " + address.legaldescription + " " + address.area + ", " + "Property Number: " + address.value + ", Assessment Number: " + address.assessment_no :
                        address.label :
                    "Nothing selected, input was " + this.value);
                }
            })
            */
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
                viewMode: 'years',
                maxDate: moment().add(-1, 'year')




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
    <input type="hidden" id="hf_entity_ctr" name="hf_entity_ctr" value="<%:hf_entity_ctr%>" />
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Entity Information
    </h1>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Reference number:</label>
        <div class="col-sm-8">
            <asp:TextBox ID="tb_reference" name="tb_reference" runat="server" ReadOnly="true" style="width:100%"></asp:TextBox>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" value="<%:tb_emailaddress%>" required />
        </div>
    </div>
    <div class="form-group" id="div_emailconfirm">
        <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
        <div class="col-sm-8">
            <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste required" autocomplete="off" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_username">User name</label>
        <div class="col-sm-8">
            <input id="tb_username" name="tb_username" type="text" class="form-control" value="<%:tb_username%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
        <div class="col-sm-8">
            <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_firstname">First name <img src="../Images/questionsmall.png" title="Only your first name in full.  If you are known by a 'nickname' or shortened version of your first name please enter it in the 'Known as' field below." /></label>
        <div class="col-sm-8">
            <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_othernames">Other names <img src="../Images/questionsmall.png" title="ie: middle names." /></label>
        <div class="col-sm-8">
            <input id="tb_othernames" name="tb_othernames" type="text" class="form-control" value="<%:tb_othernames%>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_knownas">Known as</label>
        <div class="col-sm-8">
            <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" value="<%:tb_knownas%>" />
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_residentialaddressformat">
            Residential address
            <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_residentialaddressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_residentialaddressformat">Change</a>
            <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="4" required><%:tb_residentialaddress%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_postaladdressformat">
            Postal address
            <img src="../Images/questionsmall.png" title="This is only required if different to the residential address above. If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_postaladdressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_postaladdressformat">Change</a>
            <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="4"><%:tb_postaladdress%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_mobilephone">Mobile phone</label>
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
        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
        <div class="col-sm-8">
            <select id="dd_gender" name="dd_gender" class="form-control" required>
                <option></option>
                 <%=Online.WDCFunctions.WDCFunctions.populateselect(genders, dd_gender, "None")%>
            </select>
        </div>
    </div>



    <div class="form-group">
        <label for="tb_dateofbirth" class="control-label col-sm-4">
            Date of birth
            <img src="../Images/questionsmall.png" title="Your date of birth will help us better locate you on our council records and will help distinguish you from others with the same name" /></label>
        <div class="col-sm-8">
            <div class="input-group date" id="div_dateofbirth">
                <input id="tb_dateofbirth" name="tb_dateofbirth" required placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%:tb_dateofbirth%>" />
                
                <span class="input-group-addon">
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
           
                <span id="span_age" class="input-group-addon"></span>
            </div>
        </div>
    </div>

    <% if (hf_entity_ctr != "") {%>
    <div class="form-group" id="div_changepassword">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <a href="javascript:void(0);" id="href_changepassword">Change password</a>
        </div>
    </div>
    <%} %>
    <div id="div_password">
        <div class="form-group" id="pwd-container">
            <label class="control-label col-sm-4" for="tb_password">Password<img src="../Images/questionsmall.png" title="Your password must be between 6 and 15 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit." /></label>
            <div class="col-sm-3">
                <input id="tb_password" name="tb_password" type="password" class="form-control required" />
            </div>
            <div class="col-sm-3" style="padding-top: 10px;">
                <div class="pwstrength_viewport_progress"></div>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_passwordconfirm">Please retype your password</label>
            <div class="col-sm-3">
                <input id="tb_passwordconfirm" name="tb_passwordconfirm" type="password" class="form-control inhibitcutcopypaste required" />
            </div>
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
