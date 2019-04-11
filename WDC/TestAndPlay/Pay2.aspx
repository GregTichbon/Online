<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pay2.aspx.cs" Inherits="Online.TestAndPlay.Pay2" %>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <title>Infringement Payment: Payment Selection - Whanganui District Council</title>

        <link href="https://eservices.whanganui.govt.nz/content/core.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
        <link href="https://eservices.whanganui.govt.nz/content/responsive.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
        <link href="https://eservices.whanganui.govt.nz/content/my-account.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
        <link href="https://eservices.whanganui.govt.nz/content/masonry-layout.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />

    <link href="https://eservices.whanganui.govt.nz/content/bookings.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/themes/jqueryui/smoothness/jquery-ui-1.8.22.custom.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/themes/base/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/themes/base/jquery.qtip.min.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/themes/base/jquery.qtip.custom.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/themes/base/jquery.alerts.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/themes/base/jquery.countdown.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/DataTables/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/DataTables/css/select.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/DataTables/css/responsive.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/UI-Grid-master/grid.min.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/UI-Grid-master/grid.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/sitestyle/Block" rel="stylesheet" type="text/css" />

        <link href="https://eservices.whanganui.govt.nz/content/themes/whanganuidc/clientcore.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/themes/fontawesome/font-awesome.css" rel="stylesheet" type="text/css" />

    <link href="https://eservices.whanganui.govt.nz/content/mapping/leaflet.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/mapping/leaflet.label.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/content/mapping/easy-button.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/scripts/mapping/leaflet-control-geocoder-1.5.1/Control.Geocoder.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />
    <link href="https://eservices.whanganui.govt.nz/scripts/mapping/leaflet-draw/leaflet.draw.css?rev=2018.02.2134.1" rel="stylesheet" type="text/css" />

    

    <link href="https://fonts.googleapis.com/css?family=Oxygen" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery-1.11.3.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.validate.unobtrusive.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.unobtrusive-ajax.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery-ui-1.9.2.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery-ui-extensions.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.uniform.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/modernizr-2.6.2.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.numeric.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.fileupload.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.qtip.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.alerts.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.watermark.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/init.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/spinner.js?rev=2018.02.2134.1" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.countdown.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.ddslick.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.cookie.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.blockUI.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.price_format.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jgestures.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/uri.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.mobile.custom.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.lazyload.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.visible.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/DataTables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/DataTables/dataTables.select.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/DataTables/dataTables.responsive.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/moment.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/DataTables/datetime-moment.js" type="text/javascript"></script>

    <script src="https://eservices.whanganui.govt.nz/scripts/mapping/leaflet.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/mapping/leaflet.label.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/mapping/leaflet-draw/leaflet.draw.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/mapping/leaflet-control-geocoder-1.5.1/Control.Geocoder.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/mapping/easy-button.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/underscore.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/mapping/mapping.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/signature/signature_pad.min.js" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/jquery.reveal.js" type="text/javascript"></script>
    

    
    <script type="text/javascript" src="https://www.addressfinder.co.nz/assets/v2/widget.js"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/core.js?rev=2018.02.2134.1" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/dynamicforms.js?rev=2018.02.2134.1" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/sharing.js?rev=2018.02.2134.1" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/mapping/mapping-question.js?rev=2018.02.2134.1" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/scripts/DynamicForms/MapQuestion.js?rev=2018.02.2134.1" type="text/javascript"></script>
    <script src="https://eservices.whanganui.govt.nz/Scripts/DynamicForms/combodate.js?rev=2018.02.2134.1" type="text/javascript"></script>

    <script type="text/javascript">
        var rootUrl = '/';
        var countdownValue = 1; // minutes
        var sessTimeout = 60; // minutes
        var isLoggedIn = false;
        var noTimeout = false;
        var pageLanguageCode = '';
        $(function() {
            if(isLoggedIn) {
                initSessionTimer();
            }
        });
    </script>

    
    <script src="https://eservices.whanganui.govt.nz/scripts/bookings/bookings.js?rev=2018.02.2134.1" type="text/javascript"></script>

    



