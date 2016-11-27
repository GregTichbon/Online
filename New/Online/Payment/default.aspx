<%@ Page Title="Whanganui District Council Payment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Online.Payment._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">


        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "LIMRequestHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate({
                ignore: [],
            });

            $("#form1").submit(function (event) {

                //alert('submit');

                // Stop form from submitting normally
                event.preventDefault();

                var arForm = $("#form1").serializeArray();
                var formData = JSON.stringify({ formVars: arForm })

                // process the form
                $.ajax({
                    type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                    contentType: "application/json; charset=utf-8",
                    url: '../functions/posts.asmx/CreditCardProcess', // the url where we want to POST
                    data: formData,
                    dataType: 'json', // what type of data do we expect back from the server
                    success: function (result) {
                        details = $.parseJSON(result.d);
                        if (details.status == "OKx") {
                            window.location.href = "complete.aspx?reference=<%:paymentrequestreference %> "
                        } else {
                            $("#dialog-message").html(details.message);
                            $("#dialog-message").dialog({
                                resizable: true,
                                height: 300,
                                modal: true
                            });
                        };
                    },
                    error: function (xhr, status) {
                        alert("An error occurred: " + status);
                    }
                })
            });
        }); //document.ready
    </script>
    <style>
        #datacom-payment-screen label {
            width: 145px;
            display: inline-block;
            text-align: left;
            margin-right: 8px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <input id="hf_payment_request_ctr" name="hf_payment_request_ctr" type="hidden" value="<%: payment_request_ctr %>" />
    <input id="hf_amount" name="hf_amount" type="hidden" value="<%: amount %>" />
    <input id="hf_transactionfee" name="hf_transactionfee" type="hidden" value="<%: transactionfee %>" />    
    <input id="hf_surcharge" name="hf_surcharge" type="hidden" value="<%: surcharge %>" />    
    <input id="hf_emailaddress" name="hf_emailaddress" type="hidden" value="<%: emailaddress %>" />
        <div id="dialog-message" title="Processing Message"></div>


    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Land Information Memorandum (LIM) Request
    </h1>
    <table>
        <tr>
            <td>
                <a href="http://www.paymentexpress.com/privacypolicy.htm" target="_blank">
                    <img src="https://www.paymentexpress.com/DPS/media/theme/pxlogostackedreg.png" /></a><br />
                <strong>Test cards</strong><br />
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
    </table>



    <div class="form-group">
        <label class="control-label col-sm-4" for="lbl_reference">Payment reference number:</label>
        <div class="col-sm-8">
            <span><%: paymentrequestreference %></span>
        </div>
    </div>



    <div class="form-group">
        <label class="control-label col-sm-4" for="lbl_detail">Detail:</label>
        <div class="col-sm-8">
            <span><%: detail %></span>

        </div>
    </div>


    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_cardnumber">Card Number:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_cardnumber" name="tb_cardnumber" class="form-control" maxlength="16" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_cardholder">Card Holder&#39;s Name:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_cardholder" name="tb_cardholder" class="form-control" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="xxxxx">Card Expiry Date:</label>
        <div class="col-sm-2">
            <select id="dd_expirymonth" name="dd_expirymonth" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect_ccmonth("X","None") %>
            </select>
        </div>
        <div class="col-sm-2">
            <select id="dd_expiryyear" name="dd_expiryyear" class="form-control" required>
                <option></option>
                <%= Online.WDCFunctions.WDCFunctions.populateselect_ccyear("X","None") %>
            </select>
        </div>
        <div class="col-sm-4"></div>

    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="tb_secureid">CSC/CVV/CVV2:</label>
        <div class="col-sm-8">
            <input type="text" id="tb_secureid" name="tb_secureid" class="form-control" maxlength="3" required />
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="lbl_amount">Amount:</label>
        <div class="col-sm-8">$
            <asp:Label ID="lbl_amount" runat="server"></asp:Label>
            <span><%: amount %></span>


        </div>
    </div>



    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_pay" type="submit" value="submit" class="btn btn-info" />
        </div>
    </div>
</asp:Content>
