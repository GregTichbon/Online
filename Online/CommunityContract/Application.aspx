<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Application.aspx.cs" Inherits="Online.CommunityContract.Application" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
                $(".act span").text(x);
                $(".prev span").text(y);
            });

            $("#pagehelp").colorbox({ href: "Application.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $('#test').on('click', function (e) {
                $.ajax({
                    type: 'POST', url: 'posts.asmx/application', data: $('#form1').serialize(), success: function (response) {
                        $('#form1').find('.form_result').html(response);
                    }
                });
            });



        });
        



    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1>Community Contracts Application
    </h1>

    <div class="form_result"> </div>

    <ul class="nav nav-tabs">
        <li class="active"><a href="#div_application">Application Details</a></li>
        <li><a href="#div_leadingedge">Whanganui - Leading Edge</a></li>
                <li><a href="#div_financial">Financial Details</a></li>
        <li><a href="#div_contactperson">Contact Person</a></li>
        <li><a href="#div_finalise">Finalise this application</a></li>


        

    </ul>
<!------------------------------------------------------------------------------------------------------>
        <div class="tab-content">
        <div id="div_application" class="tab-pane fade in active">
           <h3> Application Details</h3>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_reference">Application reference number</label><div class="col-sm-8">
            <input id="tb_reference" name="tb_reference" type="text" class="form-control" required value="<%:tb_reference%>" />
        </div>
    </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_groupreference">Please enter your group's reference number</label><div class="col-sm-8">
                    <input id="tb_groupreference" name="tb_groupreference" type="text" class="form-control" required value="<%:tb_groupreference%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="dd_fundingtype">What type of funding are you seeking?</label><div class="col-sm-8">

                    <select id="dd_fundingtype" name="dd_fundingtype" class="form-control" required>
                        <option></option>
                        <%
                            foreach (string dd_value in dd_fundingtype_values)
                            {
                                if (dd_value == dd_fundingtype)
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
                <label class="control-label col-sm-4" for="tb_projectname">Name of the project / activity</label><div class="col-sm-8">
                    <input id="tb_projectname" name="tb_projectname" type="text" class="form-control" required value="<%:tb_projectname%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_projectdescription">Describe the project / activity</label><div class="col-sm-8">
                    <textarea id="tb_projectdescription" name="tb_projectdescription" class="form-control" required > <%:tb_projectdescription%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_peopledirectbenefit">Who, how many and how will people benefit?</label><div class="col-sm-8">
                    <input id="tb_peopledirectbenefit" name="tb_peopledirectbenefit" type="text" class="form-control" required value="<%:tb_peopledirectbenefit%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_outcomes">What are the planned outcomes and how will they be measured?</label><div class="col-sm-8">
                    <input id="tb_outcomes" name="tb_outcomes" type="text" class="form-control" required value="<%:tb_outcomes%>" />
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_saferwhanganui">How will this project fit within the Safer Whanganui Framework?</label><div class="col-sm-8">
                    <input id="tb_saferwhanganui" name="tb_saferwhanganui" type="text" class="form-control" required value="<%:tb_saferwhanganui%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_collaboration">Who and how do you collaborate with others?</label><div class="col-sm-8">
                    <input id="tb_collaboration" name="tb_collaboration" type="text" class="form-control" required value="<%:tb_collaboration%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="fu_additionalfiles">Please upload any other information that may aid your application</label><div class="col-sm-8">

                        <asp:FileUpload ID="fu_additionalfiles" runat="server" AllowMultiple="True" />
                </div>
            </div>

                    </div>

            <!------------------------------------------------------------------------------------------------------>


        <div id="div_leadingedge" class="tab-pane fade">
            <h3>Whanganui Leading Edge</h3><p>Please tell us how your application relates to the following five (5) goals in our &quot;Whanganui: Leading Edge&quot; vision.&nbsp; More information on the vision is available <a href="http://www.whanganui.govt.nz/our-council/publications/policies/Documents/Whanganui%20Leading%20Edge%20Strategy%202015.pdf" target="_blank">here</a><br />(Please enter N/A if your application does not relate to a particular goal)</p>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_deeplyunited">Deeply United - We are a place resounding with community spirit, we support each other, work in partnership and are pulling in the same direction.</label><div class="col-sm-8">
                    <textarea id="tb_deeplyunited" name="tb_deeplyunited" class="form-control" required><%:tb_deeplyunited%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_globallyconnected">Globally Connected - We are outward looking, we are connected in the widest sense through our network infrastructure, digital capacity, expansive ideas and external relationships.</label><div class="col-sm-8">
                    <textarea id="tb_globallyconnected" name="tb_globallyconnected" class="form-control" required><%:tb_globallyconnected%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_creativesmarts">Creative Smarts - We are innovative, entrepreneurial, go getters, we actively attract industry, support start ups.</label><div class="col-sm-8">
                    <textarea id="tb_creativesmarts" name="tb_creativesmarts" class="form-control" required><%:tb_creativesmarts%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_flowingwithrichness">Flowing with Richness - We draw strength from the river and this sustains and shapes us. It feels positive here and there is a lot going on. Our wealth is abundant and we take a broad view of what this means. We play on our strengths and make our own opportunities - trumpetting our unique identity through placemaking that flows from the mountain to the river to the coast.</label><div class="col-sm-8">
                    <textarea id="tb_flowingwithrichness" name="tb_flowingwithrichness" class="form-control" required><%:tb_flowingwithrichness%></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_worksforeveryone">Works for Everyone - We have boundless opportunities and are truly a place of choice for all. There is a diversity to what we offer and people are able to make a conscious decision to come here and stay</label><div class="col-sm-8">
                    <textarea id="tb_worksforeveryone" name="tb_worksforeveryone"class="form-control" required><%:tb_worksforeveryone%></textarea>
                </div>
            </div>

        </div>
            <!------------------------------------------------------------------------------------------------------>

        <div id="div_financial" class="tab-pane fade">
            <h3>Finacial Details</h3>
    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_projectcost">Total cost of project</label><div class="col-sm-8">
            <input id="tb_projectcost" name="tb_projectcost" type="text" class="form-control" required value="<%:tb_projectcost%>" />
        </div>
    </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_owncontributions">How much are you contributiong from your own funds for this project?</label><div class="col-sm-8">
                    <input id="tb_owncontributions" name="tb_owncontributions" type="text" class="form-control" required value="<%:tb_owncontributions%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_committedfunding">How much money has been committed from other funding groups for this project?</label><div class="col-sm-8">
                    <input id="tb_committedfunding" name="tb_committedfunding" type="text" class="form-control" required value="<%:tb_committedfunding%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_fundingapplications">How much OTHER money has or will been sought from other funding groups for this project?</label><div class="col-sm-8">
                    <input id="tb_fundingapplications" name="tb_fundingapplications" type="text" class="form-control" required value="<%:tb_fundingapplications%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_councilcontribution">How much money are you seeking from the Whanganui District Council for this project?</label><div class="col-sm-8">
                    <input id="tb_councilcontribution" name="tb_councilcontribution" type="text" class="form-control" required value="<%:tb_councilcontribution%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_committedfunders">What other funding groups have committed money to this project?</label><div class="col-sm-8">
                    <input id="tb_committedfunders" name="tb_committedfunders" type="text" class="form-control" required value="<%:tb_committedfunders%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_fundersappliedto">What other funding groups have you applied to, or intend to apply to, for money toward this project?</label><div class="col-sm-8">
                    <input id="tb_fundersappliedto" name="tb_fundersappliedto" type="text" class="form-control" required value="<%:tb_fundersappliedto%>" />
                </div>
            </div>
        </div>
            <!------------------------------------------------------------------------------------------------------>

        <div id="div_contactperson" class="tab-pane fade">
            <h3>Contact Person</h3>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_applicantname">Name</label><div class="col-sm-8">
            <input id="tb_applicantname" name="tb_applicantname" type="text" class="form-control" required value="<%:tb_applicantname%>" />
        </div>
    </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantposition">Position within the group</label><div class="col-sm-8">
                    <input id="tb_applicantposition" name="tb_applicantposition" type="text" class="form-control" required value="<%:tb_applicantposition%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantemail">Email address</label><div class="col-sm-8">
                    <input id="tb_applicantemail" name="tb_applicantemail" type="text" class="form-control" required value="<%:tb_applicantemail%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_emailconfirm">Please confirm your email address</label><div class="col-sm-8">
                    <input id="tb_emailconfirm" name="tb_emailconfirm" type="text" class="form-control" required value="<%:tb_emailconfirm%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantphone">Phone Number</label><div class="col-sm-8">
                    <input id="tb_applicantphone" name="tb_applicantphone" type="text" class="form-control" required value="<%:tb_applicantphone%>" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-4" for="tb_applicantmobile">Mobile Phone Number</label><div class="col-sm-8">
                    <input id="tb_applicantmobile" name="tb_applicantmobile" type="text" class="form-control" required value="<%:tb_applicantmobile%>" />
                </div>
            </div>
            </div>
            <!------------------------------------------------------------------------------------------------------>

                    <div id="div_finalise" class="tab-pane fade">
            <h3>Finalise this application</h3>
<p>Once this application is finalised no amendments will be allowed. The application must be finalised prior to the closing date to be considered by Council"</p>
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


    <div style="text-align: center">
        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
        <input type="button" id="test" value="Test" />
    </div>







</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
