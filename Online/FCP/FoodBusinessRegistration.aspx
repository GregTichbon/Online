<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FoodBusinessRegistration.aspx.cs" Inherits="Online.FCP.FoodBusinessRegistration1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "FoodBusinessRegistration.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('#cb_before1mar2016').change(function () {
                if (this.checked) {
                    $('#div_registrationnumbers').show();
                } else {
                    $('#div_registrationnumbers').hide();
                }
            });


            var sitectr = 0;
            var options = {
                source: "../functions/data.asmx/NZPostAddressSearch",
                minLength: 5,
                select: function (event, ui) {
                    event.preventDefault();
                    address = ui.item;
                    thisid = this.id;
                    $('#' + thisid).val(ui.item ?
                        address.label.replace(/,/g, "\r\n") : "Nothing selected, input was " + this.value);
                }
            };



            $(document).ready(function () {
                
                var validator = $("#form1").validate({
                    groups: {
                        phone_numbers: "tb_applicantphonemobile tb_applicantphonehome tb_applicantphonework"
                    },
                    rules: {
                        tb_applicantemailconfirm: {
                            equalTo: '#tb_applicantemailaddress'
                        },
                        tb_applicantphonemobile: {
                            require_from_group: [1, ".phone-group"],
                            pattern: /02[0-9] \d{5,9}/
                        },
                        tb_applicantphonehome: {
                            require_from_group: [1, ".phone-group"],
                            pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                        },
                        tb_applicantphonework: {
                            require_from_group: [1, ".phone-group"],
                            pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/
                        }
                    },
                    messages: {
                        tb_applicantemailconfirm: {
                            equalTo: 'This must be the same as the email address above'
                        },
                        tb_applicantphonemobile: {
                            require_from_group: 'Please provide at least 1 phone number',
                            pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                        },
                        tb_applicantphonehome: {
                            require_from_group: 'Please provide at least 1 phone number',
                            pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                        },
                        tb_applicantphonework: {
                            require_from_group: 'Please provide at least 1 phone number',
                            pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                        }
                    }
                })

               

                $('body').on('click', '.addressformat', function () {
                    //$('.addressformat').click(function () {
                    thisid = this.id;
                    if ($('#span_' + thisid).text() == 'Address lookup mode (preferred)') {
                        $('#span_' + thisid).text('Free format address mode (not preferred)');
                        $('#tb_' + thisid).autocomplete("disable");
                    } else {
                        $('#span_' + thisid).text('Address lookup mode (preferred)');
                        $('#tb_' + thisid).autocomplete("enable");
                    }
                })

                $(document).on('keydown.autocomplete', '.autoaddress', function () {
                    $(this).autocomplete(options);
                });

                /*
                            $(".autoaddress").autocomplete({
                                source: "../functions/data.asmx/NZPostAddressSearch",
                                minLength: 5,
                                select: function (event, ui) {
                                    event.preventDefault();
                                    address = ui.item;email
                                    thisid = this.id;
                                    $('#' + thisid).val(ui.item ?
                                        address.label : "Nothing selected, input was " + this.value);
                                }
                            })
                
                
                            .autocomplete("instance")._renderItem = function (ul, item) {
                                return $("<li>")
                                    //.append("<a>" + item.label + "<br />" + item.legaldescription + " " + item.area + "</a>")
                                    .append("<a>" + item.label + "</a>")
                                    .appendTo(ul);
                            };
                */
                // Add a new repeating section
                $('.addsite').click(function () {
                    addrepeater();
                });


                function addrepeater() {

                    // validator.resetForm();

                    //var lastRepeatingGroup = $('#div_site_0').last();

                    //var cloned = lastRepeatingGroup.clone()
                    var cloned = $('#div_site_').clone()

                    sitectr = sitectr + 1;
                    cloned = cloned.repeater_changer(sitectr);

                    var place = $('.addsite');
                    cloned.insertAfter(place);
   
                    validator.groups['tb_daytodaymanagerphonemobile_' + sitectr] = 'daytodaymanagerphone_' + sitectr;
                    validator.groups['tb_daytodaymanagerphonehome_' + sitectr] = 'daytodaymanagerphone_' + sitectr;
                    validator.groups['tb_daytodaymanagerphonework_' + sitectr] = 'daytodaymanagerphone_' + sitectr;

                    $("#tb_daytodaymanagerphonemobile_" + sitectr).rules("add", {
                        require_from_group: [1, ".validgroup_daytodaymanagerphone_" + sitectr],   //this should match the class on the element
                        pattern: /02[0-9] \d{5,9}/,
                        messages: {
                            require_from_group: 'Please provide at least 1 phone number',
                            pattern: 'Must be in the format: 02? number, eg: 027 123456...'
                        }
                    });
  

                    $("#tb_daytodaymanagerphonehome_" + sitectr).rules("add", {
                        require_from_group: [1, ".validgroup_daytodaymanagerphone_" + sitectr],   //this should match the class on the element
                        pattern: /02[0-9] \d{5,9}|0[0-9] \d{7}/,
                        messages: {
                            require_from_group: 'Please provide at least 1 phone number',
                            pattern: 'Must be in the format: 0? number, eg: 06 1234567 or  02? number, eg: 027 123456...'
                        }
                    });

                    $("#tb_daytodaymanagerphonework_" + sitectr).rules("add", {
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
                $('.deletesite').click(function () {
                    if ($('[id^=div_site_]').length == 2) {
                        alert('You can not delete this site, at least 1 site is required.')
                    } else {
                        var siteid = this.id.substring(11)
                        if (window.confirm("Are you sure you want to delete this site?")) {
                            $('#div_site_' + siteid).remove();
                        }
                    }
                    return false;
                });


            });


            $('#cb_wheredoifit').change(function () {
                thischecked = this.checked;
                if (thischecked) {
                    $('#div_showform').show();
                } else {
                    $('#div_showform').hide();
                }
            });

            
            $('#dd_businesstype').change(function () {
                if (this.value == 'Company') {
                    $('#div_businessnumber').show();
                } else {
                    $('#div_businessnumber').hide();
                }
            });


            $('#dd_verificationagency').change(function () {
                selectedvalue = $('#dd_verificationagency :selected').text();
                if (selectedvalue == 'Whanganui District Council' || selectedvalue == '') {
                    $('#div_verificationagencyconfirmation').hide();
                } else {
                    $('#div_verificationagencyconfirmation').show();

                }
            });

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Food Business Registration Application
    </h1>


    <div class="form-group">
        <label class="control-label col-sm-4" for="cb_wheredoifit">Have you completed <a href="http://www.mpi.govt.nz/food-safety/food-act-2014/where-do-i-fit" target="_blank">"Where do I fit"</a> on the MPI website and ensured that you need to complete this application?</label>
        <div class="col-sm-1">
            <input id="cb_wheredoifit" name="cb_wheredoifit" class="form-control" type="checkbox" value="Where do I fit?" />
        </div>
    </div>

    <div id="div_showform" style="display: <%:none%>">

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_reference">Application reference number:</label>
            <div class="col-sm-8">
                <asp:TextBox ID="tb_reference" runat="server" ReadOnly="true"></asp:TextBox>
            </div>
        </div>




        <!-- Day-to-day person -->

        <div class="form-group">
            <label class="control-label col-sm-4 repeatupdatefor" for="tb_applicant">Applicant's name</label>
            <div class="col-sm-8">
                <input id="tb_applicant" name="tb_applicant" type="text" class="form-control" required />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4 repeatupdatefor" for="tb_applicantemailaddress">Email address</label>
            <div class="col-sm-8">
                <input id="tb_applicantemailaddress" name="tb_applicantemailaddress" type="email" class="form-control" required />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4 repeatupdatefor" for="tb_applicantemailconfirm">Please re-type your email address</label>
            <div class="col-sm-8">
                <input id="tb_applicantemailconfirm" name="tb_applicantemailconfirm" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" required />
            </div>
        </div>




        <div class="form-group">
            <label class="control-label col-sm-4 repeatupdatefor" for="tb_applicantphonemobile">Mobile phone</label>
            <div class="col-sm-8">
                <input id="tb_applicantphonemobile" placeholder="eg: 027 123456..." name="tb_applicantphonemobile" type="text" class="form-control phone-group" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4 repeatupdatefor" for="tb_applicantphonehome">Home phone</label>
            <div class="col-sm-8">
                <input id="tb_applicantphonehome" name="tb_applicantphonehome" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" />
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4 repeatupdatefor" for="tb_applicantphonework">Work phone</label>
            <div class="col-sm-8">
                <input id="tb_applicantphonework" name="tb_applicantphonework" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control phone-group" />
            </div>
        </div>






        <!-- Registered before 1 March 2016-->

        <div class="form-group">
            <label class="control-label col-sm-4" for="cb_before1mar2016">Was your business registered before 1 March 2016? </label>
            <div class="col-sm-1">
                <input id="cb_before1mar2016" name="cb_before1mar2016" class="form-control" type="checkbox" value="Registered before 1 March 2016" />
            </div>
        </div>

        <!-- Registered before 1 March 2016 Registration numbers -->

        <div class="form-group" id="div_registrationnumbers" style="display: <%: none%>">
            <label class="control-label col-sm-4" for="tb_registrationnumbers">Registration numbers</label>
            <div class="col-sm-8">
                <input type="text" id="tb_registrationnumbers" name="tb_registrationnumbers" class="form-control" maxlength="100" value="<%: tb_registrationnumbers %>" required />
            </div>
        </div>

        <!-- Type of Business -->

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_businesstype">Business type</label>
            <div class="col-sm-8">
                <select id="dd_businesstype" name="dd_businesstype" class="form-control" required>
                    <option></option>
                    <%
                        foreach (string businesstype in businesstypes)
                        {
                            Response.Write("<option>" + businesstype + "</option>");
                        }
                    %>
                </select>
            </div>
        </div>


        <!-- Business Number-->
        <div id="div_businessnumber" class="form-group" style="display:<%:none%>">
            <label class="control-label col-sm-4" for="tb_businessnumber">Business Number</label>
            <div class="col-sm-8">
                <input type="text" id="tb_businessnumber" name="tb_businessnumber" class="form-control" maxlength="100" value="<%: tb_businessnumber %>" required />
            </div>
        </div>

        <!-- Business Name-->
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_businessname">Legal name of business</label>
            <div class="col-sm-8">
                <input type="text" id="tb_businessname" name="tb_businessname" class="form-control" maxlength="100" value="<%: tb_businessname %>" required />
            </div>
        </div>



        <!-- Verification Agency -->

        <div class="form-group">
            <label class="control-label col-sm-4" for="dd_verificationagency">Who will be doing your verifcations</label>
            <div class="col-sm-8">
                <select id="dd_verificationagency" name="dd_verificationagency" class="form-control" required>
                    <option></option>
                    <%
                        foreach (string verificationagency in verificationagencies)
                        {
                            Response.Write("<option>" + verificationagency + "</option>");
                        }
                    %>
                </select>
            </div>
        </div>

        <!-- Verification Agency Confirmation Letter -->

        <div class="form-group" id="div_verificationagencyconfirmation" style="display: <%: none%>">
            <label class="control-label col-sm-4" for="tb_registrationnumbers">Please attach your confirmation letter from this agency</label>
            <div class="col-sm-8">
                Working on
            </div>
        </div>






        <!-- Postal Address -->
        <div class="form-group">
            <label class="control-label col-sm-4" for="cb_postaladdressformat">
                Postal address<br />
                (if different to physical premises address)
        <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." />
            </label>
            <div class="col-sm-8">
                <span id="span_postaladdressformat">Address lookup mode (preferred)</span>
                <a href="javascript:void(0);" id="postaladdressformat" class="addressformat">Change</a>
                <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control autoaddress" rows="4"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-4" for="cb_witholdpostal">Withhold the postal address from the public? </label>
            <div class="col-sm-1">
                <input id="cb_witholdpostal" name="cb_witholdpostal" class="form-control" type="checkbox" value="Withold postal address" />
            </div>
        </div>

        <!-- REPEATER SECTION -->

        <a href="javascript:void(0);" class="addsite">Add Site</a>


        <!-- Submit -->
        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>



    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div style="display: <%:none%>">

        <!-- Accordian header start -->
        <div id="div_site_" class="repeatupdateid">
            <div class="panel-group">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a data-toggle="collapse" href="#collapse_site_" class="repeatupdatehref">
                            <h4 class="panel-title repeatupdatehtml">Site 1</h4>
                        </a>
                    </div>
                    <div id="collapse_site_" class="panel-collapse collapse repeatupdateid">
                        <div class="panel-body">

                            <!-- Accordian header end -->




                            <!-- Type of Registration -->

                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="dd_registrationtype_">Registration type</label>
                                <div class="col-sm-8">
                                    <select id="dd_registrationtype_" name="dd_registrationtype_" class="form-control" required>
                                        <option></option>
                                        <option>Ministry of Primary Industries (MPI) template food control plan</option>
                                        <option>National programme level 3 (NP3)</option>
                                        <option>National programme level 2 (NP2)</option>
                                        <option>National programme level 1 (NP1)</option>

                                    </select>
                                </div>
                            </div>

                            <!-- Trading Name-->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_tradingname_">Trading name</label>
                                <div class="col-sm-8">
                                    <input type="text" id="tb_tradingname_" name="tb_tradingname_" class="form-control" maxlength="100" required />
                                </div>
                            </div>


                            <!-- Physical Address -->
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="cb_physicaladdressformat_">
                                    Physical premises address
        <img src="../Images/questionsmall.png" title="If you are in 'Address lookup mode' start typing your address (at least 5 characters).  A list of addresses will be given to you as options, please select one.  The more that you type the closer the options provided will be.  If you cannot find your address, change the lookup mode above." />
                                </label>
                                <div class="col-sm-8">
                                    <span id="span_physicaladdressformat_" class="repeatupdateid">Address lookup mode (preferred)</span>
                                    <a href="javascript:void(0);" id="physicaladdressformat_" class="addressformat repeatupdateid">Change</a>
                                    <textarea id="tb_physicaladdress_" name="tb_physicaladdress_" class="form-control autoaddress" rows="4" required></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="cb_witholdphysical_">Withhold the physical premises address from the public? </label>
                                <div class="col-sm-1">
                                    <input id="cb_witholdphysical_" name="cb_witholdphysical_" class="form-control" type="checkbox" value="Withold physical address" />
                                </div>
                            </div>

                            <!-- Day-to-day person -->

                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_daytodaymanager_">Day to day manager's name</label>
                                <div class="col-sm-8">
                                    <input id="tb_daytodaymanager_" name="tb_daytodaymanager_" type="text" class="form-control" required />
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_daytodaymanagerposition_">Position</label>
                                <div class="col-sm-8">
                                    <input id="tb_daytodaymanagerposition_" name="tb_daytodaymanagerposition_" type="text" class="form-control" required />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_daytodaymanageremailaddress_">Email address</label>
                                <div class="col-sm-8">
                                    <input id="tb_daytodaymanageremailaddress_" name="tb_daytodaymanageremailaddress_" type="email" class="form-control" required />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_daytodaymanageremailconfirm_">Please re-type your email address</label>
                                <div class="col-sm-8">
                                    <input id="tb_daytodaymanageremailconfirm_" name="tb_daytodaymanageremailconfirm_" type="email" class="form-control inhibitcutcopypaste" autocomplete="off" required />
                                </div>
                            </div>




                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_daytodaymanagerphonemobile_">Mobile phone</label>
                                <div class="col-sm-8">
                                    <input id="tb_daytodaymanagerphonemobile_" placeholder="eg: 027 123456..." name="tb_daytodaymanagerphonemobile_" type="text" class="form-control repeatupdatevalidgroup validgroup_daytodaymanagerphone_" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_daytodaymanagerphonehome_">Home phone</label>
                                <div class="col-sm-8">
                                    <input id="tb_daytodaymanagerphonehome_" name="tb_daytodaymanagerphonehome_" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control repeatupdatevalidgroup validgroup_daytodaymanagerphone_" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-4 repeatupdatefor" for="tb_daytodaymanagerphonework_">Work phone</label>
                                <div class="col-sm-8">
                                    <input id="tb_daytodaymanagerphonework_" name="tb_daytodaymanagerphonework_" placeholder="eg: 06 1234567 or 027 123456..." type="text" class="form-control repeatupdatevalidgroup validgroup_daytodaymanagerphone_" />
                                </div>
                            </div>


                            <!-- Attach Scope of Operation -->

                            <div class="form-group">
                                <label class="control-label col-sm-4" for="tb_scope">
                                    Please upload your completed "Scope of Operations"
                                <img src="../Images/questionsmall.png" title="This document is required.  It is available at https://www.mpi.govt.nz/document-vault/11437.  Please complete the document, save it to your own device and then upload it here" />

                                </label>
                                <div class="col-sm-4">
                                    Working On
                                </div>
                                <div class="col-sm-4">
                                    <a href="https://www.mpi.govt.nz/document-vault/11437" target="_blank">https://www.mpi.govt.nz/document-vault/11437</a>
                                </div>

                                <div class="col-sm-12">
                                            <a id="deletesite_" href="javascript:void(0);" class="repeatupdateid deletesite">Delete this site</a>

                                </div>
                                <!-- Accordian footer start -->
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
