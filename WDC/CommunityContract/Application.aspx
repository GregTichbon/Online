<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Application.aspx.cs" Inherits="Online.CommunityContract.Application" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                autosize.update($('textarea'));
                //var x = $(event.target).text();         // active tab
                //var y = $(event.relatedTarget).text();  // previous tab
                //$(".act span").text(x);
                //$(".prev span").text(y);
            });

            $("#pagehelp").colorbox({ href: "ApplicationHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });


            autosize(document.querySelectorAll('textarea'));

            <% if (viewmode == "readonly")
            { %>

                $(':input').attr('readonly', 'readonly');
                $('select').attr("disabled", true);
                $('.readonlyinvisible').hide();


            <%}
            else
            {%>
                $('input[type=text], textarea').maxlength({
                    text: '%length/%maxlength' //%left
                });
                origemailaddress = $("#tb_applicantemail").val();

                $("#tb_applicantemail").keyup(function () {
                    if ($("#tb_applicantemail").val() != origemailaddress) {
                        $("#div_emailconfirm").show();
                        $("#tb_emailconfirm").removeClass("novalidation")
                    } else {
                        $("#div_emailconfirm").hide();
                        $("#tb_emailconfirm").addClass("novalidation")
                    }
                });


                $("#form1").validate({
                    onkeyup: false,
                    onclick: false,
                    onfocusout: false,
                    showErrors: function (errorMap, errorList) {
                        //console.log(errorList);
                        $("#dialog-message").html('<span align="center">There are errors that need to be corrected before you can submit this application.<br /><br />They may be on other tabs.<br /><br />You may continue to save this document.</span>');
                        $("#dialog-message").dialog({
                            resizable: false,
                            height: 340,
                            modal: true
                        });
                        this.defaultShowErrors();
                    },
                    ignore: ".novalidation",
                    rules: {
                        tb_emailconfirm: {
                            equalTo: '#tb_applicantemail'
                        }
                    }
                });

                $(".numeric").keydown(function (event) {

                    if (event.shiftKey == true) {
                        event.preventDefault();
                    }

                    if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                        (event.keyCode >= 96 && event.keyCode <= 105) ||
                        event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                        event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190) {

                    } else {
                        event.preventDefault();
                    }

                    if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                        event.preventDefault();
                    //if a decimal has been added, disable the "."-button

                });

                $('#btn_submit').click(function () {
                    //$('form').submit(function (e) {
                    if ($("#form1").valid() == true) {
                        if ($("#dd_finalised").val() == "No") {
                            msg = "You have chosen not to finalise this application.  You can continue to update it until the closing date, but it must be finalised by this date to be considered by the Council.";
                        } else {
                            msg = "You have chosen to finalise this application.  This means that you will no longer be able to continue to update it.";
                        }
                        $("#dialog-message").html(msg);
                        $("#dialog-message").dialog({
                            resizable: true,
                            height: 300,
                            modal: true,
                            buttons: {
                                "Continue": function () {
                                    $(this).dialog("close");
                                    saveData('submit');
                                    submitform();
                                },
                                Cancel: function () {
                                    $(this).dialog("close");
                                }
                            }
                        });
                    }
                })
                

                $('#btn_save').on('click', function (e) {
                    $("#dd_finalised").val('No');
                    saveData('Save');
                })

                $('form').dirtyForms();

                $(document).on('keypress', function (e) {
                    $('.form_result').html('');
                });



            <% } %>



        });

        <% if (viewmode != "readonly")
        { %>
        function saveData(mode) {
            var dofiles = false;
                if(mode == "Save") {
                    $("#div_processing").show();
                }

                var deletefile_additional = [];
                $("[id^='cb_deletefile_additional_']").each(function (index) {
                    //alert($(this).val() + '=' + this.checked);
                    if (this.checked) {
                        deletefile_additional.push($(this).val());
                    }
                });
                $("#hf_deletefile_additional").val(deletefile_additional);
                //alert(deletefile_additional);

                var files = $("#fu_additionalfiles").get(0).files;

                if (files.length > 0) {
                    dofiles = true;
                    //alert('SAVE FILES');
                    savefiles(files);
                }

                if($('form:dirty').dirtyForms('isDirty') == true) {
                    //alert('SAVE FIELDS');
                    savefields();
                }

                //alert(mode);
                if (mode == "Save") {
                    //alert(dofiles);
                    //alert($("#hf_deletefile_additional").val());
                    if (dofiles = true || $("#hf_deletefile_additional").val() != '') {
                        //alert("Processing files.");
                        //alert('REFRESH FILES TABLE');
                        //alert(1);
                        refreshfilestable();
                    }
                }

                if (mode == "Save") {
                    $("#div_processing").hide();
                    $("#dialog-message").html('<span align="center">Saved</span>');
                    $("#dialog-message").dialog({
                        resizable: false,
                        height: 140,
                        modal: true
                    });
                }

                //$(document).ajaxComplete(function (event, xhr, settings) {
                //    alert(settings.url);
                //});
            }

//SAVE FIELDS

            function savefields() {
                var arForm = $("#form1")
                    .find("input,textarea,select,hidden")
                    .not("[id^='__']")
                    .not("[id^='cb_deletefile_additional_']")
                    .serializeArray();


                var formData = JSON.stringify({ formVars: arForm });
                //alert(formData);

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    async: false,
                    contentType: "application/json; charset=utf-8",
                    url: 'posts.asmx/application', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        //alert(result);
                        $('form:dirty').dirtyForms('setClean');
                        //$('.form_result').html('Saved');
                        //details = $.parseJSON(result.d);
                        //alert(details.status);
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
 
                })
            }