</head>
<body>
    <div id="body-wrapper">
        <div id="wrapper">
            <header >
                


    <div id="header-container">
    <div id="logging">
    </div>
    <div id="logo-center">
        <a href="http://www.whanganui.govt.nz/" id="logo" lang="en" title="Online Services"> </a>
    </div>
        <div id="nav-wrapper">
            <ul id="nav">
                                    <li class="home-link"><a href="http://www.whanganui.govt.nz/">Back to Home</a></li>

                    <li class="services-link"><a class="selected" href="/">Services</a></li>

                    <li class="my-account-link"><a class="" href="/my-account">My Account</a></li>
            </ul>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>








            </header>
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
                        



<h1><span >

        Infringement Payment
    </span>
    <span ></span>
</h1>

<form action="https://eservices.whanganui.govt.nz/online-services/new/infringement-payment/step/1" class="mark-required" data-dialogue-category="Services" data-dialogue-code="INFRINGEMENT-PAYMENT" data-dialogue-group="Payments" data-popup-cancel="Cancel" data-popup-enable="False" data-popup-msg="Form is currently busy, please try again." data-popup-ok="OK" data-popup-submitcancel="No" data-popup-submitmsg="Are you sure you want to submit and finalise your application?" data-popup-submitok="Yes" data-popup-submittitle="Confirm Submission" data-popup-title="Form Busy" id="dialogue-form" method="post"><input name="__RequestVerificationToken" type="hidden" value="dY3O48wORRd-arfiEpUhQH8AE1FGZCbF1UiNY_e9Y-N52O-L2w_ONzGMUszJVqp1nhoISWG7T9rCIuXrWhSNfVpf1MPLMAEMq7IQzhvRwWE1" /><input data-val="true" data-val-required="The IsEmbedded field is required." id="IsEmbedded" name="IsEmbedded" type="hidden" value="False" /><div class="clear"></div>





<input type="submit" value="continue" name="_continueButton" style="position: absolute; margin-left: -9999px; "  />

<input type="hidden" name="__wizard-step" id="__wizard-step"  />

<a href="#step-heading" accesskey="[" class="skip-to-main">[Jump to content]</a>

        <div id="progress-bar">
                        <div class="current-step">
                                <span >Payment Request Details</span>
                                <span class="step_cr"></span>
                        </div>
                            <img src="https://eservices.whanganui.govt.nz/content/images/wizard/wizard-divider-current-right.png" alt="navigation menu divider" class="current" />
                        <div class="step">
                                <button id="_wizard-step-2" type="button" data-stepnumber="2" >
                                    <span >Owing</span>
                                    <span class="step_nf"></span>
                                </button>
                        </div>
                            <img src="https://eservices.whanganui.govt.nz/content/images/wizard/wizard-divider.png" alt="navigation menu divider" class="default" />
                        <div class="step">
                                <button id="_wizard-step-3" type="button" data-stepnumber="3" >
                                    <span >Make Payment</span>
                                    <span class="step_nf"></span>
                                </button>
                        </div>
                            <img src="https://eservices.whanganui.govt.nz/content/images/wizard/wizard-divider.png" alt="navigation menu divider" class="default" />
                        <div class="step">
                                <span class="disabled-step" >Confirmation</span>
                                <span class="step_nf"></span>
                        </div>
                <div class="clear"></div>
        </div>











<div class="clear"></div>
    <div class="clear"></div>
    <div id="step-heading">
        <div class="step-buttons">

    <span class="directional-buttons">
        <input type="submit" value="Submit &gt;&gt;" 
               class="button continue-buttonX disableAfterClickX" name="_continueButtonX" />

    </span>


        </div>
        <div class="step-title">
            
            <h2>
                <span >
                    Payment Selection
                </span>

            </h2>
        </div>
    </div>
    <div id="form-wrapper">
    
    
    <div class="form-instruction note"></div>
    <div class="clear"></div>




