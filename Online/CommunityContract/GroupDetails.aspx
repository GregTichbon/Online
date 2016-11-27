<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GroupDetails.aspx.cs" Inherits="Online.CommunityContract.GroupDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="//cdn.jsdelivr.net/jquery.dirtyforms/2.0.0/jquery.dirtyforms.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "GroupDetails.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            origemailaddress = $("#tb_emailaddress").val();

            $("#tb_emailaddress").keyup(function () {
                if ($("#tb_emailaddress").val() != origemailaddress) {
                    $("#div_emailconfirm").show();
                } else {
                    $("#div_emailconfirm").hide();
                }
            });

            $("#form1").validate({
                rules: {
                    tb_emailconfirm: {
                        equalTo: '#tb_emailaddress'
                    },
                    tb_paidstaff: {
                        number: true
                    },
                    tb_paidstaffhours: {
                        number: true
                    },
                    tb_volunteers: {
                        number: true
                    },
                    tb_volunteerhours: {
                        number: true
                    }
                }
            });

            $('#cb_physicaladdressformat').click(function () {
                if ($('#span_physicaladdressformat').text() == 'Address lookup mode (preferred)') {
                    $('#span_physicaladdressformat').text('Free format address mode (not preferred)');
                    $("#tb_physicaladdress").autocomplete("disable");
                } else {
                    $('#span_physicaladdressformat').text('Address lookup mode (preferred)');
                    $("#tb_physicaladdress").autocomplete("enable");
                }
            })



            $("#tb_physicaladdress").autocomplete({
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    $("#tb_physicaladdress").val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
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


            $('form').dirtyForms();

            $('#populate').click(function () {
                $("#form1").find("input[type=text], textarea").val($(this).attr('id'));

            });



        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hf_groupdetails_ctr" Value="0" runat="server" />
    <asp:HiddenField ID="hf_users_ctr" runat="server" />
    <asp:HiddenField ID="hf_reference" runat="server" />
        <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="default.aspx">Community Contracts</a>
            </div>
            <!--
    <ul class="nav navbar-nav">dir
      <li class="active"><a href="#">Home</a></li>
      <li><a href="#">Page 1</a></li>

    </ul>
                  -->
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.aspx"><span class="glyphicon glyphicon-user"></span>Log out</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-user"></span>Reset Password</a></li>
                <li><a id="pagehelp">
                    <img id="helpiconz" src="http://wdc.whanganui.govt.nz/online/images/questionNavBar.png" title="Click on me for specific help on this page." /></a></li>
            </ul>
        </div>
    </nav>
    <a id="populate">Populate</a>
    <h1>Community Contracts Group Details
    </h1>
   <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Reference</label><div class="col-sm-8">
            <input id="tb_reference" name="tb_reference" type="text" readonly="readonly" class="form-control" value="<%:tb_reference%>" />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_grouptype">Type of your group
                    <img src="../Images/questionsmall.png" title="eg: Incorporated Society, Trust, Club, Society, or some other type of organisation." />

        </label><div class="col-sm-8">
            <input id="tb_grouptype" name="tb_grouptype" type="text" class="form-control" required maxlength="100" value="<%:tb_grouptype%>" />



         


        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_legalname">Legal name of your group</label><div class="col-sm-8">
            <input id="tb_legalname" name="tb_legalname" type="text" class="form-control" required maxlength="100" value="<%:tb_legalname%>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_charitiesnumber">What is your charities number if you have one?
            
                    <img src="../Images/questionsmall.png" title="Please enter 'None' if you are not registered" />
        </label><div class="col-sm-8">
            <input id="tb_charitiesnumber" name="tb_charitiesnumber" type="text" class="form-control" maxlength="20" value="<%:tb_charitiesnumber%>" />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_physicaladdressformat">
            Physical address
        <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." />
        </label>
        <div class="col-sm-8">
            <span id="span_physicaladdressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_physicaladdressformat">Change</a>
            <textarea id="tb_physicaladdress" name="tb_physicaladdress" class="form-control" rows="4" required maxlength="500"><%:tb_physicaladdress%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_postaladdressformat">
            Postal address (only required if different)
        <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." />
        </label>
        <div class="col-sm-8">
            <span id="span_postaladdressformat">Address lookup mode (preferred)</span>
            <a href="javascript:void(0);" id="cb_postaladdressformat">Change</a>
            <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="4" maxlength="500"><%:tb_postaladdress%></textarea>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_bankaccountnumber">Bank Account Number </label>
        <div class="col-sm-8">
            <input id="tb_bankaccountnumber" name="tb_bankaccountnumber" type="text" class="form-control" value="<%:tb_bankaccountnumber%>" required maxlength="20" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_gstnumber">GST Number
                    <img src="../Images/questionsmall.png" title="If registered." /></label><div class="col-sm-8">
            <input id="tb_gstnumber" name="tb_gstnumber" type="text" class="form-control" value="<%:tb_gstnumber%>" required maxlength="20" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_phonenumber">Phone Numbers</label><div class="col-sm-8">
            <input id="tb_phonenumber" name="tb_phonenumber" type="text" class="form-control" value="<%:tb_phonenumber%>" required maxlength="40" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email Address</label><div class="col-sm-8">
            <input id="tb_emailaddress" name="tb_emailaddress" type="email" class="form-control inhibitcutcopypaste" value="<%:tb_emailaddress%>" required maxlength="100" />
        </div>
    </div>
    <div id="div_emailconfirm" class="form-group" style="display:none">
        <label class="control-label col-sm-4" for="tb_emailconfirm">Please confirm the Email Address</label><div class="col-sm-8">
            <input id="tb_emailconfirm" name="tb_emailconfirm" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_facebook">Facebook Page
                    <img src="../Images/questionsmall.png" title="Please use the URL eg: https://www.facebook.com/whanganuidistrictcouncil" /></label><div class="col-sm-8">
            <input id="tb_facebook" name="tb_facebook" type="url" class="form-control" maxlength="100" value="<%:tb_facebook%>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_website">Website
                    <img src="../Images/questionsmall.png" title="Please use the URL eg: http://www.whanganui.govt.nz" /></label><div class="col-sm-8">
            <input id="tb_website" name="tb_website" type="url" class="form-control" maxlength="100" value="<%:tb_website%>" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_umbrellagroup">Does your group have some form of umbrella group?  If so who is it?</label><div class="col-sm-8">
            <input id="tb_umbrellagroup" name="tb_umbrellagroup" type="text" class="form-control" maxlength="50" value="<%:tb_umbrellagroup%>" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_constitution">Does the group have a constitution?</label>
        <div class="col-sm-8">
            <select id="dd_constitution" name="dd_constitution" class="form-control" required>
                <option></option>
                <%
                    foreach (string dd_value in yesno_values)
                    {
                        if (dd_value == dd_constitution)
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
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="fu_strategicplan">If you have a strategic plan please attach it.</label><div class="col-sm-8">
            <asp:FileUpload ID="fu_strategicplan" runat="server" AllowMultiple="True" /><asp:HiddenField ID="hf_strategicplan" runat="server" Value="File(s) not provided" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_employedstaff">How do you employ staff in your group?
                    <img src="../Images/questionsmall.png" title="Please describe your process." /></label><div class="col-sm-8">

            <textarea id="tb_employedstaff" name="tb_employedstaff" rows="3" class="form-control" required maxlength="500"><%:tb_employedstaff%></textarea>


        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_employmentcontracts">Do you have individual or collective employment contracts?
                    <img src="../Images/questionsmall.png" title="Please add comments as required." /></label><div class="col-sm-8">
                        <textarea id="tb_employmentcontracts" name="tb_employmentcontracts" rows="3" class="form-control" required maxlength="200"><%:tb_employmentcontracts%></textarea>
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_jobdescriptions">Are there job descriptions in place?  
                    <img src="../Images/questionsmall.png" title="Please add comments as required." /></label>
        <div class="col-sm-8">
                        <textarea id="tb_jobdescriptions" name="tb_jobdescriptions" rows="2" class="form-control" required maxlength="500"><%:tb_jobdescriptions%></textarea>

        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_performancemanagement">Is there performance management in place for the management team and staff?
                    <img src="../Images/questionsmall.png" title="Please add comments as required." /></label><div class="col-sm-8">

                        <textarea id="tb_performancemanagement" name="tb_performancemanagement" rows="2" class="form-control" required maxlength="500"><%:tb_performancemanagement%></textarea>        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_paidstaff ">How many paid staff do you have?</label><div class="col-sm-8">
            <input id="tb_paidstaff" name="tb_paidstaff" type="text" class="form-control" value="<%:tb_paidstaff%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_paidstaffhours">How many paid hours per week on average are worked?</label><div class="col-sm-8">
            <input id="tb_paidstaffhours" name="tb_paidstaffhours" type="text" class="form-control" value="<%:tb_paidstaffhours%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_volunteers">How many volunteers do you have?</label><div class="col-sm-8">
            <input id="tb_volunteers" name="tb_volunteers" type="text" class="form-control" value="<%:tb_volunteers%>" required />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_volunteerhours">How many volunteer hours per week on average are worked?</label><div class="col-sm-8">
            <input id="tb_volunteerhours" name="tb_volunteerhours" type="text" class="form-control" value="<%:tb_volunteerhours%>" required />
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="dd_financialpoliciespractices">Are there financial management policies and practises in place?</label>
        <div class="col-sm-8">
            <select id="dd_financialpoliciespractices" name="dd_financialpoliciespractices" class="form-control" required>
                <option></option>
                <%
                    foreach (string dd_value in yesno_values)
                    {
                        if (dd_value == dd_financialpoliciespractices)
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
        </div>
    </div>


        <div class="form-group">
        <label class="control-label col-sm-4" for="dd_financialpeople">Are there specific people identified to manage the finances of your group?</label>
        <div class="col-sm-8">
            <select id="dd_financialpeople" name="dd_financialpeople" class="form-control" required>
                <option></option>
                <%
                    foreach (string dd_value in yesno_values)
                    {
                        if (dd_value == dd_financialpeople)
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
        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_accountingprogramme">What is the financial accounting system that you use?
                    <img src="../Images/questionsmall.png" title="Spreadsheets, MYOB, Quickbooks, Xero, other systems." /></label><div class="col-sm-8">
            <input id="tb_accountingprogramme" name="tb_accountingprogramme" type="text" class="form-control" value="<%:tb_accountingprogramme%>" required maxlength="200" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_financialreports">What financial reports do you produce, how often, and to whom are these distributed?</label><div class="col-sm-8">

            <textarea id="tb_financialreports" name="tb_financialreports" rows="3" class="form-control" required maxlength="500"><%:tb_financialreports%></textarea>

        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_financialyear">What is your financial year end?
                    <img src="../Images/questionsmall.png" title="eg: 31 March, 30 June etc" /></label><div class="col-sm-8">
            <input id="tb_financialyear" name="tb_financialyear" type="text" class="form-control" value="<%:tb_financialyear%>" required maxlength="20" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_payrollsystem">What is the payroll system that you use?
                    <img src="../Images/questionsmall.png" title="Manual, Electronic, PAYE records, Other payment methods." /></label><div class="col-sm-8">
            <input id="tb_payrollsystem" name="tb_payrollsystem" type="text" class="form-control" value="<%:tb_payrollsystem%>" required maxlength="200" />
        </div>
    </div>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_premises">Are the premises leased, owned or rented?</label><div class="col-sm-8">
            <input id="tb_premises" name="tb_premises" type="text" class="form-control" value="<%:tb_premises%>" required maxlength="100" />
        </div>
    </div>


        <div class="form-group">
        <label class="control-label col-sm-4" for="dd_complaints">Do you have policies and practices in place for recording and dealing with complaints?</label>
        <div class="col-sm-8">
            <select id="dd_complaints" name="dd_complaints" class="form-control" required>
                <option></option>
                <%
                    foreach (string dd_value in yesno_values)
                    {
                        if (dd_value == dd_complaints)
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
        </div>
    </div>






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
