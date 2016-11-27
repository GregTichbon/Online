<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BC1.aspx.cs" Inherits="Online.TestAndPlay.BC1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {



            var fieldsdiv = $("<div>", { id: "fields" });
            $("body").append(fieldsdiv);

            var x = '';
            $('input, textarea, select').each(function (index) {
                x = x + '<br>' + '@pre' + this.id + '@post';

            })
            $('#fields').html(x);

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


        <div id="content-container">
            <div id="upgrade-browser" style="display: none">
                <p><strong>Attention:</strong> This site may not function correctly with your current browser. We recommend using IE 8+, Chrome or Firefox.</p>
            </div>
            <noscript>
                <div id="noscript-browser">
                    <p><strong>Attention:</strong> This site requires that Javascript be enabled.</p>
                </div>
            </noscript>
            <div id="dcc-interaction">










                <div id="middle-zone">



                    <h1><span>Application for Building Consent/PIM (including Temporary Structures)
                    </span>
                        <span></span>
                    </h1>

                    <form action="/online-services/REF160500700/step/2" data-dialogue-category="Application" data-dialogue-code="Tauranga-BC" data-dialogue-group="Building Consent / PIM" data-popup-cancel="Cancel" data-popup-enable="False" data-popup-msg="Form is currently busy, please try again." data-popup-ok="OK" data-popup-submitcancel="No" data-popup-submitmsg="Are you sure you want to submit and finalise your application?" data-popup-submitok="Yes" data-popup-submittitle="Confirm Submission" data-popup-title="Form Busy" id="dialogue-form" method="post">
                        <input name="__RequestVerificationToken" type="hidden" value="hAV7sNeePzPB3VipvHMr8rN0E2d34T7MOgDTPoLyEphtFnmoD6UZSy2RTOyQh_K4OF2s6JcOVZ-yfc0sfixYsffTusruSwERwSXjpwmjyeY1" /><div class="clear"></div>





                        <input type="submit" value="continue" name="_continueButton" style="position: absolute; margin-left: -9999px;" />

                        <input type="hidden" name="__wizard-step" id="__wizard-step" />

                        <a href="#step-heading" accesskey="[" class="skip-to-main">[Jump to content]</a>

                        <div id="progress-bar">

                            <div class="step">
                                <button id="_wizard-step-1" type="button" data-stepnumber="1">
                                    <span>Property Selection</span>
                                    <span class="step_cp"></span>
                                </button>
                            </div>
                            <img src="/content/images/wizard/wizard-divider-current-left.png" alt="navigation menu divider" />
                            <div class="current-step">
                                <span>Application Details</span>
                                <span class="step_cr"></span>
                            </div>
                            <img src="/content/images/wizard/wizard-divider-current-right.png" alt="navigation menu divider" />
                            <div class="step">
                                <button id="_wizard-step-3" type="button" data-stepnumber="3">
                                    <span>Project Details</span>
                                    <span class="step_nf"></span>
                                </button>
                            </div>
                            <img src="/content/images/wizard/wizard-divider.png" alt="navigation menu divider" />
                            <div class="step">
                                <button id="_wizard-step-4" type="button" data-stepnumber="4">
                                    <span>Building Code</span>
                                    <span class="step_nf"></span>
                                </button>
                            </div>
                            <img src="/content/images/wizard/wizard-divider.png" alt="navigation menu divider" />
                            <div class="step">
                                <button id="_wizard-step-5" type="button" data-stepnumber="5">
                                    <span>Attachments</span>
                                    <span class="step_nf"></span>
                                </button>
                            </div>
                            <img src="/content/images/wizard/wizard-divider.png" alt="navigation menu divider" />
                            <div class="step">
                                <button id="_wizard-step-6" type="button" data-stepnumber="6">
                                    <span>Application Checklist</span>
                                    <span class="step_nf"></span>
                                </button>
                            </div>
                            <img src="/content/images/wizard/wizard-divider.png" alt="navigation menu divider" />
                            <div class="step">
                                <span class="disabled-step">Confirmation</span>
                                <span class="step_nf"></span>
                            </div>
                            <div class="clear"></div>
                        </div>





                        <div class="clear"></div>
                        <div class="clear"></div>
                        <div id="step-heading">
                            <div class="step-buttons">

                                <input type="submit" value="Continue &gt;&gt;"
                                    class="button continue-button disableAfterClick" name="_continueButton" />
                                <input type="submit" value="Cancel" class="button cancel-button" name="_cancelButton"
                                    data-popup-title="Confirm Cancellation"
                                    data-popup-msg="This will delete your entire application. Are you sure you want to delete your application?"
                                    data-popup-ok="OK"
                                    data-popup-cancel="Cancel" />
                                <input type="hidden" name="_cancelButtonAction" />
                                <input type="hidden" name="_submitButtonAction" />


                            </div>
                            <div class="step-title">

                                <h2>
                                    <span>Application Details
                                    </span>

                                </h2>
                            </div>
                        </div>
                        <div id="form-wrapper">


                            <div class="form-instruction note"><span class="required">*</span><span>- indicates required field.</span></div>
                            <div class="clear"></div>


                            <div class="question-cell">
                                <div class="label">

                                    <p>
                                        The information you have provided on this form is required so that your building consent application can be processed under the Building Act 2004. Council collates statistics relating to issued building consents and has a statutory obligation to forward these regularly to Statistics New Zealand. Council stores the information on a public register, which  must be supplied (as previously determined by the Ombudsman) to whoever requests the information.            
                                    <p>&nbsp;</p>
                                    <p>Under the Privacy Act 1993 you have the right to see and correct personal information the Council holds about you. Pursuant to Section 217 of the Building Act 2004 the building owner may request the plans and/or specifications be marked confidential for the purposes of security. Such a request must be in writing and addressed to: Building Control Team Leader, PO Box 637, Whanganui 4540 and uploaded as an "Additional Document" under the Attachments screen during your application.</p>
                                    <p>&nbsp;</p>
                                    <p>If you have any questions about how to use this online application form please contact us for assistance by calling 06 349 0001. </p>

                                </div>
                            </div>
                            <div class="question-cell ">
                            </div>
                            <div class="clear"></div>
                            <div class="divider"></div>

                            <div class="question-cell">
                                <h3 class="wizard-info-title">The Application
                                </h3>
                            </div>
                            <div class="question-cell header-label-help">
                            </div>
                            <div class="clear"></div>

                            <div class="question-cell">
                                <div class="term-and-con">

                                    <p>
                                        <em>
                                        We recommend applying for a Project Information Memorandum (PIM) early in your project so you can find out information that may be important for your design. Finding out information on a PIM early may help you complete consent documents for your application more accurately.
            A PIM can help you find out if your proposed project, including the design is achievable. The information may prevent delays and reduce costs in the design of your proposal before you get to the building consent stage.           
                                    <p>&nbsp;</p>
                                    <p><em>Please note: Under the Building Act a PIM is no longer mandatory. You will need to specifically request one.</em></p>
                                    <p>&nbsp;</p>

                                </div>
                            </div>
                            <div class="question-cell ">
                            </div>
                            <div class="clear"></div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-ApplicationInfo" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="ApplicationInfo-error" ajax-trigger="ApplicationInfo" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="questionName">
                                            <label class="questionName-text" for="ApplicationInfo_1">I request that you issue a:<p>(for the building work described in this application)</p>
                                            </label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="verticalOptionList">
                                                <div>
                                                    <input id="ApplicationInfo_1" name="ApplicationInfo" type="radio" value="P" />
                                                    <label for="ApplicationInfo_1">Project Information Memorandum (PIM)</label>
                                                </div>
                                                <div>
                                                    <input id="ApplicationInfo_2" name="ApplicationInfo" type="radio" value="C" />
                                                    <label for="ApplicationInfo_2">Building Consent</label>
                                                </div>
                                                <div>
                                                    <input id="ApplicationInfo_3" name="ApplicationInfo" type="radio" value="B" />
                                                    <label for="ApplicationInfo_3">Building Consent and Project Information Memorandum (PIM)</label>
                                                </div>
                                                <div>
                                                    <input id="ApplicationInfo_4" name="ApplicationInfo" type="radio" value="NMA" />
                                                    <label for="ApplicationInfo_4">National Multiple Use Approval (Building Consent and PIM)</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                            <div class="clear"></div>
                                        </div>

                                        <div class="clear"></div>


                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="ApplicationInfo-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>
                            <div id="AppType-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="questionName">
                                        <label class="questionName-text" for="AppType_1">Nature of Application</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">

                                        <div class="verticalOptionList">
                                            <div>
                                                <input id="AppType_1" name="AppType" type="radio" value="DEMOLITION" />
                                                <label for="AppType_1">Demolition</label>
                                            </div>
                                            <div>
                                                <input id="AppType_2" name="AppType" type="radio" value="PLUMBING_DRAINAGE" />
                                                <label for="AppType_2">Plumbing and Drainage</label>
                                            </div>
                                            <div>
                                                <input id="AppType_3" name="AppType" type="radio" value="MULTIRES_IND_COM" />
                                                <label for="AppType_3">Multi-residential / Industrial / Commercial</label>
                                            </div>
                                            <div>
                                                <input id="AppType_4" name="AppType" type="radio" value="NON_HABITABLE" />
                                                <label for="AppType_4">Non-habitable (garage, shed etc.)</label>
                                            </div>
                                            <div>
                                                <input id="AppType_5" name="AppType" type="radio" value="RESIDENTIAL" />
                                                <label for="AppType_5">Residential</label>
                                            </div>
                                            <div>
                                                <input id="AppType_6" name="AppType" type="radio" value="SOLAR_HEATING" />
                                                <label for="AppType_6">Solar Heating</label>
                                            </div>
                                            <div>
                                                <input id="AppType_7" name="AppType" type="radio" value="SOLID_FUEL_HEATERS" />
                                                <label for="AppType_7">Solid Fuel Heater</label>
                                            </div>
                                            <div>
                                                <input id="AppType_8" name="AppType" type="radio" value="SWIMMING_POOLS" />
                                                <label for="AppType_8">Swimming Pool</label>
                                            </div>
                                            <div>
                                                <input id="AppType_9" name="AppType" type="radio" value="TEMP_STRUCTURE" />
                                                <label for="AppType_9">Temporary Structure</label>
                                            </div>
                                            <div>
                                                <input id="AppType_10" name="AppType" type="radio" value="NEWDWELL" />
                                                <label for="AppType_10">New Dwell TEMPORARY (Use this for end to end testing)</label>
                                            </div>
                                        </div>


                                        <div class="subtext"></div>



                                        <div class="clear"></div>
                                    </div>

                                    <div class="clear"></div>


                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>


                            <div class="question-cell">
                                <div class="label">
                                    <em><a href="http://www.building.govt.nz/bca-competency-assessment-system-update#aid2" target="_blank">For help determining your building consent category</a></em>
                                </div>
                            </div>
                            <div class="question-cell ">
                            </div>
                            <div class="clear"></div>
                            <div id="RestrictedBuildingWorkApplicable-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="longQuestionName">
                                        <label class="questionName-text" for="RestrictedBuildingWorkApplicable_1">Restricted Building Work applicable?</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">

                                        <div class="horizontalOptionList">
                                            <div>
                                                <input id="RestrictedBuildingWorkApplicable_1" name="RestrictedBuildingWorkApplicable" type="radio" value="true" />
                                                <label for="RestrictedBuildingWorkApplicable_1">Yes</label>
                                            </div>
                                            <div>
                                                <input id="RestrictedBuildingWorkApplicable_2" name="RestrictedBuildingWorkApplicable" type="radio" value="false" />
                                                <label for="RestrictedBuildingWorkApplicable_2">No</label>
                                            </div>
                                        </div>


                                        <div class="subtext"></div>



                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                    <a class="question-help" href="javascript:void(0);">
                                        <span>HelpText</span>
                                    </a>
                                    <div class="tooltip-text">
                                        <span>Select yes or no depending on whether there is any restricted building work (RBW) – if there is RBW you will need to provide certificates of design work and Advice of licensed building practitioner(s) form(s). These forms are available within subsequent sections of this document.</span>
                                    </div>


                                </div>
                                <div class="clear"></div>

                            </div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-CulturalOrHeritageSignificance" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="CulturalOrHeritageSignificance-error" ajax-trigger="CulturalOrHeritageSignificance" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="CulturalOrHeritageSignificance_1">Does the building/site have any Cultural or Heritage significance or is it a Marae?</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="CulturalOrHeritageSignificance_1" name="CulturalOrHeritageSignificance" type="radio" value="true" />
                                                    <label for="CulturalOrHeritageSignificance_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="CulturalOrHeritageSignificance_2" name="CulturalOrHeritageSignificance" type="radio" value="false" />
                                                    <label for="CulturalOrHeritageSignificance_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="CulturalOrHeritageSignificance-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-SiteSubjectToHazard" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="SiteSubjectToHazard-error" ajax-trigger="SiteSubjectToHazard" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="SiteSubjectToHazard_1">Is the site subject to natural or created hazards such as erosion, subsidence, flooding, slips, cut and fill or contamination?</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="SiteSubjectToHazard_1" name="SiteSubjectToHazard" type="radio" value="true" />
                                                    <label for="SiteSubjectToHazard_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="SiteSubjectToHazard_2" name="SiteSubjectToHazard" type="radio" value="false" />
                                                    <label for="SiteSubjectToHazard_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="SiteSubjectToHazard-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-FinancialAssistance" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="FinancialAssistance-error" ajax-trigger="FinancialAssistance" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="FinancialAssistance_1">Financial assistance package (FAP) re-clad application - or claim under FAP scheme?</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="FinancialAssistance_1" name="FinancialAssistance" type="radio" value="true" />
                                                    <label for="FinancialAssistance_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="FinancialAssistance_2" name="FinancialAssistance" type="radio" value="false" />
                                                    <label for="FinancialAssistance_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="FinancialAssistance-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-ExistingPIM" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="ExistingPIM-error" ajax-trigger="ExistingPIM" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="questionName">
                                            <label class="questionName-text" for="ExistingPIM_1">Is there an existing PIM?</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="ExistingPIM_1" name="ExistingPIM" type="radio" value="true" />
                                                    <label for="ExistingPIM_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="ExistingPIM_2" name="ExistingPIM" type="radio" value="false" />
                                                    <label for="ExistingPIM_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="ExistingPIM-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>

                            <div class="divider"></div>

                            <div class="question-cell">
                                <h3 class="wizard-info-title">Building Details
                                </h3>
                            </div>
                            <div class="question-cell header-label-help">
                            </div>
                            <div class="clear"></div>
                            <div id="BuildingName-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">






                                    <div class="questionName">
                                        <label class="questionName-text" for="BuildingName">Building name:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">


                                        <input class="medium" id="BuildingName" name="BuildingName" type="text" />

                                        <div class="subtext">(Only valid for Multi-Residential/Industrial/Commercial or Heritage Buildings)</div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="LocationOfBuildingWithinSiteBlockNumber-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">






                                    <div class="questionName">
                                        <label class="questionName-text" for="LocationOfBuildingWithinSiteBlockNumber">Location of building within site/block number:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">


                                        <textarea id="LocationOfBuildingWithinSiteBlockNumber" name="LocationOfBuildingWithinSiteBlockNumber" rows="2"></textarea>

                                        <div class="subtext">(Include nearest street access)</div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                    <a class="question-help" href="javascript:void(0);">
                                        <span>HelpText</span>
                                    </a>
                                    <div class="tooltip-text">
                                        <span>If there is more than one building on the property, indicate which building the application relates to. Where access to the building is from another address, include details of the street and number. Examples:
            • on-street front
            • at back of section accessed from ‘The Street’
            • north-west corner of site.
                                        </span>
                                    </div>


                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="WorkType-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="questionName">
                                        <label class="questionName-text" for="WorkType">Work type:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">

                                        <select id="WorkType" name="WorkType" class="dropdownList">
                                            <option value=""></option>
                                            <option value="ADD"
                                                lang="en">Addition (increased floor area)</option>
                                            <option value="ADD"
                                                lang="en">Alteration (no increased floor area)</option>
                                            <option value="DEM"
                                                lang="en">Demolition</option>
                                            <option value="FOU"
                                                lang="en">Foundations Only</option>
                                            <option value="NEW"
                                                lang="en">New</option>
                                            <option value="RES"
                                                lang="en">Relocation (foundations and services only)</option>
                                        </select>


                                        <div class="subtext"></div>



                                        <div class="clear"></div>
                                    </div>

                                    <div class="clear"></div>


                                </div>
                                <div class="question-cell">
                                    <a class="question-help" href="javascript:void(0);">
                                        <span>HelpText</span>
                                    </a>
                                    <div class="tooltip-text">
                                        <span>Note: for Plumbing and Drainage or Solid Fuel Heaters, use &quot;Alteration&quot; and for Temporary Structure use &quot;New&quot;</span>
                                    </div>


                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="YearFirstConstructed-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="questionName">
                                        <label class="questionName-text" for="YearFirstConstructed">Year first constructed:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">
                                        <input id="YearFirstConstructed" name="YearFirstConstructed" type="text" data-numeric-field="noneg-nodec" />


                                        <div class="subtext">(If new building, please enter likely year of construction)</div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="SubdivisionLotNumber-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">




                                    <div class="questionName">
                                        <label class="questionName-text" for="SubdivisionLotNumber">Subdivision Lot Number:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">
                                        <input id="SubdivisionLotNumber" name="SubdivisionLotNumber" type="text" data-numeric-field="noneg-nodec" />


                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="SubdivisionConsentNumber-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">




                                    <div class="questionName">
                                        <label class="questionName-text" for="SubdivisionConsentNumber">Subdivision Consent Number:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">
                                        <input id="SubdivisionConsentNumber" name="SubdivisionConsentNumber" type="text" data-numeric-field="noneg-nodec" />


                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="LevelUnitNumber-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">






                                    <div class="questionName">
                                        <label class="questionName-text" for="LevelUnitNumber">Level/Unit number:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">


                                        <input class="short" id="LevelUnitNumber" name="LevelUnitNumber" type="text" value="1" />

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="NumberOfLevels-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">




                                    <div class="questionName">
                                        <label class="questionName-text" for="NumberOfLevels">Number of Levels:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">
                                        <input id="NumberOfLevels" name="NumberOfLevels" type="text" value="1" data-numeric-field="noneg-nodec" />


                                        <div class="subtext">(Above ground, ground &amp; below ground)</div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="AddNoOfOccupantsPerLevelAndPerUseIfMoreThan1-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">






                                    <div class="questionName">
                                        <label class="questionName-text" for="AddNoOfOccupantsPerLevelAndPerUseIfMoreThan1">Add no. of occupants per level and per use if more than 1:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">


                                        <textarea id="AddNoOfOccupantsPerLevelAndPerUseIfMoreThan1" name="AddNoOfOccupantsPerLevelAndPerUseIfMoreThan1" rows="2">1</textarea>

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="CurrentLawfullyEstablishedUse-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="questionName">
                                        <label class="questionName-text" for="CurrentLawfullyEstablishedUse">Current, lawfully established use:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">

                                        <select id="CurrentLawfullyEstablishedUse" name="CurrentLawfullyEstablishedUse" class="dropdownList">
                                            <option value=""></option>
                                            <option value="ANC"
                                                lang="en">Ancillary</option>
                                            <option value="COMM"
                                                lang="en">Commercial</option>
                                            <option value="ASSC"
                                                lang="en">Communal non-residential - Assembly care</option>
                                            <option value="ASSS"
                                                lang="en">Communal non-residential - Assembly service</option>
                                            <option value="CCR"
                                                lang="en">Communal residential - Community care - Restrained</option>
                                            <option value="CCUR"
                                                lang="en">Communal residential - Community care - Unrestrained</option>
                                            <option value="COMS"
                                                lang="en">Communal residential - Community services</option>
                                            <option value="DDWG"
                                                lang="en">Housing - Detached dwellings</option>
                                            <option value="GDWG"
                                                lang="en">Housing - Group dwelling</option>
                                            <option value="MUDWG"
                                                lang="en">Housing - Multi-unit dwelling</option>
                                            <option value="IND"
                                                lang="en">Industrial</option>
                                            <option value="OUT"
                                                lang="en">Outbuildings</option>
                                            <option value="NA"
                                                lang="en">Not Applicable</option>
                                        </select>


                                        <div class="subtext options">(Select N/A if new / clear site)</div>



                                        <div class="clear"></div>
                                    </div>

                                    <div class="clear"></div>


                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="FloorArea-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="questionName">
                                        <label class="questionName-text" for="FloorArea">Floor area:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">
                                        <input id="FloorArea" name="FloorArea" type="text" data-numeric-field="noneg-nodec" />


                                        <div class="subtext">(Square metres - indicate area affected by the building work)</div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                    <a class="question-help" href="javascript:void(0);">
                                        <span>HelpText</span>
                                    </a>
                                    <div class="tooltip-text">
                                        <span>Calculated over cladding.</span>
                                    </div>


                                </div>
                                <div class="clear"></div>

                            </div>

                            <div class="divider"></div>

                            <div class="question-cell">
                                <h3 class="wizard-info-title">Owner Details
                                </h3>
                            </div>
                            <div class="question-cell header-label-help">
                            </div>
                            <div class="clear"></div>
                            <div id="ActingOnOwnBehalf-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="longQuestionName">
                                        <label class="questionName-text" for="ActingOnOwnBehalf_1">Are you acting on your own behalf?</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">

                                        <div class="horizontalOptionList">
                                            <div>
                                                <input id="ActingOnOwnBehalf_1" name="ActingOnOwnBehalf" type="radio" value="true" />
                                                <label for="ActingOnOwnBehalf_1">Yes</label>
                                            </div>
                                            <div>
                                                <input id="ActingOnOwnBehalf_2" name="ActingOnOwnBehalf" type="radio" value="false" />
                                                <label for="ActingOnOwnBehalf_2">No</label>
                                            </div>
                                        </div>


                                        <div class="subtext"></div>



                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                    <a class="question-help" href="javascript:void(0);">
                                        <span>HelpText</span>
                                    </a>
                                    <div class="tooltip-text">
                                        <span>If you select &quot;Yes&quot;, you are indicating that you are NOT applying through an agent.</span>
                                    </div>


                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="NameOfOwner-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />






                                    <div class="questionName">
                                        <label class="questionName-text" for="NameOfOwner">Name of owner:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">


                                        <input class="long" id="NameOfOwner" name="NameOfOwner" type="text" />

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="ContactPerson-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">






                                    <div class="questionName">
                                        <label class="questionName-text" for="ContactPerson">Contact person:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">


                                        <input class="medium" id="ContactPerson" name="ContactPerson" type="text" />

                                        <div class="subtext">(Required if contact person is someone other than the owner)</div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="MailingAddress-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />







                                    <div class="questionName">
                                        <label class="questionName-text" for="MailingAddress">Mailing address:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">
                                        <div class="address-finder">
                                            <input type="hidden" class="field-value" id="MailingAddressed24c8df-b01e-49d1-b1e7-bb6e4156c8f0" name="MailingAddress" />
                                            <input type="hidden" class="licence-value" value="" />

                                            <div>
                                                <div class="field-label"></div>
                                                <div class="field">
                                                    <input type="text" id="MailingAddress" area="International"
                                                        class="address-finder-textbox long"
                                                        placeholder="Type an address here"
                                                        rural="" region="" pobox="" />
                                                </div>
                                                <div class="clear"></div>
                                            </div>


                                            <div class="manual-fields hidden">
                                                <div>
                                                    <div class="field-label">
                                                        <label for="house-numbered24c8df-b01e-49d1-b1e7-bb6e4156c8f0">House Number:</label></div>
                                                    <div class="field">
                                                        <input type="text" class="house-number" id="house-numbered24c8df-b01e-49d1-b1e7-bb6e4156c8f0" /></div>
                                                    <div class="clear"></div>
                                                </div>
                                                <div>
                                                    <div class="field-label">
                                                        <label for="streeted24c8df-b01e-49d1-b1e7-bb6e4156c8f0">Street:</label></div>
                                                    <div class="field">
                                                        <input type="text" class="street" id="streeted24c8df-b01e-49d1-b1e7-bb6e4156c8f0" /></div>
                                                    <div class="clear"></div>
                                                </div>
                                                <div>
                                                    <div class="field-label">
                                                        <label for="suburbed24c8df-b01e-49d1-b1e7-bb6e4156c8f0">Suburb:</label></div>
                                                    <div class="field">
                                                        <input type="text" class="suburb" id="suburbed24c8df-b01e-49d1-b1e7-bb6e4156c8f0" /></div>
                                                    <div class="clear"></div>
                                                </div>
                                                <div>
                                                    <div class="field-label">
                                                        <label for="cityed24c8df-b01e-49d1-b1e7-bb6e4156c8f0">City:</label></div>
                                                    <div class="field">
                                                        <input type="text" class="city" id="cityed24c8df-b01e-49d1-b1e7-bb6e4156c8f0" /></div>
                                                    <div class="clear"></div>
                                                </div>
                                                <div>
                                                    <div class="field-label">
                                                        <label for="post-codeed24c8df-b01e-49d1-b1e7-bb6e4156c8f0">Post Code:</label></div>
                                                    <div class="field">
                                                        <input type="text" class="post-code" id="post-codeed24c8df-b01e-49d1-b1e7-bb6e4156c8f0" /></div>
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                            <div>
                                                <a class="manual-address-trigger">Enter address manually</a>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                    <a class="question-help" href="javascript:void(0);">
                                        <span>HelpText</span>
                                    </a>
                                    <div class="tooltip-text">
                                        <span>For PO boxes, please ensure no space between the P &amp; O.</span>
                                    </div>


                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="StreetAddressRegisteredOffice-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">






                                    <div class="questionName">
                                        <label class="questionName-text" for="StreetAddressRegisteredOffice">Street address/registered office:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">


                                        <input class="long" id="StreetAddressRegisteredOffice" name="StreetAddressRegisteredOffice" type="text" />

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>


                            <div class="question-cell">
                                <div class="label">
                                    Phone Numbers:
                                </div>
                            </div>
                            <div class="question-cell ">
                            </div>
                            <div class="clear"></div>
                            <div id="PrimaryContact-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />








                                    <div class="questionName">
                                        <label class="questionName-text" for="PrimaryContact">Primary contact:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">
                                        <div class="telephone-question">
                                            <input type="hidden" id="PrimaryContact" />

                                            <input class="ac" id="PrimaryContact_ac" name="PrimaryContact_ac" type="text" aria-labelledby="PrimaryContact PrimaryContact_ac" /><span class="parenthesis hyphen">-</span>
                                            <input class="num" id="PrimaryContact_num" name="PrimaryContact_num" type="text" aria-labelledby="PrimaryContact PrimaryContact_num" />

                                        </div>
                                        <div class="clear"></div>
                                        <div class="telephone-question landline">
                                            <label class="acprefix" for="PrimaryContact_ac">Area</label>
                                            <label class="telnum" for="PrimaryContact_num">Number</label>
                                        </div>
                                        <div class="clear"></div>

                                        <div class="subtext">Landline or mobile</div>
                                    </div>

                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="OtherContact-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">








                                    <div class="questionName">
                                        <label class="questionName-text" for="OtherContact">Other contact:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">
                                        <div class="telephone-question">
                                            <input type="hidden" id="OtherContact" />

                                            <input class="ac" id="OtherContact_ac" name="OtherContact_ac" type="text" aria-labelledby="OtherContact OtherContact_ac" /><span class="parenthesis hyphen">-</span>
                                            <input class="num" id="OtherContact_num" name="OtherContact_num" type="text" aria-labelledby="OtherContact OtherContact_num" />

                                        </div>
                                        <div class="clear"></div>
                                        <div class="telephone-question landline">
                                            <label class="acprefix" for="OtherContact_ac">Area</label>
                                            <label class="telnum" for="OtherContact_num">Number</label>
                                        </div>
                                        <div class="clear"></div>

                                        <div class="subtext">Landline or mobile</div>
                                    </div>

                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="AfterHours-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">








                                    <div class="questionName">
                                        <label class="questionName-text" for="AfterHours">After hours:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">
                                        <div class="telephone-question">
                                            <input type="hidden" id="AfterHours" />

                                            <input class="ac" id="AfterHours_ac" name="AfterHours_ac" type="text" aria-labelledby="AfterHours AfterHours_ac" /><span class="parenthesis hyphen">-</span>
                                            <input class="num" id="AfterHours_num" name="AfterHours_num" type="text" aria-labelledby="AfterHours AfterHours_num" />

                                        </div>
                                        <div class="clear"></div>
                                        <div class="telephone-question landline">
                                            <label class="acprefix" for="AfterHours_ac">Area</label>
                                            <label class="telnum" for="AfterHours_num">Number</label>
                                        </div>
                                        <div class="clear"></div>

                                        <div class="subtext"></div>
                                    </div>

                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="Facsimile-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">








                                    <div class="questionName">
                                        <label class="questionName-text" for="Facsimile">Facsimile:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">
                                        <div class="telephone-question">
                                            <input type="hidden" id="Facsimile" />

                                            <input class="ac" id="Facsimile_ac" name="Facsimile_ac" type="text" aria-labelledby="Facsimile Facsimile_ac" /><span class="parenthesis hyphen">-</span>
                                            <input class="num" id="Facsimile_num" name="Facsimile_num" type="text" aria-labelledby="Facsimile Facsimile_num" />

                                        </div>
                                        <div class="clear"></div>
                                        <div class="telephone-question landline">
                                            <label class="acprefix" for="Facsimile_ac">Area</label>
                                            <label class="telnum" for="Facsimile_num">Number</label>
                                        </div>
                                        <div class="clear"></div>

                                        <div class="subtext"></div>
                                    </div>

                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="EmailAddress-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />






                                    <div class="questionName">
                                        <label class="questionName-text" for="EmailAddress">Email address:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">


                                        <input class="medium" id="EmailAddress" name="EmailAddress" type="text" />

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="Website-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">






                                    <div class="questionName">
                                        <label class="questionName-text" for="Website">Website:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">


                                        <input class="medium" id="Website" name="Website" type="text" />

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>


                            <div class="question-cell">
                                <div class="label">
                                    Evidence of Ownership:
                                </div>
                            </div>
                            <div class="question-cell ">
                                <a class="question-help" href="javascript:void(0);">
                                    <span>HelpText</span>
                                </a>
                                <div class="tooltip-text">
                                    <span>This is required information.  The most common ‘proof of ownership’ is a copy of the land title (this may also be called computer register, Certificate of Title, CT or property title). These can be obtained from Land Information New Zealand (LINZ), phone 0800 665 463, or go online to linz.govt.nz The ‘proof of ownership’ must be current – that is, less than three months old. For a commercial building, a copy of the lease may serve as sufficient ‘proof of ownership’.</span>
                                </div>

                            </div>
                            <div class="clear"></div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-CertificateOfTitle" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="CertificateOfTitle-error" ajax-trigger="CertificateOfTitle" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="CertificateOfTitle_1">Certificate of Title (must be no more than 3 months old)</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="CertificateOfTitle_1" name="CertificateOfTitle" type="radio" value="true" />
                                                    <label for="CertificateOfTitle_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="CertificateOfTitle_2" name="CertificateOfTitle" type="radio" value="false" />
                                                    <label for="CertificateOfTitle_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="CertificateOfTitle-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-LeaseAgreement" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="LeaseAgreement-error" ajax-trigger="LeaseAgreement" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="LeaseAgreement_1">Lease Agreement</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="LeaseAgreement_1" name="LeaseAgreement" type="radio" value="true" />
                                                    <label for="LeaseAgreement_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="LeaseAgreement_2" name="LeaseAgreement" type="radio" value="false" />
                                                    <label for="LeaseAgreement_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="LeaseAgreement-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-AgreementForSaleAndPurchase" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="AgreementForSaleAndPurchase-error" ajax-trigger="AgreementForSaleAndPurchase" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="AgreementForSaleAndPurchase_1">Agreement for Sale and Purchase</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="AgreementForSaleAndPurchase_1" name="AgreementForSaleAndPurchase" type="radio" value="true" />
                                                    <label for="AgreementForSaleAndPurchase_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="AgreementForSaleAndPurchase_2" name="AgreementForSaleAndPurchase" type="radio" value="false" />
                                                    <label for="AgreementForSaleAndPurchase_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="AgreementForSaleAndPurchase-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-RatesNotice" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="RatesNotice-error" ajax-trigger="RatesNotice" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="RatesNotice_1">WDC Rates Notice</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="RatesNotice_1" name="RatesNotice" type="radio" value="true" />
                                                    <label for="RatesNotice_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="RatesNotice_2" name="RatesNotice" type="radio" value="false" />
                                                    <label for="RatesNotice_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="RatesNotice-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>

                            <div class="divider"></div>

                            <div class="question-cell">
                                <h3 class="wizard-info-title">Agent Details
                                </h3>
                            </div>
                            <div class="question-cell header-label-help">
                            </div>
                            <div class="clear"></div>
                            <!-- Ajax region around here? -->
                            <div class="collapsible-layout-group">


                                <a toggle-target="layoutContent-clg-AgentYN" href="#" class="twisty-collapsible-region twisty-on"></a>




                                <div id="AgentYN-error" ajax-trigger="AgentYN" class="error-question">
                                    <div class="question-cell">
                                        <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                        <div class="longQuestionName">
                                            <label class="questionName-text" for="AgentYN_1">Is there an agent working on behalf of the applicant?</label>
                                            <span class="required">*    </span>
                                        </div>
                                        <div class="questionContent">

                                            <div class="horizontalOptionList">
                                                <div>
                                                    <input id="AgentYN_1" name="AgentYN" type="radio" value="true" />
                                                    <label for="AgentYN_1">Yes</label>
                                                </div>
                                                <div>
                                                    <input id="AgentYN_2" name="AgentYN" type="radio" value="false" />
                                                    <label for="AgentYN_2">No</label>
                                                </div>
                                            </div>


                                            <div class="subtext"></div>



                                        </div>
                                        <div class="clear"></div>

                                    </div>
                                    <div class="question-cell">
                                        <a class="question-help" href="javascript:void(0);">
                                            <span>HelpText</span>
                                        </a>
                                        <div class="tooltip-text">
                                            <span>An agent may be your designer, builder or a relative</span>
                                        </div>


                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div id="AgentYN-collapsible-region" class="collapsible-region">
                                    <div>
                                    </div>

                                </div>
                            </div>

                            <div class="divider"></div>

                            <div class="question-cell">
                                <h3 class="wizard-info-title">First Point of Contact
                                </h3>
                            </div>
                            <div class="question-cell header-label-help">
                            </div>
                            <div class="clear"></div>
                            <div id="FPOC-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="questionName">
                                        <label class="questionName-text" for="FPOC_1">First point of contact for correspondence:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">

                                        <div class="horizontalOptionList">
                                            <div>
                                                <input id="FPOC_1" name="FPOC" type="radio" value="O" />
                                                <label for="FPOC_1">Owner</label>
                                            </div>
                                            <div>
                                                <input id="FPOC_2" name="FPOC" type="radio" value="A" />
                                                <label for="FPOC_2">Agent</label>
                                            </div>
                                        </div>


                                        <div class="subtext"></div>



                                        <div class="clear"></div>
                                    </div>

                                    <div class="clear"></div>


                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>

                            <div class="divider"></div>

                            <div class="question-cell">
                                <h3 class="wizard-info-title">Authorisation
                                </h3>
                            </div>
                            <div class="question-cell header-label-help">
                            </div>
                            <div class="clear"></div>

                            <div class="question-cell">
                                <div class="label">
                                    The person specified below will be responsible for all debt associated with this building consent.
                                </div>
                            </div>
                            <div class="question-cell ">
                            </div>
                            <div class="clear"></div>
                            <div id="ConfirmationBillPayment-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />



                                    <div class="questionName">
                                        <span class="questionName-text">
                                            <label for="ConfirmationBillPayment">
                                                <em><strong>In ticking this box I acknowledge and agree that:</em></strong><p>&nbsp;</p>
                                                <p>1. I will pay, or arrange payment, of all fees</p>
                                                <p>payable in respect of this application.</p>
                                                <p>&nbsp;</p>
                                                <p>2. A cancellation fee may be payable if this application</p>
                                                <p>is withdrawn before a building consent is issued.</p>
                                                <p>&nbsp;</p>
                                                <p>3. I have read, understood and agree to abide by the</p>
                                                <p>Online Services Terms and Conditions and the</p>
                                                <p>Council website Terms and Conditions.</p>
                                                <p>&nbsp;</p>
                                                <p>
                                                    4. The person who is nominated below is the person responsible for all billing and debt associated
                                                </p>
                                                <p>with this building consent.</p>
                                            </label>

                                        </span>
                                        <span class="required">*    </span>

                                    </div>
                                    <div class="questionContent">
                                        <input id="ConfirmationBillPayment" name="ConfirmationBillPayment" type="checkbox" value="True" />

                                        <div class="subtext"></div>
                                    </div>

                                    <div class="clear"></div>







                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="SignedByName-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />






                                    <div class="questionName">
                                        <label class="questionName-text" for="SignedByName">Signed by:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">


                                        <input id="SignedByName" name="SignedByName" type="text" />

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>

                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="SignedDate-row" class="question-answer-pair   colspan-1">
                                <div class="question-cell">





                                    <div class="questionName">
                                        <label class="questionName-text" for="SignedDate">Date:</label>
                                        <span class="required"></span>
                                    </div>
                                    <div class="questionContent">



                                        <input data-yearrange="c-20:c+20" class="date-field" id="SignedDate" name="SignedDate" type="text" value="11/05/2016" />

                                        <div class="subtext"></div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>
                            <div id="BillingDetails-error" class="question-answer-pair  error-question colspan-1">
                                <div class="question-cell">
                                    <img src="/Content/images/error-icon-small.png" title="An Error Has Occurred." alt="An Error Has Occurred." class="error-indicator" />




                                    <div class="questionName">
                                        <label class="questionName-text" for="BillingDetails_1">Please specify the billing details for this application:</label>
                                        <span class="required">*    </span>
                                    </div>
                                    <div class="questionContent">

                                        <div class="horizontalOptionList">
                                            <div>
                                                <input id="BillingDetails_1" name="BillingDetails" type="radio" value="O" />
                                                <label for="BillingDetails_1">Owner</label>
                                            </div>
                                            <div>
                                                <input id="BillingDetails_2" name="BillingDetails" type="radio" value="A" />
                                                <label for="BillingDetails_2">Agent</label>
                                            </div>
                                        </div>


                                        <div class="subtext"></div>



                                        <div class="clear"></div>
                                    </div>

                                    <div class="clear"></div>


                                </div>
                                <div class="question-cell">
                                </div>
                                <div class="clear"></div>

                            </div>













                            <div class="bottom-buttons">

                                <input type="submit" value="Continue &gt;&gt;"
                                    class="button continue-button disableAfterClick" name="_continueButton" />
                                <input type="submit" value="Cancel" class="button cancel-button" name="_cancelButton"
                                    data-popup-title="Confirm Cancellation"
                                    data-popup-msg="This will delete your entire application. Are you sure you want to delete your application?"
                                    data-popup-ok="OK"
                                    data-popup-cancel="Cancel" />
                                <input type="hidden" name="_cancelButtonAction" />
                                <input type="hidden" name="_submitButtonAction" />



                                <div class="clear"></div>
                            </div>
                            <div class="clear"></div>
                        </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
