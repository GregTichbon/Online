<%@ Page Title="Invoice Payments" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvoicePayment.aspx.cs" Inherits="Online.InvoicePayment.InvoicePayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Invoice Payment - Whanganui District Council</title>
    <script type="text/javascript">
        $(document).ready(function () {
            //window.addEventListener('hashchange', function () {
            //alert('the hash has changed to: ' + window.location.hash)
            //})
            $("#pagehelp").colorbox({ href: "InvoicePaymentHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: [],
                rules: {
                    tb_emailconfirm: {
                        equalTo: '#tb_emailaddress'
                    },
                    hidden_location: {
                        items_exist: true
                    },
                    hidden_datesofuse: {
                        items_exist: true
                    },
                    hidden_vehicles: {
                        items_exist: true
                    }

                },
                errorPlacement: function (error, element) {
                    var placement = $(element).data('errorplacement');
                    if (placement) {
                        $(placement).append(error)
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            $.validator.addMethod("items_exist", function (value, element) {
                if (value > 0) {
                    return true;
                } else {
                    return false;
                }
            }, "This field is required.");

            $('#rbl_invoicetype').change(function () {
                $('#invoicedetails').hide();
                $('#div_selectinvoice').hide();
                $('#paymentform').hide();
                $('#div_invoicedetail').show();
                //$('#btn_continue').show();

                selectedvalue = $('#rbl_invoicetype :selected').text();
                $('#hf_type').val(selectedvalue);
                switch (selectedvalue) {
                    case 'Application':
                        $('#lbl_reference1').html('Tax invoice number');
                        $('#lbl_reference2').html('Reference number');

                        $('#tb_reference1').val('20171042854') //Testing
                        $('#tb_reference2').val('BCon17/0607')  //Testing

                        break;
                    case 'Sundry Debtor':
                        $('#lbl_reference1').html('Debtor number');
                        $('#lbl_reference2').html('Tax invoice number');

                        $('#tb_reference1').val('test') //Testing
                        $('#tb_reference2').val('test')  //Testing

                        //$('.div_Water').hide();
                        break;
                    case 'Water':
                        $('#lbl_reference1').html('Account number');
                        $('#lbl_reference2').html('Notice number');

                        $('#tb_reference1').val('test') //Testing
                        $('#tb_reference2').val('test')  //Testing

                        //$('.div_Water').show();
                        break;
                }
            });

            $('#btn_showinvoice').click(function () {
                //window.location.hash = "showinvoice";
                $('#div_selectinvoice').hide();
                $('#invoicedetails').show();
                $('#paymentform').hide();
                selectedvalue = $('#rbl_invoicetype :selected').text();
                $.ajax({
                    url: "../functions/data.asmx/InvoiceAmounts?type=" + selectedvalue + "&reference1=" + $("#tb_reference1").val() + "&reference2=" + $("#tb_reference2").val(), success: function (result) {
                        details = $.parseJSON(result);
                        if (details[0].result == 'Found') {
                            if (details[0].balance <= 0) {
                                $('#div_selectinvoice').hide();
                                $('#invoicedetails').html('This invoice has been paid');
                            } else {
                                $('#div_selectinvoice').show();
                                var amount = parseFloat(details[0].amount).toFixed(2);
                                var gst = parseFloat(details[0].gst).toFixed(2);
                                var balance = parseFloat(details[0].balance).toFixed(2);
                                var transactionfee = parseFloat(details[0].transactionfee).toFixed(2);
                                var surcharge = parseFloat(details[0].surcharge).toFixed(2);
                                var totalamount = (Number(balance) + Number(transactionfee) + Number(surcharge)).toFixed(2);
                                $('#invoicedetails').html('<table><tr><td>Detail</td><td>' + details[0].detail + '</td></tr><tr><td>Amount</td><td align="right">$' + amount + '</td></tr><tr><td>GST</td><td align="right">$' + gst + '</td></tr><tr><td>Balance</td><td align="right">$' + balance + '</td></tr><tr><td>Transaction Fee</td><td align="right">$' + transactionfee + '</td></tr><tr><td>Credit Card Surcharge</td><td align="right">$' + surcharge + '</td></tr><tr><td>Total to Pay</td><td align="right">$' + totalamount + '</td></tr></table>');
                                $('#hf_amount').val(balance);
                                $('#span_amount').html(parseFloat(totalamount).toFixed(2));
                                $('#ccdetail').html($('#tb_reference2').val() + ' - ' + details[0].detail + ' (' + $('#tb_reference1').val() + ')');
                                $('#hf_ccdetail').val($('#tb_reference2').val() + ' - ' + details[0].detail + ' (' + $('#tb_reference1').val() + ')');
                                $('#hf_transactionfee').val(transactionfee);
                                $('#hf_surcharge').val(surcharge);
                            }
                        } else {
                            $('#div_selectinvoice').hide();
                            $('#invoicedetails').html(details[0].result);
                        }
                    }
                });
            });

            $('#btn_selectinvoice').click(function () {
                //window.location.hash = "selectinvoice";
                $('#paymentform').show();
            });

            $("#form1").submit(function (event) {

                //alert('submit');
                // Stop form from submitting normally
                event.preventDefault();

                if ($("#form1").valid() == true) {

                    var arForm = $("#form1").serializeArray();
                    var formData = JSON.stringify({ formVars: arForm })

                    // process the form
                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: '../functions/posts.asmx/InvoicePayment', // the url where we want to POST
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (result) {
                            details = $.parseJSON(result.d);
                            alert(details.id);
                        },
                        error: function (xhr, status) {
                            alert("An error occurred: " + status);
                        }
                    })
                }
            });



            $('#a_test').click(function () {
                $('#tb_cardnumber').val('4111111111111111');
                $('#tb_cardholder').val('TEST');
                $('#ddl_expirymonth').val('10');
                $('#ddl_expiryyear').val('17');
                $('#tb_secureid').val('999');
            })

        });
    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Online Invoice Payments</h1>


    <input type="hidden" id="hf_type" name="hf_type" />
    <input type="hidden" id="hf_amount" name="hf_amount" />
    <input type="hidden" id="hf_ccdetail" name="hf_ccdetail" />
    <input type="hidden" id="hf_transactionfee" name="hf_transactionfee" />
    <input type="hidden" id="hf_surcharge" name="hf_surcharge" />







    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailaddress">Email address:</label>
        <div class="col-sm-8">
            <input type="email" id="tb_emailaddress" name="tb_emailaddress" class="form-control" title="" maxlength="60" required />

        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_emailconfirm">Please confirm your email address:</label>
        <div class="col-sm-8">
            <input type="email" id="tb_emailconfirm" name="tb_emailconfirm" class="form-control" title="" maxlength="60" required />

        </div>
    </div>






    <div class="form-group">
        <label class="control-label col-sm-4" for="Invoice type">Invoice type:</label>
        <div class="col-sm-8">
            <select id="rbl_invoicetype" name="rbl_invoicetype" class="form-control" required>
                <option></option>
                <option>Application</option>
                <option>Sundry Debtor</option>
                <option>Water</option>
            </select>
        </div>
    </div>

    <div id="div_invoicedetail" style="display: <%: none%>">






        <div class="form-group">
            <label id="lbl_reference1" class="control-label col-sm-4" for="tb_reference1">Reference:</label>
            <div class="col-sm-8">
                <input type="text" id="tb_reference1" name="tb_reference1" class="form-control" title="" maxlength="20" />
            </div>
        </div>






        <div class="form-group">
            <label id="lbl_reference2" class="control-label col-sm-4" for="tb_reference2">Reference:</label>
            <div class="col-sm-8">
                <input type="text" id="tb_reference2" name="tb_reference2" class="form-control" title="" maxlength="20" />
            </div>
        </div>





        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input id="btn_showinvoice" type="button" value="Show Invoice" class="btn btn-info" />
                <span id="invoicedetails"></span>
            </div>
        </div>
    </div>

    <div class="form-group" id="div_selectinvoice" style="display: <%: none%>">

        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_selectinvoice" type="button" value="Select this Invoice" class="btn btn-info" />

        </div>
    </div>



    <table id="paymentform" class="table table-hover table-responsive" style="display: <%: none%>">





        <tr>
            <td class="col-md-4 text-right">Detail</td>
            <td>
                <span id="ccdetail"></span>
            </td>
            <td rowspan="7">
                <a href="http://www.paymentexpress.com/privacypolicy.htm" target="_blank">
                    <img src="https://www.paymentexpress.com/Image/paynow-red-120x29-jpg.jpg" /></a><br />
                <strong>Test cards&nbsp;&nbsp; </strong>
                <a id="a_test">Test</a><br />
                4111111111111111 for Visa<br />
                5431111111111111 for MasterCard<br />
                371111111111114 for Amex<br />
                36000000000008 for Diners.
                <br />
                These can be used with any current expiry<br />
                <br />
                Expired Card (ReCo 54) - 4999999999999996<br />
                Card with Insufficient Funds (ReCo 51) - 5431111111111228<br />
                Timeout (ReCo U9) - 4999999999999202<br />
                <br />
                Using the card number 4999999999999202 will result in a declined transaction and set the retry flag to &quot;1&quot; for interfaces that support it.<br />
                <br />
                4999999999999236 - ReCo 05<br />
                4999999999999269 - ReCo 12<br />
                5431111111111301 - ReCo 30<br />
                5431111111111228 - ReCo 51<br />
                <br />
                <a href="http://www.paymentexpress.com/Technical_Resources/Ecommerce_NonHosted/PxPost">http://www.paymentexpress.com/Technical_Resources/Ecommerce_NonHosted/PxPost</a>
                <br />
                <a href="http://www.paymentexpress.com/knowledge_base/faq/developer_faq.html">http://www.paymentexpress.com/knowledge_base/faq/developer_faq.html</a>
                <br />
            </td>
        </tr>




        <tr>
            <td class="col-md-4 text-right">Card Number</td>
            <td>
                <input type="text" id="tb_cardnumber" name="tb_cardnumber" class="form-control" title="" maxlength="16" required />
            </td>
        </tr>
        <tr>






            <td class="col-md-4 text-right">Card Holder&#39;s Name</td>
            <td>
                <input type="text" id="tb_cardholder" name="tb_cardholder" class="form-control" title="" required />
            </td>
        </tr>





        <tr>
            <td class="col-md-4 text-right">Card Expiry Date</td>
            <td>
                <select id="ddl_expirymonth" name="ddl_expirymonth" required>

                    <option value="">Month</option>
                    <option value="01">Jan</option>
                    <option value="02">Feb</option>
                    <option value="03">Mar</option>
                    <option value="04">Apr</option>
                    <option value="05">May</option>
                    <option value="06">Jun</option>
                    <option value="07">Jul</option>
                    <option value="08">Aug</option>
                    <option value="09">Sep</option>
                    <option value="10">Oct</option>
                    <option value="11">Nov</option>
                    <option value="12">Dec</option>

                </select>
                <select id="ddl_expiryyear" name="ddl_expiryyear" required>

                    <option value="">Year</option>
                    <option value="15">2015</option>
                    <option value="16">2016</option>
                    <option value="17">2017</option>
                    <option value="18">2018</option>
                    <option value="19">2019</option>
                    <option value="20">2020</option>
                </select>

            </td>
        </tr>







        <tr>
            <td class="col-md-4 text-right">
                <label for="cardSecureId">
                    CSC/CVV/CVV2</label></td>
            <td>
                <input type="text" id="tb_secureid" name="tb_secureid" class="form-control" maxlength="3" title="" required />

            </td>
        </tr>








        <tr>
            <td class="col-md-4 text-right">
                <label id="lbl_AmountWording">
                    Amount
                </label>
            </td>
            <td>
                <span id="span_amount"></span>

            </td>
        </tr>









        <tr>
            <td></td>
            <td>
                <asp:Button ID="btn_payinvoice" runat="server" Text="Pay this Invoice" class="btn btn-info btn_payinvoice" />
            </td>
        </tr>







    </table>





    <div id="div_termsconditions">
        <h3>Terms and conditions for online transaction processing services
        </h3>
        <p>Whanganui District Council Online Transaction Processing Service offers certain transactions that can be done through the Council's website. All such transactions are subject to these terms and conditions. The Council may vary these terms and conditions from time to time without notification and it is your responsibility to ensure that you are familiar with them. In these terms and conditions, the following words and phrases shall have the following meanings:</p>


        <h3>1.	Use of Online Transactions</h3>
        <p>Whanganui District Council makes online transactions available for your personal and/or internal business purposes. You may use information provided to you through your online transactions solely for your personal and/or internal business purposes, provided that you do not remove any proprietary rights notices, do not modify the information or make it available to third parties through a networked computer environment and do not make any additional representations or warranties regarding the information.</p>


        <h3>2.	Information and Privacy</h3>
        <p>You hereby authorise Whanganui District Council to receive and collect information about you (including information about your online transactions) from time to time through the Whanganui District Council website. Any such information collected shall be treated in accordance with the Privacy Act 1993. Whanganui District Council may disclose information about you (including your identity) to a third party if Whanganui District Council is requested to do so in the course of a criminal or other legal investigation, or if Whanganui District Council determines that disclosure is necessary in connection with any complaint regarding your use of the site.</p>


        <h3>3.	Payment Convenience Fees</h3>
        <p>Processing fees for online credit card payments are added to your payment amount – 2.6% of the transaction for credit card processing by Council's bank. These will not be itemised on your bank statement, but included in the transaction total. Whanganui District Council retains no part of these fees. We have several other payment options if you prefer not to make payments online. </p>


        <h3>4.	Consent for us to receive and store information in electronic form</h3>
        <p>Use of these services means that you agree to provide information through electronic means. This means you agree to provide any relevant information, documents and attachments in the format and to the standards described for each transaction. It also means you agree and understand that the information will be retained in electronic form.</p>


        <h3>5.	Consent for us to provide you with information in electronic form</h3>
        <p>Use of these services means that you agree to receive information through electronic means. Where information is requested by another person, the requesting party is deemed to be the recipient's agent and is presumed to have obtained the consent of the recipient to receive the information in electronic format.</p>


        <h3>6.	Accounts</h3>
        <p>Certain online transactions offered by Whanganui District Council may require a login ID and password for verification of your identity to access the online transactions. You agree that all information provided to Whanganui District Council by you in relation to your account shall be current, complete and accurate. Your use of a Whanganui District Council account is subject to these terms and conditions You agree to comply with all such terms and conditions in respect of your use of online transactions.</p>

        <h3>7.	Password Security</h3>
        <p>If you are required to select a password, Whanganui District Council recommends the password you select should not relate to any readily accessible data such as your name, birth date, address, telephone number, driver's licence, licence plate or passport. Nor may it be an obvious combination of letters and numbers, including sequential or same numbers or letters. You are entirely responsible for maintaining the security of your login ID and password, and for all activity which occurs on or through your account, whether authorised or unauthorised, including use by current and former employees if you are a corporate entity. You should change your password immediately if you believe that your login ID and password have been used without authorisation and advise Whanganui District Council of this. Whanganui District Council shall not have any liability for your failure to comply with these obligations.</p>


        <h3>8.	Security</h3>
        <p>Transaction Processing Services are provided through a secure website. However, you acknowledge and agree that Internet transmissions are never entirely secure or private, and that any message or information you send to or through the Council website while using online transactions (including credit card information) may be read or intercepted by others, even where a website is stated as being secure. Whanganui District Council shall have no liability for the interception or ‘hacking' of data through the website by unauthorised third parties.</p>


        <h3>9.	Your Warranties</h3>
        <p>In using any Whanganui District Council transactions you represent and warrant that you are over 18 years of age and have legal capacity to contract in New Zealand. If you are using a credit card to process a transaction, you represent and warrant that the credit card is issued in your name and that you shall pay to the issuer all charges incurred while using online transactions. If you are using a Whanganui District Council account, you represent and warrant that you are authorised to use the login ID and password allocated to such account.</p>


        <h3>10.	Accuracy of Transaction Information</h3>
        <p>Before completing an online transaction with the Whanganui District Council, you will be presented with a confirmation screen verifying the transaction details you wish to process. It is your responsibility to verify that all transaction, credit card/account information and other details are correct. You should print the transaction confirmation for future reference and your files. Whanganui District Council shall have no liability for transactions which are incorrect as a result of inaccurate data entry in the course of any online transactions, or for loss of data or information caused by factors outside of Whanganui District Council's control. This includes the information supplied as part of the application.</p>


        <h3>11.	Limitation of Liability</h3>
        <p>Except as expressly prohibited by law, in no event will Whanganui District Council be liable to you for any direct, indirect, consequential, exemplary, incidental or punitive damages, including lost profits, even where Whanganui District Council has been advised of the possibility of such damages occurring. If, notwithstanding the foregoing, Whanganui District Council is found to be liable to you for any damage or loss which arises as a result of your use of the website, Whanganui District Council's liability shall not exceed the dollar amount of the transaction which formed the basis of the damage or $100.00, whichever is the lesser.</p>


        <h3>12.	Right to Suspend, Alter or Cancel Service</h3>
        <p>Whanganui District Council shall be entitled at any time without prior notice or any liability to you, to cancel or suspend any or all online services and/or to substitute alternative services, which may or may not be interactive or transactional in nature.</p>


        <h3>13.	Specific Service Terms and Conditions</h3>
        <p>You acknowledge that certain online transactions made available or offered by Whanganui District Council from time to time may be subject to specific additional terms and conditions, and you agree to review and comply with any such additional terms and conditions. Access and use of any online services shall be deemed to constitute acceptance of any such additional terms and conditions applicable to such service.</p>


        <h3>14.	Jurisdiction</h3>
        <p>These terms and conditions and the online services they cover are governed by New Zealand law. The New Zealand Courts have exclusive jurisdiction over any matter in connection with the online services and these terms and conditions.</p>


        <h3>15.	Support Hours</h3>
        <p>Whanganui District Council provides customer support for online services between the hours of 8.00am to 5.00pm (Monday to Friday). All queries outside these hours will be logged and attended to during office hours.</p>


        <h3>16.	Refunds Policy</h3>
        <p>A refund will only be provided when it has been proven that a payment has been made twice at the same time for one item, by the same method.</p>
    </div>

    <h3>Additional Information</h3>
    <p><b>How you can pay:</b></p>
    <ul>
        <li>By the following credit card types: Visa or MasterCard only are accepted</li>
    </ul>
    <p><b>Credit Card Fees:</b></p>
    <ul>
        <li>You will be charged a convenience fee of 2.6% + $0.15 for online transactions</li>
    </ul>
    <p><b>Instructions:</b></p>
    You will find step by step instructions as you go through the payment process. 
    <ul>
        <li>At the end of the transaction you will be given a reference number.</li>
        <li>Receipts for online payments are emailed; however, you can either print the screen or note down the details for future reference.</li>
        <li>Close the browser window when you are finished.</li>
        <li>When using the service we recommend that you use the navigation buttons provided within the screens. Use of the 'enter' key in some screens may have unexpected results.</li>
    </ul>
    <p><b>Hours:</b></p>
    <ul>

        <li>Payments made after 10pm may appear on your account the following business day.</li>
    </ul>

    <p><b>Refund enquiries:</b></p>
    <ul>
        <li>Refund enquiries should be directed to Whanganui District Council. Phone +64 6 349 0001 or Email: wdc@whanganui.govt.nz</li>
    </ul>

</asp:Content>