//SAVE FILES
            function savefiles(files) {
            //alert(files.length);
                var filedata = new FormData();


                for (i = 0; i < files.length; i++) {
                    //alert(files[i].size);
                    filedata.append("UploadedFile", files[i]);
                }
                filedata.append("reference", $('#tb_reference').val());
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "posts.asmx/applicationupload",
                    contentType: false,
                    processData: false,
                    data: filedata,
                    dataType: 'text', // what type of data do we expect back from the server
                    success: function (result) {
                        //alert(result);
                        var xml = result,
                            xmlDoc = $.parseXML(result),
                            $xml = $(xmlDoc),
                            $message = $xml.find("message");
                        //alert($message.text());
                        //$("#ContentPlaceHolder1_lbl_additionalfiles").html($message.text());
                        $("#fu_additionalfiles").val("");
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                });
            }

//REFRESH FILES TABLE

            function refreshfilestable() {
                //alert('2');
                //alert(files.length);
                //alert($("#hf_deletefile_additional").val());
                $.ajax({
                    dataType: 'html', // what type of data do we expect back from the server
                    url: "data.aspx?mode=buildfilestable&name=additional&reference=" + $("#tb_reference").val(), success: function (result) {
                        //alert(result);
                        //filestable = $.parseJSON(result.message)
                        //alert(filestable);
                        $("#ContentPlaceHolder1_lbl_additionalfiles").html(result);
                    }
                });

            }

            function submitform() {
                var arForm = $("#form1")
                    .find("input,textarea,select,hidden")
                    .not("[id^='__']")
                    .not("[id^='cb_deletefile_additional_']")
                    .serializeArray();

                var formData = JSON.stringify({ formVars: arForm });

                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    contentType: "application/json; charset=utf-8",
                    url: 'posts.asmx/submit', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        window.location.href = 'default.aspx';
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                })
            }




        <% } %>




    </script>

    <style>
        .maxlength {
            font-size:8px;
        }

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input id="hf_application_ctr" name="hf_application_ctr" type="hidden" value="<%: hf_application_ctr %>" />
    <input id="hf_users_ctr" name="hf_users_ctr" type="hidden" value="<%: hf_users_ctr %>" />
    <input id="hf_deletefile_additional" name="hf_deletefile_additional" type="hidden" value="" />

    <div id="dialog-message" title="Processing Message"></div>

    <div id="div_processing" style="display: none">Saving</div>

    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="default.aspx">Community Contracts</a><span class="navbar-brand"> <%:Session["communitycontractsgroup_legalname"]%></span>
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

    <h1>Community Contracts Application
    </h1>
    <!--<a id="populate">Populate</a>-->
    <div class="form_result"></div>


    <ul class="nav nav-tabs">
        <li class="active"><a data-target="#div_application">Application Details</a></li>
        <li><a data-target="#div_leadingedge">Whanganui - Leading Edge</a></li>
        <li><a data-target="#div_financial">Financial Details</a></li>
        <li><a data-target="#div_contactperson">Contact Person</a></li>
        <li><a data-target="#div_finalise">Finalise this application</a></li>




    </ul>
    <!------------------------------------------------------------------------------------------------------>
    <div class="tab-content">
        <div id="div_application" class="tab-pane fade in active">
            <h3>Application Details</h3>
            <!--<h3 style="color:red">Please ensure you update the group details before doing the application:  Do it <a href="groupdetails.aspx">Here</a></h3>-->

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_reference">Application reference number</label><div class="col-sm-8">
                    <input id="tb_reference" name="tb_reference" type="text" class="form-control" readonly="readonly" value="<%:tb_reference%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_fundingtype">What type of funding are you seeking? <img src="../Images/questionsmall.png" title="Projects of significance are for a projects only, there is $50,000 in the pool, funding is for 3 years as long as you meet all the performance measures. The Community fund is a pool of $100,000 with a limit of $20,000 per application" />
                </label><div class="col-sm-8">

                    <select id="dd_fundingtype" name="dd_fundingtype" class="form-control" required>
                        <option></option>
                        <%=Online.WDCFunctions.WDCFunctions.populateselect(dd_fundingtype_values, dd_fundingtype, "None")%>
                    </select>

                </div>

            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_projectname">Name of the project / activity</label><div class="col-sm-8">
                    <input id="tb_projectname" name="tb_projectname" type="text" maxlength="100" class="form-control" required value="<%:tb_projectname%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_projectdescription">Describe the project / activity</label><div class="col-sm-8">
                    <textarea id="tb_projectdescription" name="tb_projectdescription" maxlength="2000" class="form-control" required><%:tb_projectdescription%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_peopledirectbenefit">Who, how many and how will people benefit?</label><div class="col-sm-8">
                    <textarea id="tb_peopledirectbenefit" name="tb_peopledirectbenefit" maxlength="500" class="form-control" required><%:tb_peopledirectbenefit%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_outcomes">What are the planned outcomes and how will they be measured?</label><div class="col-sm-8">
                    <textarea id="tb_outcomes" name="tb_outcomes" maxlength="2000" class="form-control" required><%:tb_outcomes%></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_saferwhanganui">How will this project fit within the Safer Whanganui Framework?</label><div class="col-sm-8">
                    <textarea id="tb_saferwhanganui" name="tb_saferwhanganui" maxlength="2000" class="form-control" required><%:tb_saferwhanganui%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_collaboration">Who and how do you collaborate with others?</label><div class="col-sm-8">
                    <textarea id="tb_collaboration" name="tb_collaboration" maxlength="2000" class="form-control" required><%:tb_collaboration%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="fu_additionalfiles">Please upload any other information that may aid your application</label><div class="col-sm-8">
                    <% if (viewmode != "readonly")
                       { %>
                    <!--<asp:FileUpload ID="fu_additionalfiles" runat="server" AllowMultiple="True" />-->
                    <input id="fu_additionalfiles" name="fu_additionalfiles" type="file" multiple="multiple" />
                    <% } %>
                    <asp:Label ID="lbl_additionalfiles" runat="server" Text=""></asp:Label>
                </div>
            </div>

        </div>

        <!------------------------------------------------------------------------------------------------------>


        <div id="div_leadingedge" class="tab-pane fade">
            <h3>Whanganui Leading Edge</h3>
            <p>
                Please tell us how your application relates to any of the following five (5) goals in our &quot;Whanganui: Leading Edge&quot; vision.&nbsp; More information on the vision is available <a href="http://www.whanganui.govt.nz/our-council/publications/policies/Documents/Whanganui%20Leading%20Edge%20Strategy%202015.pdf" target="_blank">here</a><br />
                (Please enter N/A if your application does not relate to a particular goal)
            </p>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_deeplyunited">Deeply United - We are a place resounding with community spirit, we support each other, work in partnership and are pulling in the same direction.</label><div class="col-sm-8">
                    <textarea id="tb_deeplyunited" name="tb_deeplyunited" maxlength="2000" class="form-control" required><%:tb_deeplyunited%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_globallyconnected">Globally Connected - We are outward looking, we are connected in the widest sense through our network infrastructure, digital capacity, expansive ideas and external relationships.</label><div class="col-sm-8">
                    <textarea id="tb_globallyconnected" name="tb_globallyconnected" maxlength="2000" class="form-control" required><%:tb_globallyconnected%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_creativesmarts">Creative Smarts - We are innovative, entrepreneurial, go getters, we actively attract industry, support start ups.</label><div class="col-sm-8">
                    <textarea id="tb_creativesmarts" name="tb_creativesmarts" maxlength="2000" class="form-control" required><%:tb_creativesmarts%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_flowingwithrichness">Flowing with Richness - We draw strength from the river and this sustains and shapes us. It feels positive here and there is a lot going on. Our wealth is abundant and we take a broad view of what this means. We play on our strengths and make our own opportunities - trumpetting our unique identity through placemaking that flows from the mountain to the river to the coast.</label><div class="col-sm-8">
                    <textarea id="tb_flowingwithrichness" name="tb_flowingwithrichness" maxlength="2000" class="form-control" required><%:tb_flowingwithrichness%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_worksforeveryone">Works for Everyone - We have boundless opportunities and are truly a place of choice for all. There is a diversity to what we offer and people are able to make a conscious decision to come here and stay</label><div class="col-sm-8">
                    <textarea id="tb_worksforeveryone" name="tb_worksforeveryone" maxlength="2000" class="form-control" required><%:tb_worksforeveryone%></textarea>
                </div>
            </div>

        </div>
        <!------------------------------------------------------------------------------------------------------>

        <div id="div_financial" class="tab-pane fade">
            <h3>Financial Details</h3>

            Please enter all amounts in whole dollars
         
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_projectcost">Total cost of project</label><div class="col-sm-8">
                    <input id="tb_projectcost" name="tb_projectcost" type="text" class="form-control numeric" required value="<%:tb_projectcost%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_owncontributions">How much are you contributing from your own funds for this project?</label><div class="col-sm-8">
                    <input id="tb_owncontributions" name="tb_owncontributions" type="text" class="form-control numeric" required value="<%:tb_owncontributions%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_committedfunding">How much money has been committed from other funding groups for this project?</label><div class="col-sm-8">
                    <input id="tb_committedfunding" name="tb_committedfunding" type="text" class="form-control numeric" required value="<%:tb_committedfunding%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_fundingapplications">How much OTHER money has or will been sought from other funding groups for this project?</label><div class="col-sm-8">
                    <input id="tb_fundingapplications" name="tb_fundingapplications" type="text" class="form-control numeric" required value="<%:tb_fundingapplications%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_councilcontribution">How much money are you seeking from the Whanganui District Council for this project?</label><div class="col-sm-8">
                    <input id="tb_councilcontribution" name="tb_councilcontribution" type="text" class="form-control numeric" required value="<%:tb_councilcontribution%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_committedfunders">What other funding groups have committed money to this project?</label><div class="col-sm-8">
                    <input id="tb_committedfunders" name="tb_committedfunders" maxlength="2000" type="text" class="form-control" required value="<%:tb_committedfunders%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_fundersappliedto">What other funding groups have you applied to, or intend to apply to, for money toward this project?</label><div class="col-sm-8">
                    <input id="tb_fundersappliedto" name="tb_fundersappliedto" type="text" maxlength="2000" class="form-control" required value="<%:tb_fundersappliedto%>" />
                </div>
            </div>
        </div>
        <!------------------------------------------------------------------------------------------------------>

        <div id="div_contactperson" class="tab-pane fade">
            <h3>Contact Person</h3>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantname">Name</label><div class="col-sm-8">
                    <input id="tb_applicantname" name="tb_applicantname" maxlength="100" type="text" class="form-control" required value="<%:tb_applicantname%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantposition">Position within the group</label><div class="col-sm-8">
                    <input id="tb_applicantposition" name="tb_applicantposition" maxlength="100" type="text" class="form-control" required value="<%:tb_applicantposition%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantemail">Email address</label><div class="col-sm-8">
                    <input id="tb_applicantemail" name="tb_applicantemail" maxlength="100" type="text" class="form-control" required value="<%:tb_applicantemail%>" />
                </div>
            </div>
            <% if (viewmode != "readonly")
               { %>
            <div id="div_emailconfirm" class="form-group" style="display: none">

                <label class="control-label col-sm-4" for="tb_emailconfirm">Please confirm your email address</label><div class="col-sm-8">
                    <input id="tb_emailconfirm" name="tb_emailconfirm" type="text" class="form-control inhibitcutcopypaste novalidation" autocomplete="off" required />
                </div>
            </div>
            <% } %>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantphone">Phone Number</label><div class="col-sm-8">
                    <input id="tb_applicantphone" name="tb_applicantphone" type="text" maxlength="50" class="form-control" required value="<%:tb_applicantphone%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantmobile">Mobile Phone Number</label><div class="col-sm-8">
                    <input id="tb_applicantmobile" name="tb_applicantmobile" maxlength="50" type="text" class="form-control" required value="<%:tb_applicantmobile%>" />
                </div>
            </div>
        </div>
        <!------------------------------------------------------------------------------------------------------>

        <div id="div_finalise" class="tab-pane fade">
            <h3>Finalise this application</h3>
            <p>Once this application is finalised no amendments will be allowed. The application must be finalised prior to the closing date to be considered by Council</p>
            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_finalised">
                    Finalise this application    

                </label>
                <div class="col-sm-8">

                    <select id="dd_finalised" name="dd_finalised" class="form-control" required>
                        <option></option>
                        <%
                            foreach (string dd_value in yesno_values)
                            {
                                if (dd_value == dd_finalised)
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
        </div>
    </div>

    <% if (viewmode != "readonly")
       { %>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input type="button" id="btn_save" class="btn btn-info submit" value="Save" />&nbsp;&nbsp;&nbsp;
            <input type="button" id="btn_submit" class="btn btn-info submit" value="Submit" />

        </div>
    </div>


    <% } %>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