<div class="question-cell" >
            <h2>
                Payment Request Details
            </h2>
</div>
    <div class="question-cell question-help-wrapper ">
        
    </div>
<div class="clear"></div>




<div class="question-cell" >
            <div class="label">
                This information should be populated with HTML code returned from Whanganui District Council based on a parameter in the querystring.<br /><br />EG: Cemetery Burial Fee = $120.00<br /><br />This could be done when the page is formed or by the use of a web service.<br /><br />The HTML, simple description, amount, and whether part payment is allowed will be supplied.<br /><br />The reference in the query string should be retained and returned when payment has been accepted.  The amount (which may be part) should also be returned.
            </div>
</div>
    <div class="question-cell question-help-wrapper ">
        
    </div>
<div class="clear"></div>
                    <div id="EmailAddress-row" class="question-answer-pair   ">
        <div class="question-cell question-help-wrapper">
            
        </div>
    <div class="clear"></div>

                    </div>
                    <div id="DebtorNumber-row" class="question-answer-pair   ">
        <div class="question-cell question-help-wrapper">
            
        </div>
    <div class="clear"></div>

                    </div>
                    <div id="TermsAndConditions-row" class="question-answer-pair   ">
                            <div class="question-cell" role="group" aria-label="">
        <span class="error-anchor" id="TermsAndConditions-error-anchor"></span>
        
 
<div class="questionName  ">
    <label class="questionName-text" for="TermsAndConditions"  id="TermsAndConditions_Label">
        <span class="label-text">
            
        </span> 
        <span class="label-after">
                
                    </span>
    </label>
    <div class="subtext"></div>
</div>    <div class="questionContent ">
        

    <div class="horizontalOptionList">
        <div>
            <input id="TermsAndConditions_1" name="TermsAndConditions" type="checkbox" value="Option1"   />
            <label for="TermsAndConditions_1" >By using this service, I accept the terms and conditions</label>
        </div>
    </div>


<div class="clear"></div>
<div class="subtext"></div>



        <div class="clear"></div>
    </div>

<div class="clear"></div>


    </div>
        <div class="question-cell question-help-wrapper">
            
        </div>
    <div class="clear"></div>

                    </div>




<div class="question-cell" >
            <h2>
                Terms and conditions for online transaction processing services
            </h2>
</div>
    <div class="question-cell question-help-wrapper ">
        
    </div>
<div class="clear"></div>




    <div class="divider"></div>
<div class="question-cell" >
            <h3 class="wizard-info-title">
                Additional Information
            </h3>
</div>
    <div class="question-cell question-help-wrapper header-label-help">
        
    </div>
<div class="clear"></div>




<div class="question-cell" >
            <div class="term-and-con">
                <P>Whanganui District Council Online Transaction Processing Service offers certain transactions that can be done through the Council's website. All such transactions are subject to these terms and conditions. The Council may vary these terms and conditions from time to time without notification and it is your responsibility to ensure that you are familiar with them. In these terms and conditions, the following words and phrases shall have the following meanings:</P>
