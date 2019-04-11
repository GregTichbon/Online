<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatacomOption1.aspx.cs" Inherits="Online.Payment.DatacomOption1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">


        $(document).ready(function () {

            $("#form1").validate({
                ignore: [],
            });

            $("#dialog-start").dialog({ modal: true });

            $("#form1").submit(function (event) {

                // Stop form from submitting normally
                event.preventDefault();

                if ($("#form1").valid() == true) {
                    $("#dialog-message").dialog({
                        resizable: false,
                        width: 600, 
                        height: 600,
                        modal: true
                    });
                }
            });


            $('#btn_test').click(function () {
                resp = $('#response').val();
                $("#dialog-message").dialog('close');
                resp = $('#response').val();
                if (resp == 'Success') {
                    window.location.href = 'DataComOption1Success.aspx';
                } else {
                    $("#dialog-response").dialog({ modal: true });
                }
            })

            $('#btn_close').click(function () {
                $("#dialog-response").dialog('close');
            });         
        }); //document.ready
    </script>
    <style>

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <input id="hf_paymentrequestreference" name="hf_paymentrequestreference" type="hidden" value="<%: paymentrequestreference %>" />
    <input id="hf_amount" name="hf_amount" type="hidden" value="<%: amount %>" />
    <h1>Payment</h1>
 
    <div class="form-group">
        <label class="control-label col-sm-4">Payment reference number:</label>
        <div class="col-sm-8">
            <p class="form-control-static"><%: paymentrequestreference %></p>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label col-sm-4" for="lbl_detail">Detail:</label>
        <div class="col-sm-8">
            <p class="form-control-static"><%: detail %></p>

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
        <div class="col-sm-8">
            <p class="form-control-static">$<%: amount %></p>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-4">
        </div>
        <div class="col-sm-8">
            <input id="btn_pay" type="submit" value="submit" class="btn btn-info" />
        </div>
    </div>

    <div id="dialog-start" title="Credit Card Processing">
        <p>This is a crude example of the functionality required to process credit card transactions.</p>
        <p>Please complete the form and SUBMIT</p>
        </div>

    <div id="dialog-message" title="Interact with Datacom" style="display:none">
        <p>The credit card details from this screen, along with the description, amount of the transaction and a reference are passed to the DataCom API with DataCom's authorisation requirements.</p>
        <p>DataCom validate the transaction and return a success / failure response.</p>
        <p>Where the transaction fails other detail of the reason for the failure is also returned from DataCom.</p>
        <p>Where the transaction is successful the bank transfer is actioned.</p>
        <p>DataCom records the detail of the request within Sphere.</p>
        <p>Let's pretend DataCom respond with <select id="response" name="response"><option>Failure</option><option>Success</option></select><input type="button" id="btn_test" value="Get DataCom response" /></p>
    </div>

      <div id="dialog-response" title="Processing failure" style="display:none">
          <p>I'm sorry your credit card transaction was unable to be made beause ...... response reason from Datacom</p>
          <p><input type="button" id="btn_close" value="Try again" /></p>
          </div>
</asp:Content>
