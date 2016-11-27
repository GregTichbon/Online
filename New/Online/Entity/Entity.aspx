<%@ Page Title="Entity Information" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Entity.aspx.cs" Inherits="Online.Entity.Entity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <script src="<%: ResolveUrl("~/Scripts/pwstrength-bootstrap.min.js")%>"></script>

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

            var populatelink = '<a id="populate" href="javascript:void(0)">Populate</a>'
            $("body").prepend(populatelink);

            $("#populate").click(function () {
                $('input, textarea, select').each(function () {
                    if (this.id.substring(0, 2) == '__' || this.id.substr(this.id.length - 1) == '_' || ($(this).attr('readonly') == 'readonly')) {
                        //alert(this.id + ', ' + this.id.substr(this.id.length - 1) + ', ' + $(this).attr('readonly'));
                    } else {
                        thetype = this.type;
                        switch (thetype) {
                            case 'email':
                                this.value = 'greg.tichbon@whanganui.govt.nz'
                                break;
                            case 'select-one':
                                $(this).val($('#' + this.id + ' option:last').val());
                            case 'checkbox':
                                $(this).prop('checked', true);
                                break;
                            case 'file':
                                break;
                            case 'submit':
                                break;
                            default:
                                if (this.id.indexOf('phone') > -1) {
                                    this.value = '027 123456'
                                } else {
                                    //alert(this.id + ', ' + thetype);
                                    this.value = this.id;
                                }
                        }
                    }
                })
            })


            $("#pagehelp").colorbox({ href: "EntityHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });




            $("#form1").validate({
                groups: {
                    phone_numbers: "tb_mobilephone tb_homephone tb_workphone"
                },
                rules: {
                    tb_emailaddress: {
                        remote: "../functions/data.asmx/entity_emailaddress"
                    },
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
                    tb_dateofbirth: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    },
                    tb_password: {
                        pattern: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,12}$/
                    },
                    tb_passwordconfirm: {
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
                    tb_password: 'Must be between 6 and 8 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit'
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
                debug: true,
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

            $('#div_dateofbirth').datetimepicker({
                format: 'D MMM YYYY',
                viewMode: 'years',
                //defaultDate: moment().subtract(30, 'years'),
                showClear: true,
                viewDate: false
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
                //alert(e.date);
                var years = moment().diff(e.date, 'years');
                //alert(years);
                $("#span_age").text('Age: ' + years + ' years');
                //calculate_age(e.date);    
            });

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

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string selected;
        string none = "none";
    %>
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Entity Information
    </h1>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address</label>
        <div class="col-sm-8">
            <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control" value="<%:tb_emailaddress%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailconfirm">Please re-type your email address</label>
        <div class="col-sm-8">
            <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" value="<%:tb_emailconfirm%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_lastname">Last name</label>
        <div class="col-sm-8">
            <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_firstname">First name</label>
        <div class="col-sm-8">
            <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_othernames">Other names</label>
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
        <label class="control-label col-sm-4" for="cb_residentialaddressformat">Residential address <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_residentialaddressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_residentialaddressformat">Change</a>
            <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="4" required><%:tb_residentialaddress%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_postaladdressformat">Postal address <img src="../Images/questionsmall.png" title="This is only required if different to the residential address above. If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
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
                <%
                    foreach (string gender in genders)
                    {
                        if (gender == dd_gender_value)
                        {
                            selected = " selected";
                        }
                        else
                        {
                            selected = "";
                        }
                        Response.Write("<option" + selected + ">" + gender + "</option>");
                    }
                %>
            </select>
        </div>
    </div>



    <div class="form-group">
        <label for="tb_dateofbirth" class="control-label col-sm-4">Date of birth <img src="../Images/questionsmall.png" title="Your date of birth will help us better to locate you on our council records and will help distinguish you from others with the same name’" /></label>
        <div class="col-sm-8">
            <div class="input-group date" id="div_dateofbirth">
                <input id="tb_dateofbirth" name="tb_dateofbirth" required placeholder="eg: 23 Jun 1985" type="date" class="form-control" value="<%:tb_dateofbirth%>" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                    <span id="span_age" class="input-group-addon"></span>
            </div>
        </div>
    </div>

      <div class="form-group" id="pwd-container">
        <label class="control-label col-sm-4" for="tb_password">Password</label>
        <div class="col-sm-3">
            <input id="tb_password" name="tb_password" type="password" class="form-control" required />
        </div>
        <div class="col-sm-3" style="padding-top: 10px;">
            <div class="pwstrength_viewport_progress"></div>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_passwordconfirm">Please retype your password</label>
        <div class="col-sm-3">
            <input id="tb_passwordconfirm" name="tb_passwordconfirm" type="password" class="form-control inhibitcutcopypaste" required />
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