<BR><BR><H2>1.	Use of Online Transactions</H2>
<P>Whanganui District Council makes online transactions available for your personal and/or internal business purposes. You may use information provided to you through your online transactions solely for your personal and/or internal business purposes, provided that you do not remove any proprietary rights notices, do not modify the information or make it available to third parties through a networked computer environment and do not make any additional representations or warranties regarding the information.</P>
<BR><BR><H2>2.	Information and Privacy</H2>
<P>You hereby authorise Whanganui District Council to receive and collect information about you (including information about your online transactions) from time to time through the Whanganui District Council website. Any such information collected shall be treated in accordance with the Privacy Act 1993. Whanganui District Council may disclose information about you (including your identity) to a third party if Whanganui District Council is requested to do so in the course of a criminal or other legal investigation, or if Whanganui District Council determines that disclosure is necessary in connection with any complaint regarding your use of the site.</P>
<BR><BR><H2>3.	Payment Convenience Fees</H2>
<P>Processing fees for online credit card payments are added to your payment amount – 2.6% of the transaction for credit card processing by Council's bank. These will not be itemised on your bank statement, but included in the transaction total. Whanganui District Council retains no part of these fees. We have several other payment options if you prefer not to make payments online. </P>
<BR><BR><H2>4.	Consent for us to receive and store information in electronic form</H2>
<P>Use of these services means that you agree to provide information through electronic means. This means you agree to provide any relevant information, documents and attachments in the format and to the standards described for each transaction. It also means you agree and understand that the information will be retained in electronic form.</P>
<BR><BR><H2>5.	Consent for us to provide you with information in electronic form</H2>
<P>Use of these services means that you agree to receive information through electronic means. Where information is requested by another person, the requesting party is deemed to be the recipient's agent and is presumed to have obtained the consent of the recipient to receive the information in electronic format.</P>
<BR><BR><H2>6.	Accounts</H2>
<P>Certain online transactions offered by Whanganui District Council may require a login ID and password for verification of your identity to access the online transactions. You agree that all information provided to Whanganui District Council by you in relation to your account shall be current, complete and accurate. Your use of a Whanganui District Council account is subject to these terms and conditions You agree to comply with all such terms and conditions in respect of your use of online transactions.</P>
<BR><BR><H2>7.	Password Security</H2>
<P>If you are required to select a password, Whanganui District Council recommends the password you select should not relate to any readily accessible data such as your name, birth date, address, telephone number, driver's licence, licence plate or passport. Nor may it be an obvious combination of letters and numbers, including sequential or same numbers or letters. You are entirely responsible for maintaining the security of your login ID and password, and for all activity which occurs on or through your account, whether authorised or unauthorised, including use by current and former employees if you are a corporate entity. You should change your password immediately if you believe that your login ID and password have been used without authorisation and advise Whanganui District Council of this. Whanganui District Council shall not have any liability for your failure to comply with these obligations.</P>
<BR><BR><H2>8.	Security</H2>
<P>Transaction Processing Services are provided through a secure website. However, you acknowledge and agree that Internet transmissions are never entirely secure or private, and that any message or information you send to or through the Council website while using online transactions (including credit card information) may be read or intercepted by others, even where a website is stated as being secure. Whanganui District Council shall have no liability for the interception or ‘hacking' of data through the website by unauthorised third parties.</P>
<BR><BR><H2>9.	Your Warranties</H2>
<P>In using any Whanganui District Council transactions you represent and warrant that you are over 18 years of age and have legal capacity to contract in New Zealand. If you are using a credit card to process a transaction, you represent and warrant that the credit card is issued in your name and that you shall pay to the issuer all charges incurred while using online transactions. If you are using a Whanganui District Council account, you represent and warrant that you are authorised to use the login ID and password allocated to such account.</P>
<BR><BR><H2>10.	Accuracy of Transaction Information</H2>
<P>Before completing an online transaction with the Whanganui District Council, you will be presented with a confirmation screen verifying the transaction details you wish to process. It is your responsibility to verify that all transaction, credit card/account information and other details are correct. You should print the transaction confirmation for future reference and your files. Whanganui District Council shall have no liability for transactions which are incorrect as a result of inaccurate data entry in the course of any online transactions, or for loss of data or information caused by factors outside of Whanganui District Council's control. This includes the information supplied as part of the application.</P>
<BR><BR><H2>11.	Limitation of Liability</H2>
<P>Except as expressly prohibited by law, in no event will Whanganui District Council be liable to you for any direct, indirect, consequential, exemplary, incidental or punitive damages, including lost profits, even where Whanganui District Council has been advised of the possibility of such damages occurring. If, notwithstanding the foregoing, Whanganui District Council is found to be liable to you for any damage or loss which arises as a result of your use of the website, Whanganui District Council's liability shall not exceed the dollar amount of the transaction which formed the basis of the damage or $100.00, whichever is the lesser.</P>
<BR><BR><H2>12.	Right to Suspend, Alter or Cancel Service</H2>
<P>Whanganui District Council shall be entitled at any time without prior notice or any liability to you, to cancel or suspend any or all online services and/or to substitute alternative services, which may or may not be interactive or transactional in nature.</P>
<BR><BR><H2>13.	Specific Service Terms and Conditions</H2>
<P>You acknowledge that certain online transactions made available or offered by Whanganui District Council from time to time may be subject to specific additional terms and conditions, and you agree to review and comply with any such additional terms and conditions. Access and use of any online services shall be deemed to constitute acceptance of any such additional terms and conditions applicable to such service.</P>
<BR><BR><H2>14.	Jurisdiction</H2>
<P>These terms and conditions and the online services they cover are governed by New Zealand law. The New Zealand Courts have exclusive jurisdiction over any matter in connection with the online services and these terms and conditions.</P>
<BR><BR><H2>15.	Support Hours</H2>
<P>Whanganui District Council provides customer support for online services between the hours of 8.00am to 5.00pm (Monday to Friday). All queries outside these hours will be logged and attended to during office hours.</P>
<BR><BR><H2>16.	Refunds Policy</H2>
<P>A refund will only be provided when it has been proven that a payment has been made twice at the same time for one item, by the same method.</P>
            </div>
