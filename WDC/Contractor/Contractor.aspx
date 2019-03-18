<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contractor.aspx.cs" Inherits="Online.Contractor.Contractor" %>

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

            <% if (hf_contractor_ctr != "") {%>
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

            $(".phone").mask('009 0000000999');

            $("#pagehelp").colorbox({ href: "ContractorHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

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
                rules: {
                    tb_emailaddress: {
                        notEqualTo: '#tb_username',
                        remote: {
                            url: "../functions/data.asmx/contractor_usernameemailaddress",
                            data: {
                                usernameemailaddress: function () {
                                    return $('#tb_emailaddress').val();
                                },
                                contractor_ctr: function () {
                                    return $('#hf_contractor_ctr').val();
                                }
                            },
                            async: false
                        }
                    },
                    tb_emailconfirm: {
                        required: function (element) {
                               return ($("#hf_contractor_ctr").val() == '' || $("#tb_emailaddress").val() != '<%:tb_emailaddress%>');
                        },
                        equalTo: '#tb_emailaddress'
                    },
                    tb_username: {
                        notEqualTo: '#tb_emailaddress',
                        remote: {
                            url: "../functions/data.asmx/contractor_usernameemailaddress",
                            data: {
                                usernameemailaddress: function () {
                                    return $('#tb_username').val();
                                },
                                contractor_ctr: function () {
                                    return $('#hf_contractor_ctr').val();
                                }
                            },
                            async: false
                        }
                    },
                    tb_officephone: {
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_altphone: {
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                    },
                    tb_password: {
                        required: function (element) {
                            return $("#hf_contractor_ctr").val() == '';
                        },
                        pattern: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,15}$/
                    },
                    tb_passwordconfirm: {
                        required: function (element) {
                            return ($("#hf_contractor_ctr").val() == '' || $("#tb_password").val() != '');
                        },
                        equalTo: '#tb_password'
                    }

                },
                messages: {
                    tb_emailconfirm: {
                        equalTo: 'This must be the same as the email address above'
                    },
                    tb_officephone: {
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                    },
                    tb_altphone: {
                        require_from_group: 'Please provide at least 1 phone number',
                        pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
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

           .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li>")
                  //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                  .append("<a>" + item.label + "</a>")
                  .appendTo(ul);
            };

           
            <% =Online.WDCFunctions.WDCFunctions.googleanalyticstracking(false)%>

        }); //document.ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string selected;
        string none = "none";
    %>
    <input type="hidden" id="hf_contractor_ctr" name="hf_contractor_ctr" value="<%:hf_contractor_ctr%>" />
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Contractor Information
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
        <label class="control-label col-sm-4" for="tb_name">Name</label>
        <div class="col-sm-8">
            <input id="tb_name" name="tb_name" type="text" class="form-control" value="<%:tb_name%>" required />
        </div>
    </div>
     <div class="form-group">
        <label class="control-label col-sm-4" for="tb_contactperson">Contact person</label>
        <div class="col-sm-8">
            <input id="tb_contactperson" name="tb_contactperson" type="text" class="form-control" required value="<%:tb_contactperson%>" />
        </div>
    </div>   

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_addressformat">
             Address
            <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." /></label>
        <div class="col-sm-8">
            <span id="span_addressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_addressformat">Change</a>
            <textarea id="tb_address" name="tb_address" class="form-control" rows="4" required><%:tb_address%></textarea>
        </div>
    </div>

    

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_officephone">Office phone</label>
        <div class="col-sm-8">
            <input id="tb_officephone" placeholder="eg: 027 123456..." name="tb_officephone" type="text" class="form-control phone" value="<%:tb_officephone%>" />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_altphone">Alternative phone</label>
        <div class="col-sm-8">
            <input id="tb_altphone" placeholder="eg: 027 123456..." name="tb_altphone" type="text" class="form-control phone" value="<%:tb_altphone%>" />
        </div>
    </div>
     

    <% if (hf_contractor_ctr != "") {%>
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
            <label class="control-label col-sm-4" for="tb_password">Password <img src="../Images/questionsmall.png" title="Your password must be between 6 and 15 characters long.  It must include at least one upper case letter, one lower case letter, and one numeric digit." /></label>
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