</div>
    <div class="question-cell question-help-wrapper ">
        
    </div>
<div class="clear"></div>




<div class="question-cell" >
            <div class="label">
                <LU><P><B>How you can pay:</B></P>
<LI>By the following credit card types: Visa or MasterCard only are accepted</LI></LU>
<BR><LU><P><B>Credit Card Fees:</B></P>
<LI>You will be charged a convenience fee of 2.6% + $0.15 for online transactions</LI></LU>
<BR><LU><P><B>Instructions:</B></P>	You will find step by step instructions as you go through the payment process. 
<LI>At the end of the transaction you will be given a reference number.</LI></LU>
<LI>Receipts for online payments are emailed; however, you can either print the screen or note down the details for future reference.</LI>
<LI>Close the browser window when you are finished.</LI>
<LI>When using the service we recommend that you use the navigation buttons provided within the screens. Use of the 'enter' key in some screens may have unexpected results.</LI></LU>
<BR><LU><P><B>Hours:</B></P>	
<LI>Payments made after 10pm may appear on your account the following business day.</LI></LU>
	
<BR><LU><P><B>Refund enquiries:</B></P>
<LI>Refund enquiries should be directed to Whanganui District Council. Phone +64 6 349 0001 or Email: wdc@whanganui.govt.nz</LI></LU>
            </div>
</div>
    <div class="question-cell question-help-wrapper ">
        
    </div>
<div class="clear"></div>















    <div class="bottom-buttons">
        
    <span class="directional-buttons">
        <input type="submit" value="Submit &gt;&gt;" 
               class="button continue-buttonX disableAfterClickX" name="_continueButtonX" />

    </span>



        <div class="clear"></div>
    </div>
    <div class="clear"></div>
    </div>
</form><input id="DisablePublicDialogueSpinner" name="DisablePublicDialogueSpinner" type="hidden" value="True" />




                    </div>
                    










                </div>
            </div>

            <div id="timeoutWarning" data-timer-title="Timeout" data-timer-button="Continue">
                <div class="timeout-wrapper">
                    <div class="message">

                        <p>Your session is about to time out.</p>
                        <p>You will lose any unsaved data.</p>

                        <div id="countdown-timer"></div>
                        Click &quot;Continue&quot; to extend your session.
                    </div>
                </div>
            </div>

            <div id="formRenderError">
                <p>Unfortunately, an error has occurred when processing this form. Please click "OK" to reload.</p>
                <input type="button" class="button" id="btnFormRenderErrorOK" value="OK" />
            </div>

        </div>
        <input type="hidden" id="DialogueBaseUrl" value="https://eservices.whanganui.govt.nz" />
        <footer>
            <div id="footer-container" >
 
            </div>
        </footer>
    </div>
</body>
</html>